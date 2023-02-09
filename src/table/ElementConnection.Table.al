table 50027 "DEL Element Connection"
{
    Caption = 'Element Connection';
    DataClassification = CustomerContent;
    LookupPageID = "DEL ACO Connection";
    fields
    {
        field(1; Deal_ID; Code[20])
        {

            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
        field(2; Element_ID; Code[20])
        {
            Caption = 'Element_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Element".ID;
        }
        field(3; "Apply To"; Code[20])
        {
            Caption = 'Apply To';
            DataClassification = CustomerContent;
            TableRelation = "DEL Element".ID;
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

