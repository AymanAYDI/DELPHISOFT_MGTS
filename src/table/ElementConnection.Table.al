table 50027 "DEL Element Connection"
{
    LookupPageID = "DEL ACO Connection";
    Caption = 'Element Connection';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Deal_ID; Code[20])
        {

            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
        }
        field(2; Element_ID; Code[20])
        {
            TableRelation = "DEL Element".ID;
            Caption = 'Element_ID';
            DataClassification = CustomerContent;
        }
        field(3; "Apply To"; Code[20])
        {
            TableRelation = "DEL Element".ID;
            Caption = 'Apply To';
            DataClassification = CustomerContent;
        }
        field(4; Instance; Enum "DEL Instance")
        {

            Caption = 'Instance';
            DataClassification = CustomerContent;
        }
        field(10; "Split Index"; Integer)
        {
            Caption = 'Split Index';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Deal_ID, Element_ID, "Apply To")
        {
            Clustered = true;
        }
        key(Key2; Element_ID)
        {
        }
        key(Key3; Element_ID, "Split Index")
        {
        }
    }

    fieldgroups
    {
    }
}

