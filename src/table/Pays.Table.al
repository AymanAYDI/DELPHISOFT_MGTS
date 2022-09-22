table 50052 "DEL Pays"
{


    Caption = 'Country';
    // TODO // DrillDownPageID = 50088;
    // LookupPageID = 50088;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
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

