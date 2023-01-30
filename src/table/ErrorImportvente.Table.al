table 50062 "DEL Error Import vente"
{
    Caption = 'Error Import vente';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Position; Text[100])
        {
            Caption = 'Position';
            DataClassification = CustomerContent;
        }
        field(10; "Error"; Text[250])
        {
            Caption = 'Error';
            Editable = false;
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.", Position)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

