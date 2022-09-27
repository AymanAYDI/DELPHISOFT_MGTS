tableextension 50016 tableextension50016 extends "Ship-to Address"
{
    // THM       16.03.18        add field "Purchase Shipment Method Code"
    fields
    {
        modify("Shipment Method Code")
        {
            Caption = 'Sales Shipment Method Code';
        }
        field(50000; "Purchase Shipment Method Code"; Code[10])
        {
            Caption = 'Purchase Shipment Method Code';
            TableRelation = "Shipment Method";
        }
    }
}

