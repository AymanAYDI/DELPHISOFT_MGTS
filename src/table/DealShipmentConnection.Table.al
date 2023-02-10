table 50032 "DEL Deal Shipment Connection"
{
    Caption = 'DEL Deal Shipment Connection';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Deal Shipment connection";
    fields
    {
        field(1; Deal_ID; Code[20])
        {
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
        field(10; Shipment_ID; Code[20])
        {
            Caption = 'Shipment_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal Shipment".ID;
        }
        field(20; Element_ID; Code[20])
        {
            Caption = 'Element_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Element".ID;
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

