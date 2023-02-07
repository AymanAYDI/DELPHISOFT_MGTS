report 50058 "DEL Import Ext. Ref From Excel"
{

    Caption = 'Import Externals References';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));

            trigger OnPreDataItem()
            begin
                ExcelBuffer.LOCKTABLE();
                //TODO ExcelBuffer.OpenBook(FileName, sheetName);

                ExcelBuffer.OpenBookStream(FileName, SheetName);
                ExcelBuffer.ReadSheet();

                ExcelBuffer.ReadSheet();
                GetLastRowandColumns();
                IF Totalrows < 2 THEN
                    ERROR(FileEmpty);

                ExcelBufferDialogMgt.Open(ImportFile);
                FOR i := 2 TO Totalrows DO BEGIN
                    ExcelBufferDialogMgt.SetProgress(ROUND(i / Totalrows * 10000, 1));
                    UpdateData(i);
                END;
                ExcelBufferDialogMgt.Close();
                ExcelBuffer.DELETEALL();
                MESSAGE(ImportCompleted);
            end;
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

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            //TODO IF CloseAction = ACTION::OK THEN BEGIN
            //     FileName := FileManagement.UploadFile('Import Excel', ExcelExtension);
            //     IF FileName = '' THEN
            //         EXIT(FALSE);
            //     sheetName := ExcelBuffer.SelectSheetsName(FileName);
            //     IF sheetName = '' THEN
            //         EXIT(FALSE);
            // END;
        end;
    }

    labels
    {
    }

    var
        ExcelBuffer: Record "Excel Buffer";
        TotalColumns: Integer;
        Totalrows: Integer;
        FileName: InStream;
        sheetName: Text;
        FileManagement: Codeunit "File Management";
        ExcelExtension: Label '*.xlsx;*.xls';
        i: Integer;
        FileEmpty: Label 'Le fichier est vide. ';
        ImportCompleted: Label 'Import completed!';
        ExcelBufferDialogMgt: Codeunit "Excel Buffer Dialog Management";
        ImportFile: Label 'Import Excel worksheet...\\', Comment = '{Locked="Excel"}';

    local procedure GetLastRowandColumns()
    begin
        ExcelBuffer.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuffer.COUNT;
        ExcelBuffer.RESET();
        IF ExcelBuffer.FINDLAST() THEN
            Totalrows := ExcelBuffer."Row No.";
    end;

    local procedure UpdateData(RowNo: Integer)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ItemCrossReference: Record "Item Reference";
        Item: Record Item;
        OrderNo: Code[20];
        ItemNo: Code[20];
        CrossRef: Code[20];
        DistIntegration: Codeunit "Dist. Integration";
    begin
        OrderNo := GetValueAtCell(RowNo, 1, '');
        IF NOT SalesHeader.GET(SalesHeader."Document Type"::Order, OrderNo) THEN
            EXIT;

        ItemNo := GetValueAtCell(RowNo, 2, '');
        IF NOT Item.GET(ItemNo) THEN
            EXIT;

        CrossRef := GetValueAtCell(RowNo, 3, '');

        ItemCrossReference.RESET();
        ItemCrossReference.SETRANGE("Item No.", ItemNo);
        ItemCrossReference.SETFILTER("Reference Type", '%1|%2', ItemCrossReference."Reference Type"::Customer, ItemCrossReference."Reference Type"::" ");
        ItemCrossReference.SETFILTER("Reference Type No.", '%1|%2', SalesHeader."Sell-to Customer No.", '');
        ItemCrossReference.SETRANGE("Reference No.", CrossRef);
        IF NOT ItemCrossReference.FINDFIRST() THEN BEGIN
            ItemCrossReference.INIT();
            ItemCrossReference.VALIDATE("Item No.", ItemNo);
            ItemCrossReference.VALIDATE("Unit of Measure", Item."Base Unit of Measure");
            ItemCrossReference.VALIDATE("Reference Type", ItemCrossReference."Reference Type"::Customer);
            ItemCrossReference.VALIDATE("Reference Type No.", SalesHeader."Sell-to Customer No.");
            ItemCrossReference.VALIDATE("Reference No.", CrossRef);
            ItemCrossReference.INSERT(TRUE);
        END;

        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", ItemNo);
        IF SalesLine.FINDSET() THEN
            REPEAT
                SalesLine."Item Reference No." := ItemCrossReference."Reference No.";
                SalesLine."Unit of Measure" := ItemCrossReference."Unit of Measure";
                SalesLine."Item Reference Type" := ItemCrossReference."Reference Type";
                SalesLine."Item Reference Type No." := ItemCrossReference."Reference Type No.";
                SalesLine.MODIFY();
            UNTIL SalesLine.NEXT() = 0;
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; DefaultValue: Text[10]): Text
    var
        ExcelBuffer1: Record "Excel Buffer";
    begin
        IF ExcelBuffer1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuffer1."Cell Value as Text")
        ELSE
            EXIT(DefaultValue);
    end;
}

