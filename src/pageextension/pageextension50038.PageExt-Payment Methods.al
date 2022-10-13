pageextension 50038 pageextension50038 extends "Payment Methods"
{
    layout
    {
        addafter("Control 9")
        {
            field("Swiss QRBill Layout"; "Swiss QRBill Layout")
            {
                ApplicationArea = Basic, Suite;
                LookupPageID = "Swiss QR-Bill Layout";
                ToolTip = 'Specifies the QR-Bill Layout code.';
            }
        }
    }
}

