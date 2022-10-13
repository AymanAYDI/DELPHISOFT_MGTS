report 50044 "Supp reception1"
{
    Permissions = TableData 121 = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table120)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                PurchRcptLine.RESET;
                PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", "Purch. Rcpt. Header"."No.");
                PurchRcptLine.SETFILTER(PurchRcptLine.Type, '%1', PurchRcptLine.Type::"G/L Account");
                IF PurchRcptLine.FINDFIRST THEN
                    REPEAT
                    //SAZ PurchRcptLine.DELETE;
                    UNTIL PurchRcptLine.NEXT = 0;
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
    }

    labels
    {
    }

    var
        PurchRcptLine: Record "121";
        ReceptionOK: Boolean;
}

