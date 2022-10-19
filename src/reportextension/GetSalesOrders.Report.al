report 698 "Get Sales Orders"
{
    // 
    // +-------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                      |
    // | Status: 04.06.2013                                    |
    // | Customer / Project: NGTS                              |
    // +-------------------------------------------------------+
    // 
    // Version    Requirement   ID   Date        Description
    // ---------------------------------------------------------
    // Interne1    T-00051      STG  24.06.2008 utilisation of field 50000 "Requested Delivery Date" // Migration NAV2013
    // 
    // MGTS0125                 MHH  26.08.2019 Changed function: InsertReqWkshLine()
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Emil Hr. Hristov = ehh
    // Version : MGTS10.008
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version       Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.008    04.09.20    ehh     List of changes:
    //                                           Changed function: InsertReqWkshLine()
    // 
    // 002     MGTS10.023    01.02.21    mhh     List of changes:
    //                                           Changed function: InsertReqWkshLine()
    // ------------------------------------------------------------------------------------------
    // 
    // MGTSEDI10.00.00.23 | 21.05.2021 | EDI Management : Add Function SetSalesDocNo
    //                                                    Add C/AL code function Sales Line - OnPreDataItem

    Caption = 'Get Sales Orders';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem2844; Table37)
        {
            DataItemTableView = WHERE (Document Type=CONST(Order),
                                      Type=CONST(Item),
                                      Purch. Order Line No.=CONST(0),
                                      Outstanding Quantity=FILTER(<>0));
            RequestFilterFields = "Document No.","Sell-to Customer No.","No.";
            RequestFilterHeading = 'Sales Order Line';

            trigger OnAfterGetRecord()
            begin
                IF ("Purchasing Code" = '') AND (SpecOrder <> 1)THEN
                  IF "Drop Shipment" THEN BEGIN
                    LineCount := LineCount + 1;
                    Window.UPDATE(1,LineCount);
                    InsertReqWkshLine("Sales Line");
                  END;

                IF "Purchasing Code" <> '' THEN
                  IF PurchasingCode.GET("Purchasing Code") THEN
                    IF PurchasingCode."Drop Shipment" AND (SpecOrder <> 1) THEN BEGIN
                      LineCount := LineCount + 1;
                      Window.UPDATE(1,LineCount);
                      InsertReqWkshLine("Sales Line");
                    END ELSE
                      IF PurchasingCode."Special Order" AND
                         ("Special Order Purchase No." = '') AND
                         (SpecOrder <> 0)
                      THEN BEGIN
                        LineCount := LineCount + 1;
                        Window.UPDATE(1,LineCount);
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
                //>>MGTSEDI10.00.00.23
                IF SalesDocNoFilter <> '' THEN BEGIN
                  "Sales Line".SETFILTER("Document Type", '%1',"Sales Line"."Document Type"::Order);
                  "Sales Line".SETFILTER("Document No.", SalesDocNoFilter);
                END;
                //<<MGTSEDI10.00.00.23
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
                    field(GetDim;GetDim)
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
        ReqWkshName.GET(ReqLine."Worksheet Template Name",ReqLine."Journal Batch Name");
        ReqLine.SETRANGE("Worksheet Template Name",ReqLine."Worksheet Template Name");
        ReqLine.SETRANGE("Journal Batch Name",ReqLine."Journal Batch Name");
        ReqLine.LOCKTABLE;
        IF ReqLine.FINDLAST THEN BEGIN
          ReqLine.INIT;
          LineNo := ReqLine."Line No.";
        END;
        Window.OPEN(Text000);
    end;

    var
        Text000: Label 'Processing sales lines  #1######';
        Text001: Label 'There are no sales lines to retrieve.';
        ReqWkshTmpl: Record "244";
        ReqWkshName: Record "245";
        ReqLine: Record "246";
        SalesHeader: Record "36";
        PurchasingCode: Record "5721";
        ItemTrackingMgt: Codeunit "6500";
        LeadTimeMgt: Codeunit "5404";
        Window: Dialog;
        LineCount: Integer;
        SpecOrder: Integer;
        GetDim: Option Item,"Sales Line";
        LineNo: Integer;
        Item: Record "27";
        Text50000: Label '-%1';
        Vendor: Record "23";
        Text50001: Label '+%1';
        SalesDocNoFilter: Code[20];

    [Scope('Internal')]
    procedure SetReqWkshLine(NewReqLine: Record "246";SpecialOrder: Integer)
    begin
        ReqLine := NewReqLine;
        SpecOrder := SpecialOrder;
    end;

    local procedure InsertReqWkshLine(SalesLine: Record "37")
    var
        ItemVendor: Record "99";
    begin
        ReqLine.RESET;
        ReqLine.SETCURRENTKEY(Type,"No.");
        ReqLine.SETRANGE(Type,"Sales Line".Type);
        ReqLine.SETRANGE("No.","Sales Line"."No.");
        ReqLine.SETRANGE("Sales Order No.","Sales Line"."Document No.");
        ReqLine.SETRANGE("Sales Order Line No.","Sales Line"."Line No.");
        IF ReqLine.FINDFIRST THEN
          EXIT;

        LineNo := LineNo + 10000;
        CLEAR(ReqLine);
        ReqLine.SetDropShipment(SalesLine."Drop Shipment");
        WITH ReqLine DO BEGIN
          INIT;
          "Worksheet Template Name" := ReqWkshName."Worksheet Template Name";
          "Journal Batch Name" := ReqWkshName.Name;
          "Line No." := LineNo;
          VALIDATE(Type,SalesLine.Type);
          VALIDATE("No.",SalesLine."No.");
          "Variant Code" := SalesLine."Variant Code";
          VALIDATE("Location Code",SalesLine."Location Code");
          "Bin Code" := SalesLine."Bin Code";

          // Drop Shipment means replenishment by purchase only
          IF ("Replenishment System" <> "Replenishment System"::Purchase) AND
             SalesLine."Drop Shipment"
          THEN
            VALIDATE("Replenishment System","Replenishment System"::Purchase);

          IF SpecOrder <> 1 THEN
            VALIDATE("Unit of Measure Code",SalesLine."Unit of Measure Code");
          VALIDATE(
            Quantity,
            ROUND(SalesLine."Outstanding Quantity" * SalesLine."Qty. per Unit of Measure" / "Qty. per Unit of Measure",0.00001));
          "Sales Order No." := SalesLine."Document No.";
          "Sales Order Line No." := SalesLine."Line No.";
          "Sell-to Customer No." := SalesLine."Sell-to Customer No.";
          SalesHeader.GET(1,SalesLine."Document No.");

          //MGTS10.023; 002; mhh; deleted line: IF SpecOrder <> 1 THEN

          "Ship-to Code" := SalesHeader."Ship-to Code";
          "Item Category Code" := SalesLine."Item Category Code";
          Nonstock := SalesLine.Nonstock;
          "Action Message" := "Action Message"::New;
          "Purchasing Code" := SalesLine."Purchasing Code";
          // Backward Scheduling
          "Due Date" := SalesLine."Shipment Date";

          //MGTS10.008; 001; ehh; begin
          IF NOT Item.GET(SalesLine."No.") THEN
            Item.INIT;

          IF NOT (SalesHeader."Ship-to Country/Region Code" = '') AND (SalesLine.Type = SalesLine.Type::Item) THEN BEGIN
            ItemVendor.RESET;
            ItemVendor.SETRANGE("Item No.", SalesLine."No.");
            ItemVendor.SETRANGE("Country/Region Code", SalesHeader."Ship-to Country/Region Code");
            IF ItemVendor.FINDFIRST THEN BEGIN
              Item."Vendor No." := ItemVendor."Vendor No.";
              "Vendor Item No." := ItemVendor."Vendor Item No.";
              IF NOT (FORMAT(ItemVendor."Lead Time Calculation") = '') THEN
                Item."Lead Time Calculation" := ItemVendor."Lead Time Calculation";
            END;
          END;
          VALIDATE("Vendor No.", Item."Vendor No.");
          //MGTS10.008; 001; ehh; end

          //MGTS0125; MHH; begin
          IF SalesLine.Type = SalesLine.Type::Item THEN BEGIN
            IF FORMAT(Item."Lead Time Calculation") <> '' THEN BEGIN
              "Purchase Order Due Date" := CALCDATE(STRSUBSTNO(Text50000, Item."Lead Time Calculation"), SalesLine."Shipment Date");
              "Recalc. Date Of Delivery" := CALCDATE(STRSUBSTNO(Text50001, Item."Lead Time Calculation"), TODAY);
            END ELSE BEGIN
              IF NOT Vendor.GET(Item."Vendor No.") THEN
                Vendor.INIT;

              IF FORMAT(Vendor."Lead Time Calculation") <> '' THEN BEGIN
                "Purchase Order Due Date" := CALCDATE(STRSUBSTNO(Text50000, Vendor."Lead Time Calculation"), SalesLine."Shipment Date");
                "Recalc. Date Of Delivery" := CALCDATE(STRSUBSTNO(Text50001, Vendor."Lead Time Calculation"), TODAY);
              END ELSE BEGIN
                "Purchase Order Due Date" := SalesLine."Shipment Date";
                "Recalc. Date Of Delivery" := TODAY;
              END;
            END;
          END;
          //MGTS0125; MHH; end

          "Ending Date" :=
            LeadTimeMgt.PlannedEndingDate(
              "No.","Location Code","Variant Code","Due Date","Vendor No.","Ref. Order Type");

          // START Interne1
          "Requested Delivery Date":=SalesLine."Requested Delivery Date";
          // STOP Interne1

          CalcStartingDate('');
          UpdateDescription;
          UpdateDatetime;

          INSERT;
          ItemTrackingMgt.CopyItemTracking(SalesLine.RowID1,RowID1,TRUE);
          IF GetDim = GetDim::"Sales Line" THEN BEGIN
            "Shortcut Dimension 1 Code" := SalesLine."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := SalesLine."Shortcut Dimension 2 Code";
            "Dimension Set ID" := SalesLine."Dimension Set ID";
            MODIFY;
          END;
        END;
    end;

    [Scope('Internal')]
    procedure InitializeRequest(NewRetrieveDimensionsFrom: Option)
    begin
        GetDim := NewRetrieveDimensionsFrom;
    end;

    [Scope('Internal')]
    procedure SetSalesDocNo(pSalesDocNoFilter: Code[20])
    begin
        SalesDocNoFilter := pSalesDocNoFilter;
    end;
}

