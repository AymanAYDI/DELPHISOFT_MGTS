report 50057 "Import Meeting Date From Excel"
{
    // MGTS10.042  | 02.01.2022 | Container/DESADV Management

    Caption = 'Import Metting Date From Excel';
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
                ExcelBuffer.OpenBookStream(Istream, sheetName);
                // ExcelBuffer.OpenBook(FileName, sheetName);
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
                    EXIT(FALSE)
                else begin
                    FileName := FileManagement.GetFileName(FromFile);
                    sheetName := ExcelBuffer.SelectSheetsNameStream(Istream);
                end;
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
        PostedContainerList: Record "DEL Posted Container List";
        FileManagement: Codeunit "File Management";
        ExcelBufferDialogMgt: Codeunit "Excel Buffer Dialog Management";
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
        ContainerNo: Code[20];
        MeetingDate: Date;
    begin
        ContainerNo := GetValueAtCell(RowNo, 1, '');
        EVALUATE(MeetingDate, GetValueAtCell(RowNo, 2, ''));
        PostedContainerList.SETCURRENTKEY("Container No.", "Order No.");
        PostedContainerList.SETRANGE("Container No.", ContainerNo);
        PostedContainerList.SETRANGE(Level, 1);
        PostedContainerList.MODIFYALL("Meeting Date", MeetingDate);
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; DefaultValue: Text[10]): Code[20]
    var
        ExcelBuffer1: Record "Excel Buffer";
    begin
        IF ExcelBuffer1.GET(RowNo, ColNo) THEN
            EXIT(ExcelBuffer1."Cell Value as Text")
        ELSE
            EXIT(DefaultValue);
    end;
}
