table 50032 "DEL Deal Shipment Connection"
{
    Caption = 'DEL Deal Shipment Connection';
    LookupPageID = "DEL Deal Shipment connection";

    fields
    {
        field(1; Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
        }
        field(10; Shipment_ID; Code[20])
        {
            TableRelation = "DEL Deal Shipment".ID;
            Caption = 'Shipment_ID';
        }
        field(20; Element_ID; Code[20])
        {
            TableRelation = "DEL Element".ID;
            Caption = 'Element_ID';
        }
    }

    keys
    {
        key(Key1; Deal_ID, Shipment_ID, Element_ID)
        {
            Clustered = true;
        }
        key(Key2; Shipment_ID)
        {
        }
        key(Key3; Element_ID)
        {
        }
    }

    fieldgroups
    {
    }
}

