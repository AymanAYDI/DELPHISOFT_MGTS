report 50013 "DEL Import from Excel purch"
{

    Caption = 'Import Budget from Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Purchase Price Worksheet"; "DEL Purchase Price Worksheet")
        {
            DataItemTableView = SORTING("Item No.", "Vendor No.", "Starting Date", "Currency Code",
            "Variant Code", "Unit of Measure Code", "Minimum Quantity", "Qty. optimale");
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
        "DEL Purchase Price Worksheet".LOCKTABLE();

        ReadExcelSheet();
        InsertPrice();
    end;

    var
        PurchPriceWorksheet: Record "DEL Purchase Price Worksheet";
        ExcelBuf: Record "Excel Buffer";
        FileName: InStream;
    //Text[250];        SheetName: Text[250];

    local procedure ReadExcelSheet()
    begin
        //TODO:CLOUD ExcelBuf.OpenBook(FileName, SheetName);
        // ExcelBuf.OpenBookStream(FileName, SheetName);

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
        FormatDate: Date;
        FormatDate2: Date;
        FormatDecimal: Decimal;
        FormatDecimal2: Decimal;
        FormatDecimal3: Decimal;
        FormatDecimal4: Decimal;
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
                    UNTIL ExcelBuf.NEXT() = 0;
                END;
                PurchPriceWorksheet.INSERT();

                i := i + 1;
            END;
        END;
    end;
}

