table 50071 "DEL DocMatrix Selection"
{
    Caption = 'DocMatrix Selection';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Type; Enum "Credit Transfer Account Type")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE
            IF (Type = CONST(Vendor)) Vendor."No.";
        }
        field(3; "Process Type"; Enum "DEL Process Type")
        {
            Caption = 'Process Type';
            DataClassification = CustomerContent;
        }
        field(4; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));
        }
        field(5; "Report Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Report),
                                                                           "Object ID" = FIELD("Report ID")));
            Caption = 'Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Usage; Enum "DEL Usage DocMatrix Selection")
        {
            Caption = 'Usage';
            DataClassification = CustomerContent;
        }
        field(7; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(8; "UserId"; Code[50])
        {
            Caption = 'UserId';
            DataClassification = CustomerContent;
        }
        field(10; "Send to FTP 1"; Boolean)
        {
            Caption = 'Send to FTP 1';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF xRec."Save PDF" AND NOT "Save PDF" THEN
                    IF NOT "Save PDF" THEN
                        "Save PDF" := TRUE;
            end;
        }
        field(11; "Send to FTP 2"; Boolean)
        {
            Caption = 'Send to FTP 2';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF xRec."Save PDF" AND NOT "Save PDF" THEN
                    IF NOT "Save PDF" THEN
                        "Save PDF" := TRUE;
            end;
        }
        field(20; "E-Mail To 1"; Text[80])
        {
            Caption = 'E-Mail To 1';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 1" = '') AND ("E-Mail To 1" <> '') THEN
                    IF NOT "Save PDF" THEN BEGIN
                        "Save PDF" := TRUE;
                        IF "E-Mail From" = '' THEN
                            "E-Mail From" := CheckEmailFromAddress();
                    END;
            end;
        }
        field(21; "E-Mail To 2"; Text[80])
        {
            Caption = 'E-Mail To 2';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 2" = '') AND ("E-Mail To 2" <> '') THEN
                    IF NOT "Save PDF" THEN BEGIN
                        "Save PDF" := TRUE;
                        IF "E-Mail From" = '' THEN
                            "E-Mail From" := CheckEmailFromAddress();

                    END;
            end;
        }
        field(22; "E-Mail To 3"; Text[250])
        {
            Caption = 'E-Mail To 3';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 3" = '') AND ("E-Mail To 3" <> '') THEN
                    IF NOT "Save PDF" THEN BEGIN
                        "Save PDF" := TRUE;
                        IF "E-Mail From" = '' THEN
                            "E-Mail From" := CheckEmailFromAddress();
                    END;
            end;
        }
        field(23; "E-Mail From"; Text[80])
        {
            Caption = 'E-Mail From';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF EMailAddresExists() AND (xRec."E-Mail From" <> '') AND ("E-Mail From" = '') THEN
                    ERROR(Err003);
            end;
        }
        field(30; "Save PDF"; Boolean)
        {
            Caption = 'Save PDF';
            DataClassification = CustomerContent;
        }
        field(40; "Print PDF"; Boolean)
        {
            Caption = 'Print PDF';
            DataClassification = CustomerContent;
        }
        field(50; "Mail Text Code"; Code[20])
        {
            Caption = 'Mail Text Code';
            DataClassification = CustomerContent;
            TableRelation = "DEL DocMatrix Email Codes" WHERE("Language Code" = FILTER('MAIL TEXT LANGAUGE CODE' | ''));
        }
        field(51; "Mail Text Langauge Code"; Code[10])
        {
            Caption = 'Mail Text Language Code';
            DataClassification = CustomerContent;
            TableRelation = Language;
        }
        field(60; "Request Page Parameters"; BLOB)
        {
            Caption = 'Request Page Parameters';
            DataClassification = CustomerContent;
        }
        field(70; Post; Enum "DEL Post DocMatrix")
        {
            Caption = 'Post';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF (Post IN [Post::Ship, Post::Invoice, Post::"Ship and Invoice"]) AND (Usage <> Usage::"S.Order") THEN
                    IF Usage = Usage::"S.Cr.Memo" THEN
                        ERROR(Err007, FORMAT(Usage::"S.Cr.Memo"))
                    ELSE
                        ERROR(Err005, FORMAT(Usage));

                IF (Usage <> Usage::"S.Cr.Memo") AND (Post = Post::Yes) THEN
                    ERROR(Err006, FORMAT(Usage::"S.Cr.Memo"));
            end;
        }
        field(75; "E-Mail from Sales Order"; Boolean)
        {
            Caption = 'E-Mail from Sales Order';
            DataClassification = CustomerContent;
            Description = 'CR100';
            trigger OnValidate()
            begin

                TESTFIELD(Type, Type::Customer);

            end;
        }
    }

    keys
    {
        key(Key1; UserId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var

        DocumentMatrixSetup: Record "DEL DocMatrix Setup";
        DocumentMatrixMgt: Codeunit "DEL DocMatrix Management";

        boNotificationAlreadySent: Boolean;
        Err003: Label 'You can not delete the "E-Mail From" Address, if a E-Mail Address is entered. First you have to delete all the E-Mail Addresses.';
        Err005: Label 'You can not "Post" documents of Type "%1".';
        Err006: Label 'You can select "Post = Yes" only for documents of Type "%1".';
        Err007: Label 'For documents of Type "%1" you have to select "Post = Yes", if you want to post it.';

    local procedure EMailAddresExists(): Boolean
    begin
        EXIT(("E-Mail To 1" <> '') OR ("E-Mail To 2" <> '') OR ("E-Mail To 3" <> ''));
    end;

    local procedure CheckEmailFromAddress(): Text
    var
        ltxText001: Label 'You can enter a "Default E-Mail From" Address in the Document Matrix Setup.';
    begin
        IF EMailAddresExists() THEN BEGIN
            IF (DocumentMatrixSetup.GET()) AND (DocumentMatrixSetup."Default E-Mail From" = '') THEN
                SendNotificationInfo(ltxText001);
            EXIT(DocumentMatrixSetup."Default E-Mail From");
        END;
    end;

    local procedure SendNotificationInfo(ptxNotificationText: Text)
    var
        MyNotification: Notification;
    begin
        IF boNotificationAlreadySent AND NOT NotificationsActive() THEN
            EXIT;
        MyNotification.MESSAGE := ptxNotificationText;
        MyNotification.SCOPE := NOTIFICATIONSCOPE::LocalScope;
        MyNotification.SEND();
        boNotificationAlreadySent := TRUE;
    end;

    local procedure NotificationsActive(): Boolean
    begin
        IF DocumentMatrixSetup.GET() THEN
            EXIT(DocumentMatrixSetup."Show Notifications");
    end;
}

