table 50076 "DEL MGTS Change Log Entry"
{
    Caption = 'Change Log Entry';
    DataClassification = CustomerContent;
    DrillDownPageID = "Change Log Entries";
    LookupPageID = "Change Log Entries";
    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Date and Time"; DateTime)
        {
            Caption = 'Date and Time';
            DataClassification = CustomerContent;
        }
        field(3; "Time"; Time)
        {
            Caption = 'Time';
            DataClassification = CustomerContent;
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            TableRelation = User."User Security ID";
            TestTableRelation = false;

            //TODO trigger OnLookup() 
            // var
            //     UserMgt: Codeunit "User Management"; // 418
            // begin
            // UserMgt.LookupUserID("User ID"); IS NOT SUPPORTED IN V20
            // end;
        }
        field(5; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(6; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table No.")));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        field(7; "Type of Change"; Enum "Change Log Entry Type")
        {
            Caption = 'Type of Change';
            DataClassification = CustomerContent;
        }
        field(8; "Record ID"; Text[250])
        {
            Caption = 'Record ID';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Table No.", "Date and Time")
        {
        }
    }
    var

    procedure InsertLogEntry(UserID: Text[50]; TableNo: Integer; ChangeType: Enum "Change Log Entry Type"; RecordID: Text[250])
    begin
        INIT();
        "Date and Time" := CURRENTDATETIME;
        "User ID" := UserID;
        "Table No." := TableNo;
        "Type of Change" := ChangeType;
        "Record ID" := RecordID;
        Time := Time;
        INSERT();
    end;
}

