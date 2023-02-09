table 50083 "DEL Record Modifs. Tracking"
{
    Caption = 'Record Modification Tracking';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Record ID"; RecordID)
        {
            Caption = 'Record ID';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(3; "Record ID Text"; Text[100])
        {
            Caption = 'Record ID Text';
            DataClassification = CustomerContent;
        }
        field(4; Synchronized; Boolean)
        {
            Caption = 'Synchronized';
            DataClassification = CustomerContent;
        }
        field(5; "Last Date Modified"; DateTime)
        {
            Caption = 'Last Date Modified';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Last Date Synchronized"; DateTime)
        {
            Caption = 'Last Date Synchronized';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Last Synchronized state"; Enum "DEL Last Synchronized State")
        {
            Caption = 'Last Synchronized state';
            DataClassification = CustomerContent;
        }
        field(8; Deleted; Boolean)
        {
            Caption = 'Deleted';
            DataClassification = CustomerContent;
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

}

