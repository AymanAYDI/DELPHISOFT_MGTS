table 50019 "DEL Note"
{
    Caption = 'DEL Note';

    DrillDownPageID = "DEL Note audit";
    LookupPageID = "DEL Note audit";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[60])
        {
            Caption = 'Description';
        }
        field(3; "Revision Calculation"; DateFormula)
        {
            Caption = 'Revising Calculation';
        }
        field(4; "Type audit"; Enum "DEL Type Audit")
        {
            Caption = 'Audit Type ';
        }
        field(5; "Impact statut"; Enum "DEL Impact Status")
        {
            Caption = 'Impact of status';

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

