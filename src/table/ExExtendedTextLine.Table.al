
table 99209 "DEL Ex_Extended Text Line"

{
    Caption = 'Extended Text Line';

    fields
    {
        field(1; "Table Name"; Enum "Extended Text Table Name")
        {
            Caption = 'Table Name';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF ("Table Name" = CONST("Standard Text")) "Standard Text"
            ELSE
            IF ("Table Name" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Table Name" = CONST(Item)) Item
            ELSE
            IF ("Table Name" = CONST(Resource)) Resource;
        }
        field(3; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
        }
        field(4; "Text No."; Integer)
        {
            Caption = 'Text No.';
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        field(6; "Text"; Text[50])
        {
            Caption = 'Text';
        }
        field(4006496; Vererbt; Boolean)
        {
            Caption = 'Inherited';

        }
        //TODO field(4006497; Separator; Enum "Separator ")
        // {
        //     Caption = 'Separator';

        // }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Language Code", "Text No.", "Line No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    begin
        ExtendedTextHeader.GET("Table Name", "No.", "Language Code", "Text No.");
    end;

    var
        ExtendedTextHeader: Record "Extended Text Header";
}

