pageextension 50033 pageextension50033 extends "Ship-to Address List"
{
    // THM       16.03.18        add field "Purchase Shipment Method Code"
    layout
    {
        addafter("Control 23")
        {
            field("Shipment Method Code"; "Shipment Method Code")
            {
            }
            field("Purchase Shipment Method Code"; "Purchase Shipment Method Code")
            {
            }
        }
    }
}

