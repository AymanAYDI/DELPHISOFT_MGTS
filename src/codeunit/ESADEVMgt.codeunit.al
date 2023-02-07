codeunit 50061 "DEL ESADEV Mgt"
{



    procedure GenerateSalesShipmentDESADVBuffer(ShipmentNo: Code[20]; Force: Boolean)
    var
        Customer: Record Customer;
        TempDESADVExportBufferLine: Record "DEL DESADV Export Buffer Line" temporary;
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        IF (ShipmentNo = '') THEN
            EXIT;

        IF NOT SalesShipmentHeader.GET(ShipmentNo) THEN
            EXIT;

        IF (SalesShipmentHeader."Order No." = '') THEN
            EXIT;

        Customer.GET(SalesShipmentHeader."Sell-to Customer No.");
        IF NOT Customer."DEL EDI" THEN
            EXIT;


        GetSalesShipmentDESADVExportBufferLines(SalesShipmentHeader, TempDESADVExportBufferLine, Force);
        IF TempDESADVExportBufferLine.ISEMPTY THEN
            EXIT;

        InsertSalesShipmentDESADVBuffer(SalesShipmentHeader, TempDESADVExportBufferLine);
    end;

    local procedure GetSalesShipmentDESADVExportBufferLines(SalesShipmentHeader: Record "Sales Shipment Header"; var TempDESADVExportBufferLine: Record "DEL DESADV Export Buffer Line" temporary; Force: Boolean)
    var
        Item: Record Item;
        SalesLine: Record "Sales Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        LineNo: Integer;
    begin
        TempDESADVExportBufferLine.RESET();
        TempDESADVExportBufferLine.DELETEALL();

        SalesShipmentLine.SETRANGE("Document No.", SalesShipmentHeader."No.");
        SalesShipmentLine.SETRANGE(Type, SalesShipmentLine.Type::Item);
        SalesShipmentLine.SETFILTER(Quantity, '>%1', 0);
        SalesShipmentLine.SETFILTER("No.", '<>%1', '');
        IF SalesShipmentLine.ISEMPTY THEN
            EXIT;
        SalesShipmentLine.FINDSET();
        REPEAT
            IF NOT DESADVExportSalesShipmentExist(SalesShipmentLine) OR Force THEN BEGIN
                LineNo += 1;
                Item.GET(SalesShipmentLine."No.");
                Item.TESTFIELD("DEL Code EAN 13");

                TempDESADVExportBufferLine.INIT();
                TempDESADVExportBufferLine."Line No." := LineNo;
                TempDESADVExportBufferLine."Source No." := DATABASE::"Sales Shipment Header";
                TempDESADVExportBufferLine."Document No." := SalesShipmentHeader."No.";
                TempDESADVExportBufferLine."Delivery GLN" := SalesShipmentHeader."DEL GLN";
                TempDESADVExportBufferLine."Document Line No." := SalesShipmentLine."Line No.";
                TempDESADVExportBufferLine."Item No." := SalesShipmentLine."No.";
                TempDESADVExportBufferLine.Description := SalesShipmentLine.Description;
                TempDESADVExportBufferLine.EAN := Item."DEL Code EAN 13";
                TempDESADVExportBufferLine."Supplier Item No." := SalesShipmentLine."No.";
                TempDESADVExportBufferLine."Customer Item No." := SalesShipmentLine."Item Reference No.";
                TempDESADVExportBufferLine."Unit of Measure" := 'PCE';//SalesShipmentLine."Unit of Measure Code";

                IF SalesLine.GET(SalesLine."Document Type"::Order, SalesShipmentLine."Order No.", SalesShipmentLine."Order Line No.") THEN BEGIN
                    TempDESADVExportBufferLine."Ordered Quantity" := SalesLine.Quantity;
                    TempDESADVExportBufferLine."Delivery Quantity" := SalesLine."Outstanding Quantity";
                END;

                TempDESADVExportBufferLine.Quantity := SalesShipmentLine.Quantity;
                TempDESADVExportBufferLine.INSERT();
            END;
        UNTIL SalesShipmentLine.NEXT() = 0;
    end;

    local procedure DESADVExportSalesShipmentExist(SalesShipmentLine: Record "Sales Shipment Line"): Boolean
    var
        DESADVExportBufferLine: Record "DEL DESADV Export Buffer Line";
    begin
        DESADVExportBufferLine.SETCURRENTKEY("Document No.", "Document Line No.");
        DESADVExportBufferLine.SETRANGE("Document No.", SalesShipmentLine."Document No.");
        DESADVExportBufferLine.SETRANGE("Document Line No.", SalesShipmentLine."Line No.");
        EXIT(NOT DESADVExportBufferLine.ISEMPTY);
    end;

    local procedure InsertSalesShipmentDESADVBuffer(SalesShipmentHeader: Record "Sales Shipment Header"; var TempDESADVExportBufferLine: Record "DEL DESADV Export Buffer Line" temporary)
    var
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        DESADVExportBuffer: Record "DEL DESADV Export Buffer";
        DESADVExportBufferLine: Record "DEL DESADV Export Buffer Line";
    begin
        IF (SalesShipmentHeader."Order No." = '') THEN
            EXIT;

        Customer.GET(SalesShipmentHeader."Sell-to Customer No.");
        IF NOT Customer."DEL EDI" THEN
            EXIT;

        CompanyInformation.GET();

        DESADVExportBuffer.INIT();
        DESADVExportBuffer."Source No." := DATABASE::"Sales Shipment Header";
        DESADVExportBuffer."Delivery No." := SalesShipmentHeader."No.";
        DESADVExportBuffer."Your Reference" := SalesShipmentHeader."External Document No.";
        DESADVExportBuffer."Container No." := SalesShipmentHeader."DEL Container No.";
        DESADVExportBuffer."Delivery Date" := SalesShipmentHeader."Posting Date";
        DESADVExportBuffer."Delivery Date Text" := FORMAT(SalesShipmentHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');

        DESADVExportBuffer."Order No." := SalesShipmentHeader."Order No.";
        DESADVExportBuffer."Order Date" := SalesShipmentHeader."Order Date";
        DESADVExportBuffer."Order Date Text" := FORMAT(SalesShipmentHeader."Order Date", 0, '<Year4>-<Month,2>-<Day,2>');

        DESADVExportBuffer."Supplier GLN" := CompanyInformation.GLN;
        DESADVExportBuffer."Supplier Name" := CompanyInformation.Name;
        IF (STRLEN(CompanyInformation."DEL Info fiscales 1") >= 24) THEN
            DESADVExportBuffer."Supplier Legal Form" := COPYSTR(CompanyInformation."DEL Info fiscales 1", 1, 24);
        IF (STRLEN(CompanyInformation."DEL Info fiscales 1") > 25) THEN
            DESADVExportBuffer."Supplier Capital Stock" := COPYSTR(CompanyInformation."DEL Info fiscales 1", 25, STRLEN(CompanyInformation."DEL Info fiscales 1"));

        DESADVExportBuffer."Supplier City" := CompanyInformation.City;
        DESADVExportBuffer."Supplier Country" := CompanyInformation."Country/Region Code";
        DESADVExportBuffer."Supplier Street" := CompanyInformation.Address;
        DESADVExportBuffer."Supplier VAT No." := DELCHR(CompanyInformation."VAT Registration No.", '=', '.- ');
        DESADVExportBuffer."Supplier Registration No." := CompanyInformation."UID Number";
        DESADVExportBuffer."Supplier SIREN No." := CompanyInformation."DEL Info fiscales 2";
        DESADVExportBuffer."Supplier Post Code" := CompanyInformation."Post Code";

        DESADVExportBuffer."Delivery GLN" := GetSalesShipToGLN(SalesShipmentHeader);
        DESADVExportBuffer."Delivery Name" := SalesShipmentHeader."Ship-to Name";
        DESADVExportBuffer."Delivery City" := SalesShipmentHeader."Ship-to City";
        DESADVExportBuffer."Delivery Country" := SalesShipmentHeader."Ship-to Country/Region Code";
        DESADVExportBuffer."Delivery Street" := SalesShipmentHeader."Ship-to Address";
        DESADVExportBuffer."Delivery Post Code" := SalesShipmentHeader."Ship-to Post Code";
        DESADVExportBuffer.INSERT();

        TempDESADVExportBufferLine.FINDSET();
        REPEAT
            DESADVExportBufferLine.INIT();
            DESADVExportBufferLine := TempDESADVExportBufferLine;
            DESADVExportBufferLine."Document Enty No." := DESADVExportBuffer."Entry No.";
            DESADVExportBufferLine."Delivery GLN" := DESADVExportBuffer."Delivery GLN";
            DESADVExportBufferLine."Delivery Date Text" := DESADVExportBuffer."Delivery Date Text";
            DESADVExportBufferLine.INSERT();
        UNTIL TempDESADVExportBufferLine.NEXT() = 0;
    end;

    local procedure GetSalesShipToGLN(SalesShipmentHeader: Record "Sales Shipment Header"): Text[13]
    var
    // ANVEDICrossReference: Record 5327362;
    // Customer: Record Customer;
    //------ SPECIFIQUE SUISSE
    begin
        //TODO IF (SalesShipmentHeader.GLN <> '') AND (STRLEN(SalesShipmentHeader.GLN) = 13) THEN
        //     EXIT(COPYSTR(SalesShipmentHeader.GLN, 1, 13));

        // IF (SalesShipmentHeader."Ship-to Code" = '') THEN BEGIN
        //     Customer.GET(SalesShipmentHeader."Sell-to Customer No.");
        //     EXIT(Customer.GLN);
        // END;

        // ANVEDICrossReference.SETRANGE("Cross-Reference Type", 'MOBIVIA-SHIP-GLN');
        // ANVEDICrossReference.SETRANGE("Table ID", DATABASE::"Ship-to Address");
        // ANVEDICrossReference.SETRANGE("Table Relation Par 1", SalesShipmentHeader."Sell-to Customer No.");
        // ANVEDICrossReference.SETRANGE("Internal No.", SalesShipmentHeader."Ship-to Code");
        // IF NOT ANVEDICrossReference.ISEMPTY THEN BEGIN
        //     ANVEDICrossReference.FINDSET;
        //     EXIT(ANVEDICrossReference."External No.");
        // END
        // ELSE
        //     EXIT('');
    end;

    procedure ResendSalesShipmentDESADV(SalesShipmentHeader: Record "Sales Shipment Header")
    var
        ConfirmEDISend: Label 'Are you sure you want to send expedition %1 via EDI?';
        MsgResend: Label 'Resend in progress';
    begin
        IF NOT CONFIRM(STRSUBSTNO(ConfirmEDISend, SalesShipmentHeader."No.")) THEN
            EXIT;
        CheckResendDocumentAuthorization();
        GenerateSalesShipmentDESADVBuffer(SalesShipmentHeader."No.", TRUE);
        MESSAGE(MsgResend);
    end;

    local procedure CheckResendDocumentAuthorization()
    var
        UserSetup: Record "User Setup";
        ErrResendEDIDoc: Label 'You are not authorized to resend EDI documents.';
    begin
        IF NOT UserSetup.GET(USERID) THEN
            UserSetup.INIT();
        IF NOT UserSetup."DEL Resend EDI Document" THEN
            ERROR(ErrResendEDIDoc);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    var
        Cust: Record Customer;
        DESADEVMgt: Codeunit "DEL ESADEV Mgt";
        ExportQst: Label 'Do you want to export the shipment %1 from document No. %2 with EDI?';
    begin
        IF SalesHeader.Ship AND (SalesShptHdrNo <> '') THEN BEGIN
            IF NOT Cust.GET(SalesHeader."Sell-to Customer No.") THEN
                Cust.INIT();

            IF Cust."DEL EDI" THEN
                IF CONFIRM(STRSUBSTNO(ExportQst, SalesShptHdrNo, SalesHeader."No.")) THEN
                    DESADEVMgt.GenerateSalesShipmentDESADVBuffer(SalesShptHdrNo, TRUE);
        END;
    end;

    procedure ResendDocument(var DESADVExportBuffer: Record "DEL DESADV Export Buffer")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        MsgResend: Label 'Resend in progress';
    begin
        CheckResendDocumentAuthorization();

        IF SalesShipmentHeader.GET(DESADVExportBuffer."Delivery No.") THEN
            GenerateSalesShipmentDESADVBuffer(SalesShipmentHeader."No.", TRUE)
        ELSE BEGIN
            DESADVExportBuffer.Exported := FALSE;
            DESADVExportBuffer."Export Date" := 0DT;
            DESADVExportBuffer.MODIFY();
        END;
        MESSAGE(MsgResend);
    end;
}

