codeunit 50052 "DEL MGTS EDI Management"
{


    trigger OnRun()
    begin
        GenerateSalesInvoiceEDIBuffer('0555891', TRUE);
    end;

    local procedure SendPurchaseOrder(PurchaseHeader: Record "Purchase Header"; Force: Boolean)
    var
        TempEDIExportBufferLine: Record "DEL EDI Export Buffer Line" temporary;
        Vendor: Record Vendor;
    begin
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        IF NOT Vendor."DEL EDI" THEN
            EXIT;
        GetPurchEDIExportBufferLines(PurchaseHeader, TempEDIExportBufferLine, Force);
        IF TempEDIExportBufferLine.ISEMPTY THEN
            EXIT;

        InsertPurchEDIExportBuffer(PurchaseHeader, TempEDIExportBufferLine);
    end;

    local procedure InsertPurchEDIExportBuffer(PurchaseHeader: Record "Purchase Header"; var TempEDIExportBufferLine: Record "DEL EDI Export Buffer Line" temporary)
    var
        CompanyInformation: Record "Company Information";
        EDIExportBuffer: Record "DEL EDI Export Buffer";
        EDIExportBufferLine: Record "DEL EDI Export Buffer Line";
        Vendor: Record Vendor;
    begin
        Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
        IF NOT Vendor."DEL EDI" THEN
            EXIT;
        CompanyInformation.GET();

        PurchaseHeader.CALCFIELDS(Amount);
        EDIExportBuffer.INIT();
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
        EDIExportBuffer."Delivery GLN" := PurchaseHeader."DEL GLN";
        EDIExportBuffer."Contact Name" := CompanyInformation.Name;
        EDIExportBuffer."Contact Email" := CompanyInformation."E-Mail";
        EDIExportBuffer."EDI Document Type" := PurchaseHeader."DEL Type Order EDI";
        IF (PurchaseHeader."Currency Code" <> '') THEN
            EDIExportBuffer."Currency Code" := PurchaseHeader."Currency Code"
        ELSE
            EDIExportBuffer."Currency Code" := 'CHF';
        EDIExportBuffer."Document Amount" := PurchaseHeader.Amount;
        EDIExportBuffer.INSERT();

        TempEDIExportBufferLine.FINDSET();
        IF (EDIExportBuffer."Delivery Date" = 0D) THEN BEGIN
            EDIExportBuffer."Delivery Date" := TempEDIExportBufferLine."Delivery Date";
            EDIExportBuffer."Delivery Date Text" := TempEDIExportBufferLine."Delivery Date Text";
            EDIExportBuffer.MODIFY();
        END;
        REPEAT
            EDIExportBufferLine.INIT();
            EDIExportBufferLine := TempEDIExportBufferLine;
            EDIExportBufferLine."Document Enty No." := EDIExportBuffer."Entry No.";
            EDIExportBufferLine."Delivery GLN" := EDIExportBuffer."Delivery GLN";
            EDIExportBufferLine.INSERT();
        UNTIL TempEDIExportBufferLine.NEXT() = 0;
    end;

    local procedure GetPurchEDIExportBufferLines(PurchaseHeader: Record "Purchase Header"; var TempEDIExportBufferLine: Record "DEL EDI Export Buffer Line" temporary; Force: Boolean)
    var
        Item: Record Item;
        PurchaseLine: Record "Purchase Line";
        LineNo: Integer;
    begin
        TempEDIExportBufferLine.RESET();
        TempEDIExportBufferLine.DELETEALL();
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '>%1', 0);
        PurchaseLine.SETFILTER("No.", '<>%1', '');
        IF PurchaseLine.ISEMPTY THEN
            EXIT;
        PurchaseLine.FINDSET();
        REPEAT
            IF NOT EDIExportBufferLineExist(PurchaseLine) OR Force THEN BEGIN
                LineNo += 1;
                Item.GET(PurchaseLine."No.");
                TempEDIExportBufferLine.INIT();
                TempEDIExportBufferLine."Line No." := LineNo;
                TempEDIExportBufferLine."Source No." := DATABASE::"Purchase Line";
                TempEDIExportBufferLine."Document Type" := PurchaseLine."Document Type";
                TempEDIExportBufferLine."Document No." := PurchaseLine."Document No.";
                TempEDIExportBufferLine."Delivery GLN" := PurchaseHeader."DEL GLN";
                TempEDIExportBufferLine."Document Line No." := PurchaseLine."Line No.";
                TempEDIExportBufferLine."Item No." := PurchaseLine."No.";
                TempEDIExportBufferLine.Description := PurchaseLine.Description;
                TempEDIExportBufferLine.EAN := Item."DEL Code EAN 13";
                TempEDIExportBufferLine."Supplier Item No." := PurchaseLine."Vendor Item No.";
                TempEDIExportBufferLine."Customer Item No." := PurchaseLine."No.";
                TempEDIExportBufferLine."Unit of Measure" := PurchaseLine."Unit of Measure Code";
                TempEDIExportBufferLine.Quantity := PurchaseLine.Quantity;
                TempEDIExportBufferLine.Price := ROUND(PurchaseLine."Line Amount" / PurchaseLine.Quantity, 0.01);
                TempEDIExportBufferLine."Delivery Quantity" := PurchaseLine.Quantity;
                TempEDIExportBufferLine."Delivery Date" := PurchaseLine."Requested Receipt Date";
                TempEDIExportBufferLine."Delivery Date Text" := FORMAT(PurchaseLine."Requested Receipt Date", 0, '<Year4>-<Month,2>-<Day,2>');
                TempEDIExportBufferLine.INSERT();
            END;
        UNTIL PurchaseLine.NEXT() = 0;
    end;

    local procedure EDIExportBufferLineExist(PurchaseLine: Record "Purchase Line"): Boolean
    var
        EDIExportBufferLine: Record "DEL EDI Export Buffer Line";
    begin
        EDIExportBufferLine.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.");
        EDIExportBufferLine.SETRANGE("Document Type", PurchaseLine."Document Type");
        EDIExportBufferLine.SETRANGE("Document No.", PurchaseLine."Document No.");
        EDIExportBufferLine.SETRANGE("Document Line No.", PurchaseLine."Line No.");
        EXIT(NOT EDIExportBufferLine.ISEMPTY);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var

    begin
        IF PreviewMode THEN
            EXIT;

        SendPurchaseOrder(PurchaseHeader, FALSE);
    end;

    local procedure InsertSalesInvoiceEDIExportBuffer(SalesInvoiceHeader: Record "Sales Invoice Header"; var TempEDIExportBufferLine: Record "DEL EDI Export Buffer Line" temporary)
    var
        CompanyInformation: Record "Company Information";

        Contact: Record Contact;
        Customer: Record Customer;
        EDIExportBuffer: Record "DEL EDI Export Buffer";
        EDIExportBufferLine: Record "DEL EDI Export Buffer Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        IF (SalesInvoiceHeader."Order No." = '') THEN
            EXIT;
        Customer.GET(SalesInvoiceHeader."Sell-to Customer No.");
        IF NOT Customer."DEL EDI" THEN
            EXIT;
        CompanyInformation.GET();
        SalesInvoiceHeader.CALCFIELDS(Amount, "Amount Including VAT");

        EDIExportBuffer.INIT();
        EDIExportBuffer."Source No." := DATABASE::"Sales Invoice Header";
        EDIExportBuffer."Document Type" := EDIExportBuffer."Document Type"::Invoice;
        EDIExportBuffer."Document No." := SalesInvoiceHeader."No.";
        EDIExportBuffer."Document Date" := SalesInvoiceHeader."Posting Date";
        EDIExportBuffer."Document Date Text" := FORMAT(SalesInvoiceHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');
        EDIExportBuffer."Your Reference" := SalesInvoiceHeader."External Document No.";
        EDIExportBuffer."Contact Name" := CompanyInformation.Name;
        EDIExportBuffer."Contact Email" := CompanyInformation."E-Mail";
        EDIExportBuffer."EDI Order Type" := SalesInvoiceHeader."DEL Type Order EDI";
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
        IF (STRLEN(CompanyInformation."DEL Info fiscales 1") >= 24) THEN
            EDIExportBuffer."Supplier Legal Form" := COPYSTR(CompanyInformation."DEL Info fiscales 1", 1, 24);
        IF (STRLEN(CompanyInformation."DEL Info fiscales 1") > 25) THEN
            EDIExportBuffer."Supplier Capital Stock" := COPYSTR(CompanyInformation."DEL Info fiscales 1", 25, STRLEN(CompanyInformation."DEL Info fiscales 1"));

        EDIExportBuffer."Supplier City" := CompanyInformation.City;
        EDIExportBuffer."Supplier Country" := CompanyInformation."Country/Region Code";
        EDIExportBuffer."Supplier Street" := CompanyInformation.Address;
        EDIExportBuffer."Supplier VAT No." := DELCHR(CompanyInformation."VAT Registration No.", '=', '.- ');
        EDIExportBuffer."Supplier Registration No." := CompanyInformation."UID Number";
        EDIExportBuffer."Supplier SIREN No." := CompanyInformation."DEL Info fiscales 2";
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



        IF Contact.GET(SalesInvoiceHeader."DEL Fiscal Repr.") THEN BEGIN

            EDIExportBuffer."Tax Representative ID" := Contact."DEL GLN";
            EDIExportBuffer."Tax Representative Name" := Contact.Name;
            EDIExportBuffer."Tax Representative City" := Contact.City;
            EDIExportBuffer."Tax Representative Country" := Contact."Country/Region Code";
            EDIExportBuffer."Tax Representative Street" := Contact.Address;
            EDIExportBuffer."Tax Representative VAT  No." := DELCHR(Contact."VAT Registration No.", '=', '.- ');
            EDIExportBuffer."Tax Rep. Intracom VAT  No." := DELCHR(Contact."N° de TVA", '=', '.- ');
            EDIExportBuffer."Tax Rep. Post Code" := Contact."Post Code";
        END;


        SalesShipmentHeader.SETCURRENTKEY("Order No.");
        SalesShipmentHeader.SETRANGE("Order No.", SalesInvoiceHeader."Order No.");
        IF NOT SalesShipmentHeader.ISEMPTY THEN BEGIN
            SalesShipmentHeader.FINDFIRST();

            IF (SalesInvoiceHeader."DEL Shipment No." = '') THEN
                EDIExportBuffer."Delivery Document No." := SalesShipmentHeader."No."
            ELSE
                EDIExportBuffer."Delivery Document No." := SalesInvoiceHeader."DEL Shipment No.";


            EDIExportBuffer."Delivery Date" := SalesShipmentHeader."Posting Date";
            EDIExportBuffer."Delivery Date Text" := FORMAT(SalesShipmentHeader."Posting Date", 0, '<Year4>-<Month,2>-<Day,2>');
            EDIExportBuffer."Delivery Name" := SalesShipmentHeader."Ship-to Name";
            EDIExportBuffer."Delivery City" := SalesShipmentHeader."Ship-to City";
            EDIExportBuffer."Delivery Country" := SalesShipmentHeader."Ship-to Country/Region Code";
            EDIExportBuffer."Delivery Street" := SalesShipmentHeader."Ship-to Address";
            EDIExportBuffer."Delivery Post Code" := SalesShipmentHeader."Ship-to Post Code";
        END;
        EDIExportBuffer.INSERT();

        TempEDIExportBufferLine.FINDSET();
        IF (EDIExportBuffer."Delivery Date" = 0D) THEN BEGIN
            EDIExportBuffer."Delivery Date" := TempEDIExportBufferLine."Delivery Date";
            EDIExportBuffer."Delivery Date Text" := TempEDIExportBufferLine."Delivery Date Text";
            EDIExportBuffer.MODIFY();
        END;
        REPEAT
            EDIExportBufferLine.INIT();
            EDIExportBufferLine := TempEDIExportBufferLine;
            EDIExportBufferLine."Document Enty No." := EDIExportBuffer."Entry No.";
            EDIExportBufferLine."Delivery GLN" := EDIExportBuffer."Delivery GLN";
            EDIExportBufferLine."Delivery Date Text" := EDIExportBuffer."Delivery Date Text";
            EDIExportBufferLine.INSERT();
        UNTIL TempEDIExportBufferLine.NEXT() = 0;

        GenerateSalesInvoiceVATAndTextEDInfos(SalesInvoiceHeader, EDIExportBuffer);

    end;

    local procedure GetSalesInvoiceEDIExportBufferLines(SalesInvoiceHeader: Record "Sales Invoice Header"; var TempEDIExportBufferLine: Record "DEL EDI Export Buffer Line" temporary; Force: Boolean)
    var
        Item: Record Item;
        SalesInvoiceLine: Record "Sales Invoice Line";
        LineNo: Integer;
    begin
        TempEDIExportBufferLine.RESET();
        TempEDIExportBufferLine.DELETEALL();

        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
        SalesInvoiceLine.SETFILTER(Quantity, '>%1', 0);
        SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
        IF SalesInvoiceLine.ISEMPTY THEN
            EXIT;
        SalesInvoiceLine.FINDSET();
        REPEAT
            IF NOT EDIExportSalesInvoiceExist(SalesInvoiceLine) OR Force THEN BEGIN
                LineNo += 1;
                Item.GET(SalesInvoiceLine."No.");
                TempEDIExportBufferLine.INIT();
                TempEDIExportBufferLine."Line No." := LineNo;
                TempEDIExportBufferLine."Source No." := DATABASE::"Sales Invoice Header";
                TempEDIExportBufferLine."Document Type" := TempEDIExportBufferLine."Document Type"::Invoice;
                TempEDIExportBufferLine."Document No." := SalesInvoiceHeader."No.";
                TempEDIExportBufferLine."Delivery GLN" := SalesInvoiceHeader."DEL GLN";
                TempEDIExportBufferLine."Document Line No." := SalesInvoiceLine."Line No.";
                TempEDIExportBufferLine."Item No." := SalesInvoiceLine."No.";
                TempEDIExportBufferLine.Description := SalesInvoiceLine.Description;
                TempEDIExportBufferLine.EAN := Item."DEL Code EAN 13";
                TempEDIExportBufferLine."Supplier Item No." := SalesInvoiceLine."No.";
                TempEDIExportBufferLine."Customer Item No." := SalesInvoiceLine."Item Reference No.";
                TempEDIExportBufferLine."Unit of Measure" := SalesInvoiceLine."Unit of Measure Code";
                TempEDIExportBufferLine.Quantity := SalesInvoiceLine.Quantity;
                TempEDIExportBufferLine."Net Price" := ROUND(SalesInvoiceLine."Line Amount" / SalesInvoiceLine.Quantity, 0.01);
                TempEDIExportBufferLine.Price := SalesInvoiceLine."Unit Price";
                TempEDIExportBufferLine."Delivery Quantity" := SalesInvoiceLine.Quantity;
                TempEDIExportBufferLine."Line Amount" := SalesInvoiceLine."Line Amount";
                TempEDIExportBufferLine."VAT Code" := 'VAT';
                TempEDIExportBufferLine."VAT %" := SalesInvoiceLine."VAT %";
                TempEDIExportBufferLine.INSERT();
            END;
        UNTIL SalesInvoiceLine.NEXT() = 0;
    end;

    local procedure EDIExportSalesInvoiceExist(SalesInvoiceLine: Record "Sales Invoice Line"): Boolean
    var
        EDIExportBufferLine: Record "DEL EDI Export Buffer Line";
    begin
        EDIExportBufferLine.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.");
        EDIExportBufferLine.SETRANGE("Document Type", EDIExportBufferLine."Document Type"::Invoice);
        EDIExportBufferLine.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        EDIExportBufferLine.SETRANGE("Document Line No.", SalesInvoiceLine."Line No.");
        EXIT(NOT EDIExportBufferLine.ISEMPTY);
    end;


    procedure GenerateSalesInvoiceEDIBuffer(InvoiceNo: Code[20]; Force: Boolean)
    var
        Customer: Record Customer;
        TempEDIExportBufferLine: Record "DEL EDI Export Buffer Line" temporary;
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        IF (InvoiceNo = '') THEN
            EXIT;
        IF NOT SalesInvoiceHeader.GET(InvoiceNo) THEN
            EXIT;
        IF (SalesInvoiceHeader."Order No." = '') THEN
            EXIT;
        Customer.GET(SalesInvoiceHeader."Sell-to Customer No.");
        IF NOT Customer."DEL EDI" THEN
            EXIT;


        GetSalesInvoiceEDIExportBufferLines(SalesInvoiceHeader, TempEDIExportBufferLine, Force);
        IF TempEDIExportBufferLine.ISEMPTY THEN
            EXIT;

        InsertSalesInvoiceEDIExportBuffer(SalesInvoiceHeader, TempEDIExportBufferLine);
    end;

    local procedure GenerateSalesInvoiceVATAndTextEDInfos(SalesInvoiceHeader: Record "Sales Invoice Header"; EDIExportBuffer: Record "DEL EDI Export Buffer")
    var
        CompanyInformation: Record "Company Information";
        EDIExportBufferAddInfos: Record "DEL EDI Exp. Buffer Add. Infos";
        PaymentTerms: Record "Payment Terms";
        SalesInvoiceLine: Record "Sales Invoice Line";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        LineNo: Integer;
        Cst000: Label 'Payment Terms :  %1';
    begin
        CompanyInformation.GET();
        IF PaymentTerms.GET(SalesInvoiceHeader."Payment Terms Code") THEN BEGIN
            LineNo += 1;
            EDIExportBufferAddInfos.INIT();
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
            EDIExportBufferAddInfos.INSERT();
        END;

        LineNo += 1;
        EDIExportBufferAddInfos.INIT();
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
        EDIExportBufferAddInfos.INSERT();

        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.FINDFIRST();
        SalesInvoiceLine.CalcVATAmountLines(SalesInvoiceHeader, TempVATAmountLine);
        TempVATAmountLine.SETFILTER("VAT Base", '<>%1', 0);
        IF TempVATAmountLine.ISEMPTY THEN BEGIN
            LineNo += 1;
            SalesInvoiceHeader.CALCFIELDS("Amount Including VAT");
            EDIExportBufferAddInfos.INIT();
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
            EDIExportBufferAddInfos.INSERT();
        END
        ELSE
            REPEAT
                LineNo += 1;
                EDIExportBufferAddInfos.INIT();
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
                    EDIExportBufferAddInfos.INSERT();
            UNTIL TempVATAmountLine.NEXT() = 0;


        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"G/L Account");
        SalesInvoiceLine.SETRANGE("No.", '3610');
        SalesInvoiceLine.SETFILTER("Line Amount", '>0');
        IF SalesInvoiceLine.FINDFIRST() THEN BEGIN
            LineNo += 1;
            EDIExportBufferAddInfos.INIT();
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
            EDIExportBufferAddInfos.INSERT();
        END;


        SalesInvoiceLine.SETRANGE("Line Amount");
        SalesInvoiceLine.SETRANGE("Document No.", SalesInvoiceHeader."No.");
        SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::" ");
        SalesInvoiceLine.SETFILTER("No.", '<>%1', '');
        IF SalesInvoiceLine.FINDSET() THEN
            REPEAT
                LineNo += 1;
                EDIExportBufferAddInfos.INIT();
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
                EDIExportBufferAddInfos.INSERT();
            UNTIL SalesInvoiceLine.NEXT() = 0;
    end;



    procedure OpenDocument(EDIExportBuffer: Record "DEL EDI Export Buffer")
    var
        PurchaseHeader: Record "Purchase Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        IF (EDIExportBuffer."Source No." = DATABASE::"Purchase Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Order) THEN
            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, EDIExportBuffer."Document No.") THEN
                PAGE.RUN(PAGE::"Purchase Order", PurchaseHeader);

        IF (EDIExportBuffer."Source No." = DATABASE::"Sales Invoice Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Invoice) THEN
            IF SalesInvoiceHeader.GET(EDIExportBuffer."Document No.") THEN
                PAGE.RUN(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
    end;


    procedure ResendDocument(var EDIExportBuffer: Record "DEL EDI Export Buffer")
    var
        PurchaseHeader: Record "Purchase Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        MsgResend: Label 'Resend in progress';
    begin
        CheckResendDocumentAuthorization();
        IF (EDIExportBuffer."Source No." = DATABASE::"Purchase Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Order) THEN BEGIN
            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, EDIExportBuffer."Document No.") THEN
                SendPurchaseOrder(PurchaseHeader, TRUE)
            ELSE BEGIN
                EDIExportBuffer.Exported := FALSE;
                EDIExportBuffer."Export Date" := 0DT;
                EDIExportBuffer.MODIFY();
            END;
            MESSAGE(MsgResend);
        END;

        IF (EDIExportBuffer."Source No." = DATABASE::"Sales Invoice Header") AND (EDIExportBuffer."Document Type" = EDIExportBuffer."Document Type"::Invoice) THEN BEGIN
            IF SalesInvoiceHeader.GET(EDIExportBuffer."Document No.") THEN
                GenerateSalesInvoiceEDIBuffer(SalesInvoiceHeader."No.", TRUE)
            ELSE BEGIN
                EDIExportBuffer.Exported := FALSE;
                EDIExportBuffer."Export Date" := 0DT;
                EDIExportBuffer.MODIFY();
            END;
            MESSAGE(MsgResend);
        END;
    end;


    procedure CheckResendDocumentAuthorization()
    var
        UserSetup: Record "User Setup";
        ErrResendEDIDoc: Label 'You are not authorized to resend EDI documents.';
    begin
        IF NOT UserSetup.GET(USERID) THEN
            UserSetup.INIT();
        IF NOT UserSetup."DEL Resend EDI Document" THEN
            ERROR(ErrResendEDIDoc);
    end;


    procedure ResendCustomerInvoice(SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        ConfirmEDISend: Label 'Are you sure you want to send invoice %1 via EDI?';
        MsgResend: Label 'Resend in progress';
    begin
        IF NOT CONFIRM(STRSUBSTNO(ConfirmEDISend, SalesInvoiceHeader."No.")) THEN
            EXIT;
        CheckResendDocumentAuthorization();
        GenerateSalesInvoiceEDIBuffer(SalesInvoiceHeader."No.", TRUE);
        MESSAGE(MsgResend);
    end;



    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'DEL GLN', false, false)]
    local procedure OnAfterValidateGLNSalesHeader(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        EDIDeliveryGLNCustomer: Record "DEL EDI Delivery GLN Customer";
    begin
        IF EDIDeliveryGLNCustomer.GET(Rec."DEL GLN") THEN
            IF Rec."Bill-to Customer No." <> EDIDeliveryGLNCustomer."Bill-to Customer No." THEN
                Rec.VALIDATE(Rec."Bill-to Customer No.", EDIDeliveryGLNCustomer."Bill-to Customer No.");
    end;
}

