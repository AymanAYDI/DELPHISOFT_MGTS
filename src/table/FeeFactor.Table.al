table 50043 "DEL Fee Factor"
{
    Caption = 'Fee Factor';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Fee Factor";
    fields
    {
        field(1; Fee_ID; Code[20])
        {

            Caption = 'Fee_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Fee".ID;
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

