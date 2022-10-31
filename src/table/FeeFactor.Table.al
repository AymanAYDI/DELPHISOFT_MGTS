table 50043 "DEL Fee Factor"
{
    Caption = 'Fee Factor';
    LookupPageID = "DEL Fee Factor";

    fields
    {
        field(1; Fee_ID; Code[20])
        {
            TableRelation = "DEL Fee".ID;

            Caption = 'Fee_ID';

        }
        field(10; "Allow From"; Date)
        {
            Caption = 'Allow From';
        }
        field(20; "Allow To"; Date)
        {
            Caption = 'Allow To';
        }
        field(30; Factor; Decimal)
        {
            Caption = 'Factor';
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

