
table 99209 "DEL Ex_Extended Text Line"

{
    Caption = 'Extended Text Line';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Table Name"; Enum "Extended Text Table Name")
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
            TableRelation = Language;
        }
        field(4; "Text No."; Integer)
        {
            Caption = 'Text No.';
            DataClassification = CustomerContent;
        }
        field(5; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }

        field(6; "Text"; Text[50])
        {
            Caption = 'Text';
            DataClassification = CustomerContent;
        }
        field(4006496; Vererbt; Boolean)
        {
            Caption = 'Inherited';
            DataClassification = CustomerContent;
        }
        //TODO 
        // field(4006497; Separator; Enum "Separator ")
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

