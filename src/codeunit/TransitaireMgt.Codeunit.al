codeunit 50002 "DEL TransitaireMgt"
{
    // EDI       22.05.13/LOCO/ChC- Codeunit copied


    trigger OnRun()
    var
        XmlExpPort: XMLport "50000";
        PurchHeader: Record "Purchase Header";
    begin
    end;

    var
        Testfile: File;
        TestStream: InStream;
        XMLPor: XMLport "50000";
        TestStream1: OutStream;
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        GLSetupFound: Boolean;
        CompanyInfoFound: Boolean;
        DimMgt: Codeunit DimensionManagement;
        Text001: Label 'Intercompany transactions from %1.';
        Text002: Label 'Attached to this mail is an xml file containing one or more intercompany transactions from %1 (%2 %3).';
        Text003: Label 'Do you want to complete line actions?';
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
        Text010: Label 'This Purchase Order Number %1 does not exist.';
        Text50000: Label 'A Message was already sent away. Do you want to send a new away?';
        Text50001: Label 'The operation was broken off.';
        Text50002: Label 'Operation canceld! Code transitaire is not correct.';


    procedure SendForwardingDoc(PurchHeader: Record "Purchase Header"; Post: Boolean)
    var
        ICPartner: Record "IC Partner";
        Release: Codeunit "Release Purchase Document";
    begin
        // Führt Tests durch. CU 427 ist das Beispiel.
        IF PurchHeader."DEL Forwarding Agent Code" <> '' THEN
            CreateOutboxForwardingDocTrans(PurchHeader, FALSE, Post)
        ELSE
            MESSAGE(Text50002);
    end;


    procedure CreateOutboxForwardingDocTrans(PurchHeader: Record "Purchase Header"; Rejection: Boolean; Post: Boolean)
    var
        OutboxTransaction: Record "IC Outbox Transaction";
        Vendor: Record Vendor;
        PurchLine: Record "Purchase Line";
        ICOutBoxPurchHeader: Record "IC Outbox Purchase Header";
        ICOutBoxPurchLine: Record "IC Outbox Purchase Line";
        TempDocDim: Record "Gen. Jnl. Dim. Filter" temporary;
        TransactionNo: Integer;
        LinesCreated: Boolean;
    begin
        // Erstellt einen Eintrag in der Tabelle 414 "IC Outbox Transaction"
        GLSetup.LOCKTABLE();
        GetGLSetup();
        TransactionNo := GLSetup."Last IC Transaction No." + 1;
        GLSetup."Last IC Transaction No." := TransactionNo;
        GLSetup.MODIFY();
        Vendor.GET(PurchHeader."Buy-from Vendor No.");
        Vendor.CheckBlockedVendOnDocs(Vendor, FALSE);
        WITH PurchHeader DO BEGIN
            OutboxTransaction.INIT();
            OutboxTransaction."Transaction No." := TransactionNo;
            OutboxTransaction."IC Partner Code" := Vendor."IC Partner Code";
            OutboxTransaction."Source Type" := OutboxTransaction."Source Type"::"Forwarding Document";
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
            OutboxTransaction."Document No." := "No.";
            OutboxTransaction."Posting Date" := "Posting Date";
            OutboxTransaction."Document Date" := "Document Date";
            IF Rejection THEN
                OutboxTransaction."Transaction Source" := OutboxTransaction."Transaction Source"::"Rejected by Current Company"
            ELSE
                OutboxTransaction."Transaction Source" := OutboxTransaction."Transaction Source"::"Created by Current Company";
            OutboxTransaction.INSERT();
        END;
        ICOutBoxPurchHeader.TRANSFERFIELDS(PurchHeader);
        ICOutBoxPurchHeader."IC Transaction No." := OutboxTransaction."Transaction No.";
        ICOutBoxPurchHeader."IC Partner Code" := OutboxTransaction."IC Partner Code";
        ICOutBoxPurchHeader."Transaction Source" := OutboxTransaction."Transaction Source";
        IF ICOutBoxPurchHeader."Currency Code" = '' THEN
            ICOutBoxPurchHeader."Currency Code" := GLSetup."LCY Code";

        DimMgt.CopyDocDimtoICDocDim(DATABASE::"IC Outbox Purchase Header", ICOutBoxPurchHeader."IC Transaction No.",
          ICOutBoxPurchHeader."IC Partner Code", ICOutBoxPurchHeader."Transaction Source", 0, PurchHeader."Dimension Set ID");

        WITH ICOutBoxPurchLine DO BEGIN
            PurchLine.RESET();
            PurchLine.SETRANGE("Document Type", PurchHeader."Document Type");
            PurchLine.SETRANGE("Document No.", PurchHeader."No.");
            IF PurchLine.FINDFIRST() THEN
                REPEAT
                    INIT();
                    TRANSFERFIELDS(PurchLine);
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
                    "IC Partner Code" := OutboxTransaction."IC Partner Code";
                    "IC Transaction No." := OutboxTransaction."Transaction No.";
                    "Transaction Source" := OutboxTransaction."Transaction Source";

                    "Currency Code" := ICOutBoxPurchHeader."Currency Code";
                    DimMgt.CopyDocDimtoICDocDim(
                      DATABASE::"IC Outbox Purchase Line", "IC Transaction No.", "IC Partner Code", "Transaction Source",
                      "Line No.", PurchLine."Dimension Set ID");

                    IF PurchLine.Type = PurchLine.Type::" " THEN
                        ICOutBoxPurchLine."IC Partner Reference" := '';
                    IF INSERT(TRUE) THEN
                        LinesCreated := TRUE;
                UNTIL PurchLine.NEXT() = 0;
        END;

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

    procedure CopyDocDimToDocDim(var TempDocDim: Record "Gen. Jnl. Dim. Filter" temporary; "Table ID": Integer; DocType: Integer; DocNo: Code[20]; LineNo: Integer)
    var
        DocDim: Record "Gen. Jnl. Dim. Filter";
    begin
        TempDocDim.RESET();
        TempDocDim.DELETEALL();
        DocDim.RESET();
        DocDim.SETRANGE(DocDim."Table ID", "Table ID");
        DocDim.SETRANGE("Document Type", DocType);
        DocDim.SETRANGE("Document No.", DocNo);
        DocDim.SETRANGE("Line No.", LineNo);
        IF DocDim.FINDFIRST() THEN
            REPEAT
                TempDocDim := DocDim;
                TempDocDim.INSERT();
            UNTIL DocDim.NEXT() = 0;
    end;


    procedure SendToTransitairePartner(ICOutboxTrans: Record "IC Outbox Transaction")
    var
        ICPartner: Record "IC Partner";
        MailHandler: Codeunit Mail;
        ICOutboxExportXML: XMLport "IC Outbox Imp/Exp";
        OFile: File;
        FileName: Text[250];
        Ostr: OutStream;
        ICPartnerFilter: Text[1024];
        i: Integer;
        ToName: Text[100];
        CcName: Text[100];
        Transitaire: Record "DEL Forwarding agent 2";
        PurchHeader: Record "Purchase Header";
        NGTSSetup: Record "DEL General Setup";
        XMLPortOutbox: XMLport 50000;
        ICPurchHeaderArchiv: Record "Handled IC Outbox Purch. Hdr";
        XMLPortOutboxNew: XMLport 50002;
    begin
        //Erstellt XML file.
        PurchHeader.SETRANGE("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SETRANGE("No.", ICOutboxTrans."Document No.");
        IF PurchHeader.FINDFIRST() THEN BEGIN

            // Test ob Transitaire gültig ist.
            Transitaire.GET(PurchHeader."Forwarding Agent Code");
            NGTSSetup.GET();

            // Test ob bereits ein XML File erstellt wurde.
            // THM
            ICPurchHeaderArchiv.SETRANGE(ICPurchHeaderArchiv."Document Type", ICPurchHeaderArchiv."Document Type"::Order);
            ICPurchHeaderArchiv.SETRANGE(ICPurchHeaderArchiv."Buy-from Vendor No.", PurchHeader."Buy-from Vendor No.");
            //end THM
            ICPurchHeaderArchiv.SETRANGE("No.", PurchHeader."No.");

            IF ICPurchHeaderArchiv.FINDFIRST() THEN
                IF NOT DIALOG.CONFIRM(Text50000) THEN
                    ERROR(Text50001);
            // XML File erstellen.
            FileName :=
                      STRSUBSTNO('%1\%2_%3-%4.xml', Transitaire."Folder for file",
                      NGTSSetup."Nom emetteur", NGTSSetup."Nom achat commande transitaire",
                      ICOutboxTrans."Document No.");

            OFile.CREATE(FileName);
            OFile.CREATEOUTSTREAM(Ostr);

            IF Transitaire."HSCODE Enable" = FALSE THEN BEGIN   //ngts1  begin
                XMLPortOutbox.SETDESTINATION(Ostr);
                XMLPortOutbox.SETTABLEVIEW(PurchHeader);
                XMLPortOutbox.EXPORT;
            END;

            IF Transitaire."HSCODE Enable" = TRUE THEN BEGIN
                XMLPortOutboxNew.SETDESTINATION(Ostr);
                XMLPortOutboxNew.SETTABLEVIEW(PurchHeader);
                XMLPortOutboxNew.EXPORT;
            END;                                               //ngts1  end


            OFile.CLOSE;
            CLEAR(Ostr);
            CLEAR(ICOutboxExportXML);

        END ELSE
            MESSAGE(Text010);
    end;
}
