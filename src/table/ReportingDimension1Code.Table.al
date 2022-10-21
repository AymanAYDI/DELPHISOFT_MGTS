table 50015 "DEL Reporting Dimension 1 Code"
{
    Caption = 'Reporting Dimension 1 Code';
    LookupPageID = "DEL Reporting Dimension 1 Code";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
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

