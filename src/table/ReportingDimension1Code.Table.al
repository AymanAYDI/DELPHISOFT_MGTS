table 50015 "DEL Reporting Dimension 1 Code"
{
    Caption = 'Reporting Dimension 1 Code';
    LookupPageID = "DEL Reporting Dimension 1 Code";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
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

