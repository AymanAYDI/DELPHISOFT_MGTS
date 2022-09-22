table 50082 "D365FM Mail Template"
{
    // +------------------------------------------------------------------------------------------+
    // | D365FM-INV14.00.00.05  | 30.06.21 | Create table                                         |
    // +------------------------------------------------------------------------------------------+

    Caption = 'Modèle e-mail';

    fields
    {
        field(1; "Parameter String"; Text[250])
        {
            Caption = 'Paramètre';
        }
        field(2; "Language Code"; Code[20])
        {
            Caption = 'Code langue';
            TableRelation = Language;
        }
        field(3; "Template mail"; BLOB)
        {
            Caption = 'Template';
        }
        field(4; Title; Text[250])
        {
            Caption = 'Objet';
        }
        field(5; Default; Boolean)
        {
            Caption = 'Par défaut';
        }
        field(6; "Sender Address"; Text[250])
        {
            Caption = 'Emetteur email';
        }
        field(7; Cci; Text[250])
        {
            Caption = 'Cci';
            DataClassification = ToBeClassified;
        }
        field(8; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reminder Terms";
        }
        field(9; "Reminder Level"; Integer)
        {
            Caption = 'Reminder Level';
            DataClassification = ToBeClassified;
            TableRelation = "Reminder Level".No. WHERE (Reminder Terms Code=FIELD(Reminder Terms Code));
        }
        field(10;"Document Type";Option)
        {
            Caption = 'Type document';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Facture service,Avoir service,Relance émise';
            OptionMembers = " ","Service Invoice","Service Credit Memo","Issued Reminder";
        }
    }

    keys
    {
        key(Key1;"Parameter String","Language Code")
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
        BooLTemplateExists: Boolean;
        RBAutoMgt: Codeunit "419";
        BLOBRef: Record "99008535";
    begin
        CALCFIELDS("Template mail");

        IF "Template mail".HASVALUE THEN
          BooLTemplateExists := TRUE;

        IF RBAutoMgt.BLOBImport(BLOBRef,'*.html') = '' THEN
          EXIT;

        "Template mail" := BLOBRef.Blob;

        IF BooLTemplateExists THEN
          IF NOT CONFIRM(CstG001,FALSE,"Parameter String","Language Code") THEN
            ERROR('');

        MODIFY;
    end;


    procedure ExportHtmlTemplate()
    var
        RBAutoMgt: Codeunit "419";
        BLOBRef: Record "99008535";
    begin
        CALCFIELDS("Template mail");
        IF "Template mail".HASVALUE THEN BEGIN
          BLOBRef.Blob := "Template mail";
          RBAutoMgt.BLOBExport(BLOBRef,'*.html',TRUE);
        END;
    end;


    procedure DeleteHtmlTemplate()
    begin
        CALCFIELDS("Template mail");
        IF "Template mail".HASVALUE THEN BEGIN
          IF CONFIRM(CstG002,FALSE,"Parameter String","Language Code") THEN BEGIN
            CLEAR("Template mail");
            MODIFY;
          END;
        END;
    end;
}

