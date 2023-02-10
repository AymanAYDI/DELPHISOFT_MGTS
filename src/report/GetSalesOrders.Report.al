report 50078 "DEL Get Sales Orders" //698
{

    Caption = 'Get Sales Orders';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = WHERE("Document Type" = CONST(Order),
                                      Type = CONST(Item),
                                      "Purch. Order Line No." = CONST(0),
                                      "Outstanding Quantity" = FILTER(<> 0));
            RequestFilterFields = "Document No.", "Sell-to Customer No.", "No.";
            RequestFilterHeading = 'Sales Order Line';

            trigger OnAfterGetRecord()
            begin
                IF ("Purchasing Code" = '') AND (SpecOrder <> 1) THEN
                    IF "Drop Shipment" THEN BEGIN
                        LineCount := LineCount + 1;
                        Window.UPDATE(1, LineCount);
                        InsertReqWkshLine("Sales Line");
                    END;

                IF "Purchasing Code" <> '' THEN
                    IF PurchasingCode.GET("Purchasing Code") THEN
                        IF PurchasingCode."Drop Shipment" AND (SpecOrder <> 1) THEN BEGIN
                            LineCount := LineCount + 1;
                            Window.UPDATE(1, LineCount);
                            InsertReqWkshLine("Sales Line");
                        END ELSE
                            IF PurchasingCode."Special Order" AND
                               ("Special Order Purchase No." = '') AND
                               (SpecOrder <> 0)
                            THEN BEGIN
                                LineCount := LineCount + 1;
                                Window.UPDATE(1, LineCount);
                                InsertReqWkshLine("Sales Line");
                            END;
            end;

            trigger OnPostDataItem()
            begin
                IF LineCount = 0 THEN
                    ERROR(Text001);
            end;

            trigger OnPreDataItem()
            begin
                IF SalesDocNoFilter <> '' THEN BEGIN
                    "Sales Line".SETFILTER("Document Type", '%1', "Sales Line"."Document Type"::Order);
                    "Sales Line".SETFILTER("Document No.", SalesDocNoFilter);
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(GetDim; GetDim)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Retrieve dimensions from';
                        OptionCaption = 'Item,Sales Line';
                        ToolTip = 'Specifies the source of dimensions that will be copied in the batch job. Dimensions can be copied exactly as they were used on a sales line or can be copied from the items used on a sales line.';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        ReqWkshTmpl.GET(ReqLine."Worksheet Template Name");
        ReqWkshName.GET(ReqLine."Worksheet Template Name", ReqLine."Journal Batch Name");
        ReqLine.SETRANGE("Worksheet Template Name", ReqLine."Worksheet Template Name");
        ReqLine.SETRANGE("Journal Batch Name", ReqLine."Journal Batch Name");
        ReqLine.LOCKTABLE();
        IF ReqLine.FINDLAST() THEN BEGIN
            ReqLine.INIT();
            LineNo := ReqLine."Line No.";
        END;
        Window.OPEN(Text000);
    end;

    var
        Item: Record Item;
        PurchasingCode: Record Purchasing;
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqLine: Record "Requisition Line";
        ReqWkshName: Record "Requisition Wksh. Name";
        SalesHeader: Record "Sales Header";
        Vendor: Record Vendor;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        LeadTimeMgt: Codeunit "Lead-Time Management";
        SalesDocNoFilter: Code[20];
        Window: Dialog;
        GetDim: enum "DEL Get Dim";
        LineCount: Integer;
        LineNo: Integer;
        SpecOrder: Integer;
        Text000: Label 'Processing sales lines  #1######';
        Text001: Label 'There are no sales lines to retrieve.';
        Text50000: Label '-%1';
        Text50001: Label '+%1';


    procedure SetReqWkshLine(NewReqLine: Record "Requisition Line"; SpecialOrder: Integer)
    begin
        ReqLine := NewReqLine;
        SpecOrder := SpecialOrder;
    end;

    local procedure InsertReqWkshLine(SalesLine: Record "Sales Line")
    var
        ItemVendor: Record "Item Vendor";
    begin
        ReqLine.RESET();
        ReqLine.SETCURRENTKEY(Type, "No.");
        ReqLine.SETRANGE(Type, "Sales Line".Type);
        ReqLine.SETRANGE("No.", "Sales Line"."No.");
        ReqLine.SETRANGE("Sales Order No.", "Sales Line"."Document No.");
        ReqLine.SETRANGE("Sales Order Line No.", "Sales Line"."Line No.");
        IF ReqLine.FINDFIRST() THEN
            EXIT;

        LineNo := LineNo + 10000;
        CLEAR(ReqLine);
        ReqLine.SetDropShipment(SalesLine."Drop Shipment");
        ReqLine.INIT();
        ReqLine."Worksheet Template Name" := ReqWkshName."Worksheet Template Name";
        ReqLine."Journal Batch Name" := ReqWkshName.Name;
        ReqLine."Line No." := LineNo;
        ReqLine.VALIDATE(Type, SalesLine.Type);
        ReqLine.VALIDATE("No.", SalesLine."No.");
        ReqLine."Variant Code" := SalesLine."Variant Code";
        ReqLine.VALIDATE("Location Code", SalesLine."Location Code");
        ReqLine."Bin Code" := SalesLine."Bin Code";

        // Drop Shipment means replenishment by purchase only
        IF (ReqLine."Replenishment System" <> ReqLine."Replenishment System"::Purchase) AND
           SalesLine."Drop Shipment"
        THEN
            ReqLine.VALIDATE("Replenishment System", ReqLine."Replenishment System"::Purchase);

        IF SpecOrder <> 1 THEN
            ReqLine.VALIDATE("Unit of Measure Code", SalesLine."Unit of Measure Code");
        ReqLine.VALIDATE(
          Quantity,
          ROUND(SalesLine."Outstanding Quantity" * SalesLine."Qty. per Unit of Measure" / ReqLine."Qty. per Unit of Measure", 0.00001));
        ReqLine."Sales Order No." := SalesLine."Document No.";
        ReqLine."Sales Order Line No." := SalesLine."Line No.";
        ReqLine."Sell-to Customer No." := SalesLine."Sell-to Customer No.";
        SalesHeader.GET(1, SalesLine."Document No.");
        ReqLine."Ship-to Code" := SalesHeader."Ship-to Code";
        ReqLine."Item Category Code" := SalesLine."Item Category Code";
        ReqLine.Nonstock := SalesLine.Nonstock;
        ReqLine."Action Message" := ReqLine."Action Message"::New;
        ReqLine."Purchasing Code" := SalesLine."Purchasing Code";
        // Backward Scheduling
        ReqLine."Due Date" := SalesLine."Shipment Date";
        IF NOT Item.GET(SalesLine."No.") THEN
            Item.INIT();

        IF NOT (SalesHeader."Ship-to Country/Region Code" = '') AND (SalesLine.Type = SalesLine.Type::Item) THEN BEGIN
            ItemVendor.RESET();
            ItemVendor.SETRANGE("Item No.", SalesLine."No.");
            ItemVendor.SETRANGE("DEL Country/Region Code", SalesHeader."Ship-to Country/Region Code");
            IF ItemVendor.FINDFIRST() THEN BEGIN
                Item."Vendor No." := ItemVendor."Vendor No.";
                ReqLine."Vendor Item No." := ItemVendor."Vendor Item No.";
                IF NOT (FORMAT(ItemVendor."Lead Time Calculation") = '') THEN
                    Item."Lead Time Calculation" := ItemVendor."Lead Time Calculation";
            END;
        END;
        ReqLine.VALIDATE("Vendor No.", Item."Vendor No.");
        IF SalesLine.Type = SalesLine.Type::Item THEN
            IF FORMAT(Item."Lead Time Calculation") <> '' THEN BEGIN
                ReqLine."DEL Purchase Order Due Date" := CALCDATE(STRSUBSTNO(Text50000, Item."Lead Time Calculation"), SalesLine."Shipment Date");
                ReqLine."DEL Recalc. Date Of Delivery" := CALCDATE(STRSUBSTNO(Text50001, Item."Lead Time Calculation"), TODAY);
            END ELSE BEGIN
                IF NOT Vendor.GET(Item."Vendor No.") THEN
                    Vendor.INIT();

                IF FORMAT(Vendor."Lead Time Calculation") <> '' THEN BEGIN
                    ReqLine."DEL Purchase Order Due Date" := CALCDATE(STRSUBSTNO(Text50000, Vendor."Lead Time Calculation"), SalesLine."Shipment Date");
                    ReqLine."DEL Recalc. Date Of Delivery" := CALCDATE(STRSUBSTNO(Text50001, Vendor."Lead Time Calculation"), TODAY);
                END ELSE BEGIN
                    ReqLine."DEL Purchase Order Due Date" := SalesLine."Shipment Date";
                    ReqLine."DEL Recalc. Date Of Delivery" := TODAY;
                END;
            END;
        ReqLine."Ending Date" :=
          LeadTimeMgt.PlannedEndingDate(
            ReqLine."No.", ReqLine."Location Code", ReqLine."Variant Code", ReqLine."Due Date", ReqLine."Vendor No.", ReqLine."Ref. Order Type");

        ReqLine."DEL Requested Delivery Date" := SalesLine."Requested Delivery Date";

        ReqLine.CalcStartingDate('');
        ReqLine.UpdateDescription();
        ReqLine.UpdateDatetime();

        ReqLine.INSERT();
        ItemTrackingMgt.CopyItemTracking(SalesLine.RowID1(), ReqLine.RowID1(), TRUE);
        IF GetDim = GetDim::"Sales Line" THEN BEGIN
            ReqLine."Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            ReqLine."Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            ReqLine."Dimension Set ID" := SalesLine."Dimension Set ID";
            ReqLine.MODIFY();
        END;
    end;


    procedure InitializeRequest(NewRetrieveDimensionsFrom: Option)
    begin
        GetDim := NewRetrieveDimensionsFrom;
    end;

    procedure SetSalesDocNo(pSalesDocNoFilter: Code[20])
    begin
        SalesDocNoFilter := pSalesDocNoFilter;
    end;
}

