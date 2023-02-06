report 50056 "DEL ImportContainers FromExcel"
{

    Caption = 'Import Containers From Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Integer)
        {
            DataItemTableView = SORTING(Number)
                                ORDER(Ascending)
                                WHERE(Number = FILTER(1));

            trigger OnPreDataItem()
            var
                ContainerListBufferPage: Page "Container List";
            begin
                ContainerListBuffer.RESET();
                IF NOT ContainerListBuffer.ISEMPTY THEN
                    IF CONFIRM(AlreadyExistLbl) THEN
                        ContainerListBuffer.DELETEALL()
                    ELSE
                        ERROR('');

                ExcelBuffer.LOCKTABLE();
                ExcelBuffer.OpenBook(FileName, sheetName);
                ExcelBuffer.ReadSheet();
                GetLastRowandColumns();
                IF Totalrows < 2 THEN
                    ERROR(FileEmpty);

                EntryNo := 0;
                ExcelBufferDialogMgt.Open(ImportFile);
                FOR i := 2 TO Totalrows DO BEGIN
                    ExcelBufferDialogMgt.SetProgress(ROUND(i / Totalrows * 10000, 1));
                    Insertdata(i);
                END;
                ExcelBufferDialogMgt.Close();
                ExcelBuffer.DELETEALL();
                MESSAGE(ImportCompleted);
                COMMIT();
                ContainerListBufferPage.RUNMODAL();
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
            TempCsvBuffer.SaveDataToBlob(TempBlob, ';');
            TempBlob.CreateInStream(IStream, TextEncoding::UTF8);
            DownloadFromStream(IStream, '', '', '', FileName)

        end;
    }

    labels
    {
    }

    var
        ContainerListBuffer: Record "DEL Container List";
        ExcelBuffer: Record "Excel Buffer";
        TempCsvBuffer: Record "CSV Buffer" temporary;
        TempBlob: Codeunit "Temp Blob";
        ExcelBufferDialogMgt: Codeunit "Excel Buffer Dialog Management";
        FileManagement: Codeunit "File Management";
        EntryNo: Integer;
        i: Integer;
        TotalColumns: Integer;
        Totalrows: Integer;
        IStream: InStream;
        AlreadyExistLbl: Label 'Lines already exist in container list. Do you want to continue ?';
        ExcelExtension: Label '*.xlsx;*.xls';
        FileEmpty: Label 'Le fichier est vide. ';
        ImportCompleted: Label 'Import completed!';
        ImportFile: Label 'Import Excel worksheet...\\', Comment = '{Locked="Excel"}';
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

    local procedure Insertdata(RowNo: Integer)
    var
        ContainerMgt: Codeunit "Container Mgt";
        ContainerNo: Code[20];
        OrderNo: Code[20];
    begin
        ContainerNo := GetValueAtCell(RowNo, 6, '');
        OrderNo := GetValueAtCell(RowNo, 8, '');

        EntryNo += 1;
        IF InsertPackingGroupByContainerOrderNo(ContainerNo, OrderNo) THEN
            EntryNo += 1;

        ContainerListBuffer.INIT();
        ContainerListBuffer."Entry No." := EntryNo;
        ContainerListBuffer."Row No." := RowNo;
        ContainerListBuffer."Container No." := ContainerNo;
        ContainerListBuffer."Order No." := OrderNo;
        ContainerListBuffer."Item No." := GetValueAtCell(RowNo, 9, '');
        EVALUATE(ContainerListBuffer.Pieces, GetValueAtCell(RowNo, 12, '0'));
        EVALUATE(ContainerListBuffer.CTNS, GetValueAtCell(RowNo, 13, '0'));
        EVALUATE(ContainerListBuffer.Volume, GetValueAtCell(RowNo, 14, '0'));
        EVALUATE(ContainerListBuffer.Weight, GetValueAtCell(RowNo, 15, '0'));

        AddPurchaseLineInfo(ContainerListBuffer);

        ContainerListBuffer.Level := 2;
        ContainerListBuffer.INSERT();

        ContainerMgt.CheckContainerLine(ContainerListBuffer);
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

    local procedure InsertPackingGroupByContainerOrderNo(ContainerNo: Code[20]; OrderNo: Code[20]): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        ContainerListBuffer.SETCURRENTKEY("Container No.", "Order No.");
        ContainerListBuffer.SETRANGE("Container No.", ContainerNo);
        ContainerListBuffer.SETRANGE("Order No.", OrderNo);
        IF ContainerListBuffer.ISEMPTY THEN BEGIN
            ContainerListBuffer.INIT();
            ContainerListBuffer."Entry No." := EntryNo;
            ContainerListBuffer."Container No." := ContainerNo;
            ContainerListBuffer."Order No." := OrderNo;
            IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, OrderNo) THEN
                ContainerListBuffer."Buy-from Vendor No." := PurchaseHeader."Buy-from Vendor No.";
            ContainerListBuffer.Level := 1;
            IF ContainerListBuffer.INSERT() THEN
                EXIT(TRUE);
        END
    end;

    local procedure AddPurchaseLineInfo(var _ContainerListBuffer: Record "DEL Container List")
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", _ContainerListBuffer."Order No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("No.", _ContainerListBuffer."Item No.");
        IF PurchaseLine.FINDFIRST() THEN BEGIN
            _ContainerListBuffer.Description := PurchaseLine.Description;
            _ContainerListBuffer."Order Quantity" := PurchaseLine.Quantity;
            _ContainerListBuffer."Order Line No." := PurchaseLine."Line No.";
            _ContainerListBuffer."Special Order Sales No." := PurchaseLine."Special Order Sales No.";
            _ContainerListBuffer."Special Order Sales Line No." := PurchaseLine."Special Order Sales Line No.";
        END;
    end;
}

