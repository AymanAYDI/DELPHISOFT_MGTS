report 699 "Calculate Plan - Req. Wksh."
{
    // -- THM   04.06.13   Migration 2013   added "Date prochaine commande"    ReqFilterFields

    Caption = 'Calculate Plan - Req. Wksh.';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem8129; Table27)
        {
            DataItemTableView = SORTING (Low-Level Code)
                                WHERE (Type = CONST (Inventory));
            RequestFilterFields = "No.", "Search Description", "Location Filter", "Date prochaine commande";

            trigger OnAfterGetRecord()
            begin
                IF Counter MOD 5 = 0 THEN
                    Window.UPDATE(1, "No.");
                Counter := Counter + 1;

                IF SkipPlanningForItemOnReqWksh(Item) THEN
                    CurrReport.SKIP;

                PlanningAssignment.SETRANGE("Item No.", "No.");

                ReqLine.LOCKTABLE;
                ActionMessageEntry.LOCKTABLE;

                PurchReqLine.SETRANGE("No.", "No.");
                PurchReqLine.MODIFYALL("Accept Action Message", FALSE);
                PurchReqLine.DELETEALL(TRUE);

                ReqLineExtern.SETRANGE(Type, ReqLine.Type::Item);
                ReqLineExtern.SETRANGE("No.", "No.");
                IF ReqLineExtern.FIND('-') THEN
                    REPEAT
                        ReqLineExtern.DELETE(TRUE);
                    UNTIL ReqLineExtern.NEXT = 0;

                InvtProfileOffsetting.SetParm(UseForecast, ExcludeForecastBefore, CurrWorksheetType);
                InvtProfileOffsetting.CalculatePlanFromWorksheet(
                  Item,
                  MfgSetup,
                  CurrTemplateName,
                  CurrWorksheetName,
                  FromDate,
                  ToDate,
                  TRUE,
                  RespectPlanningParm);

                IF PlanningAssignment.FIND('-') THEN
                    REPEAT
                        IF PlanningAssignment."Latest Date" <= ToDate THEN BEGIN
                            PlanningAssignment.Inactive := TRUE;
                            PlanningAssignment.MODIFY;
                        END;
                    UNTIL PlanningAssignment.NEXT = 0;

                COMMIT;
            end;

            trigger OnPreDataItem()
            begin
                SKU.SETCURRENTKEY("Item No.");
                COPYFILTER("Variant Filter", SKU."Variant Code");
                COPYFILTER("Location Filter", SKU."Location Code");

                COPYFILTER("Variant Filter", PlanningAssignment."Variant Code");
                COPYFILTER("Location Filter", PlanningAssignment."Location Code");
                PlanningAssignment.SETRANGE(Inactive, FALSE);
                PlanningAssignment.SETRANGE("Net Change Planning", TRUE);

                ReqLineExtern.SETCURRENTKEY(Type, "No.", "Variant Code", "Location Code");
                COPYFILTER("Variant Filter", ReqLineExtern."Variant Code");
                COPYFILTER("Location Filter", ReqLineExtern."Location Code");

                PurchReqLine.SETCURRENTKEY(
                  Type, "No.", "Variant Code", "Location Code", "Sales Order No.", "Planning Line Origin", "Due Date");
                PurchReqLine.SETRANGE(Type, PurchReqLine.Type::Item);
                COPYFILTER("Variant Filter", PurchReqLine."Variant Code");
                COPYFILTER("Location Filter", PurchReqLine."Location Code");
                PurchReqLine.SETFILTER("Worksheet Template Name", ReqWkshTemplateFilter);
                PurchReqLine.SETFILTER("Journal Batch Name", ReqWkshFilter);
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
                    field(StartingDate; FromDate)
                    {
                        Caption = 'Starting Date';
                    }
                    field(EndingDate; ToDate)
                    {
                        Caption = 'Ending Date';
                    }
                    field(UseForecast; UseForecast)
                    {
                        Caption = 'Use Forecast';
                        TableRelation = "Production Forecast Name".Name;
                    }
                    field(ExcludeForecastBefore; ExcludeForecastBefore)
                    {
                        Caption = 'Exclude Forecast Before';
                    }
                    field(RespectPlanningParm; RespectPlanningParm)
                    {
                        Caption = 'Respect Planning Parameters for Supply Triggered by Safety Stock';
                        ToolTip = 'Specifies that planning lines triggered by safety stock will respect the following planning parameters: Reorder Point, Reorder Quantity, Reorder Point, and Maximum Inventory in addition to all order modifiers. If you do not select this check box, planning lines triggered by safety stock will only cover the exact demand quantity.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            MfgSetup.GET;
            UseForecast := MfgSetup."Current Production Forecast";
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        ProductionForecastEntry: Record "99000852";
    begin
        Counter := 0;
        IF FromDate = 0D THEN
            ERROR(Text002);
        IF ToDate = 0D THEN
            ERROR(Text003);
        PeriodLength := ToDate - FromDate + 1;
        IF PeriodLength <= 0 THEN
            ERROR(Text004);

        IF (Item.GETFILTER("Variant Filter") <> '') AND
           (MfgSetup."Current Production Forecast" <> '')
        THEN BEGIN
            ProductionForecastEntry.SETRANGE("Production Forecast Name", MfgSetup."Current Production Forecast");
            Item.COPYFILTER("No.", ProductionForecastEntry."Item No.");
            IF MfgSetup."Use Forecast on Locations" THEN
                Item.COPYFILTER("Location Filter", ProductionForecastEntry."Location Code");
            IF NOT ProductionForecastEntry.ISEMPTY THEN
                ERROR(Text005);
        END;

        ReqLine.SETRANGE("Worksheet Template Name", CurrTemplateName);
        ReqLine.SETRANGE("Journal Batch Name", CurrWorksheetName);

        Window.OPEN(
          Text006 +
          Text007);
    end;

    var
        Text002: Label 'Enter a starting date.';
        Text003: Label 'Enter an ending date.';
        Text004: Label 'The ending date must not be before the order date.';
        Text005: Label 'You must not use a variant filter when calculating MPS from a forecast.';
        Text006: Label 'Calculating the plan...\\';
        Text007: Label 'Item No.  #1##################';
        ReqLine: Record "246";
        ActionMessageEntry: Record "99000849";
        ReqLineExtern: Record "246";
        PurchReqLine: Record "246";
        SKU: Record "5700";
        PlanningAssignment: Record "99000850";
        MfgSetup: Record "99000765";
        InvtProfileOffsetting: Codeunit "99000854";
        Window: Dialog;
        CurrWorksheetType: Option Requisition,Planning;
        PeriodLength: Integer;
        CurrTemplateName: Code[10];
        CurrWorksheetName: Code[10];
        FromDate: Date;
        ToDate: Date;
        ReqWkshTemplateFilter: Code[50];
        ReqWkshFilter: Code[50];
        Counter: Integer;
        UseForecast: Code[10];
        ExcludeForecastBefore: Date;
        RespectPlanningParm: Boolean;

    [Scope('Internal')]
    procedure SetTemplAndWorksheet(TemplateName: Code[10]; WorksheetName: Code[10])
    begin
        CurrTemplateName := TemplateName;
        CurrWorksheetName := WorksheetName;
    end;

    [Scope('Internal')]
    procedure InitializeRequest(StartDate: Date; EndDate: Date)
    begin
        FromDate := StartDate;
        ToDate := EndDate;
    end;

    local procedure SkipPlanningForItemOnReqWksh(Item: Record "27"): Boolean
    begin
        WITH Item DO
            IF (CurrWorksheetType = CurrWorksheetType::Requisition) AND
               ("Replenishment System" = "Replenishment System"::Purchase) AND
               ("Reordering Policy" <> "Reordering Policy"::" ")
            THEN
                EXIT(FALSE);

        WITH SKU DO BEGIN
            SETRANGE("Item No.", Item."No.");
            IF FIND('-') THEN
                REPEAT
                    IF (CurrWorksheetType = CurrWorksheetType::Requisition) AND
                       ("Replenishment System" IN ["Replenishment System"::Purchase,
                                                   "Replenishment System"::Transfer]) AND
                       ("Reordering Policy" <> "Reordering Policy"::" ")
                    THEN
                        EXIT(FALSE);
                UNTIL NEXT = 0;
        END;

        EXIT(TRUE);
    end;
}

