table 99208 "DEL Ex_Extended Text Header"
{
    Caption = 'Extended Text Header';
    DataCaptionFields = "No.", "Language Code", "Text No.";
    LookupPageID = "Extended Text List";
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
            TableRelation = IF ("Table Name" = CONST("Standard Text")) "Standard Text"
            ELSE
            IF ("Table Name" = CONST("G/L Account")) "G/L Account"
            ELSE
            IF ("Table Name" = CONST("Item")) Item
            ELSE
            IF ("Table Name" = CONST("Resource")) Resource;
            DataClassification = CustomerContent;
        }
        field(3; "Language Code"; Code[10])
        {
            Caption = 'Language Code';
            TableRelation = Language;
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(5; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = CustomerContent;
        }
        field(6; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            DataClassification = CustomerContent;
        }
        field(7; "All Language Codes"; Boolean)
        {
            Caption = 'All Language Codes';
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(12; "Sales Invoice"; Boolean)
        {
            Caption = 'Sales Invoice';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(13; "Sales Order"; Boolean)
        {
            Caption = 'Sales Order';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(14; "Sales Credit Memo"; Boolean)
        {
            Caption = 'Sales Credit Memo';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(15; "Purchase Quote"; Boolean)
        {
            Caption = 'Purchase Quote';
            InitValue = true;
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(20; "Finance Charge Memo"; Boolean)
        {
            Caption = 'Finance Charge Memo';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(21; "Sales Blanket Order"; Boolean)
        {
            Caption = 'Sales Blanket Order';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(22; "Purchase Blanket Order"; Boolean)
        {
            Caption = 'Purchase Blanket Order';
            InitValue = true;
            DataClassification = CustomerContent;
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
            DataClassification = CustomerContent;
        }
        field(24; "Prepmt. Sales Credit Memo"; Boolean)
        {
            Caption = 'Prepmt. Sales Credit Memo';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(25; "Prepmt. Purchase Invoice"; Boolean)
        {
            Caption = 'Prepmt. Purchase Invoice';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(26; "Prepmt. Purchase Credit Memo"; Boolean)
        {
            Caption = 'Prepmt. Purchase Credit Memo';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(5900; "Service Order"; Boolean)
        {
            Caption = 'Service Order';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(5901; "Service Quote"; Boolean)
        {
            Caption = 'Service Quote';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(5902; "Service Invoice"; Boolean)
        {
            Caption = 'Service Invoice';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(5903; "Service Credit Memo"; Boolean)
        {
            Caption = 'Service Credit Memo';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(6600; "Sales Return Order"; Boolean)
        {
            Caption = 'Sales Return Order';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        field(6605; "Purchase Return Order"; Boolean)
        {
            Caption = 'Purchase Return Order';
            InitValue = true;
            DataClassification = CustomerContent;
        }
        //---------Spécifique pays Suisse: à voir avec Ayman
        field(4006496; Lieferantext; Boolean)
        {
            Caption = 'Lieferantext';
            DataClassification = CustomerContent;
        }
        field(4006497; Vererbt; Boolean)
        {
            Caption = 'Inherited';
            DataClassification = CustomerContent;
        }
        field(4006498; Quellzeilennr; Boolean)
        {
            Caption = 'Source Line No.';
            DataClassification = CustomerContent;
        }
        field(4006499; Beschreibung; BLOB)
        {
            Caption = 'Description';
            Compressed = false;
            SubType = Memo;
            DataClassification = CustomerContent;
        }
        field(5005270; "Delivery Reminder"; Boolean)
        {
            Caption = 'Delivery Reminder';
            DataClassification = CustomerContent;
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
