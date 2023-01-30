
table 50052 "DEL Pays"
{
    Caption = 'Country';
    DrillDownPageID = "DEL Pays";
    LookupPageID = "DEL Pays";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
        {

            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

