report 50058 "Import External Ref From Excel"
{
    // MGTS10.043  | 23.01.2023 | Create new object

    Caption = 'Import Externals References';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table2000000026)
        {
            DataItemTableView = SORTING (Number)
                                ORDER(Ascending)
                                WHERE (Number = FILTER (1));

            trigger OnPreDataItem()
            begin
                ExcelBuffer.LOCKTABLE;
                ExcelBuffer.OpenBook(FileName, sheetName);
                ExcelBuffer.ReadSheet;
                GetLastRowandColumns;
                IF Totalrows < 2 THEN
                    ERROR(FileEmpty);

                ExcelBufferDialogMgt.Open(ImportFile);
                FOR i := 2 TO Totalrows DO BEGIN
                    ExcelBufferDialogMgt.SetProgress(ROUND(i / Totalrows * 10000, 1));
                    UpdateData(i);
                END;
                ExcelBufferDialogMgt.Close;
                ExcelBuffer.DELETEALL;
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
            IF CloseAction = ACTION::OK THEN BEGIN
                FileName := FileManagement.UploadFile('Import Excel', ExcelExtension);
                IF FileName = '' THEN
                    EXIT(FALSE);
                sheetName := ExcelBuffer.SelectSheetsName(FileName);
                IF sheetName = '' THEN
                    EXIT(FALSE);
            END;
        end;
    }

    labels
    {
    }

    var
        ExcelBuffer: Record "370";
        TotalColumns: Integer;
        Totalrows: Integer;
        FileName: Text;
        sheetName: Text;
        FileManagement: Codeunit "419";
        ExcelExtension: Label '*.xlsx;*.xls';
        i: Integer;
        FileEmpty: Label 'Le fichier est vide. ';
        ImportCompleted: Label 'Import completed!';
        ExcelBufferDialogMgt: Codeunit "5370";
        ImportFile: Label 'Import Excel worksheet...\\', Comment = '{Locked="Excel"}';

    local procedure GetLastRowandColumns()
    begin
        ExcelBuffer.SETRANGE("Row No.", 1);
        TotalColumns := ExcelBuffer.COUNT;
        ExcelBuffer.RESET;
        IF ExcelBuffer.FINDLAST THEN
            Totalrows := ExcelBuffer."Row No.";
    end;

    local procedure UpdateData(RowNo: Integer)
    var
        SalesHeader: Record "36";
        SalesLine: Record "37";
        ItemCrossReference: Record "5717";
        Item: Record "27";
        OrderNo: Code[20];
        ItemNo: Code[20];
        CrossRef: Code[20];
        DistIntegration: Codeunit "5702";
    begin
        OrderNo := GetValueAtCell(RowNo, 1, '');
        IF NOT SalesHeader.GET(SalesHeader."Document Type"::Order, OrderNo) THEN
            EXIT;

        ItemNo := GetValueAtCell(RowNo, 2, '');
        IF NOT Item.GET(ItemNo) THEN
            EXIT;

        CrossRef := GetValueAtCell(RowNo, 3, '');

        ItemCrossReference.RESET;
        ItemCrossReference.SETRANGE("Item No.", ItemNo);
        ItemCrossReference.SETFILTER("Cross-Reference Type", '%1|%2', ItemCrossReference."Cross-Reference Type"::Customer, ItemCrossReference."Cross-Reference Type"::" ");
        ItemCrossReference.SETFILTER("Cross-Reference Type No.", '%1|%2', SalesHeader."Sell-to Customer No.", '');
        ItemCrossReference.SETRANGE("Cross-Reference No.", CrossRef);
        IF NOT ItemCrossReference.FINDFIRST THEN BEGIN
            ItemCrossReference.INIT;
            ItemCrossReference.VALIDATE("Item No.", ItemNo);
            ItemCrossReference.VALIDATE("Unit of Measure", Item."Base Unit of Measure");
            ItemCrossReference.VALIDATE("Cross-Reference Type", ItemCrossReference."Cross-Reference Type"::Customer);
            ItemCrossReference.VALIDATE("Cross-Reference Type No.", SalesHeader."Sell-to Customer No.");
            ItemCrossReference.VALIDATE("Cross-Reference No.", CrossRef);
            ItemCrossReference.INSERT(TRUE);
        END;

        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETRANGE("No.", ItemNo);
        IF SalesLine.FINDSET THEN
            REPEAT
                SalesLine."Cross-Reference No." := ItemCrossReference."Cross-Reference No.";
                SalesLine."Unit of Measure (Cross Ref.)" := ItemCrossReference."Unit of Measure";
                SalesLine."Cross-Reference Type" := ItemCrossReference."Cross-Reference Type";
                SalesLine."Cross-Reference Type No." := ItemCrossReference."Cross-Reference Type No.";
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; DefaultValue: Text[10]): Text
    var
        ExcelBuffer1: Record "370";
    begin
        IF ExcelBuffer1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuffer1."Cell Value as Text")
        ELSE
            EXIT(DefaultValue);
    end;
}

