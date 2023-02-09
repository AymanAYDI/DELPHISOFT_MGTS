tableextension 50002 "DEL SalesShipmentLine" extends "Sales Shipment Line" //111
{

    fields
    { //TODO 
        // modify("Customer Price Group")
        // {

        //     //Unsupported feature: Property Modification (Data type) on ""Customer Price Group"(Field 42)".

        // }
        field(50001; "DEL Qty. Init. Client"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50008; "DEL Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;

            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(50009; "DEL Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
        }
    }
}

