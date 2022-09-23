table 50083 "Record Modification Tracking"
{
    Caption = 'Record Modification Tracking';
    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
        }
        field(2; "Record ID"; RecordID)
        {
            Caption = 'Record ID';
            NotBlank = true;
        }
        field(3; "Record ID Text"; Text[100])
        {
            Caption = 'Record ID Text';
        }
        field(4; Synchronized; Boolean)
        {
            Caption = 'Synchronized';
        }
        field(5; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(6; "Last Date Synchronized"; DateTime)
        {
            Caption = 'Last Date Synchronized';
            Editable = false;
        }
        field(7; "Last Synchronized state"; Option)
        {
            Caption = 'Last Synchronized state';
        }
        field(8; Deleted; Boolean)
        {
            Caption = 'Deleted';
        }
    }

    keys
    {
        key(Key1; "Record ID")
        {
            Clustered = true;
        }
        key(Key2; "Table ID")
        {
        }
        key(Key3; Synchronized, "Table ID", Deleted)
        {
        }
    }

    fieldgroups
    {
    }
}

