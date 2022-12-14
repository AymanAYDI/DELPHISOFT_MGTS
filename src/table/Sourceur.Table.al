table 50061 "DEL Sourceur"
{

    DrillDownPageID = "DEL Sourceurs";
    LookupPageID = "DEL Sourceurs";
    Caption = 'Sourceur';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;

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

