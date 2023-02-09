table 50061 "DEL Sourceur"
{

    Caption = 'Sourceur';
    DataClassification = CustomerContent;
    DrillDownPageID = "DEL Sourceurs";
    LookupPageID = "DEL Sourceurs";


    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;

        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
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

