table 50082 "DEL D365FM Mail Template"
{

    Caption = 'Modèle e-mail';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Parameter String"; Text[250])
        {
            Caption = 'Paramètre';
            DataClassification = CustomerContent;
        }
        field(2; "Language Code"; Code[20])
        {
            Caption = 'Code langue';
            DataClassification = CustomerContent;
            TableRelation = Language;
        }
        field(3; "Template mail"; BLOB)
        {
            Caption = 'Template';
            DataClassification = CustomerContent;
        }
        field(4; Title; Text[250])
        {
            Caption = 'Objet';
            DataClassification = CustomerContent;
        }
        field(5; Default; Boolean)
        {
            Caption = 'Par défaut';
            DataClassification = CustomerContent;
        }
        field(6; "Sender Address"; Text[250])
        {
            Caption = 'Emetteur email';
            DataClassification = CustomerContent;
        }
        field(7; Cci; Text[250])
        {
            Caption = 'Cci';
            DataClassification = CustomerContent;
        }
        field(8; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            DataClassification = CustomerContent;
            TableRelation = "Reminder Terms";
        }
        field(9; "Reminder Level"; Integer)
        {
            Caption = 'Reminder Level';
            DataClassification = CustomerContent;
            TableRelation = "Reminder Level"."No." WHERE("Reminder Terms Code" = FIELD("Reminder Terms Code"));
        }
        field(10; "Document Type"; Enum "DEL DoC Facture Type")
        {
            Caption = 'Type document';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Parameter String", "Language Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        CstG001: Label 'Do you want to replace the existing template %1 %2?';
        CstG002: Label 'Do you want to delete the template %1 %2 ?';


    procedure SetHtmlTemplate() TxtRRecupients: Text[1024]
    var
        RBAutoMgt: Codeunit "File Management";
        BLOBRef: Codeunit "Temp Blob";
        RecRef: RecordRef;
        BooLTemplateExists: Boolean;
    begin
        CALCFIELDS("Template mail");

        IF "Template mail".HASVALUE THEN
            BooLTemplateExists := TRUE;

        IF RBAutoMgt.BLOBImport(BLOBRef, '*.html') = '' THEN
            EXIT;
        RecRef.GetTable(Rec);
        BLOBRef.ToRecordRef(RecRef, FieldNo("Template mail"));
        RecRef.SetTable(Rec);

        IF BooLTemplateExists THEN
            IF NOT CONFIRM(CstG001, FALSE, "Parameter String", "Language Code") THEN
                ERROR('');

        MODIFY();
    end;


    procedure ExportHtmlTemplate()
    var
        RBAutoMgt: Codeunit "File Management";
        BLOBRef: Codeunit "Temp Blob";
    begin
        CALCFIELDS("Template mail");
        IF "Template mail".HASVALUE THEN BEGIN

            BLOBRef.FromRecord(Rec, FieldNo("Template mail"));
            RBAutoMgt.BLOBExport(BLOBRef, '*.html', TRUE);
        END;
    end;


    procedure DeleteHtmlTemplate()
    begin
        CALCFIELDS("Template mail");
        IF "Template mail".HASVALUE THEN
            IF CONFIRM(CstG002, FALSE, "Parameter String", "Language Code") THEN BEGIN
                CLEAR("Template mail");
                MODIFY();
            END;

    end;
}

