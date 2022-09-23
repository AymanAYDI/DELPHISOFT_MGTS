table 50064 "DEL Liste des motifs"
{

    // DrillDownPageID = 50123;
    // LookupPageID = 50123;
    Caption = 'Liste des motifs';
    DataClassification = CustomerContent;


    fields
    {
        field(1; No; Integer)
        {
            AutoIncrement = false;

            DataClassification = CustomerContent;
        }
        field(2; Motif; Text[100])
        {
            DataClassification = CustomerContent;

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

