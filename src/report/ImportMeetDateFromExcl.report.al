report 50057 "DEL Import Meet Date From Excl"
{
    Caption = 'Import Metting Date From Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Integer)
        {
            DataItemTableView = sorting(Number)
                                order(ascending)
                                where(Number = filter(1));

            trigger OnPreDataItem()
            begin
                ExcelBuffer.LOCKTABLE();
                ExcelBuffer.OpenBookStream(Istream, sheetName);
                ExcelBuffer.ReadSheet();
                GetLastRowandColumns();
                if Totalrows < 2 then
                    ERROR(FileEmpty);

                ExcelBufferDialogMgt.Open(ImportFile);
                for i := 2 to Totalrows do begin
                    ExcelBufferDialogMgt.SetProgress(ROUND(i / Totalrows * 10000, 1));
                    UpdateData(i);
                end;
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
            if CloseAction = ACTION::OK then begin
                UploadIntoStream(UploadExcelMsg, '', ExcelExtension, FromFile, Istream);
                if FromFile = '' then
                    exit(false);
                FileName := FileManagement.GetFileName(FromFile);
                sheetName := ExcelBuffer.SelectSheetsNameStream(Istream);
                if sheetName = '' then
                    exit(false);
            end;
        end;
    }

    labels
    {
    }

    var
        PostedContainerList: Record "DEL Posted Container List";
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
        if ExcelBuffer.FINDLAST() then
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

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer; DefaultValue: Text[10]): text
    var
        ExcelBuffer1: Record "Excel Buffer";
    begin
        if ExcelBuffer1.GET(RowNo, ColNo) then
            exit(ExcelBuffer1."Cell Value as Text")
        else
            exit(DefaultValue);
    end;
}
