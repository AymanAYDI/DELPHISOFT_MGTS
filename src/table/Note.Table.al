table 50019 "DEL Note"
{
    Caption = 'DEL Note';
    DataClassification = CustomerContent;

    DrillDownPageID = "DEL Note audit";
    LookupPageID = "DEL Note audit";
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Revision Calculation"; DateFormula)
        {
            Caption = 'Revising Calculation';
            DataClassification = CustomerContent;
        }
        field(4; "Type audit"; Enum "DEL Type Audit")
        {
            Caption = 'Audit Type ';
            DataClassification = CustomerContent;
        }
        field(5; "Impact statut"; Enum "DEL Impact Status")
        {
            Caption = 'Impact of status';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code", "Type audit")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

