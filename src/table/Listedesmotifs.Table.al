table 50064 "DEL Liste des motifs"
{
    DrillDownPageID = 50123;
    LookupPageID = 50123;
    Caption = 'Liste des motifs';

    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;
            Caption = 'No';
        }
        field(2; Motif; Text[100])
        {
            Caption = 'Motif';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; No, Motif)
        {
        }
    }
}

