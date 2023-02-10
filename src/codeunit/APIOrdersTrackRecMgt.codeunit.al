codeunit 50044 "DEL API Orders Track Rec. Mgt."
{


    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    local procedure GetACODealID(ACONo: Code[20]): Code[20]
    var
        Element: Record "DEL Element";
    begin

        Element.SETCURRENTKEY(Type, "Type No.");
        Element.SETRANGE(Type, Element.Type::ACO);
        Element.SETRANGE("Type No.", ACONo);
        Element.SETRANGE(Instance, Element.Instance::planned);
        IF NOT Element.ISEMPTY THEN BEGIN
            Element.FINDFIRST();
            EXIT(Element.Deal_ID);
        END
        ELSE
            EXIT('');
    end;

    local procedure GetVCODealID(VCONo: Code[20]): Code[20]
    var
        Element: Record "DEL Element";
    begin

        Element.SETCURRENTKEY(Type, "Type No.");
        Element.SETRANGE(Type, Element.Type::VCO);
        Element.SETRANGE("Type No.", VCONo);
        Element.SETRANGE(Instance, Element.Instance::planned);
        IF NOT Element.ISEMPTY THEN BEGIN
            Element.FINDFIRST();
            EXIT(Element.Deal_ID);
        END
        ELSE
            EXIT('');
    end;

    local procedure ACOInDeal(ACONo: Code[20]): Boolean
    var
        Deal: Record "DEL Deal";
        Element: Record "DEL Element";
        SalesHeader: Record "Sales Header";
    begin

        Element.SETCURRENTKEY(Type, "Type No.");
        Element.SETRANGE(Type, Element.Type::ACO);
        Element.SETRANGE("Type No.", ACONo);
        Element.SETRANGE(Instance, Element.Instance::planned);
        IF NOT Element.ISEMPTY THEN BEGIN
            Element.FINDFIRST();

            IF NOT Deal.GET(Element.Deal_ID) THEN
                EXIT(FALSE);
            IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
                EXIT(FALSE);

            Element.SETRANGE("Type No.");
            Element.SETCURRENTKEY(Deal_ID, Type, Instance);
            Element.SETRANGE(Type, Element.Type::VCO);
            Element.SETRANGE(Deal_ID, Element.Deal_ID);
            Element.SETRANGE(Instance, Element.Instance::planned);
            IF NOT Element.ISEMPTY THEN BEGIN
                Element.FINDFIRST();
                EXIT(SalesHeader.GET(SalesHeader."Document Type"::Order, Element."Type No.") AND ACOHasLines(ACONo));
            END
            ELSE
                EXIT(FALSE)
        END
        ELSE
            EXIT(FALSE);
    end;

    local procedure VCOInDeal(VCONo: Code[20]): Boolean
    var
        Deal: Record "DEL Deal";
        Element: Record "DEL Element";
        PurchaseHeader: Record "Purchase Header";
    begin

        Element.SETCURRENTKEY(Type, "Type No.");
        Element.SETRANGE(Type, Element.Type::VCO);
        Element.SETRANGE("Type No.", VCONo);
        Element.SETRANGE(Instance, Element.Instance::planned);
        IF NOT Element.ISEMPTY THEN BEGIN
            Element.FINDFIRST();

            IF NOT Deal.GET(Element.Deal_ID) THEN
                EXIT(FALSE);
            IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
                EXIT(FALSE);

            Element.SETRANGE("Type No.");
            Element.SETCURRENTKEY(Deal_ID, Type, Instance);
            Element.SETRANGE(Type, Element.Type::ACO);
            Element.SETRANGE(Deal_ID, Element.Deal_ID);
            Element.SETRANGE(Instance, Element.Instance::planned);
            IF NOT Element.ISEMPTY THEN BEGIN
                Element.FINDFIRST();
                EXIT(PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, Element."Type No.") AND ACOHasLines(PurchaseHeader."No."));
            END
            ELSE
                EXIT(FALSE)
        END
        ELSE
            EXIT(FALSE);
    end;

    local procedure ACOHasLines(ACONo: Code[20]): Boolean
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", ACONo);
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '<>%1', 0);
        EXIT(NOT PurchaseLine.ISEMPTY);
    end;

    local procedure IsACOUpdated(PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"): Boolean
    begin
        EXIT((PurchaseHeader."Order Date" <> xPurchaseHeader."Order Date") OR
              (PurchaseHeader."Purchaser Code" <> xPurchaseHeader."Purchaser Code") OR
              (PurchaseHeader."Buy-from Vendor No." <> xPurchaseHeader."Buy-from Vendor No.") OR
              (PurchaseHeader."DEL Ship Per" <> xPurchaseHeader."DEL Ship Per") OR
              (PurchaseHeader."Ship-to Code" <> xPurchaseHeader."Ship-to Code") OR
              (PurchaseHeader."DEL Port de départ" <> xPurchaseHeader."DEL Port de départ") OR
              (PurchaseHeader."DEL Port d'arrivée" <> xPurchaseHeader."DEL Port d'arrivée") OR
              (PurchaseHeader."DEL Code événement" <> xPurchaseHeader."DEL Code événement") OR
              (PurchaseHeader."Requested Receipt Date" <> xPurchaseHeader."Requested Receipt Date") OR
              (PurchaseHeader."Shipment Method Code" <> xPurchaseHeader."Shipment Method Code") OR
              (PurchaseHeader."Due Date" <> xPurchaseHeader."Due Date") OR
              (PurchaseHeader."Currency Code" <> xPurchaseHeader."Currency Code"));
    end;

    local procedure IsACOLineUpdated(PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line"): Boolean
    begin
        EXIT((PurchaseLine."Item Reference No." <> xPurchaseLine."Item Reference No.") OR
             (PurchaseLine."Vendor Item No." <> xPurchaseLine."Vendor Item No.") OR
             (PurchaseLine."No." <> xPurchaseLine."No.") OR
             (PurchaseLine."DEL External reference NGTS" <> xPurchaseLine."DEL External reference NGTS") OR


             (PurchaseLine."DEL First Purch. Order" <> xPurchaseLine."DEL First Purch. Order") OR
             (PurchaseLine.Description <> xPurchaseLine.Description) OR


             (PurchaseLine.Quantity <> xPurchaseLine.Quantity) OR
             (PurchaseLine."Line Amount" <> xPurchaseLine."Line Amount"));
    end;

    local procedure IsVCOUpdated(SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"): Boolean
    begin
        EXIT((SalesHeader."External Document No." <> xSalesHeader."External Document No.") OR
              (SalesHeader."Requested Delivery Date" <> xSalesHeader."Requested Delivery Date") OR
              (SalesHeader."Sell-to Customer No." <> xSalesHeader."Sell-to Customer No."));
    end;

    local procedure GetVCONo(DealID: Code[20]): Code[20]
    var
        Deal: Record "DEL Deal";
        Element: Record "DEL Element";
    begin

        IF NOT Deal.GET(DealID) THEN
            EXIT('');
        IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
            EXIT('');

        Element.SETCURRENTKEY(Deal_ID, Type, Instance);
        Element.SETRANGE(Type, Element.Type::VCO);
        Element.SETRANGE(Deal_ID, DealID);
        Element.SETRANGE(Instance, Element.Instance::planned);
        IF NOT Element.ISEMPTY THEN BEGIN
            Element.FINDFIRST();
            EXIT(Element."Type No.");
        END
        ELSE
            EXIT('');
    end;

    local procedure GetACONo(DealID: Code[20]): Code[20]
    var
        Deal: Record "DEL Deal";
        Element: Record "DEL Element";
    begin

        IF NOT Deal.GET(DealID) THEN
            EXIT('');
        IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
            EXIT('');

        Element.SETCURRENTKEY(Deal_ID, Type, Instance);
        Element.SETRANGE(Type, Element.Type::ACO);
        Element.SETRANGE(Deal_ID, DealID);
        Element.SETRANGE(Instance, Element.Instance::planned);
        IF NOT Element.ISEMPTY THEN BEGIN
            Element.FINDFIRST();
            EXIT(Element."Type No.");
        END
        ELSE
            EXIT('');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchHeader(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; RunTrigger: Boolean)
    var
        DealID: Code[20];
    begin
        IF (Rec."Document Type" <> Rec."Document Type"::Order) THEN
            EXIT;

        IF Rec.ISTEMPORARY OR NOT RunTrigger OR NOT ACOInDeal(Rec."No.") THEN
            EXIT;

        IF NOT IsACOUpdated(Rec, xRec) THEN
            EXIT;

        DealID := GetACODealID(Rec."No.");
        UpdateOrderAPIRecordTracking(DealID);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    var
        DealID: Code[20];
    begin
        IF (Rec."Document Type" <> Rec."Document Type"::Order) THEN
            EXIT;
        IF Rec.ISTEMPORARY OR NOT RunTrigger OR NOT ACOInDeal(Rec."Document No.") THEN
            EXIT;

        IF NOT IsACOLineUpdated(Rec, xRec) THEN
            EXIT;

        DealID := GetACODealID(Rec."Document No.");
        UpdateOrderAPIRecordTracking(DealID);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifySalesHeader(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; RunTrigger: Boolean)
    var
        DealID: Code[20];
    begin
        IF (Rec."Document Type" <> Rec."Document Type"::Order) THEN
            EXIT;

        IF Rec.ISTEMPORARY OR NOT RunTrigger OR NOT VCOInDeal(Rec."No.") THEN
            EXIT;

        IF NOT IsVCOUpdated(Rec, xRec) THEN
            EXIT;

        DealID := GetVCODealID(Rec."No.");
        UpdateOrderAPIRecordTracking(DealID);
    end;

    local procedure UpdateACOInfo(PurchaseHeader: Record "Purchase Header"; var OrderAPIRecordTracking: Record "DEL Order API Record Tracking")
    var
        PurchaseLine: Record "Purchase Line";
        TotalPurchaseLine: Record "Purchase Line";
        Vendor: Record Vendor;
        DocumentTotals: Codeunit "Document Totals";
        VATAmount: Decimal;
    begin
        IF NOT Vendor.GET(PurchaseHeader."Buy-from Vendor No.") THEN
            Vendor.INIT();

        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN BEGIN
            OrderAPIRecordTracking.INIT();
            OrderAPIRecordTracking."Deal ID" := OrderAPIRecordTracking."Deal ID";
            OrderAPIRecordTracking.INSERT();
        END;

        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN
            EXIT;

        OrderAPIRecordTracking."ACO No." := PurchaseHeader."No.";
        OrderAPIRecordTracking."ACO Date" := PurchaseHeader."Order Date";
        OrderAPIRecordTracking."ACO Product" := PurchaseHeader."Purchaser Code";
        OrderAPIRecordTracking."ACO Supplier ERP Code" := PurchaseHeader."Buy-from Vendor No.";
        OrderAPIRecordTracking."ACO Supplier ERP Name" := PurchaseHeader."Buy-from Vendor Name";
        OrderAPIRecordTracking."ACO Supplier base code" := '0';
        IF (Vendor."DEL Supplier Base ID" <> '') THEN
            OrderAPIRecordTracking."ACO Supplier base code" := Vendor."DEL Supplier Base ID";
        OrderAPIRecordTracking."ACO Transport Mode" := PurchaseHeader."DEL Ship Per";
        OrderAPIRecordTracking."ACO Departure Port" := PurchaseHeader."DEL Port de départ";
        OrderAPIRecordTracking."ACO Arrival Port" := PurchaseHeader."DEL Port d'arrivée";
        OrderAPIRecordTracking."ACO Warehouse" := PurchaseHeader."Ship-to Code";


        OrderAPIRecordTracking."ACO Event" := FORMAT(PurchaseHeader."DEL Code événement");


        OrderAPIRecordTracking."ACO ETD" := PurchaseHeader."Requested Receipt Date";
        OrderAPIRecordTracking."ACO Incoterm" := PurchaseHeader."Shipment Method Code";
        OrderAPIRecordTracking."ACO Currency Code" := PurchaseHeader."Currency Code";
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '<>%1', 0);
        PurchaseLine.FINDFIRST();
        DocumentTotals.CalculatePurchaseTotals(TotalPurchaseLine, VATAmount, PurchaseLine);
        OrderAPIRecordTracking."ACO Amount" := TotalPurchaseLine.Amount;
        OrderAPIRecordTracking."ACO Payment Deadline" := PurchaseHeader."Due Date";


        OrderAPIRecordTracking."Sent Deal" := FALSE;


        OrderAPIRecordTracking.MODIFY();
        UpdateACOLineInfo(PurchaseHeader, OrderAPIRecordTracking);
    end;

    local procedure UpdateVCOInfo(SalesHeader: Record "Sales Header"; var OrderAPIRecordTracking: Record "DEL Order API Record Tracking")
    begin
        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN BEGIN
            OrderAPIRecordTracking.INIT();
            OrderAPIRecordTracking."Deal ID" := OrderAPIRecordTracking."Deal ID";
            OrderAPIRecordTracking.INSERT();
        END;

        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN
            EXIT;
        OrderAPIRecordTracking."VCO No." := SalesHeader."No.";
        OrderAPIRecordTracking."VCO Customer Name" := SalesHeader."Sell-to Customer No.";
        OrderAPIRecordTracking."VCO Customer Ref" := SalesHeader."External Document No.";
        OrderAPIRecordTracking."VCO Delivery date" := SalesHeader."Requested Delivery Date";


        OrderAPIRecordTracking."Sent Deal" := FALSE;


        OrderAPIRecordTracking.MODIFY();
    end;

    local procedure UpdateACOLineInfo(PurchaseHeader: Record "Purchase Header"; OrderAPIRecordTracking: Record "DEL Order API Record Tracking")
    var
        ACOLinesAPIRecordTracking: Record "DEL ACO Lines API Rec. Track.";
        PurchaseLine: Record "Purchase Line";
    begin
        ACOLinesAPIRecordTracking.SETRANGE("Deal ID", OrderAPIRecordTracking."Deal ID");
        ACOLinesAPIRecordTracking.DELETEALL();
        ACOLinesAPIRecordTracking.RESET();

        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '<>%1', 0);
        IF NOT PurchaseLine.ISEMPTY THEN BEGIN
            PurchaseLine.FINDFIRST();
            REPEAT
                ACOLinesAPIRecordTracking.INIT();
                ACOLinesAPIRecordTracking."Deal ID" := OrderAPIRecordTracking."Deal ID";
                ACOLinesAPIRecordTracking."ACO Line No." := PurchaseLine."Line No.";
                ACOLinesAPIRecordTracking."ACO Line Type" := PurchaseLine.Type;
                ACOLinesAPIRecordTracking."ACO No." := PurchaseLine."Document No.";
                ACOLinesAPIRecordTracking."ACO External reference NGTS" := PurchaseLine."DEL External reference NGTS";
                ACOLinesAPIRecordTracking."ACO Supplier Item No." := PurchaseLine."Vendor Item No.";
                ACOLinesAPIRecordTracking."ACO Mgts Item No." := PurchaseLine."No.";
                ACOLinesAPIRecordTracking."ACO Line Amount" := PurchaseLine."Line Amount";
                ACOLinesAPIRecordTracking.Quantity := PurchaseLine.Quantity;


                ACOLinesAPIRecordTracking."ACO New Product" := PurchaseLine."DEL First Purch. Order";
                ACOLinesAPIRecordTracking."ACO Product Description" := PurchaseLine.Description;


                ACOLinesAPIRecordTracking.INSERT();
            UNTIL PurchaseLine.NEXT() = 0;
        END;
    end;


    procedure UpdateOrderAPIRecordTracking(DealID: Code[20])
    var
        OrderAPIRecordTracking: Record "DEL Order API Record Tracking";
        PurchaseHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        ACONo: Code[20];
        VCONo: Code[20];
    begin
        ACONo := GetACONo(DealID);
        IF NOT PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, ACONo) THEN
            EXIT;
        VCONo := GetVCONo(DealID);
        IF NOT SalesHeader.GET(SalesHeader."Document Type"::Order, VCONo) THEN
            EXIT;

        IF NOT ACOHasLines(ACONo) THEN
            EXIT;

        IF NOT OrderAPIRecordTracking.GET(DealID) THEN BEGIN
            OrderAPIRecordTracking.INIT();
            OrderAPIRecordTracking."Deal ID" := DealID;
            OrderAPIRecordTracking.INSERT();
        END;
        UpdateACOInfo(PurchaseHeader, OrderAPIRecordTracking);
        UpdateVCOInfo(SalesHeader, OrderAPIRecordTracking);
    end;
}

