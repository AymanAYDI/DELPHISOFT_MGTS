codeunit 50044 "API Orders Track Records Mgt."
{
    // Mgts10.00.01.00 | 11.01.2020 | Order API Management
    // 
    // Mgts10.00.01.02 | 06.02.2020 | Order API Management : Add fields And C\AL
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.025
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS10.025       23.02.21    mhh     List of changes:
    //                                              Changed function: UpdateACOInfo()
    // ------------------------------------------------------------------------------------------

    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    local procedure GetACODealID(ACONo: Code[20]): Code[20]
    var
        Element: Record "50021";
    begin
        WITH Element DO BEGIN
            //Search ACO DEAL
            SETCURRENTKEY(Type, "Type No.");
            SETRANGE(Type, Type::ACO);
            SETRANGE("Type No.", ACONo);
            SETRANGE(Instance, Instance::planned);
            IF NOT ISEMPTY THEN BEGIN
                FINDFIRST;
                EXIT(Deal_ID);
            END
            ELSE
                EXIT('');
        END;
    end;

    local procedure GetVCODealID(VCONo: Code[20]): Code[20]
    var
        Element: Record "50021";
    begin
        WITH Element DO BEGIN
            //Search ACO DEAL
            SETCURRENTKEY(Type, "Type No.");
            SETRANGE(Type, Type::VCO);
            SETRANGE("Type No.", VCONo);
            SETRANGE(Instance, Instance::planned);
            IF NOT ISEMPTY THEN BEGIN
                FINDFIRST;
                EXIT(Deal_ID);
            END
            ELSE
                EXIT('');
        END;
    end;

    local procedure ACOInDeal(ACONo: Code[20]): Boolean
    var
        Element: Record "50021";
        SalesHeader: Record "36";
        Deal: Record "50020";
    begin
        WITH Element DO BEGIN
            //Search ACO
            SETCURRENTKEY(Type, "Type No.");
            SETRANGE(Type, Type::ACO);
            SETRANGE("Type No.", ACONo);
            SETRANGE(Instance, Instance::planned);
            IF NOT ISEMPTY THEN BEGIN
                FINDFIRST;
                //Search Deal
                IF NOT Deal.GET(Deal_ID) THEN
                    EXIT(FALSE);
                IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
                    EXIT(FALSE);
                //Search VCO
                SETRANGE("Type No.");
                SETCURRENTKEY(Deal_ID, Type, Instance);
                SETRANGE(Type, Type::VCO);
                SETRANGE(Deal_ID, Deal_ID);
                SETRANGE(Instance, Instance::planned);
                IF NOT ISEMPTY THEN BEGIN
                    FINDFIRST;
                    EXIT(SalesHeader.GET(SalesHeader."Document Type"::Order, "Type No.") AND ACOHasLines(ACONo));
                END
                ELSE
                    EXIT(FALSE)
            END
            ELSE
                EXIT(FALSE);
        END;
    end;

    local procedure VCOInDeal(VCONo: Code[20]): Boolean
    var
        Element: Record "50021";
        PurchaseHeader: Record "38";
        Deal: Record "50020";
    begin
        WITH Element DO BEGIN
            //Search VCO
            SETCURRENTKEY(Type, "Type No.");
            SETRANGE(Type, Type::VCO);
            SETRANGE("Type No.", VCONo);
            SETRANGE(Instance, Instance::planned);
            IF NOT ISEMPTY THEN BEGIN
                FINDFIRST;
                //Search Deal
                IF NOT Deal.GET(Deal_ID) THEN
                    EXIT(FALSE);
                IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
                    EXIT(FALSE);
                //Search ACO
                SETRANGE("Type No.");
                SETCURRENTKEY(Deal_ID, Type, Instance);
                SETRANGE(Type, Type::ACO);
                SETRANGE(Deal_ID, Deal_ID);
                SETRANGE(Instance, Instance::planned);
                IF NOT ISEMPTY THEN BEGIN
                    FINDFIRST;
                    EXIT(PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, "Type No.") AND ACOHasLines(PurchaseHeader."No."));
                END
                ELSE
                    EXIT(FALSE)
            END
            ELSE
                EXIT(FALSE);
        END;
    end;

    local procedure ACOHasLines(ACONo: Code[20]): Boolean
    var
        PurchaseLine: Record "39";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", ACONo);
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '<>%1', 0);
        EXIT(NOT PurchaseLine.ISEMPTY);
    end;

    local procedure IsACOUpdated(PurchaseHeader: Record "38"; xPurchaseHeader: Record "38"): Boolean
    begin
        EXIT((PurchaseHeader."Order Date" <> xPurchaseHeader."Order Date") OR
              (PurchaseHeader."Purchaser Code" <> xPurchaseHeader."Purchaser Code") OR
              (PurchaseHeader."Buy-from Vendor No." <> xPurchaseHeader."Buy-from Vendor No.") OR
              (PurchaseHeader."Ship Per" <> xPurchaseHeader."Ship Per") OR
              (PurchaseHeader."Ship-to Code" <> xPurchaseHeader."Ship-to Code") OR
              (PurchaseHeader."Port de départ" <> xPurchaseHeader."Port de départ") OR
              (PurchaseHeader."Port d'arrivée" <> xPurchaseHeader."Port d'arrivée") OR
              (PurchaseHeader."Code événement" <> xPurchaseHeader."Code événement") OR
              (PurchaseHeader."Requested Receipt Date" <> xPurchaseHeader."Requested Receipt Date") OR
              (PurchaseHeader."Shipment Method Code" <> xPurchaseHeader."Shipment Method Code") OR
              (PurchaseHeader."Due Date" <> xPurchaseHeader."Due Date") OR
              (PurchaseHeader."Currency Code" <> xPurchaseHeader."Currency Code"));
    end;

    local procedure IsACOLineUpdated(PurchaseLine: Record "39"; xPurchaseLine: Record "39"): Boolean
    begin
        EXIT((PurchaseLine."Cross-Reference No." <> xPurchaseLine."Cross-Reference No.") OR
             (PurchaseLine."Vendor Item No." <> xPurchaseLine."Vendor Item No.") OR
             (PurchaseLine."No." <> xPurchaseLine."No.") OR
             (PurchaseLine."External reference NGTS" <> xPurchaseLine."External reference NGTS") OR

             //>>Mgts10.00.01.02
             (PurchaseLine."First Purch. Order" <> xPurchaseLine."First Purch. Order") OR
             (PurchaseLine.Description <> xPurchaseLine.Description) OR
             //>>Mgts10.00.01.02

             (PurchaseLine.Quantity <> xPurchaseLine.Quantity) OR
             (PurchaseLine."Line Amount" <> xPurchaseLine."Line Amount"));
    end;

    local procedure IsVCOUpdated(SalesHeader: Record "36"; xSalesHeader: Record "36"): Boolean
    begin
        EXIT((SalesHeader."External Document No." <> xSalesHeader."External Document No.") OR
              (SalesHeader."Requested Delivery Date" <> xSalesHeader."Requested Delivery Date") OR
              (SalesHeader."Sell-to Customer No." <> xSalesHeader."Sell-to Customer No."));
    end;

    local procedure GetVCONo(DealID: Code[20]): Code[20]
    var
        Element: Record "50021";
        SalesHeader: Record "36";
        Deal: Record "50020";
    begin
        //Search Deal
        IF NOT Deal.GET(DealID) THEN
            EXIT('');
        IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
            EXIT('');

        WITH Element DO BEGIN
            //Search ACO
            SETCURRENTKEY(Deal_ID, Type, Instance);
            SETRANGE(Type, Type::VCO);
            SETRANGE(Deal_ID, DealID);
            SETRANGE(Instance, Instance::planned);
            IF NOT ISEMPTY THEN BEGIN
                FINDFIRST;
                EXIT("Type No.");
            END
            ELSE
                EXIT('');
        END;
    end;

    local procedure GetACONo(DealID: Code[20]): Code[20]
    var
        Element: Record "50021";
        SalesHeader: Record "36";
        Deal: Record "50020";
    begin
        //Search Deal
        IF NOT Deal.GET(DealID) THEN
            EXIT('');
        IF NOT (Deal.Status IN [Deal.Status::"In order", Deal.Status::"In progress"]) THEN
            EXIT('');

        WITH Element DO BEGIN
            //Search ACO
            SETCURRENTKEY(Deal_ID, Type, Instance);
            SETRANGE(Type, Type::ACO);
            SETRANGE(Deal_ID, DealID);
            SETRANGE(Instance, Instance::planned);
            IF NOT ISEMPTY THEN BEGIN
                FINDFIRST;
                EXIT("Type No.");
            END
            ELSE
                EXIT('');
        END;
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchHeader(var Rec: Record "38"; var xRec: Record "38"; RunTrigger: Boolean)
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

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyPurchLine(var Rec: Record "39"; var xRec: Record "39"; RunTrigger: Boolean)
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

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifySalesHeader(var Rec: Record "36"; var xRec: Record "36"; RunTrigger: Boolean)
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

    local procedure UpdateACOInfo(PurchaseHeader: Record "38"; var OrderAPIRecordTracking: Record "50074")
    var
        Vendor: Record "23";
        TotalPurchaseLine: Record "39";
        PurchaseLine: Record "39";
        DocumentTotals: Codeunit "57";
        VATAmount: Decimal;
    begin
        IF NOT Vendor.GET(PurchaseHeader."Buy-from Vendor No.") THEN
            Vendor.INIT;

        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN BEGIN
            OrderAPIRecordTracking.INIT;
            OrderAPIRecordTracking."Deal ID" := OrderAPIRecordTracking."Deal ID";
            OrderAPIRecordTracking.INSERT;
        END;

        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN
            EXIT;

        OrderAPIRecordTracking."ACO No." := PurchaseHeader."No.";
        OrderAPIRecordTracking."ACO Date" := PurchaseHeader."Order Date";
        OrderAPIRecordTracking."ACO Product" := PurchaseHeader."Purchaser Code";
        OrderAPIRecordTracking."ACO Supplier ERP Code" := PurchaseHeader."Buy-from Vendor No.";
        OrderAPIRecordTracking."ACO Supplier ERP Name" := PurchaseHeader."Buy-from Vendor Name";
        OrderAPIRecordTracking."ACO Supplier base code" := '0';
        IF (Vendor."Supplier Base ID" <> '') THEN
            OrderAPIRecordTracking."ACO Supplier base code" := Vendor."Supplier Base ID";
        OrderAPIRecordTracking."ACO Transport Mode" := PurchaseHeader."Ship Per";
        OrderAPIRecordTracking."ACO Departure Port" := PurchaseHeader."Port de départ";
        OrderAPIRecordTracking."ACO Arrival Port" := PurchaseHeader."Port d'arrivée";
        OrderAPIRecordTracking."ACO Warehouse" := PurchaseHeader."Ship-to Code";

        //MGTS10.025; 001; mhh; begin
        //deleted line: OrderAPIRecordTracking."ACO Event"              := PurchaseHeader."Code événement";
        OrderAPIRecordTracking."ACO Event" := FORMAT(PurchaseHeader."Code événement");
        //MGTS10.025; 001; mhh; end

        OrderAPIRecordTracking."ACO ETD" := PurchaseHeader."Requested Receipt Date";
        OrderAPIRecordTracking."ACO Incoterm" := PurchaseHeader."Shipment Method Code";
        OrderAPIRecordTracking."ACO Currency Code" := PurchaseHeader."Currency Code";
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '<>%1', 0);
        PurchaseLine.FINDFIRST;
        DocumentTotals.CalculatePurchaseTotals(TotalPurchaseLine, VATAmount, PurchaseLine);
        OrderAPIRecordTracking."ACO Amount" := TotalPurchaseLine.Amount;
        OrderAPIRecordTracking."ACO Payment Deadline" := PurchaseHeader."Due Date";

        //>>Mgts10.00.01.02
        OrderAPIRecordTracking."Sent Deal" := FALSE;
        //<<Mgts10.00.01.02

        OrderAPIRecordTracking.MODIFY;
        UpdateACOLineInfo(PurchaseHeader, OrderAPIRecordTracking);
    end;

    local procedure UpdateVCOInfo(SalesHeader: Record "36"; var OrderAPIRecordTracking: Record "50074")
    begin
        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN BEGIN
            OrderAPIRecordTracking.INIT;
            OrderAPIRecordTracking."Deal ID" := OrderAPIRecordTracking."Deal ID";
            OrderAPIRecordTracking.INSERT;
        END;

        IF NOT OrderAPIRecordTracking.GET(OrderAPIRecordTracking."Deal ID") THEN
            EXIT;
        OrderAPIRecordTracking."VCO No." := SalesHeader."No.";
        OrderAPIRecordTracking."VCO Customer Name" := SalesHeader."Sell-to Customer No.";
        OrderAPIRecordTracking."VCO Customer Ref" := SalesHeader."External Document No.";
        OrderAPIRecordTracking."VCO Delivery date" := SalesHeader."Requested Delivery Date";

        //>>Mgts10.00.01.02
        OrderAPIRecordTracking."Sent Deal" := FALSE;
        //<<Mgts10.00.01.02

        OrderAPIRecordTracking.MODIFY;
    end;

    local procedure UpdateACOLineInfo(PurchaseHeader: Record "38"; OrderAPIRecordTracking: Record "50074")
    var
        PurchaseLine: Record "39";
        ACOLinesAPIRecordTracking: Record "50075";
    begin
        ACOLinesAPIRecordTracking.SETRANGE("Deal ID", OrderAPIRecordTracking."Deal ID");
        ACOLinesAPIRecordTracking.DELETEALL;
        ACOLinesAPIRecordTracking.RESET;

        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETFILTER(Quantity, '<>%1', 0);
        IF NOT PurchaseLine.ISEMPTY THEN BEGIN
            PurchaseLine.FINDFIRST;
            REPEAT
                ACOLinesAPIRecordTracking.INIT;
                ACOLinesAPIRecordTracking."Deal ID" := OrderAPIRecordTracking."Deal ID";
                ACOLinesAPIRecordTracking."ACO Line No." := PurchaseLine."Line No.";
                ACOLinesAPIRecordTracking."ACO Line Type" := PurchaseLine.Type;
                ACOLinesAPIRecordTracking."ACO No." := PurchaseLine."Document No.";
                ACOLinesAPIRecordTracking."ACO External reference NGTS" := PurchaseLine."External reference NGTS";
                ACOLinesAPIRecordTracking."ACO Supplier Item No." := PurchaseLine."Vendor Item No.";
                ACOLinesAPIRecordTracking."ACO Mgts Item No." := PurchaseLine."No.";
                ACOLinesAPIRecordTracking."ACO Line Amount" := PurchaseLine."Line Amount";
                ACOLinesAPIRecordTracking.Quantity := PurchaseLine.Quantity;

                //>>Mgts10.00.01.02
                ACOLinesAPIRecordTracking."ACO New Product" := PurchaseLine."First Purch. Order";
                ACOLinesAPIRecordTracking."ACO Product Description" := PurchaseLine.Description;
                //<<Mgts10.00.01.02

                ACOLinesAPIRecordTracking.INSERT;
            UNTIL PurchaseLine.NEXT = 0;
        END;
    end;

    [Scope('Internal')]
    procedure UpdateOrderAPIRecordTracking(DealID: Code[20])
    var
        ACONo: Code[20];
        VCONo: Code[20];
        OrderAPIRecordTracking: Record "50074";
        PurchaseHeader: Record "38";
        SalesHeader: Record "36";
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
            OrderAPIRecordTracking.INIT;
            OrderAPIRecordTracking."Deal ID" := DealID;
            OrderAPIRecordTracking.INSERT;
        END;
        UpdateACOInfo(PurchaseHeader, OrderAPIRecordTracking);
        UpdateVCOInfo(SalesHeader, OrderAPIRecordTracking);
    end;
}

