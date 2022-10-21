report 50077 "DEL Carry Out Act Msg.- Req."
{

    Caption = 'Carry Out Action Msg. - Req.';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintOrders; PrintOrders)
                    {
                        Caption = 'Print Orders';
                        ToolTip = 'Specifies whether to print the purchase orders after they are created.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            PurchOrderHeader."Order Date" := WORKDATE();
            PurchOrderHeader."Posting Date" := WORKDATE();
            PurchOrderHeader."Expected Receipt Date" := WORKDATE();
            IF ReqWkshTmpl.Recurring THEN
                EndOrderDate := WORKDATE()
            ELSE
                EndOrderDate := 0D;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        UseOneJnl(ReqLine);
    end;

    var
        Text000: Label 'cannot be filtered when you create orders';
        Text001: Label 'There is nothing to create.';
        Text003: Label 'You are now in worksheet %1.';
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqWkshName: Record "Requisition Wksh. Name";
        ReqLine: Record "Requisition Line";
        PurchOrderHeader: Record "Purchase Header";
        ReqWkshMakeOrders: Codeunit "Req. Wksh.-Make Order";
        EndOrderDate: Date;
        PrintOrders: Boolean;
        TempJnlBatchName: Code[10];
        HideDialog: Boolean;
        CreateFromEDI: Boolean;


    procedure SetReqWkshLine(var NewReqLine: Record "Requisition Line")
    begin
        ReqLine.COPY(NewReqLine);
        ReqWkshTmpl.GET(NewReqLine."Worksheet Template Name");
    end;


    procedure GetReqWkshLine(var NewReqLine: Record "Requisition Line")
    begin
        NewReqLine.COPY(ReqLine);
    end;

    procedure SetReqWkshName(var NewReqWkshName: Record "Requisition Wksh. Name")
    begin
        ReqWkshName.COPY(NewReqWkshName);
        ReqWkshTmpl.GET(NewReqWkshName."Worksheet Template Name");
    end;

    local procedure UseOneJnl(var ReqLine: Record "Requisition Line")
    var
        DELMGTS_FctMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        WITH ReqLine DO BEGIN
            ReqWkshTmpl.GET("Worksheet Template Name");
            IF ReqWkshTmpl.Recurring AND (GETFILTER("Order Date") <> '') THEN
                FIELDERROR("Order Date", Text000);
            TempJnlBatchName := "Journal Batch Name";
            //>>MGTSEDI10.00.00.23
            IF CreateFromEDI THEN BEGIN
                DELMGTS_FctMgt.SetEDIParam(TRUE, TRUE);

                //>>MGTSEDI10.00.00.24
                PurchOrderHeader."Order Date" := TODAY;
                //<<MGTSEDI10.00.00.24

            END;
            //<<MGTSEDI10.00.00.23
            ReqWkshMakeOrders.Set(PurchOrderHeader, EndOrderDate, PrintOrders);
            ReqWkshMakeOrders.CarryOutBatchAction(ReqLine);

            IF "Line No." = 0 THEN
                MESSAGE(Text001)
            ELSE
                IF NOT HideDialog THEN
                    IF TempJnlBatchName <> "Journal Batch Name" THEN
                        MESSAGE(
                          Text003,
                          "Journal Batch Name");

            IF NOT FIND('=><') OR (TempJnlBatchName <> "Journal Batch Name") THEN BEGIN
                RESET();
                FILTERGROUP := 2;
                SETRANGE("Worksheet Template Name", "Worksheet Template Name");
                SETRANGE("Journal Batch Name", "Journal Batch Name");
                FILTERGROUP := 0;
                "Line No." := 1;
            END;
        END;
    end;


    procedure InitializeRequest(ExpirationDate: Date; OrderDate: Date; PostingDate: Date; ExpectedReceiptDate: Date; YourRef: Text[50])
    begin
        EndOrderDate := ExpirationDate;
        PurchOrderHeader."Order Date" := OrderDate;
        PurchOrderHeader."Posting Date" := PostingDate;
        PurchOrderHeader."Expected Receipt Date" := ExpectedReceiptDate;
        PurchOrderHeader."Your Reference" := YourRef;
    end;


    procedure SetHideDialog(NewHideDialog: Boolean)
    begin
        HideDialog := NewHideDialog;
    end;


    procedure SetEdiParam(pCreateFromEDI: Boolean)
    begin
        CreateFromEDI := pCreateFromEDI;
    end;
}

