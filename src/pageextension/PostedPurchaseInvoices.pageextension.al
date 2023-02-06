pageextension 50014 "DEL PostedPurchaseInvoices" extends "Posted Purchase Invoices" //146
{

    layout
    {
        addafter("No. Printed") //8
        {
            field("DEL Vendor Shipment Date"; Rec."DEL Vendor Shipment Date")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}

