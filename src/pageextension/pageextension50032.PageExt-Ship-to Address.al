pageextension 50032 pageextension50032 extends "Ship-to Address"
{
    // THM       16.03.18        add field "Purchase Shipment Method Code"
    layout
    {
        addafter("Control 55")
        {
            field("Purchase Shipment Method Code"; "Purchase Shipment Method Code")
            {
            }
        }
    }
}

