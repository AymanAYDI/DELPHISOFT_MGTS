codeunit 50052 "MGTS EDI Management"
{
    // MGTSEDI10.00.00.00 | 07.08.2020 | EDI Management
    // 
    // MGTSEDI10.00.00.01 | 24.12.2020 | EDI Management : Add function : ResendCustomerInvoice
    // 
    // MGTSEDI10.00.00.03 | 30.12.2020 | EDI Management : Add function : GetSalesInvoiceShipToGLN
    // 
    // MGTSEDI10.00.00.21 | 18.01.2021 | EDI Management : Add function : OnAfterValidateGLNSalesHeader
    // 
    // MGTSEDI10.00.00.22 | 11.02.2021 | EDI Management : Add C\AL :
    // 
    // MGTSEDI10.00.00.23 | 30.06.2021 | EDI Management : Add C\AL : InsertSalesInvoiceEDIExportBuffer


    trigger OnRun()
    begin
        GenerateSalesInvoiceEDIBuffer('0555891', TRUE);
    end;

    local procedure SendPurchaseOrder(PurchaseHeader: Record "38"; Force: Boolean)
    var
        Vendor: Record "23";
        TempEDIExportBufferLine: Record "50078" temporary;
    begin
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        IF NOT Vendor.EDI THEN
            EXIT;
        GetPurchEDIExportBufferLines(PurchaseHeader, TempEDIExportBufferLine, Force);
        IF TempEDIExportBufferLine.ISEMPTY THEN
            EXIT;

        InsertPurchEDIExportBuffer(PurchaseHeader, TempEDIExportBufferLine);
    end;

    local procedure InsertPurchEDIExportBuffer(PurchaseHeader: Record "38"; var TempEDIExportBufferLine: Record "50078" temporary)
    var
        EDIExportBuffer: Record "50077";
        EDIExportBufferLine: Record "50078";
        CompanyInformation: Record "79";
        Vendor: Record "23";
    begin
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        IF NOT Vendor.EDI THEN
            EXIT;
        CompanyInformation.GET;

        PurchaseHeader.CALCFIELDS(Amount);
        EDIExportBuffer.INIT;
        EDIExportBuffer."Source No." := DATABASE::"Purchase Header";
        EDIExportBuffer."Document Type" := PurchaseHeader."Document Type";
        EDIExportBuffer."Document No." := PurchaseHeader."No.";
        EDIExportBuffer."Document Date" := PurchaseHeader."Document Date";
        EDIExportBuffer."Document Date Text" := FORMAT(PurchaseHeader."Document Date", 0, '<Year4>-<Month,2>-<Day,2>');
        EDIExportBuffer."Delivery Date" := PurchaseHeader."Requested Receipt Date";
        EDIExportBuffer."Delivery Date Text" := FORMAT(PurchaseHeader."Requested Receipt Date", 0, '<Year4>-<Month,2>-<Day,2>');
        EDIExportBuffer."Your Reference" := PurchaseHeader."Your Reference";
        EDIExportBuffer."Contrat ID" := '';
        EDIExportBuffer."Supplier GLN" := Vendor.GLN;
        EDIExportBuffer."Buyer GLN" := CompanyInformation.GLN;
        EDIExportBuffer."Customer GLN" := CompanyInformation.GLN;
        EDIExportBuffer."Delivery GLN" := PurchaseHeader.GLN;
        EDIExportBuffer."Contact Name" := CompanyInformation.Name;
        EDIExportBuffer."Contact Email" := CompanyInformation."E-Mail";
        EDIExportBuffer."EDI Document Type" := PurchaseHeader."Type Order EDI";
        IF (PurchaseHeader."Currency Code" <> '') THEN
            EDIExportBuffer."Currency Code" := PurchaseHeader."Currency Code"
        ELSE
            EDIExportBuffer."Currency Code" := 'CHF';
        EDIExportBuffer."Document Amount" := PurchaseHeader.Amount;
        EDIExportBuffer.INSERT;

        TempEDIExportBufferLine.FINDSET;
        IF (EDIExportBuffer."Delivery Date" = 0D) THEN BEGIN
            EDIExportBuffer."Delivery Date" := TempEDIExportBufferLine."Delivery Date";
            EDIExportBuffer."Delivery Date Text" := TempEDIExportBufferLine."Delivery Date Text";
            EDIExportBuffer.MODIFY;
        END;
        REPEAT
            EDIExportBufferLine.INIT;
            EDIExportBufferLine := TempEDIExportBufferLine;
            EDIExportBufferLine."Document Enty No." := EDIExportBuffer."Entry No.";
            EDIExportBufferLine."Delivery GLN" := EDIExportBuffer."Delivery GLN";
            EDIExportBufferLine.INSERT;
        UNTIL TempEDIExportBufferLine.NEXT = 0;
    end;

    local procedure GetPurchEDIExportBufferLines(PurchaseHeader: Record "38"; var TempEDIExportBufferLine: Record "50078" temporary; Force: Boolean)
    var
        PurchaseLine: Record "39";
        Item: Record "27";
        LineNo: Integer;
    begin
        TempEDIExportBufferLine.RESET;
        TempEDIExportBufferLine.DELETEALL;
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '>%1', 0);
        PurchaseLine.SETFILTER("No.", '<>%1', '');
        IF PurchaseLine.ISEMPTY THEN
            EXIT;
        PurchaseLine.FINDSET;
        REPEAT
            IF NOT EDIExportBufferLineExist(PurchaseLine) OR Force THEN BEGIN
                LineNo += 1;
                Item.GET(PurchaseLine."No.");
                TempEDIExportBufferLine.INIT;
                TempEDIExportBufferLine."Line No." := LineNo;
                TempEDIExportBufferLine."Source No." := DATABASE::"Purchase Line";
                TempEDIExportBufferLine."Document Type" := PurchaseLine."Document Type";
                TempEDIExportBufferLine."Document No." := PurchaseLine."Document No.";
                TempEDIExportBufferLine."Delivery GLN" := PurchaseHeader.GLN;
                TempEDIExportBufferLine."Document Line No." := PurchaseLine."Line No.";
                TempEDIExportBufferLine."Item No." := PurchaseLine."No.";
                TempEDIExportBufferLine.Description := PurchaseLine.Description;
                TempEDIExportBufferLine.EAN := Item."Code EAN 13";
                TempEDIExportBufferLine."Supplier Item No." := PurchaseLine."Vendor Item No.";
                TempEDIExportBufferLine."Customer Item No." := PurchaseLine."No.";
                TempEDIExportBufferLine."Unit of Measure" := PurchaseLine."Unit of Measure Code";
                TempEDIExportBufferLine.Quantity := PurchaseLine.Quantity;
                TempEDIExportBufferLine.Price := ROUND(PurchaseLine."Line Amount" / PurchaseLine.Quantity, 0.01);
                TempEDIExportBufferLine."Delivery Quantity" := PurchaseLine.Quantity;
                TempEDIExportBufferLine."Delivery Date" := PurchaseLine."Requested Receipt Date";
                TempEDIExportBufferLine."Delivery Date Text" := FORMAT(PurchaseLine."Requested Receipt Date", 0, '<Year4>-<Month,2>-<Day,2>');
                TempEDIExportBufferLine.INSERT;
            END;
        UNTIL PurchaseLine.NEXT = 0;
    end;

    local procedure EDIExportBufferLineExist(PurchaseLine: Record "39"): Boolean
    var
        EDIExportBufferLine: Record "50078";
    begin
        EDIExportBufferLine.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.");
        EDIExportBufferLine.SETRANGE("Document Type", PurchaseLine."Document Type");
        EDIExportBufferLine.SETRANGE("Document No.", PurchaseLine."Document No.");
        EDIExportBufferLine.SETRANGE("Document Line No.", PurchaseLine."Line No.");
        EXIT(NOT EDIExportBufferLine.ISEMPTY);
    end;

    [EventSubscriber(ObjectType::Codeunit, 415, 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "38"; PreviewMode: Boolean)
    var
        TempEDIExportBufferLine: Record "50078" temporary;
        Vendor: Record "23";
    begin
        IF PreviewMode THEN
            EXIT;

        SendPurchaseOrder(PurchaseHeader, FALSE);
    end;

    local procedure InsertSalesInvoiceEDIExportBuffer(SalesInvoiceHeader: Record "112"; var TempEDIExportBufferLine: Record "50078" temporary)
    var
        EDIExportBuffer: Record "50077";
        EDIExportBufferLine: Record "50078";
        CompanyInformation: Record "79";
        Customer: Record "18";
        Customer2: Record "18";
        Contact: Record "5050";
        SalesShipmentHeader: Record "110";
    begin
        IF (SalesInvoiceHeader."Order No." = '') THEN
            EXIT;
        Customer.GET(SalesInvoiceHeader."Sell-to Customer No.");
        IF NOT Customer.EDI THEN
            EXIT;
        CompanyInformation.GET;
        SalesInvoiceHeader.CALCFIELDS(Amount, "Amount Including VAT");

        EDIExportBuffer.INIT;
        EDIExportBuffer."Source No." := DATABASE::"Sales Invoice Header";
        EDIExportBuffer."Document Type" := EDIExportBuffer."Document Type"::Invoice;
        EDIExportBuffer."Document No." := SalesInvoiceHeader."No.";
        EDIExportBuffer."Document Date" := SalesInvoiceHeader."Posting Date";
        EDIExportBuffer."Document Date Text" := FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');
        EDIExportBuffer."Your Reference" := SalesInvoiceHeader."External Document No.";
        EDIExportBuffer."Contact Name" := CompanyInformation.Name;
        EDIExportBuffer."Contact Email" := CompanyInformation."E-Mail";
        EDIExportBuffer."EDI Order Type" := SalesInvoiceHeader."Type Order EDI";
        EDIExportBuffer."EDI Document Type" := '380';

        IF (SalesInvoiceHeader."Currency Code" <> '') THEN
            EDIExportBuffer."Currency Code" := SalesInvoiceHeader."Currency Code"
        ELSE
            EDIExportBuffer."Currency Code" := 'CHF';

        EDIExportBuffer."Document Amount" := SalesInvoiceHeader.Amount;
        EDIExportBuffer."Document Amount Inc. VAT" := SalesInvoiceHeader."Amount Including VAT";
        EDIExportBuffer."Document VAT Amount" := SalesInvoiceHeader."Amount Including VAT" - SalesInvoiceHeader.Amount;
        EDIExportBuffer."Due Date Text" := FORMAT(SalesInvoiceHeader."Due Date", 0, '<Year4>-<Month,2>-<Day,2>');

        EDIExportBuffer."Order No." := SalesInvoiceHeader."Order No.";
        EDIExportBuffer."Order Date" := SalesInvoiceHeader."Order Date";
        EDIExportBuffer."Order Date Text" := FORMAT(SalesInvoiceHeader."Order Date", 0, '<Year4>-<Month,2>-<Day,2>');

        EDIExportBuffer."Supplier GLN" := CompanyInformation.GLN;
        EDIExportBuffer."Supplier Name" := CompanyInformation.Name;
        IF (STRLEN(CompanyInformation."Info fiscales 1") >= 24) THEN
            EDIExportBuffer."Supplier Legal Form" := COPYSTR(CompanyInformation."Info fiscales 1", 1, 24);
        IF (STRLEN(CompanyInformation."Info fiscales 1") > 25) THEN
            EDIExportBuffer."Supplier Capital Stock" := COPYSTR(CompanyInformation."Info fiscales 1", 25, STRLEN(CompanyInformation."Info fiscales 1"));

        EDIExportBuffer."Supplier City" := CompanyInformation.City;
        EDIExportBuffer."Supplier Country" := CompanyInformation."Country/Region Code";
        EDIExportBuffer."Supplier Street" := CompanyInformation.Address;
        EDIExportBuffer."Supplier VAT No." := DELCHR(CompanyInformation."VAT Registration No.", '=', '.- ');
        EDIExportBuffer."Supplier Registration No." := CompanyInformation."UID Number";//CompanyInformation."Registration No.";
        EDIExportBuffer."Supplier SIREN No." := CompanyInformation."Info fiscales 2";
        EDIExportBuffer."Supplier Post Code" := CompanyInformation."Post Code";

        EDIExportBuffer."Buyer GLN" := Customer.GLN;
        EDIExportBuffer."Buyer Name" := SalesInvoiceHeader."Sell-to Customer Name";
        EDIExportBuffer."Buyer City" := SalesInvoiceHeader."Sell-to City";
        EDIExportBuffer."Buyer Country" := SalesInvoiceHeader."Sell-to Country/Region Code";
        EDIExportBuffer."Buyer Street" := SalesInvoiceHeader."Sell-to Address";
        EDIExportBuffer."Buyer VAT Registration No." := DELCHR(Customer."VAT Registration No.", '=', '.- ');
        EDIExportBuffer."Buyer Post Code" := SalesInvoiceHeader."Sell-to Post Code";

        Customer.GET(SalesInvoiceHeader."Bill-to Customer No.");
        EDIExportBuffer."Customer GLN" := Customer.GLN;
        EDIExportBuffer."Customer Name" := SalesInvoiceHeader."Bill-to Name";
        EDIExportBuffer."Customer City" := SalesInvoiceHeader."Bill-to City";
        EDIExportBuffer."Customer Country" := SalesInvoiceHeader."Bill-to Country/Region Code";
        EDIExportBuffer."Customer Street" := SalesInvoiceHeader."Bill-to Address";
        EDIExportBuffer."Customer VAT  No." := DELCHR(Customer."VAT Registration No.", '=', '.- ');
        EDIExportBuffer."Customer Post Code" := SalesInvoiceHeader."Bill-to Post Code";



        IF Contact.GET(SalesInvoiceHeader."Fiscal Repr.") THEN BEGIN
            //>>MGTSEDI10.00.00.23
            /*
            IF (SalesInvoiceHeader."Bill-to Customer No." <> '') THEN
            BEGIN
              Customer2.GET(SalesInvoiceHeader."Bill-to Customer No.");
              IF (Customer2."Fiscal Repr." <> '') THEN
                Contact.GET(Customer2."Fiscal Repr.");
            END;
            */
            //<<MGTSEDI10.00.00.23

            EDIExportBuffer."Tax Representative ID" := Contact.GLN;
            EDIExportBuffer."Tax Representative Name" := Contact.Name;
            EDIExportBuffer."Tax Representative City" := Contact.City;
            EDIExportBuffer."Tax Representative Country" := Contact."Country/Region Code";
            EDIExportBuffer."Tax Representative Street" := Contact.Address;
            EDIExportBuffer."Tax Representative VAT  No." := DELCHR(Contact."VAT Registration No.", '=', '.- ');
            EDIExportBuffer."Tax Rep. Intracom VAT  No." := DELCHR(Contact."N° de TVA", '=', '.- ');
            EDIExportBuffer."Tax Rep. Post Code" := Contact."Post Code";
        END;

        EDIExportBuffer."Delivery GLN" := GetSalesInvoiceShipToGLN(SalesInvoiceHeader);
        SalesShipmentHeader.SETCURRENTKEY("Order No.");
        SalesShipmentHeader.SETRANGE("Order No.", SalesInvoiceHeader."Order No.");
        IF NOT SalesShipmentHeader.ISEMPTY THEN BEGIN
            SalesShipmentHeader.FINDFIRST;

            //>>MGTSEDI10.00.00.22
            IF (SalesInvoiceHeader."Shipment No." = '') THEN
                EDIExportBuffer."Delivery Document No." := SalesShipmentHeader."No."
            ELSE
                EDIExportBuffer."Delivery Document No." := SalesInvoiceHeader."Shipment No.";
            //<<MGTSEDI10.00.00.22

            EDIExportBuffer."Delivery Date" := SalesShipmentHeader."Posting Date";
            EDIExportBuffer."Delivery Date Text" := FORMAT(SalesShipmentHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');
            EDIExportBuffer."Delivery Name" := SalesShipmentHeader."Ship-to Name";
            EDIExportBuffer."Delivery City" := SalesShipmentHeader."Ship-to City";
            EDIExportBuffer."Delivery Country" := SalesShipmentHeader."Ship-to Country/Region Code";
            EDIExportBuffer."Delivery Street" := SalesShipmentHeader."Ship-to Address";
            EDIExportBuffer."Delivery Post Code" := SalesShipmentHeader."Ship-to Post Code";
        END;
        EDIExportBuffer.INSERT;

        TempEDIExportBufferLine.FINDSET;
        IF (EDIExportBuffer."Delivery Date" = 0D) THEN BEGIN
            EDIExportBuffer."Delivery Date" := TempEDIExportBufferLine."Delivery Date";
            EDIExportBuffer."Delivery Date Text" := TempEDIExportBufferLine."Delivery Date Text";
            EDIExportBuffer.MODIFY;
        END;
        REPEAT
            EDIExportBufferLine.INIT;
            EDIExportBufferLine := TempEDIExportBufferLine;
            EDIExportBufferLine."Document Enty No." := EDIExportBuffer."Entry No.";
            EDIExportBufferLine."Delivery GLN" := EDIExportBuffer."Delivery GLN";
            EDIExportBufferLine."Delivery Date Text" := EDIExportBuffer."Delivery Date Text";
            EDIExportBufferLine.INSERT;
        UNTIL TempEDIExportBufferLine.NEXT = 0;

        GenerateSalesInvoiceVATAndTextEDInfos(SalesInvoiceHeader, EDIExportBuffer);

    end;

    local procedure GetSalesInvoiceEDIExportBufferLines(SalesInvoiceHeader: Record "112"; var TempEDIExportBufferLine: Record "50078" temporary; Force: Boolean)
    var
        SalesInvoiceLine: Record "113";
        Item: Record "27";
        LineNo: Integer;
    begin
        TempEDIExportBufferLine.RESET;
        TempEDIExportBufferLine.DELETEALL;

        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SETFILTER(Quantity, '>%1', 0);
        SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
        IF SalesInvoiceLine.ISEMPTY THEN
            EXIT;
        SalesInvoiceLine.FINDSET;
        REPEAT
            IF NOT EDIExportSalesInvoiceExist(SalesInvoiceLine) OR Force THEN BEGIN
                LineNo += 1;
                Item.GET(SalesInvoiceLine."No.");
                TempEDIExportBufferLine.INIT;
                TempEDIExportBufferLine."Line No." := LineNo;
                TempEDIExportBufferLine."Source No." := DATABASE::"Sales Invoice Header";
                TempEDIExportBufferLine."Document Type" := TempEDIExportBufferLine."Document Type"::Invoice;
                TempEDIExportBufferLine."Document No." := SalesInvoiceHeader."No.";
                TempEDIExportBufferLine."Delivery GLN" := SalesInvoiceHeader.GLN;
                TempEDIExportBufferLine."Document Line No." := SalesInvoiceLine."Line No.";
                TempEDIExportBufferLine."Item No." := SalesInvoiceLine."No.";
                TempEDIExportBufferLine.Description := SalesInvoiceLine.Description;
                TempEDIExportBufferLine.EAN := Item."Code EAN 13";
                TempEDIExportBufferLine."Supplier Item No." := SalesInvoiceLine."No.";
                TempEDIExportBufferLine."Customer Item No." := SalesInvoiceLine."Cross-Reference No.";
                TempEDIExportBufferLine."Unit of Measure" := SalesInvoiceLine."Unit of Measure Code";
                TempEDIExportBufferLine.Quantity := SalesInvoiceLine.Quantity;
                TempEDIExportBufferLine."Net Price" := ROUND(SalesInvoiceLine."Line Amount" / SalesInvoiceLine.Quantity, 0.01);
                TempEDIExportBufferLine.Price := SalesInvoiceLine."Unit Price";
                TempEDIExportBufferLine."Delivery Quantity" := SalesInvoiceLine.Quantity;
                TempEDIExportBufferLine."Line Amount" := SalesInvoiceLine."Line Amount";
                TempEDIExportBufferLine."VAT Code" := 'VAT';
                TempEDIExportBufferLine."VAT %" := SalesInvoiceLine."VAT %";
                TempEDIExportBufferLine.INSERT;
            END;
        UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    local procedure EDIExportSalesInvoiceExist(SalesInvoiceLine: Record "113"): Boolean
    var
        EDIExportBufferLine: Record "50078";
    begin
        EDIExportBufferLine.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.");
        EDIExportBufferLine.SETRANGE("Document Type", EDIExportBufferLine."Document Type"::Invoice);
        EDIExportBufferLine.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        EDIExportBufferLine.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
        EXIT(NOT EDIExportBufferLine.ISEMPTY);
    end;


    procedure GenerateSalesInvoiceEDIBuffer(InvoiceNo: Code[20]; Force: Boolean)
    var
        TempEDIExportBufferLine: Record "50078" temporary;
        SalesInvoiceHeader: Record "112";
        Customer: Record "18";
    begin
        IF (InvoiceNo = '') THEN
            EXIT;
        IF NOT SalesInvoiceHeader.GET(InvoiceNo) THEN
            EXIT;
        IF (SalesInvoiceHeader."Order No." = '') THEN
            EXIT;
        Customer.GET(SalesInvoiceHeader."Sell-to Customer No.");
        IF NOT Customer.EDI THEN
            EXIT;


        GetSalesInvoiceEDIExportBufferLines(SalesInvoiceHeader, TempEDIExportBufferLine, Force);
        IF TempEDIExportBufferLine.ISEMPTY THEN
            EXIT;

        InsertSalesInvoiceEDIExportBuffer(SalesInvoiceHeader, TempEDIExportBufferLine);
    end;

    local procedure GenerateSalesInvoiceVATAndTextEDInfos(SalesInvoiceHeader: Record "112"; EDIExportBuffer: Record "50077")
    var
        SalesInvoiceLine: Record "113";
        TempVATAmountLine: Record "290" temporary;
        EDIExportBufferAddInfos: Record "50080";
        CompanyInformation: Record "79";
        PaymentTerms: Record "3";
        LineNo: Integer;
        Cst000: Label 'Payment Terms :  %1';
    begin
        CompanyInformation.GET;
        IF PaymentTerms.GET(SalesInvoiceHeader."Payment Terms Code") THEN BEGIN
            LineNo += 1;
            EDIExportBufferAddInfos.INIT;
            EDIExportBufferAddInfos.Type := EDIExportBufferAddInfos.Type::Text;
            EDIExportBufferAddInfos."Document Enty No." := EDIExportBuffer."Entry No.";
            EDIExportBufferAddInfos."Line No." := LineNo;
            EDIExportBufferAddInfos."Source No." := EDIExportBuffer."Source No.";
            EDIExportBufferAddInfos."Document Type" := EDIExportBuffer."Document Type";
            EDIExportBufferAddInfos."Document No." := EDIExportBuffer."Document No.";
            EDIExportBufferAddInfos."Document Line No." := 0;
            EDIExportBufferAddInfos.Code := 'AAI';
            EDIExportBufferAddInfos."Code Type" := 'AAI';
            IF (PaymentTerms.Description <> '') THEN
                EDIExportBufferAddInfos."Text 1" := STRSUBSTNO(Cst000, PaymentTerms.Description)
            ELSE
                EDIExportBufferAddInfos."Text 1" := STRSUBSTNO(Cst000, PaymentTerms.Code);
            EDIExportBufferAddInfos.INSERT;
        END;

        LineNo += 1;
        EDIExportBufferAddInfos.INIT;
        EDIExportBufferAddInfos.Type := EDIExportBufferAddInfos.Type::Text;
        EDIExportBufferAddInfos."Document Enty No." := EDIExportBuffer."Entry No.";
        EDIExportBufferAddInfos."Line No." := LineNo;
        EDIExportBufferAddInfos."Source No." := EDIExportBuffer."Source No.";
        EDIExportBufferAddInfos."Document Type" := EDIExportBuffer."Document Type";
        EDIExportBufferAddInfos."Document No." := EDIExportBuffer."Document No.";
        EDIExportBufferAddInfos."Document Line No." := 0;
        EDIExportBufferAddInfos.Code := 'PMD';
        EDIExportBufferAddInfos."Code Type" := 'PMD';
        EDIExportBufferAddInfos."Text 1" := CompanyInformation."Info pénalités";
        EDIExportBufferAddInfos.INSERT;

        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.FINDFIRST;
        SalesInvoiceLine.CalcVATAmountLines(SalesInvoiceHeader, TempVATAmountLine);
        TempVATAmountLine.SETFILTER("VAT Base", '<>%1', 0);
        IF TempVATAmountLine.ISEMPTY THEN BEGIN
            LineNo += 1;
            SalesInvoiceHeader.CALCFIELDS("Amount Including VAT");
            EDIExportBufferAddInfos.INIT;
            EDIExportBufferAddInfos.Type := EDIExportBufferAddInfos.Type::VAT;
            EDIExportBufferAddInfos."Document Enty No." := EDIExportBuffer."Entry No.";
            EDIExportBufferAddInfos."Line No." := LineNo;
            EDIExportBufferAddInfos."Source No." := EDIExportBuffer."Source No.";
            EDIExportBufferAddInfos."Document Type" := EDIExportBuffer."Document Type";
            EDIExportBufferAddInfos."Document No." := EDIExportBuffer."Document No.";
            EDIExportBufferAddInfos."Document Line No." := 0;
            EDIExportBufferAddInfos.Code := 'VAT';
            EDIExportBufferAddInfos."Code Type" := 'VAT';
            EDIExportBufferAddInfos.Amount := TempVATAmountLine."VAT Base";
            EDIExportBufferAddInfos."Amount Inc. VAT" := SalesInvoiceHeader."Amount Including VAT";
            EDIExportBufferAddInfos."VAT Amount" := 0;
            EDIExportBufferAddInfos."VAT %" := 0;
            EDIExportBufferAddInfos.INSERT;
        END
        ELSE BEGIN
            REPEAT
                LineNo += 1;
                EDIExportBufferAddInfos.INIT;
                EDIExportBufferAddInfos.Type := EDIExportBufferAddInfos.Type::VAT;
                EDIExportBufferAddInfos."Document Enty No." := EDIExportBuffer."Entry No.";
                EDIExportBufferAddInfos."Line No." := LineNo;
                EDIExportBufferAddInfos."Source No." := EDIExportBuffer."Source No.";
                EDIExportBufferAddInfos."Document Type" := EDIExportBuffer."Document Type";
                EDIExportBufferAddInfos."Document No." := EDIExportBuffer."Document No.";
                EDIExportBufferAddInfos."Document Line No." := 0;
                EDIExportBufferAddInfos.Code := 'VAT';
                EDIExportBufferAddInfos."Code Type" := 'VAT';
                EDIExportBufferAddInfos.Amount := TempVATAmountLine."VAT Base";
                EDIExportBufferAddInfos."Amount Inc. VAT" := TempVATAmountLine."Amount Including VAT";
                EDIExportBufferAddInfos."VAT Amount" := TempVATAmountLine."VAT Amount";
                EDIExportBufferAddInfos."VAT %" := TempVATAmountLine."VAT %";
                IF (EDIExportBufferAddInfos.Amount <> 0) THEN
                    EDIExportBufferAddInfos.INSERT;
            UNTIL TempVATAmountLine.NEXT = 0;
        END;

        //Generate Ecotax segment
        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"G/L Account");
        SalesInvoiceLine.SETRANGE("No.", '3610');
        SalesInvoiceLine.SETFILTER("Line Amount", '>0');
        IF SalesInvoiceLine.FINDFIRST THEN BEGIN
            LineNo += 1;
            EDIExportBufferAddInfos.INIT;
            EDIExportBufferAddInfos.Type := EDIExportBufferAddInfos.Type::VAT;
            EDIExportBufferAddInfos."Document Enty No." := EDIExportBuffer."Entry No.";
            EDIExportBufferAddInfos."Line No." := LineNo;
            EDIExportBufferAddInfos."Source No." := EDIExportBuffer."Source No.";
            EDIExportBufferAddInfos."Document Type" := EDIExportBuffer."Document Type";
            EDIExportBufferAddInfos."Document No." := EDIExportBuffer."Document No.";
            EDIExportBufferAddInfos."Document Line No." := 0;
            EDIExportBufferAddInfos.Code := 'C';
            EDIExportBufferAddInfos."Code Type" := 'TX';
            EDIExportBufferAddInfos."Text 1" := '3001000002282';
            EDIExportBufferAddInfos."Text 2" := SalesInvoiceLine.Description + ' ' + SalesInvoiceLine."Description 2";
            EDIExportBufferAddInfos.Amount := SalesInvoiceLine.Amount;
            EDIExportBufferAddInfos."Amount Inc. VAT" := SalesInvoiceLine."Amount Including VAT";
            EDIExportBufferAddInfos."VAT Amount" := SalesInvoiceLine."Amount Including VAT" - SalesInvoiceLine.Amount;
            EDIExportBufferAddInfos."VAT %" := SalesInvoiceLine."VAT %";
            EDIExportBufferAddInfos.INSERT;
        END;

        //TVA TEXT
        SalesInvoiceLine.SETRANGE("Line Amount");
        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::" ");
        SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
        IF SalesInvoiceLine.FINDSET THEN
            REPEAT
                LineNo += 1;
                EDIExportBufferAddInfos.INIT;
                EDIExportBufferAddInfos.Type := EDIExportBufferAddInfos.Type::Text;
                EDIExportBufferAddInfos."Document Enty No." := EDIExportBuffer."Entry No.";
                EDIExportBufferAddInfos."Line No." := LineNo;
                EDIExportBufferAddInfos."Source No." := EDIExportBuffer."Source No.";
                EDIExportBufferAddInfos."Document Type" := EDIExportBuffer."Document Type";
                EDIExportBufferAddInfos."Document No." := EDIExportBuffer."Document No.";
                EDIExportBufferAddInfos."Document Line No." := 0;
                EDIExportBufferAddInfos.Code := 'SIN';
                EDIExportBufferAddInfos."Code Type" := 'SIN';
                EDIExportBufferAddInfos."Text 1" := SalesInvoiceLine.Description + ' ' + SalesInvoiceLine."Description 2";
                EDIExportBufferAddInfos.INSERT;
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "36"; var GenJnlPostLine: Codeunit "12"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20])
    begin
        //GenerateSalesInvoiceEDIBuffer(SalesInvHdrNo,FALSE);
    end;


    procedure OpenDocument(EDIExportBuffer: Record "50077")
    var
        PurchaseHeader: Record "38";
        SalesInvoiceHeader: Record "112";
    begin
        IF (EDIExportBuffer."Source No." = DATABASE::"Purchase Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Order) THEN BEGIN
            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, EDIExportBuffer."Document No.") THEN
                PAGE.RUN(PAGE::"Purchase Order", PurchaseHeader);
        END;

        IF (EDIExportBuffer."Source No." = DATABASE::"Sales Invoice Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Invoice) THEN BEGIN
            IF SalesInvoiceHeader.GET(EDIExportBuffer."Document No.") THEN
                PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        END;
    end;


    procedure ResendDocument(var EDIExportBuffer: Record "50077")
    var
        PurchaseHeader: Record "38";
        SalesInvoiceHeader: Record "112";
        MsgResend: Label 'Resend in progress';
    begin
        CheckResendDocumentAuthorization();
        IF (EDIExportBuffer."Source No." = DATABASE::"Purchase Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Order) THEN BEGIN
            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, EDIExportBuffer."Document No.") THEN
                SendPurchaseOrder(PurchaseHeader, TRUE)
            ELSE BEGIN
                EDIExportBuffer.Exported := FALSE;
                EDIExportBuffer."Export Date" := 0DT;
                EDIExportBuffer.MODIFY;
            END;
            MESSAGE(MsgResend);
        END;

        IF (EDIExportBuffer."Source No." = DATABASE::"Sales Invoice Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Invoice) THEN BEGIN
            IF SalesInvoiceHeader.GET(EDIExportBuffer."Document No.") THEN
                GenerateSalesInvoiceEDIBuffer(SalesInvoiceHeader."No.", TRUE)
            ELSE BEGIN
                EDIExportBuffer.Exported := FALSE;
                EDIExportBuffer."Export Date" := 0DT;
                EDIExportBuffer.MODIFY;
            END;
            MESSAGE(MsgResend);
        END;
    end;


    procedure CheckResendDocumentAuthorization()
    var
        UserSetup: Record "91";
        ErrResendEDIDoc: Label 'You are not authorized to resend EDI documents.';
    begin
        IF NOT UserSetup.GET(USERID) THEN
            UserSetup.INIT;
        IF NOT UserSetup."Resend EDI Document" THEN
            ERROR(ErrResendEDIDoc);
    end;


    procedure ResendCustomerInvoice(SalesInvoiceHeader: Record "112")
    var
        MsgResend: Label 'Resend in progress';
        ConfirmEDISend: Label 'Are you sure you want to send invoice %1 via EDI?';
    begin
        IF NOT CONFIRM(STRSUBSTNO(ConfirmEDISend, SalesInvoiceHeader."No.")) THEN
            EXIT;
        CheckResendDocumentAuthorization();
        GenerateSalesInvoiceEDIBuffer(SalesInvoiceHeader."No.", TRUE);
        MESSAGE(MsgResend);
    end;

    local procedure GetSalesInvoiceShipToGLN(SalesInvoiceHeader: Record "112"): Text[13]
    var
        ANVEDICrossReference: Record "5327362";
        Customer: Record "18";
    begin
        IF (SalesInvoiceHeader.GLN <> '') AND (STRLEN(SalesInvoiceHeader.GLN) = 13) THEN
            EXIT(COPYSTR(SalesInvoiceHeader.GLN, 1, 13));

        IF (SalesInvoiceHeader."Ship-to Code" = '') THEN BEGIN
            Customer.GET(SalesInvoiceHeader."Sell-to Customer No.");
            EXIT(Customer.GLN);
        END;

        ANVEDICrossReference.SETRANGE("Cross-Reference Type", 'MOBIVIA-SHIP-GLN');
        ANVEDICrossReference.SETRANGE("Table ID", DATABASE::"Ship-to Address");
        ANVEDICrossReference.SETRANGE("Table Relation Par 1", SalesInvoiceHeader."Sell-to Customer No.");
        ANVEDICrossReference.SETRANGE("Internal No.", SalesInvoiceHeader."Ship-to Code");
        IF NOT ANVEDICrossReference.ISEMPTY THEN BEGIN
            ANVEDICrossReference.FINDSET;
            EXIT(ANVEDICrossReference."External No.");
        END
        ELSE
            EXIT('');
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'GLN', false, false)]
    local procedure OnAfterValidateGLNSalesHeader(var Rec: Record "36"; var xRec: Record "36"; CurrFieldNo: Integer)
    var
        EDIDeliveryGLNCustomer: Record "50081";
    begin
        IF EDIDeliveryGLNCustomer.GET(Rec.GLN) THEN BEGIN
            IF Rec."Bill-to Customer No." <> EDIDeliveryGLNCustomer."Bill-to Customer No." THEN
                Rec.VALIDATE(Rec."Bill-to Customer No.", EDIDeliveryGLNCustomer."Bill-to Customer No.");
        END;
    end;
}

