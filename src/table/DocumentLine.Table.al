table 50008 "DEL Document Line"
{
    Caption = 'Document Line';
    DataPerCompany = false;
    //TODO:en attendant les pages
    // DrillDownPageID = 50065;
    // LookupPageID = 50065;

    fields
    {
        field(1; "Table Name"; Enum "DEL Table Namevend/customer")
        {
            Caption = 'Table Name';

        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Comment Entry No."; Integer)
        {
            Caption = 'Comment Entry No.';
            //TODO: TableRelation = Table297728;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Insert Date"; Date)
        {
            Caption = 'Date';
            Editable = false;
        }
        field(6; "Insert Time"; Time)
        {
            Caption = 'Time';
            Editable = false;
        }
        field(7; "File Name"; Text[250])
        {
            Caption = 'File Name';
            Editable = false;
        }
        field(8; Path; Text[250])
        {
            Caption = 'Path';
            Editable = false;
        }
        field(9; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
        }
        field(10; "Notation Type"; Enum "DEL Notation Type")
        {
            Caption = 'Rating type';

        }
        field(20; Document; BLOB)
        {
            Caption = 'Document';
        }
        field(21; "Type liasse"; Enum "DEL Type liasse")
        {
            Caption = 'Type of document';

        }
        field(22; "Type contrat"; Enum "DEL Type contrat")
        {
            Caption = 'Type of contract';

        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Comment Entry No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Comment Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := USERID;
        UpdateRepository(1);
    end;


    procedure SetUpNewLine(BelowxRec: Boolean)
    var
        NewLineNo: Integer;
        NewLineNo2: Integer;
    begin
        IF xRec.COUNT = 0 THEN BEGIN
            "Line No." := 10000;
            EXIT;
        END;

        IF BelowxRec THEN BEGIN
            "Line No." := xRec."Line No." + 10000;
            EXIT;
        END;

        NewLineNo := xRec."Line No.";
        IF xRec.NEXT(-1) <> 0 THEN BEGIN
            NewLineNo2 := xRec."Line No.";
            xRec.NEXT(1);
        END;

        "Line No." := ROUND(NewLineNo2 + ((NewLineNo - NewLineNo2) / 2), 1);

        "Insert Date" := TODAY;
        "Insert Time" := TIME;
    end;

    local procedure UpdateRepository("Trigger": Integer)
    var
        RecRef: RecordRef;
    begin

        CASE "Table Name" OF
            "Table Name"::Vendor:
                BEGIN
                    RecRef.GETTABLE(Rec);
                    RecRef.SETTABLE(Rec);
                END;
            "Table Name"::Contact:
                BEGIN
                    RecRef.GETTABLE(Rec);
                    RecRef.SETTABLE(Rec);
                END;
            "Table Name"::Customer:
                BEGIN
                    RecRef.GETTABLE(Rec);
                    RecRef.SETTABLE(Rec);
                END;

        END;
    end;
}

