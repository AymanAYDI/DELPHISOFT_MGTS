codeunit 50002 "DEL TransitaireMgt"
{


    trigger OnRun()
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        GLSetupFound: Boolean;
        Text010: Label 'This Purchase Order Number %1 does not exist.';
        Text50000: Label 'A Message was already sent away. Do you want to send a new away?';
        Text50001: Label 'The operation was broken off.';
        Text50002: Label 'Operation canceld! Code transitaire is not correct.';


    procedure SendForwardingDoc(PurchHeader: Record "Purchase Header"; Post: Boolean)
    begin
        IF PurchHeader."DEL Forwarding Agent Code" <> '' THEN
            CreateOutboxForwardingDocTrans(PurchHeader, FALSE, Post)
        ELSE
            MESSAGE(Text50002);
    end;


    procedure CreateOutboxForwardingDocTrans(PurchHeader: Record "Purchase Header"; Rejection: Boolean; Post: Boolean)
    var
        ICOutBoxPurchHeader: Record "IC Outbox Purchase Header";
        ICOutBoxPurchLine: Record "IC Outbox Purchase Line";
        OutboxTransaction: Record "IC Outbox Transaction";
        PurchLine: Record "Purchase Line";
        Vendor: Record Vendor;
        LinesCreated: Boolean;
        TransactionNo: Integer;
    begin
        GLSetup.LOCKTABLE();
        GetGLSetup();
        TransactionNo := GLSetup."Last IC Transaction No." + 1;
        GLSetup."Last IC Transaction No." := TransactionNo;
        GLSetup.MODIFY();
        Vendor.GET(PurchHeader."Buy-from Vendor No.");
        Vendor.CheckBlockedVendOnDocs(Vendor, FALSE);
        OutboxTransaction.INIT();
        OutboxTransaction."Transaction No." := TransactionNo;
        OutboxTransaction."IC Partner Code" := Vendor."IC Partner Code";
        CASE PurchHeader."Document Type" OF
            PurchHeader."Document Type"::Order:
                OutboxTransaction."Document Type" := OutboxTransaction."Document Type"::Order;
            PurchHeader."Document Type"::Invoice:
                OutboxTransaction."Document Type" := OutboxTransaction."Document Type"::Invoice;
            PurchHeader."Document Type"::"Credit Memo":
                OutboxTransaction."Document Type" := OutboxTransaction."Document Type"::"Credit Memo";
            PurchHeader."Document Type"::"Return Order":
                OutboxTransaction."Document Type" := OutboxTransaction."Document Type"::"Return Order";
        END;
        OutboxTransaction."Document No." := PurchHeader."No.";
        OutboxTransaction."Posting Date" := PurchHeader."Posting Date";
        OutboxTransaction."Document Date" := PurchHeader."Document Date";
        IF Rejection THEN
            OutboxTransaction."Transaction Source" := OutboxTransaction."Transaction Source"::"Rejected by Current Company"
        ELSE
            OutboxTransaction."Transaction Source" := OutboxTransaction."Transaction Source"::"Created by Current Company";
        OutboxTransaction.INSERT();
        ICOutBoxPurchHeader.TRANSFERFIELDS(PurchHeader);
        ICOutBoxPurchHeader."IC Transaction No." := OutboxTransaction."Transaction No.";
        ICOutBoxPurchHeader."IC Partner Code" := OutboxTransaction."IC Partner Code";
        ICOutBoxPurchHeader."Transaction Source" := OutboxTransaction."Transaction Source";
        IF ICOutBoxPurchHeader."Currency Code" = '' THEN
            ICOutBoxPurchHeader."Currency Code" := GLSetup."LCY Code";

        DimMgt.CopyDocDimtoICDocDim(DATABASE::"IC Outbox Purchase Header", ICOutBoxPurchHeader."IC Transaction No.",
          ICOutBoxPurchHeader."IC Partner Code", ICOutBoxPurchHeader."Transaction Source", 0, PurchHeader."Dimension Set ID");

        PurchLine.RESET();
        PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
        PurchLine.SETRANGE("Document No.", PurchHeader."No.");
        IF PurchLine.FINDFIRST() THEN
            REPEAT
                ICOutBoxPurchLine.INIT();
                ICOutBoxPurchLine.TRANSFERFIELDS(PurchLine);
                CASE PurchLine."Document Type" OF
                    PurchLine."Document Type"::Order:
                        ICOutBoxPurchLine."Document Type" := ICOutBoxPurchLine."Document Type"::Order;
                    PurchLine."Document Type"::Invoice:
                        ICOutBoxPurchLine."Document Type" := ICOutBoxPurchLine."Document Type"::Invoice;
                    PurchLine."Document Type"::"Credit Memo":
                        ICOutBoxPurchLine."Document Type" := ICOutBoxPurchLine."Document Type"::"Credit Memo";
                    PurchLine."Document Type"::"Return Order":
                        ICOutBoxPurchLine."Document Type" := ICOutBoxPurchLine."Document Type"::"Return Order";
                END;
                ICOutBoxPurchLine."IC Partner Code" := OutboxTransaction."IC Partner Code";
                ICOutBoxPurchLine."IC Transaction No." := OutboxTransaction."Transaction No.";
                ICOutBoxPurchLine."Transaction Source" := OutboxTransaction."Transaction Source";

                ICOutBoxPurchLine."Currency Code" := ICOutBoxPurchHeader."Currency Code";
                DimMgt.CopyDocDimtoICDocDim(
                  DATABASE::"IC Outbox Purchase Line", ICOutBoxPurchLine."IC Transaction No.", ICOutBoxPurchLine."IC Partner Code", ICOutBoxPurchLine."Transaction Source",
                  ICOutBoxPurchLine."Line No.", PurchLine."Dimension Set ID");

                IF PurchLine.Type = PurchLine.Type::" " THEN
                    ICOutBoxPurchLine."IC Partner Reference" := '';
                IF ICOutBoxPurchLine.INSERT(TRUE) THEN
                    LinesCreated := TRUE;
            UNTIL PurchLine.NEXT() = 0;

        IF LinesCreated THEN BEGIN
            ICOutBoxPurchHeader.INSERT();
            IF NOT Post THEN BEGIN
                PurchHeader."IC Status" := PurchHeader."IC Status"::Pending;
                PurchHeader.MODIFY();
            END;
        END;
    end;


    procedure GetGLSetup()
    begin
        IF NOT GLSetupFound THEN
            GLSetup.GET();
        GLSetupFound := TRUE;
    end;

    // procedure CopyDocDimToDocDim(var TempDocDim: Record 357 temporary; "Table ID": Integer; DocType: Integer; DocNo: Code[20]; LineNo: Integer)
    // var
    //     // DocDim: Record 357;
    //     DocDim: Codeunit 408;
    // begin
    //     TempDocDim.RESET();
    //     TempDocDim.DELETEALL();
    //     DocDim.RESET();
    //     DocDim.SETRANGE(DocDim."Table ID", "Table ID");
    //     DocDim.SETRANGE("Document Type", DocType);
    //     DocDim.SETRANGE("Document No.", DocNo);
    //     DocDim.SETRANGE("Line No.", LineNo);
    //     IF DocDim.FINDFIRST() THEN
    //         REPEAT
    //             TempDocDim := DocDim;
    //             TempDocDim.INSERT();
    //         UNTIL DocDim.NEXT() = 0;
    // end; // TODO:


    procedure SendToTransitairePartner(ICOutboxTrans: Record "IC Outbox Transaction")
    var
        Transitaire: Record "DEL Forwarding agent 2";
        NGTSSetup: Record "DEL General Setup";
        ICPurchHeaderArchiv: Record "Handled IC Outbox Purch. Hdr";
        PurchHeader: Record "Purchase Header";
        tempBlob: Codeunit "Temp Blob";
        XMLPortOutbox: XMLport "DEL IC Transitaire";
        XMLPortOutboxNew: XMLport "DEL IC Transitaire with hscode";
        ICOutboxExportXML: XMLport "IC Outbox Imp/Exp";
        Ostr: OutStream;
        FileName: Text[250];
    begin
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETRANGE("No.", ICOutboxTrans."Document No.");
        IF PurchHeader.FINDFIRST() THEN BEGIN

            Transitaire.GET(PurchHeader."DEL Forwarding Agent Code");
            NGTSSetup.GET();
            ICPurchHeaderArchiv.SETRANGE(ICPurchHeaderArchiv."Document Type", ICPurchHeaderArchiv."Document Type"::Order);
            ICPurchHeaderArchiv.SETRANGE(ICPurchHeaderArchiv."Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
            ICPurchHeaderArchiv.SETRANGE("No.", PurchHeader."No.");

            IF ICPurchHeaderArchiv.FINDFIRST() THEN
                IF NOT DIALOG.CONFIRM(Text50000) THEN
                    ERROR(Text50001);
            FileName :=
                      STRSUBSTNO('%1\%2_%3-%4.xml', Transitaire."Folder for file",
                      NGTSSetup."Nom emetteur", NGTSSetup."Nom achat commande transitaire",
                      ICOutboxTrans."Document No.");

            // OFile.CREATE(FileName);
            // OFile.CREATEOUTSTREAM(Ostr);
            tempBlob.CreateOutStream(Ostr);

            IF Transitaire."HSCODE Enable" = FALSE THEN BEGIN
                XMLPortOutbox.SETDESTINATION(Ostr);
                XMLPortOutbox.SETTABLEVIEW(PurchHeader);
                XMLPortOutbox.EXPORT();
            END;

            IF Transitaire."HSCODE Enable" = TRUE THEN BEGIN
                XMLPortOutboxNew.SETDESTINATION(Ostr);
                XMLPortOutboxNew.SETTABLEVIEW(PurchHeader);
                XMLPortOutboxNew.EXPORT();
            END;


            // OFile.CLOSE;
            CLEAR(Ostr);
            CLEAR(ICOutboxExportXML);

        END ELSE
            MESSAGE(Text010);
    end;
}

