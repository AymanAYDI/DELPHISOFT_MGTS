table 50076 "MGTS Change Log Entry"
{
    // Mgts10.00.01.01 | 23.01.2020 | User Tracking Management

    Caption = 'Change Log Entry';
    DrillDownPageID = 595;
    LookupPageID = 595;

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Date and Time"; DateTime)
        {
            Caption = 'Date and Time';
        }
        field(3; Time; Time)
        {
            Caption = 'Time';
        }
        field(4; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "418";
            begin
                UserMgt.LookupUserID("User ID");
            end;
        }
        field(5; "Table No."; Integer)
        {
            Caption = 'Table No.';
            TableRelation = AllObjWithCaption."Object ID" WHERE(Object Type=CONST(Table));
        }
        field(6; "Table Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE(Object Type=CONST(Table),
                                                                           Object ID=FIELD(Table No.)));
            Caption = 'Table Caption';
            FieldClass = FlowField;
        }
        field(7;"Type of Change";Option)
        {
            Caption = 'Type of Change';
            OptionCaption = 'Insertion,Modification,Deletion';
            OptionMembers = Insertion,Modification,Deletion;
        }
        field(8;"Record ID";Text[250])
        {
            Caption = 'Record ID';
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
        key(Key2;"Table No.","Date and Time")
        {
        }
    }

    fieldgroups
    {
    }


    procedure InsertLogEntry(UserID: Text[50];TableNo: Integer;ChangeType: Option Insertion,Modification,Deletion;RecordID: Text[250])
    begin
        INIT;
        "Date and Time"  := CURRENTDATETIME;
        "User ID"        := UserID;
        "Table No."      := TableNo;
        "Type of Change" := ChangeType;
        "Record ID"      := RecordID;
        Time             := Time;
        INSERT;
    end;
}

