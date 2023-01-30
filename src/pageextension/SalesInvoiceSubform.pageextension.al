pageextension 50045 "DEL SalesInvoiceSubform" extends "Sales Invoice Subform"
{
    layout
    {
        addafter("Control1")
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


