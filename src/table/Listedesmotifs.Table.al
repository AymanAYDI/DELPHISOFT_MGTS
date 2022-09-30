table 50064 "DEL Liste des motifs"
{

    DrillDownPageID = "DEL Liste des motifs";
    LookupPageID = "DEL Liste des motifs";
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

