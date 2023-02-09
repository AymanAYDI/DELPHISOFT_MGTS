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
                ExcelBuffer.OpenBookStream(Istream, SheetName);
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
        var
            FromFile: Text;
        begin
            IF CloseAction = ACTION::OK THEN BEGIN
                UploadIntoStream(UploadExcelMsg, '', ExcelExtension, FromFile, Istream);
                IF FromFile = '' THEN
                    EXIT(FALSE);
                FileName := FileManagement.GetFileName(FromFile);
                sheetName := ExcelBuffer.SelectSheetsNameStream(Istream);
                IF sheetName = '' THEN
                    EXIT(FALSE);
            END;
        end;

    }

    labels
    {
    }

    var

        ExcelBuffer: Record "Excel Buffer";
        ExcelBufferDialogMgt: Codeunit "Excel Buffer Dialog Management";
        FileManagement: Codeunit "File Management";
        Istream: InStream;
        i: Integer;
        TotalColumns: Integer;
        Totalrows: Integer;
        ExcelExtension: Label '*.xlsx;*.xls';
        FileEmpty: Label 'Le fichier est vide. ';
        ImportCompleted: Label 'Import completed!';
        ImportFile: Label 'Import Excel worksheet...\\', Comment = '{Locked="Excel"}';
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        FileName: Text;
        sheetName: Text;

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
        Item: Record Item;
        ItemCrossReference: Record "Item Reference";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        DistIntegration: Codeunit "Dist. Integration";
        CrossRef: Code[20];
        ItemNo: Code[20];
        OrderNo: Code[20];
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

