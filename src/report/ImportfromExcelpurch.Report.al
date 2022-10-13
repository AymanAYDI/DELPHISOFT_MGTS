report 50013 "Import from Excel purch"
{
    // +---------------------------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                                     |
    // | Status: 27.3.12                                                                                               |
    // | Customer: NGTS                                                                                                |
    // +---------------------------------------------------------------------------------------------------------------+
    // 
    // Requirement     UserID     Date       Where              Description
    // -----------------------------------------------------------------------------------------------------------------
    // CONS489519      CEO/THM    27.3.12    InsertPrice()      Changed findfirst() and findlast() to find(-) and find(+)

    Caption = 'Import Budget from Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem3883; Table50038)
        {
            DataItemTableView = SORTING (Item No., Vendor No., Starting Date, Currency Code, Variant Code, Unit of Measure Code, Minimum Quantity, Qty. optimale);
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        Page2: Page "7023";
    begin
        ExcelBuf.DELETEALL;
        Page2.RUN();
    end;

    trigger OnPreReport()
    begin
        ExcelBuf.LOCKTABLE;
        "Purchase Price Worksheet".LOCKTABLE;

        ReadExcelSheet;
        InsertPrice();
    end;

    var
        Text000: Label 'You must specify a budget name to import to.';
        Text001: Label 'Do you want to create %1 %2.';
        Text002: Label '%1 %2 is blocked. You cannot import entries.';
        Text003: Label 'Are you sure you want to %1 for %2 %3.';
        Text004: Label '%1 table has been successfully updated with %2 entries.';
        Text005: Label 'Imported from Excel ';
        Text006: Label 'Import Excel File';
        Text007: Label 'Analyzing Data...\\';
        Text008: Label 'You cannot specify more than 8 dimensions in your Excel worksheet.';
        Text009: Label 'G/L ACCOUNT NO';
        Text010: Label 'G/L Account No.';
        Text011: Label 'The text G/L Account No. can only be specified once in the Excel worksheet.';
        Text012: Label 'The dimensions specified by worksheet must be placed in the lines before the table.';
        Text013: Label 'Dimension ';
        Text014: Label 'Date';
        Text015: Label 'Dimension 1';
        Text016: Label 'Dimension 2';
        Text017: Label 'Dimension 3';
        Text018: Label 'Dimension 4';
        Text019: Label 'Dimension 5';
        Text020: Label 'Dimension 6';
        Text021: Label 'Dimension 7';
        Text022: Label 'Dimension 8';
        Text023: Label 'You cannot import the same information twice.\';
        Text024: Label 'The combination G/L Account No. - Dimensions - Date must be unique.';
        Text025: Label 'G/L Accounts have not been found in the Excel worksheet.';
        Text026: Label 'Dates have not been recognized in the Excel worksheet.';
        ExcelBuf: Record "370";
        Dim: Record "348";
        DimVal: Record "349";
        TempDim: Record "348" temporary;
        TempDimVal: Record "349" temporary;
        GLBudgetEntry: Record "96";
        GLBudgetDim: Record "361";
        GLSetup: Record "98";
        GLAcc: Record "15";
        TempGLAcc: Record "15" temporary;
        GLBudgetName: Record "95";
        GLBudgetEntry3: Record "96";
        AnalysisView: Record "363";
        FileName: Text[250];
        SheetName: Text[250];
        ToGLBudgetName: Code[10];
        DimCode: array[8] of Code[20];
        EntryNo: Integer;
        LastEntryNoBeforeImport: Integer;
        GlobalDim1Code: Code[20];
        GlobalDim2Code: Code[20];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        Description: Text[50];
        BudgetDim1Code: Code[20];
        BudgetDim2Code: Code[20];
        BudgetDim3Code: Code[20];
        BudgetDim4Code: Code[20];
        ImportOption: Option "Replace entries","Add entries";
        Text027: Label 'Replace entries,Add entries';
        Text028: Label 'A filter has been used on the %1 when the budget was exported. When a filter on a dimension has been used, a column with the same dimension must be present in the worksheet imported. The column in the worksheet must specify the dimension value codes the program should use when importing the budget.';
        PurchPriceWorksheet: Record "50038";
        ExcelBuf2: Record "370";

    local procedure ReadExcelSheet()
    begin
        ExcelBuf.OpenBook(FileName, SheetName);
        ExcelBuf.ReadSheet;
    end;

    local procedure AnalyzeData()
    var
        TempExcelBuf: Record "370" temporary;
        BudgetBuf: Record "371";
        TempBudgetBuf: Record "371" temporary;
        HeaderRowNo: Integer;
        CountDim: Integer;
        TestDate: Date;
        OldRowNo: Integer;
        DimRowNo: Integer;
        DimCode3: Code[20];
    begin
    end;

    local procedure InsertGLBudgetDim(DimCode2: Code[20]; DimValCode2: Code[20]; var GLBudgetEntry2: Record "96")
    begin
    end;

    local procedure FormatData(TextToFormat: Text[250]): Text[250]
    var
        FormatInteger: Integer;
        FormatDecimal: Decimal;
        FormatDate: Date;
    begin
    end;

    [Scope('Internal')]
    procedure SetGLBudgetName(NewToGLBudgetName: Code[10])
    begin
    end;

    [Scope('Internal')]
    procedure SetBudgetDimFilter(DimCode2: Code[20]; DimValCode2: Code[20]; var GLBudgetEntry2: Record "96")
    begin
    end;

    [Scope('Internal')]
    procedure InsertPrice()
    var
        FormatInteger: Integer;
        FormatDecimal: Decimal;
        FormatDate: Date;
        Formatbool: Boolean;
        XligneOld: Integer;
        last: Integer;
        i: Integer;
        FormatDate2: Date;
        FormatDecimal2: Decimal;
        FormatDecimal3: Decimal;
        Formatbool2: Boolean;
        Formatbool3: Boolean;
        FormatCode: Code[20];
        FormatDecimal4: Decimal;
    begin
        ExcelBuf.SETFILTER("Row No.", '>%1', 3);

        IF ExcelBuf.FIND('+') THEN
            last := ExcelBuf."Row No.";

        i := 5;
        IF ExcelBuf.FIND('-') THEN BEGIN
            WHILE (i <= last) DO BEGIN
                ExcelBuf.SETRANGE("Row No.", i);
                PurchPriceWorksheet."Item No." := '';
                PurchPriceWorksheet."Vendor No." := '';
                PurchPriceWorksheet."Starting Date" := 0D;
                PurchPriceWorksheet."Currency Code" := '';
                PurchPriceWorksheet."Variant Code" := '';
                PurchPriceWorksheet."Unit of Measure Code" := '';
                PurchPriceWorksheet."Minimum Quantity" := 0;
                PurchPriceWorksheet."Qty. optimale" := 0;
                PurchPriceWorksheet."Direct Unit Cost" := 0;
                PurchPriceWorksheet."Ending Date" := 0D;
                PurchPriceWorksheet."New Unit Price" := 0;
                IF ExcelBuf.FIND('-') THEN BEGIN
                    REPEAT
                        IF ExcelBuf."Column No." = 1 THEN BEGIN
                            EVALUATE(FormatDate, ExcelBuf."Cell Value as Text");
                            PurchPriceWorksheet."Starting Date" := FormatDate;
                            PurchPriceWorksheet.VALIDATE("Starting Date");
                        END;
                        IF ExcelBuf."Column No." = 2 THEN BEGIN
                            EVALUATE(FormatDate2, ExcelBuf."Cell Value as Text");
                            PurchPriceWorksheet."Ending Date" := FormatDate2;
                            PurchPriceWorksheet.VALIDATE("Ending Date");
                        END;
                        IF ExcelBuf."Column No." = 3 THEN BEGIN
                            PurchPriceWorksheet."Vendor No." := DELCHR(ExcelBuf."Cell Value as Text", '<=>', '''');
                            PurchPriceWorksheet.VALIDATE("Vendor No.");
                        END;
                        IF ExcelBuf."Column No." = 4 THEN BEGIN
                            PurchPriceWorksheet."Currency Code" := ExcelBuf."Cell Value as Text";
                            PurchPriceWorksheet.VALIDATE("Currency Code");
                        END;
                        IF ExcelBuf."Column No." = 5 THEN BEGIN
                            PurchPriceWorksheet."Item No." := DELCHR(ExcelBuf."Cell Value as Text", '<=>', '''');
                            PurchPriceWorksheet.VALIDATE("Item No.");
                        END;
                        IF ExcelBuf."Column No." = 6 THEN BEGIN
                            PurchPriceWorksheet."Variant Code" := ExcelBuf."Cell Value as Text";
                            PurchPriceWorksheet.VALIDATE("Variant Code");
                        END;
                        IF ExcelBuf."Column No." = 7 THEN BEGIN
                            PurchPriceWorksheet."Unit of Measure Code" := ExcelBuf."Cell Value as Text";
                            PurchPriceWorksheet.VALIDATE("Unit of Measure Code");
                        END;
                        IF ExcelBuf."Column No." = 8 THEN BEGIN
                            EVALUATE(FormatDecimal, ExcelBuf."Cell Value as Text");
                            PurchPriceWorksheet."Minimum Quantity" := FormatDecimal;
                        END;
                        IF ExcelBuf."Column No." = 9 THEN BEGIN
                            EVALUATE(FormatDecimal4, ExcelBuf."Cell Value as Text");
                            PurchPriceWorksheet."Qty. optimale" := FormatDecimal4;
                        END;
                        IF ExcelBuf."Column No." = 10 THEN BEGIN
                            EVALUATE(FormatDecimal2, ExcelBuf."Cell Value as Text");
                            PurchPriceWorksheet."Direct Unit Cost" := FormatDecimal2;
                        END;
                        IF ExcelBuf."Column No." = 11 THEN BEGIN
                            EVALUATE(FormatDecimal3, ExcelBuf."Cell Value as Text");
                            PurchPriceWorksheet."New Unit Price" := FormatDecimal3;
                        END;
                    UNTIL ExcelBuf.NEXT = 0;
                END;
                PurchPriceWorksheet.INSERT();

                i := i + 1;
            END;
        END;
    end;
}

