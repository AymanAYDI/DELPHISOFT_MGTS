report 50040 "DEL THM reception"
{
    DefaultLayout = RDLC;
    RDLCLayout = './THMreception.rdlc';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            column(No_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
            {
            }

            trigger OnAfterGetRecord()
            begin
                PurchRcptLine.RESET();
                PurchRcptLine.SETRANGE(PurchRcptLine."Document No.", "Purch. Rcpt. Header"."No.");
                PurchRcptLine.SETFILTER(PurchRcptLine.Type, '%1|%2', PurchRcptLine.Type::Item, PurchRcptLine.Type::"G/L Account");
                IF PurchRcptLine.FINDFIRST() THEN
                    REPEAT
                        IF PurchRcptLine.Type = PurchRcptLine.Type::Item THEN
                            IF PurchRcptLine.Quantity <> 0 THEN
                                CurrReport.SKIP();
                    UNTIL PurchRcptLine.NEXT() = 0;
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
        PurchRcptLine: Record "Purch. Rcpt. Line";
}

