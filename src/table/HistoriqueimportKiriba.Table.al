table 50066 "DEL Historique import Kiriba"
{
    Caption = 'Historique import Kiriba';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No traitement"; Integer)
        {
            Caption = 'No traitement';
            DataClassification = CustomerContent;
        }
        field(2; "Date"; Date)
        {
            Editable = false;
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(3; Heure; Time)
        {
            Editable = false;
            Caption = 'Heure';
            DataClassification = CustomerContent;
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

