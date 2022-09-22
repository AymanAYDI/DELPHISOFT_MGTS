table 50060 "DEL bank fournisseur"
{
    Caption = 'bank fournisseur';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Bank Code"; Code[20])
        {
            Caption = 'Bank Code';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

