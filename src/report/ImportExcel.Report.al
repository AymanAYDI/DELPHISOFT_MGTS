report 50006 "DEL Import Excel"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));

            trigger OnPreDataItem()
            begin
                ExcelBuffer.LOCKTABLE();
                //TODO: cannot be used on cloud, à vérifier ! 
                // ExcelBuffer.OpenBook(FileName, sheetName); //code original

                ExcelBuffer.OpenBookStream(FileName, sheetName);

                ExcelBuffer.ReadSheet();
                GetLastRowandColumns();
                FOR i := 2 TO Totalrows DO
                    Insertdata(i);
                ExcelBuffer.DELETEALL();
                MESSAGE('Import Completed');
            end;
        }
    }

    requestpage
    {

        layout
        { }
        actions
        { }

        // trigger OnQueryClosePage(CloseAction: Action): Boolean
        // var
        //     Buffer: Text;
        //     OutStr: OutStream;
        // begin
        //     IF CloseAction = ACTION::OK THEN BEGIN
        //         //TODO: onprem method 

        //         // FileName := FileManagement.UploadFile('Import Excel', ExcelExtension);

        //         // IF FileName.ReadText() THEN
        //         //     EXIT(false);
        //         // //TODO: onprem method 
        //         // sheetName := ExcelBuffer.SelectSheetsName(FileName);
        //         IF sheetName = '' THEN
        //             EXIT(false);
        //     END;
        // end;
    }

    labels
    { }

    var
        ExcelBuffer: Record "Excel Buffer";
        SalesPriceWorksheet: Record "Sales Price Worksheet";
        CurrencyCode: Code[10];
        UnitCode: Code[10];
        ItemNo: Code[20];
        SalesCode: Code[20];
        VendorNo: Code[20];
        EndDate: Date;
        StartDate: Date;
        CurrentUnitPrice: Decimal;
        NewPrice: Decimal;
        SalesTypeOption: Enum "Sales Price Type";
        FileName: InStream;
        i: Integer;

        TotalColumns: Integer;
        Totalrows: Integer;
        SalesType: Text;
        sheetName: Text;

    local procedure GetLastRowandColumns()
    begin
        ExcelBuffer.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuffer.COUNT;
        ExcelBuffer.RESET();
        IF ExcelBuffer.FINDLAST() THEN
            Totalrows := ExcelBuffer."Row No.";
    end;

    local procedure Insertdata(RowNo: Integer)
    begin
        EVALUATE(SalesType, GetValueAtCell(RowNo, 1));
        EVALUATE(SalesCode, GetValueAtCell(RowNo, 2));
        EVALUATE(ItemNo, GetValueAtCell(RowNo, 3));
        EVALUATE(UnitCode, GetValueAtCell(RowNo, 5));
        EVALUATE(StartDate, GetValueAtCell(RowNo, 6));
        EVALUATE(EndDate, GetValueAtCell(RowNo, 7));
        EVALUATE(NewPrice, GetValueAtCell(RowNo, 9));
        EVALUATE(CurrencyCode, GetValueAtCell(RowNo, 10));
        EVALUATE(VendorNo, GetValueAtCell(RowNo, 11));
        EVALUATE(CurrentUnitPrice, GetValueAtCell(RowNo, 8));
        IF (SalesType = 'Customer') OR (SalesType = 'Client') THEN
            SalesTypeOption := SalesTypeOption::Customer;

        IF (SalesType = 'Customer Price Group') OR (SalesType = 'Groupe tarifs client') THEN
            SalesTypeOption := SalesTypeOption::"Customer Price Group";


        IF (SalesType = 'All Customers') OR (SalesType = 'Tous les clients') THEN
            SalesTypeOption := SalesTypeOption::"All Customers";

        IF (SalesType = 'Campaign') OR (SalesType = 'Campagne') THEN
            SalesTypeOption := SalesTypeOption::Campaign;


        SalesPriceWorksheet.RESET();
        SalesPriceWorksheet.SETRANGE("Starting Date", StartDate);
        SalesPriceWorksheet.SETRANGE("Ending Date", EndDate);
        SalesPriceWorksheet.SETRANGE("Currency Code", CurrencyCode);
        SalesPriceWorksheet.SETRANGE("Item No.", ItemNo);
        SalesPriceWorksheet.SETRANGE("Unit of Measure Code", UnitCode);
        SalesPriceWorksheet.SETRANGE("Sales Type", SalesTypeOption);
        SalesPriceWorksheet.SETRANGE("Sales Code", SalesCode);
        IF SalesPriceWorksheet.FINDFIRST() THEN BEGIN
            SalesPriceWorksheet."New Unit Price" := NewPrice;
            SalesPriceWorksheet.VALIDATE("New Unit Price");
            SalesPriceWorksheet.MODIFY();
        END
        ELSE BEGIN
            SalesPriceWorksheet.INIT();
            SalesPriceWorksheet."Starting Date" := StartDate;
            SalesPriceWorksheet."Ending Date" := EndDate;
            SalesPriceWorksheet."Item No." := ItemNo;
            SalesPriceWorksheet."Currency Code" := CurrencyCode;
            SalesPriceWorksheet."Unit of Measure Code" := UnitCode;
            SalesPriceWorksheet."Sales Type" := SalesTypeOption;
            SalesPriceWorksheet."Sales Code" := SalesCode;
            SalesPriceWorksheet."Current Unit Price" := CurrentUnitPrice;
            SalesPriceWorksheet."New Unit Price" := NewPrice;
            SalesPriceWorksheet.VALIDATE("New Unit Price");
            //TODO "vendor no." does not exist
            //SalesPriceWorksheet."Vendor No." := VendorNo;
            SalesPriceWorksheet.INSERT();
        END;
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    var
        ExcelBuffer1: Record "Excel Buffer";
    begin
        IF ExcelBuffer1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuffer1."Cell Value as Text")
        ELSE
            EXIT('');
    end;

}

