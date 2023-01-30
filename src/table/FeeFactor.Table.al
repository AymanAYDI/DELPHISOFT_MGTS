table 50043 "DEL Fee Factor"
{
    Caption = 'Fee Factor';
    LookupPageID = "DEL Fee Factor";
    DataClassification = CustomerContent;
    fields
    {
        field(1; Fee_ID; Code[20])
        {
            TableRelation = "DEL Fee".ID;

            Caption = 'Fee_ID';
            DataClassification = CustomerContent;
        }
        field(10; "Allow From"; Date)
        {
            Caption = 'Allow From';
            DataClassification = CustomerContent;
        }
        field(20; "Allow To"; Date)
        {
            Caption = 'Allow To';
            DataClassification = CustomerContent;
        }
        field(30; Factor; Decimal)
        {
            Caption = 'Factor';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; Fee_ID, "Allow From")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

