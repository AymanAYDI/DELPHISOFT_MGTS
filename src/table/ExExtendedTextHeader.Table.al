table 99208 "DEL Ex_Extended Text Header"
{
    Caption = 'Extended Text Header';
    DataCaptionFields = "No.", "Language Code", "Text No.";
    LookupPageID = "Extended Text List";

    fields
    {
        field(1; "Table Name"; Enum "DEL Table Name")
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
            IF ("Table Name" = CONST("Item")) Item
            ELSE
            IF ("Table Name" = CONST("Resource")) Resource;
        }
        field(3; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;

            trigger OnValidate()
            begin
                IF "Language Code" <> '' THEN
                    TESTFIELD("All Language Codes", FALSE)
            end;
        }
        field(4; "Text No."; Integer)
        {
            Caption = 'Text No.';
            Editable = false;
        }
        field(5; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(6; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(7; "All Language Codes"; Boolean)
        {
            Caption = 'All Language Codes';

            trigger OnValidate()
            begin
                IF "All Language Codes" THEN
                    TESTFIELD("Language Code", '');
            end;
        }
        field(11; "Sales Quote"; Boolean)
        {
            Caption = 'Sales Quote';
            InitValue = true;
        }
        field(12; "Sales Invoice"; Boolean)
        {
            Caption = 'Sales Invoice';
            InitValue = true;
        }
        field(13; "Sales Order"; Boolean)
        {
            Caption = 'Sales Order';
            InitValue = true;
        }
        field(14; "Sales Credit Memo"; Boolean)
        {
            Caption = 'Sales Credit Memo';
            InitValue = true;
        }
        field(15; "Purchase Quote"; Boolean)
        {
            Caption = 'Purchase Quote';
            InitValue = true;

            trigger OnValidate()
            begin
                IF "Purchase Quote" THEN
                    NoResourcePurch();
            end;
        }
        field(16; "Purchase Invoice"; Boolean)
        {
            Caption = 'Purchase Invoice';
            InitValue = true;

            trigger OnValidate()
            begin
                IF "Purchase Invoice" THEN
                    NoResourcePurch();
            end;
        }
        field(17; "Purchase Order"; Boolean)
        {
            Caption = 'Purchase Order';
            InitValue = true;

            trigger OnValidate()
            begin
                IF "Purchase Order" THEN
                    NoResourcePurch();
            end;
        }
        field(18; "Purchase Credit Memo"; Boolean)
        {
            Caption = 'Purchase Credit Memo';
            InitValue = true;

            trigger OnValidate()
            begin
                IF "Purchase Credit Memo" THEN
                    NoResourcePurch();
            end;
        }
        field(19; Reminder; Boolean)
        {
            Caption = 'Reminder';
            InitValue = true;
        }
        field(20; "Finance Charge Memo"; Boolean)
        {
            Caption = 'Finance Charge Memo';
            InitValue = true;
        }
        field(21; "Sales Blanket Order"; Boolean)
        {
            Caption = 'Sales Blanket Order';
            InitValue = true;
        }
        field(22; "Purchase Blanket Order"; Boolean)
        {
            Caption = 'Purchase Blanket Order';
            InitValue = true;

            trigger OnValidate()
            begin
                IF "Purchase Blanket Order" THEN
                    NoResourcePurch();
            end;
        }
        field(23; "Prepmt. Sales Invoice"; Boolean)
        {
            Caption = 'Prepmt. Sales Invoice';
            InitValue = true;
        }
        field(24; "Prepmt. Sales Credit Memo"; Boolean)
        {
            Caption = 'Prepmt. Sales Credit Memo';
            InitValue = true;
        }
        field(25; "Prepmt. Purchase Invoice"; Boolean)
        {
            Caption = 'Prepmt. Purchase Invoice';
            InitValue = true;
        }
        field(26; "Prepmt. Purchase Credit Memo"; Boolean)
        {
            Caption = 'Prepmt. Purchase Credit Memo';
            InitValue = true;
        }
        field(5900; "Service Order"; Boolean)
        {
            Caption = 'Service Order';
            InitValue = true;
        }
        field(5901; "Service Quote"; Boolean)
        {
            Caption = 'Service Quote';
            InitValue = true;
        }
        field(5902; "Service Invoice"; Boolean)
        {
            Caption = 'Service Invoice';
            InitValue = true;
        }
        field(5903; "Service Credit Memo"; Boolean)
        {
            Caption = 'Service Credit Memo';
            InitValue = true;
        }
        field(6600; "Sales Return Order"; Boolean)
        {
            Caption = 'Sales Return Order';
            InitValue = true;
        }
        field(6605; "Purchase Return Order"; Boolean)
        {
            Caption = 'Purchase Return Order';
            InitValue = true;
        }
        field(4006496; Lieferantext; Boolean)
        {
            Description = 'AL.KVK4.5';
            Caption = 'Lieferantext';
        }
        field(4006497; Vererbt; Boolean)
        {
            Caption = 'Inherited';
            Description = 'AL.KVK4.5';
        }
        field(4006498; Quellzeilennr; Boolean)
        {
            Caption = 'Source Line No.';
            Description = 'AL.KVK4.5';
        }
        field(4006499; Beschreibung; BLOB)
        {
            Caption = 'Description';
            Compressed = false;
            Description = 'AL.KVK4.5';
            SubType = Memo;
        }
        field(5005270; "Delivery Reminder"; Boolean)
        {
            Caption = 'Delivery Reminder';
        }
    }

    keys
    {
        key(Key1; "Table Name", "No.", "Language Code", "Text No.")
        {
            Clustered = true;
        }
        key(Key2; "Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        ExtTextLine.SETRANGE("Table Name", "Table Name");
        ExtTextLine.SETRANGE("No.", "No.");
        ExtTextLine.SETRANGE("Language Code", "Language Code");
        ExtTextLine.SETRANGE("Text No.", "Text No.");
        ExtTextLine.DELETEALL(TRUE);
    end;

    trigger OnInsert()
    begin
        IF "Text No." = 0 THEN BEGIN
            ExtTextHeader2.SETRANGE("Table Name", "Table Name");
            ExtTextHeader2.SETRANGE("No.", "No.");
            ExtTextHeader2.SETRANGE("Language Code", "Language Code");
            IF ExtTextHeader2.FINDLAST() THEN
                "Text No." := ExtTextHeader2."Text No." + 1
            ELSE
                "Text No." := 1;
        END ELSE
            "Text No." := "Text No." + 1;

        IF "Table Name" = "Table Name"::Resource THEN BEGIN
            "Purchase Quote" := FALSE;
            "Purchase Invoice" := FALSE;
            "Purchase Blanket Order" := FALSE;
            "Purchase Order" := FALSE;
            "Purchase Credit Memo" := FALSE;
        END;
    end;

    trigger OnRename()
    begin
        ERROR(Text000, TABLECAPTION);
    end;

    var
        ExtTextHeader2: Record "Extended Text Header";
        ExtTextLine: Record "Extended Text Line";
        Text000: Label 'You cannot rename an %1.';
        Text001: Label 'You cannot purchase resources.';

    local procedure NoResourcePurch()
    begin
        IF "Table Name" = "Table Name"::Resource THEN
            ERROR(Text001);
    end;
}
