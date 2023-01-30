table 50055 "DEL Type/Nature Enregistrement"
{
    Caption = 'Type of forms';
    DrillDownPageID = "Type / Nature Enregistrement";
    LookupPageID = "Type / Nature Enregistrement";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[20])
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

