table 50066 "DEL Historique import Kiriba"
{
    Caption = 'Historique import Kiriba';

    fields
    {
        field(1; "No traitement"; Integer)
        {
            Caption = 'No traitement';
        }
        field(2; "Date"; Date)
        {
            Editable = false;
            Caption = 'Date';
        }
        field(3; Heure; Time)
        {
            Editable = false;
            Caption = 'Heure';
        }
    }

    keys
    {
        key(Key1; "No traitement")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

