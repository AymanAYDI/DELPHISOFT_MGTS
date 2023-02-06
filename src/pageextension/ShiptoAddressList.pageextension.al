pageextension 50033 "DEL ShiptoAddressList" extends "Ship-to Address List" //301
{

    layout
    {
        addafter("Location Code")
        {
            field("DEL Shipment Method Code"; Rec."Shipment Method Code")
            {
            }
            field("DEL Purchase Shipment Method Code"; Rec."DEL Purch Shipment Method Code")
            {
            }
        }
    }
}

