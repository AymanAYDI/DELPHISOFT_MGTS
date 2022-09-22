table 50071 "DEL DocMatrix Selection"
{
    Caption = 'DocMatrix Selection';
    // DEL/PD/20190227/LOP003 : object created
    // DEL/PD/20190228/LOP003 : changed "Post - OnValidate": small correction in BL
    // DEL/PD/20190305/LOP003 : deleted obsolete functions
    // 20200915/DEL/PD/CR100  : new field "E-Mail from Sales Order"
    // 20201007/DEL/PD/CR100  : published to PROD


    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,Vendor';
            OptionMembers = Customer,Vendor;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Customer)) Customer.No.
                            ELSE IF (Type=CONST(Vendor)) Vendor.No.;
        }
        field(3; "Process Type"; Option)
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Manual,Automatic';
            OptionMembers = Manual,Automatic;
        }
        field(4; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            Editable = false;
            TableRelation = AllObjWithCaption."Object ID" WHERE (Object Type=CONST(Report    Caption     Caption = 'Caption';
= '';
));
        }
        field(5; "Report Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE (Object Type=CONST(Report    Caption     Caption = 'Caption';
= '';
),
                                                                           Object ID=FIELD(Report ID    Caption = 'ID';
)));
            Caption = 'Report Caption';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; Usage; Option)
        {
            Caption = 'Usage';
            OptionCaption = ',S.Order,S.Invoice,S.Cr.Memo,,,P.Order,P.Invoice,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,C.Statement';
            OptionMembers = ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,"C.Statement";
        }
        field(7; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(8; "UserId"; Code[50])
        {
            Caption = 'UserId';
            DataClassification = ToBeClassified;
        }
        field(10; "Send to FTP 1"; Boolean)
        {
            Caption = 'Send to FTP 1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF xRec."Save PDF" AND NOT "Save PDF" THEN BEGIN
                  IF NOT "Save PDF" THEN BEGIN
                    "Save PDF" := TRUE;
                  END;
                END;
            end;
        }
        field(11; "Send to FTP 2"; Boolean)
        {
            Caption = 'Send to FTP 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF xRec."Save PDF" AND NOT "Save PDF" THEN BEGIN
                  IF NOT "Save PDF" THEN BEGIN
                    "Save PDF" := TRUE;
                  END;
                END;
            end;
        }
        field(20; "E-Mail To 1"; Text[80])
        {
            Caption = 'E-Mail To 1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 1" = '') AND ("E-Mail To 1" <> '') THEN BEGIN
                  IF NOT "Save PDF" THEN BEGIN
                    "Save PDF" := TRUE;
                    IF "E-Mail From" = '' THEN
                      "E-Mail From" := CheckEmailFromAddress;
                  END;
                END;
            end;
        }
        field(21; "E-Mail To 2"; Text[80])
        {
            Caption = 'E-Mail To 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 2" = '') AND ("E-Mail To 2" <> '') THEN BEGIN
                  IF NOT "Save PDF" THEN BEGIN
                    "Save PDF" := TRUE;
                    IF "E-Mail From" = '' THEN
                      "E-Mail From" := CheckEmailFromAddress;
                  END;
                END;
            end;
        }
        field(22; "E-Mail To 3"; Text[80])
        {
            Caption = 'E-Mail To 3';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 3" = '') AND ("E-Mail To 3" <> '') THEN BEGIN
                  IF NOT "Save PDF" THEN BEGIN
                    "Save PDF" := TRUE;
                    IF "E-Mail From" = '' THEN
                      "E-Mail From" := CheckEmailFromAddress;
                  END;
                END;
            end;
        }
        field(23; "E-Mail From"; Text[80])
        {
            Caption = 'E-Mail From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF EMailAddresExists AND (xRec."E-Mail From" <> '') AND ("E-Mail From" = '') THEN
                  ERROR(Err003);
            end;
        }
        field(30; "Save PDF"; Boolean)
        {
            Caption = 'Save PDF';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF SavePDFmandatory AND ("Save PDF" = FALSE) AND (xRec."Save PDF" = TRUE) THEN
                //  ERROR(Err002);
            end;
        }
        field(40; "Print PDF"; Boolean)
        {
            Caption = 'Print PDF';
            DataClassification = ToBeClassified;
        }
        field(50; "Mail Text Code"; Code[20])
        {
            Caption = 'Mail Text Code';
            DataClassification = ToBeClassified;
            TableRelation = "DocMatrix Email Codes" WHERE (Language Code=FILTER("MAIL TEXT LANGAUGE CODE"|''));
        }
        field(51; "Mail Text Langauge Code"; Code[10])
        {
            Caption = 'Mail Text Language Code';
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(60; "Request Page Parameters"; BLOB)
        {
            Caption = 'Request Page Parameters';
            DataClassification = ToBeClassified;
        }
        field(70; Post; Option)
        {
            Caption = 'Post';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Ship,Invoice,Ship and Invoice,Yes';
            OptionMembers = " ",Ship,Invoice,"Ship and Invoice",Yes;

            trigger OnValidate()
            begin
                IF (Post IN [1,2,3]) AND (Usage <> Usage::"S.Order") THEN BEGIN
                  IF Usage = Usage::"S.Cr.Memo" THEN
                    ERROR(Err007,FORMAT(Usage::"S.Cr.Memo"))
                  ELSE
                    ERROR(Err005,FORMAT(Usage));
                END;

                IF (Usage <> Usage::"S.Cr.Memo") AND (Post = Post::Yes) THEN
                  ERROR(Err006,FORMAT(Usage::"S.Cr.Memo"));
            end;
        }
        field(75; "E-Mail from Sales Order"; Boolean)
        {
            Caption = 'E-Mail from Sales Order';
            Description = 'CR100';

            trigger OnValidate()
            begin
                //20200915/DEL/PD/CR100.begin
                TESTFIELD(Type,Type::Customer);
                //20200915/DEL/PD/CR100.end
            end;
        }
    }

    keys
    {
        key(Key1;UserId)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        DocumentMatrixMgt: Codeunit "50015";
        DocumentMatrixSetup: Record "50069";
        boNotificationAlreadySent: Boolean;
        Err001: Label 'Please enter the Document Matrix Setup first.';
        Err002: Label 'You can not desactivate "Save PDF" if EMail or FTP is active, or if "Process Type" is "Automatic".';
        Err003: Label 'You can not delete the "E-Mail From" Address, if a E-Mail Address is entered. First you have to delete all the E-Mail Addresses.';
        Err004: Label 'You can not activate "Print" if the "Process Type" is set to "Automatic"!';
        Err005: Label 'You can not "Post" documents of Type "%1".';
        Err006: Label 'You can select "Post = Yes" only for documents of Type "%1".';
        Err007: Label 'For documents of Type "%1" you have to select "Post = Yes", if you want to post it.';
        Text001: Label 'The field "Save PDF" was set to TRUE to fit the Business Logic.';
        Text002: Label 'The field "Process Type" might have changed to fit the Business Logic.';
        Text003: Label 'Please check if you have to change the field "Usage".';

    local procedure EMailAddresExists(): Boolean
    begin
        EXIT(("E-Mail To 1" <> '') OR ("E-Mail To 2" <> '') OR ("E-Mail To 3" <> ''));
    end;

    local procedure CheckEmailFromAddress(): Text
    var
        ltxText001: Label 'You can enter a "Default E-Mail From" Address in the Document Matrix Setup.';
    begin
        IF EMailAddresExists THEN BEGIN
          IF (DocumentMatrixSetup.GET) AND (DocumentMatrixSetup."Default E-Mail From" = '') THEN
            SendNotificationInfo(ltxText001);
          EXIT(DocumentMatrixSetup."Default E-Mail From");
        END;
    end;

    local procedure SendNotificationInfo(ptxNotificationText: Text)
    var
        MyNotification: Notification;
    begin
        IF boNotificationAlreadySent AND NOT NotificationsActive THEN
          EXIT;
        MyNotification.MESSAGE := ptxNotificationText;
        MyNotification.SCOPE := NOTIFICATIONSCOPE::LocalScope;
        MyNotification.SEND;
        boNotificationAlreadySent := TRUE;
    end;

    local procedure NotificationsActive(): Boolean
    begin
        IF DocumentMatrixSetup.GET THEN
          EXIT(DocumentMatrixSetup."Show Notifications");
    end;
}

