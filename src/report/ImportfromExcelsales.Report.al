report 50009 "Import from Excel sales"
{
    // NGTS/LOCO/GRC 13.03.09 create report

    Caption = 'Import Budget from Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem5995; Table7023)
        {
            DataItemTableView = SORTING (Starting Date, Ending Date, Sales Type, Sales Code, Currency Code, Item No., Variant Code, Unit of Measure Code, Minimum Quantity);
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
        "Sales Price Worksheet".LOCKTABLE;

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
        SalesPriceWorksheet: Record "7023";
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
    begin
        ExcelBuf.SETFILTER("Row No.", '>%1', 3);

        IF ExcelBuf.FIND('+') THEN
            last := ExcelBuf."Row No.";

        i := 5;
        IF ExcelBuf.FIND('-') THEN BEGIN
            WHILE (i <= last) DO BEGIN
                ExcelBuf.SETRANGE("Row No.", i);
                SalesPriceWorksheet."Starting Date" := 0D;
                SalesPriceWorksheet."Ending Date" := 0D;
                SalesPriceWorksheet."Sales Code" := '';
                SalesPriceWorksheet."Currency Code" := '';
                SalesPriceWorksheet."Item No." := '';
                SalesPriceWorksheet."Variant Code" := '';
                SalesPriceWorksheet."Unit of Measure Code" := '';
                SalesPriceWorksheet."Minimum Quantity" := 0;
                SalesPriceWorksheet."Current Unit Price" := 0;
                SalesPriceWorksheet."New Unit Price" := 0;
                SalesPriceWorksheet."Price Includes VAT" := FALSE;
                SalesPriceWorksheet."Allow Invoice Disc." := FALSE;
                SalesPriceWorksheet."VAT Bus. Posting Gr. (Price)" := '';
                SalesPriceWorksheet."Allow Line Disc." := FALSE;
                IF ExcelBuf.FIND('-') THEN BEGIN
                    REPEAT
                        IF ExcelBuf."Column No." = 1 THEN BEGIN
                            EVALUATE(FormatDate, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."Starting Date" := FormatDate;
                            SalesPriceWorksheet.VALIDATE("Starting Date");
                        END;
                        IF ExcelBuf."Column No." = 2 THEN BEGIN
                            EVALUATE(FormatDate2, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."Ending Date" := FormatDate2;
                            SalesPriceWorksheet.VALIDATE("Ending Date");
                        END;
                        IF ExcelBuf."Column No." = 3 THEN BEGIN
                            IF ExcelBuf."Cell Value as Text" = 'Client' THEN
                                SalesPriceWorksheet."Sales Type" := 0;
                            IF ExcelBuf."Cell Value as Text" = 'Groupe tarifs client' THEN
                                SalesPriceWorksheet."Sales Type" := 1;
                            IF ExcelBuf."Cell Value as Text" = 'Tous les clients' THEN
                                SalesPriceWorksheet."Sales Type" := 2;
                            IF ExcelBuf."Cell Value as Text" = 'Campagne' THEN
                                SalesPriceWorksheet."Sales Type" := 3;
                            SalesPriceWorksheet.VALIDATE("Sales Type");
                        END;
                        IF ExcelBuf."Column No." = 4 THEN BEGIN

                            SalesPriceWorksheet."Sales Code" := DELCHR(ExcelBuf."Cell Value as Text", '<=>', '''');
                            SalesPriceWorksheet.VALIDATE("Sales Code");

                        END;
                        IF ExcelBuf."Column No." = 5 THEN BEGIN
                            SalesPriceWorksheet."Currency Code" := ExcelBuf."Cell Value as Text";
                            SalesPriceWorksheet.VALIDATE("Currency Code");
                        END;
                        IF ExcelBuf."Column No." = 6 THEN BEGIN
                            SalesPriceWorksheet."Item No." := DELCHR(ExcelBuf."Cell Value as Text", '<=>', '''');
                            SalesPriceWorksheet.VALIDATE("Item No.");
                        END;
                        IF ExcelBuf."Column No." = 7 THEN BEGIN
                            SalesPriceWorksheet."Variant Code" := ExcelBuf."Cell Value as Text";
                            SalesPriceWorksheet.VALIDATE("Variant Code");
                        END;
                        IF ExcelBuf."Column No." = 8 THEN BEGIN
                            SalesPriceWorksheet."Unit of Measure Code" := ExcelBuf."Cell Value as Text";
                            SalesPriceWorksheet.VALIDATE("Unit of Measure Code");
                        END;
                        IF ExcelBuf."Column No." = 9 THEN BEGIN
                            EVALUATE(FormatDecimal, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."Minimum Quantity" := FormatDecimal;
                        END;
                        IF ExcelBuf."Column No." = 10 THEN BEGIN
                            EVALUATE(FormatDecimal2, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."Current Unit Price" := FormatDecimal2;
                        END;
                        IF ExcelBuf."Column No." = 11 THEN BEGIN
                            EVALUATE(FormatDecimal3, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."New Unit Price" := FormatDecimal3;
                        END;
                        IF ExcelBuf."Column No." = 12 THEN BEGIN
                            EVALUATE(Formatbool, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."Allow Invoice Disc." := Formatbool;
                        END;
                        IF ExcelBuf."Column No." = 13 THEN BEGIN
                            EVALUATE(Formatbool2, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."Price Includes VAT" := Formatbool2;
                        END;
                        IF ExcelBuf."Column No." = 14 THEN BEGIN
                            SalesPriceWorksheet."VAT Bus. Posting Gr. (Price)" := ExcelBuf."Cell Value as Text";
                        END;
                        IF ExcelBuf."Column No." = 15 THEN BEGIN
                            EVALUATE(Formatbool3, ExcelBuf."Cell Value as Text");
                            SalesPriceWorksheet."Allow Line Disc." := Formatbool3;
                        END;
                    UNTIL ExcelBuf.NEXT = 0;
                END;
                SalesPriceWorksheet.INSERT();

                i := i + 1;
            END;
        END;
    end;

    [Scope('Internal')]
    procedure UploadFile()
    var
        FileMgt: Codeunit "419";
    begin
        /*
        IF FileFormat = FileFormat::"Version 4.00 or Later (.xml)" THEN
          ServerFileName := FileMgt.UploadFile(Text034,'.xml')
        ELSE
          ServerFileName := FileMgt.UploadFile(Text031,'.txt');
        
        IF ServerFileName <> '' THEN
          FileName := Text039
        */

    end;
}

