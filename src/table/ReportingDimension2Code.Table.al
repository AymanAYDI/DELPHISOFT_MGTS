table 50016 "DEL Reporting Dimension 2 Code"
{
    Caption = 'Reporting Dimension 2 Code';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Reporting Dimension 2 Code";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
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

