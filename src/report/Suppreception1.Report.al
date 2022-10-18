report 50044 "DEL Supp reception1"
{
    Permissions = TableData "Purch. Rcpt. Line" = rimd;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                PurchRcptLine.RESET();
                PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", "Purch. Rcpt. Header"."No.");
                PurchRcptLine.SETFILTER(PurchRcptLine.Type, '%1', PurchRcptLine.Type::"G/L Account");
                IF PurchRcptLine.FINDFIRST() THEN
                    REPEAT
                    //SAZ PurchRcptLine.DELETE;
                    UNTIL PurchRcptLine.NEXT() = 0;
            end;
        }
    }



    var

        PurchRcptLine: Record "Purch. Rcpt. Line";

        ReceptionOK: Boolean;
}

