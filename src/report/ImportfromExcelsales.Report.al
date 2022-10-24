report 50009 "DEL Import from Excel sales"
{

    Caption = 'Import Budget from Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Price Worksheet"; "Sales Price Worksheet")
        {
            DataItemTableView = SORTING("Starting Date", "Ending Date", "Sales Type", "Sales Code", "Currency Code", "Item No.", "Variant Code", "Unit of Measure Code", "Minimum Quantity");
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
        Page2: Page "Sales Price Worksheet";
    begin
        ExcelBuf.DELETEALL();
        Page2.RUN();
    end;

    trigger OnPreReport()
    begin
        ExcelBuf.LOCKTABLE();
        "Sales Price Worksheet".LOCKTABLE();

        ReadExcelSheet();
        InsertPrice();
    end;

    var
        ExcelBuf: Record "Excel Buffer";
        SalesPriceWorksheet: Record "Sales Price Worksheet";
        FileName: InStream;
        // i changed filename from text[250] to instream      
        SheetName: Text[250];

    local procedure ReadExcelSheet()
    begin
        //TODO only for onprem dev ! #Abir
        //ExcelBuf.OpenBook(FileName, SheetName);

        ExcelBuf.OpenBookStream(FileName, SheetName);
        ExcelBuf.ReadSheet();
    end;

    local procedure AnalyzeData()
    begin
    end;

    local procedure InsertGLBudgetDim(DimCode2: Code[20]; DimValCode2: Code[20]; var GLBudgetEntry2: Record "G/L Budget Entry")
    begin
    end;

    local procedure FormatData(TextToFormat: Text[250]): Text[250]
    begin
    end;

    procedure SetGLBudgetName(NewToGLBudgetName: Code[10])
    begin
    end;

    procedure SetBudgetDimFilter(DimCode2: Code[20]; DimValCode2: Code[20]; var GLBudgetEntry2: Record "G/L Budget Entry")
    begin
    end;

    procedure InsertPrice()
    var
        Formatbool: Boolean;
        Formatbool2: Boolean;
        Formatbool3: Boolean;
        FormatDate: Date;
        FormatDate2: Date;
        FormatDecimal: Decimal;
        FormatDecimal2: Decimal;
        FormatDecimal3: Decimal;
        i: Integer;
        last: Integer;
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
                    UNTIL ExcelBuf.NEXT() = 0;
                END;
                SalesPriceWorksheet.INSERT();

                i := i + 1;
            END;
        END;
    end;

}

