table 50018 "DEL Audit social"
{
    Caption = 'DEL Audit social';
    DataClassification = CustomerContent;
    LookupPageID = "DEL Audit Social";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Axe; Text[60])
        {
            Caption = 'Axe';
            DataClassification = CustomerContent;
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

