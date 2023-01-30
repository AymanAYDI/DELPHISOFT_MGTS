table 50083 "DEL Record Modifs. Tracking"
{
    Caption = 'Record Modification Tracking';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "Record ID"; RecordID)
        {
            Caption = 'Record ID';
            NotBlank = true;
            DataClassification = CustomerContent;
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
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; "Last Date Synchronized"; DateTime)
        {
            Caption = 'Last Date Synchronized';
            Editable = false;
            DataClassification = CustomerContent;
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

