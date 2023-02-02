pageextension 50032 "DEL ShiptoAddress" extends "Ship-to Address" //300
{

    layout
    {
        addafter("Customer No.")
        {
            field("DEL Purchase Shipment Method Code"; Rec."DEL Purch Shipment Method Code")
            {
            }
        }
    }
}

