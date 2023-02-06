report 50057 "Import Meeting Date From Excel"
{
    // MGTS10.042  | 02.01.2022 | Container/DESADV Management

    Caption = 'Import Metting Date From Excel';
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
        PostedContainerList: Record "50085";
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
        PurchaseLine: Record "39";
        ContainerNo: Code[20];
        MeetingDate: Date;
        ContainerMgt: Codeunit "50060";
    begin
        ContainerNo := GetValueAtCell(RowNo, 1, '');
        EVALUATE(MeetingDate, GetValueAtCell(RowNo, 2, ''));

        PostedContainerList.SETCURRENTKEY("Container No.", "Order No.");
        PostedContainerList.SETRANGE("Container No.", ContainerNo);
        PostedContainerList.SETRANGE(Level, 1);
        PostedContainerList.MODIFYALL("Meeting Date", MeetingDate);
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

