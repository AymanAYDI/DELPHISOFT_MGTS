table 50018 "DEL Audit social"
{
    Caption = 'DEL Audit social';
    //TODO DrillDownPageID = 50028;
    // LookupPageID = 50028;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Axe; Text[60])
        {
            Caption = 'Axe';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Axe)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(All; "No.", Axe)
        {
        }
    }
}

