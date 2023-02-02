pageextension 50010 "DEL PostedPurchaseCreditMemo" extends "Posted Purchase Credit Memo" //140
{
    layout
    {


        addafter("Document Date") //31
        {
            field("DEL Due Date Calculation"; Rec."DEL Due Date Calculation")
            {
            }
        }
    }
}

