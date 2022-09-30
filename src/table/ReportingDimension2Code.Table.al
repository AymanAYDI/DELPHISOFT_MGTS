table 50016 "DEL Reporting Dimension 2 Code"
{
    Caption = 'Reporting Dimension 2 Code';
    LookupPageID = "DEL Reporting Dimension 2 Code";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
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

