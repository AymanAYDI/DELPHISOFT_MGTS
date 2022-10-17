pageextension 50007 "DEL PostedSalesInvoiceSubform" extends "Posted Sales Invoice Subform" //133
{
    layout
    {
        addafter("Subtotal gross") //1150001
        {
            field("DEL Ship-to Code"; Rec."DEL Ship-to Code")
            {
            }
            field("DEL Ship-to Name"; Rec."DEL Ship-to Name")
            {
            }
        }
    }
}

