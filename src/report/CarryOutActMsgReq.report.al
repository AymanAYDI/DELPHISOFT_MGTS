report 50077 "DEL CarryOut Act. Msg. - Req."
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
                    field(PrintOrders; PrintOrder)
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
        PurchOrderHeader: Record "Purchase Header";
        ReqWkshTmpl: Record "Req. Wksh. Template";
        ReqLine: Record "Requisition Line";
        ReqWkshName: Record "Requisition Wksh. Name";
        ReqWkshMakeOrders: Codeunit "Req. Wksh.-Make Order";
        CreateFromEDI: Boolean;
        HideDialog: Boolean;
        PrintOrder: Boolean;
        TempJnlBatchName: Code[10];
        EndOrderDate: Date;
        Text000: Label 'cannot be filtered when you create orders';
        Text001: Label 'There is nothing to create.';
        Text003: Label 'You are now in worksheet %1.';


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
        ReqWkshTmpl.GET(ReqLine."Worksheet Template Name");
        IF ReqWkshTmpl.Recurring AND (ReqLine.GETFILTER("Order Date") <> '') THEN
            ReqLine.FIELDERROR("Order Date", Text000);
        TempJnlBatchName := ReqLine."Journal Batch Name";
        IF CreateFromEDI THEN BEGIN
            DELMGTS_FctMgt.SetEDIParam(TRUE, TRUE);
            PurchOrderHeader."Order Date" := TODAY;

        END;
        ReqWkshMakeOrders.Set(PurchOrderHeader, EndOrderDate, PrintOrder);
        ReqWkshMakeOrders.CarryOutBatchAction(ReqLine);

        IF ReqLine."Line No." = 0 THEN
            MESSAGE(Text001)
        ELSE
            IF NOT HideDialog THEN
                IF TempJnlBatchName <> ReqLine."Journal Batch Name" THEN
                    MESSAGE(
                      Text003,
                      ReqLine."Journal Batch Name");

        IF NOT ReqLine.FIND('=><') OR (TempJnlBatchName <> ReqLine."Journal Batch Name") THEN BEGIN
            ReqLine.RESET();
            ReqLine.FILTERGROUP := 2;
            ReqLine.SETRANGE("Worksheet Template Name", ReqLine."Worksheet Template Name");
            ReqLine.SETRANGE("Journal Batch Name", ReqLine."Journal Batch Name");
            ReqLine.FILTERGROUP := 0;
            ReqLine."Line No." := 1;
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

