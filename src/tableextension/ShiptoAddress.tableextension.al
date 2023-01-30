tableextension 50016 "DEL ShiptoAddress" extends "Ship-to Address" //222
{

    fields
    {

        modify("Shipment Method Code")
        {
            Caption = 'Sales Shipment Method Code';
        }
        field(50000; "DEL Purch Shipment Method Code"; Code[10])
        {
            Caption = 'Purchase Shipment Method Code';
            TableRelation = "Shipment Method";
            DataClassification = CustomerContent;
        }
    }
}

