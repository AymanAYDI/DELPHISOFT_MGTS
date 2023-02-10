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
            Caption = 'Date';

            DataClassification = CustomerContent;
            Editable = false;

        }
        field(3; Heure; Time)
        {
            Caption = 'Heure';

            DataClassification = CustomerContent;
            Editable = false;

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

