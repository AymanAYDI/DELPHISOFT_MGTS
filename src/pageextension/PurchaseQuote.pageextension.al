pageextension 50046 "DEL PurchaseQuote" extends "Purchase Quote"
{
    layout
    {

        addafter("Buy-from")
        {
            field("DEL Due Date Calculation"; Rec."DEL Due Date Calculation")
            {
            }
        }
    }

}

