table 50067 "DEL Document Matrix"
{


    Caption = 'Document Matrix';

    fields
    {
        field(1; Type; Enum "DEL Type Fee Connection")
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;

        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Customer)) Customer."No."
            ELSE
            IF (Type = CONST(Vendor)) Vendor."No.";

            trigger OnValidate()
            begin
                //TODO
                // Name := DocumentMatrixMgt.GetCustVendName(Type, "No.");
                //"Mail Text Langauge Code" := DocumentMatrixMgt.GetCustVendLanguageCode(Type, "No.");
            end;
        }
        field(3; "Process Type"; Enum "DEL Process Type")
        {
            Caption = 'Process Type';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Process Type" = "Process Type"::Automatic THEN
                    VALIDATE(Usage, Usage::"C.Statement")
                ELSE
                    IF (xRec."Process Type" <> "Process Type") THEN
                        SendNotificationInfo(Text003);
            end;
        }
        field(4; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            Editable = false;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report Caption = '';
));

            trigger OnValidate()
            begin
                CALCFIELDS("Report Caption");
            end;
        }
        field(5; "Report Caption"; Text[250])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE (Object Type=CONST(Report    Caption = '';
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

            trigger OnValidate()
            begin
                CheckSetup;
                VALIDATE("Report ID",DocumentMatrixMgt.GetReportIDWithUsage(Usage));
                IF Usage = Usage::"C.Statement" THEN BEGIN
                  "Process Type" := "Process Type"::Automatic;
                  "Save PDF" := TRUE;
                END;
                CheckUsage;
                //IF (xRec.Usage <> Usage) OR (xRec."Report ID" <> "Report ID") THEN
                //  SendNotificationInfo(Text002);
            end;
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
            Description = 'only used in T50071';
        }
        field(10; "Send to FTP 1"; Boolean)
        {
            Caption = 'Send to FTP 1';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Send to FTP 1" THEN
                  IF Type = Type::Vendor THEN
                    ERROR(Err008);
            end;
        }
        field(11; "Send to FTP 2"; Boolean)
        {
            Caption = 'Send to FTP 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "Send to FTP 2" THEN
                  IF Type = Type::Vendor THEN
                    ERROR(Err008);
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
                    SendNotificationInfo(Text001);
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
                    SendNotificationInfo(Text001);
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
                    SendNotificationInfo(Text001);
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

            trigger OnValidate()
            begin
                IF "Process Type" = "Process Type"::Automatic THEN
                  ERROR(Err004);
            end;
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
                TESTFIELD(Usage,Usage::"S.Order");
                //20200915/DEL/PD/CR100.end
            end;
        }
    }

    keys
    {
        key(Key1;Type,"No.","Process Type",Usage)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Save PDF" := SavePDFmandatory;
        "E-Mail From" := CheckEmailFromAddress;
    end;

    trigger OnModify()
    begin
        "E-Mail From" := CheckEmailFromAddress;
    end;

    var
        DocumentMatrixMgt: Codeunit "DocMatrix Management";
        DocumentMatrixSetup: Record "DocumentMatrixSetup";
        Err001: Label 'Please enter the Document Matrix Setup first.';
        Err002: Label 'You can not desactivate "Save PDF" if EMail or FTP is active, or if "Process Type" is "Automatic".';
        Err003: Label 'You can not delete the "E-Mail From" Address, if a E-Mail Address is entered. First you have to delete all the E-Mail Addresses.';
        Err004: Label 'You can not activate "Print" if the "Process Type" is set to "Automatic"!';
        Err005: Label 'You can not "Post" documents of Type "%1".';
        Err006: Label 'You can select "Post = Yes" only for documents of Type "%1".';
        Err007: Label 'For documents of Type "%1" you have to select "Post = Yes", if you want to post it.';
        Err008: Label 'FTP can only be activated for Type "Customer".';
        Text001: Label 'The field "Save PDF" was set to TRUE to fit the Business Logic.';
        Text002: Label 'The field "Process Type" might have changed to fit the Business Logic.';
        Text003: Label 'Please check if you have to change the field "Usage".';
        boNotificationAlreadySent: Boolean;

    local procedure CheckUsage()
    var
        lErr001: Label 'The selected Usage/Type combination is not valid!';
        lErr002: Label 'The selected Usage/Process Type combination is not valid!';
    begin
        CASE TRUE OF
          (Usage = Usage::"P.Invoice") AND (Type = Type::Customer) : ERROR(lErr001);
          (Usage = Usage::"P.Order") AND (Type = Type::Customer) : ERROR(lErr001);
          (Usage = Usage::"S.Cr.Memo") AND (Type = Type::Vendor) : ERROR(lErr001);
          (Usage = Usage::"S.Invoice") AND (Type = Type::Vendor) : ERROR(lErr001);
          (Usage = Usage::"S.Order") AND (Type = Type::Vendor) : ERROR(lErr001);
          (Usage = Usage::"54") AND ("Process Type" = "Process Type"::Manual) : ERROR(lErr002);
        END;
    end;

    local procedure CheckSetup()
    begin
        IF NOT DocumentMatrixSetup.GET THEN
          ERROR(Err001);
    end;

    local procedure EMailAddresExists(): Boolean
    begin
        EXIT(("E-Mail To 1" <> '') OR ("E-Mail To 2" <> '') OR ("E-Mail To 3" <> ''));
    end;

    local procedure FtpActivated(): Boolean
    begin
        EXIT("Send to FTP 1" OR "Send to FTP 1");
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
        IF NotificationsActive THEN BEGIN
          IF boNotificationAlreadySent THEN
            EXIT;
          MyNotification.MESSAGE := ptxNotificationText;
          MyNotification.SCOPE := NOTIFICATIONSCOPE::LocalScope;
          MyNotification.SEND;
          boNotificationAlreadySent := TRUE;
        END;
    end;

    local procedure NotificationsActive(): Boolean
    begin
        IF DocumentMatrixSetup.GET THEN
          EXIT(DocumentMatrixSetup."Show Notifications");
    end;

    local procedure SavePDFmandatory(): Boolean
    begin
        EXIT(EMailAddresExists OR FtpActivated OR (Usage = Usage::"C.Statement"));
    end;


    procedure SaveRequestPageParameters(precDocumentMatrix: Record "50067")
    var
        XmlParameters: Text;
        OStream: OutStream;
    begin
        WITH precDocumentMatrix DO BEGIN
          XmlParameters := REPORT.RUNREQUESTPAGE("Report ID");
          SETAUTOCALCFIELDS("Request Page Parameters");
          "Request Page Parameters".CREATEOUTSTREAM(OStream,TEXTENCODING::UTF8);
          OStream.WRITETEXT(XmlParameters);
          MODIFY;
        END;
    end;


    procedure SetRequestPageParametersText(precDocumentMatrix: Record "DocumentMatrixSetup";Value: Text)
    var
        DataStream: OutStream;
        BodyText: BigText;
    begin
        // write text to the BLOB field
        WITH precDocumentMatrix DO BEGIN
          CLEAR("Request Page Parameters");
          BodyText.ADDTEXT(Value);
          "Request Page Parameters".CREATEOUTSTREAM(DataStream,TEXTENCODING::UTF8);
          BodyText.WRITE(DataStream);
          MODIFY(TRUE);
        END;
    end;


    procedure GetRequestPageParametersText(precDocumentMatrix: Record "DocumentMatrixSetup") Value: Text
    var
        TempBlob: Record "TempBlob";
        FileManagement: Codeunit "File Management";
        DataStream: InStream;
        BodyOutStream: OutStream;
        BodyText: BigText;
        MyBigText: BigText;
        BLOBInStream: InStream;
    begin
        // get the text from the BLOB field
        WITH precDocumentMatrix DO BEGIN
          CALCFIELDS("Request Page Parameters");
          IF "Request Page Parameters".HASVALUE THEN BEGIN
            CLEAR(MyBigText);
            "Request Page Parameters".CREATEINSTREAM(BLOBInStream);
            MyBigText.READ(BLOBInStream);
            MyBigText.GETSUBTEXT(Value, 1);
          END;
          EXIT(Value);
        END;
    end;


    procedure SetRequestPageParametersBigText(var precDocumentMatrix: Record "DocumentMatrixSetup";pBigText: BigText)
    var
        DataStream: OutStream;
        BodyText: BigText;
    begin
        // write text to the BLOB field
        WITH precDocumentMatrix DO BEGIN
          CLEAR("Request Page Parameters");
          "Request Page Parameters".CREATEOUTSTREAM(DataStream,TEXTENCODING::UTF8);
          pBigText.WRITE(DataStream);
          MODIFY(TRUE);
        END;
    end;

 
    procedure GetRequestPageParametersBigText(var precDocumentMatrix: Record "DocumentMatrixSetup";var pBigText: BigText)
    var
        TempBlob: Record "TempBlob";
        FileManagement: Codeunit "File Management";
        DataStream: InStream;
        BodyOutStream: OutStream;
        BodyText: BigText;
        BLOBInStream: InStream;
    begin
        // get the text from the BLOB field
        WITH precDocumentMatrix DO BEGIN
          CALCFIELDS("Request Page Parameters");
          IF "Request Page Parameters".HASVALUE THEN BEGIN
            CLEAR(pBigText);
            "Request Page Parameters".CREATEINSTREAM(BLOBInStream);
            pBigText.READ(BLOBInStream);
          END;
        END;
    end;


    procedure ChangeRequestPageParameters(var precDocumentMatrix: Record "DocumentMatrixSetup";pTextToFind: Text;pTextToReplace: Text)
    var
        InStream: InStream;
        OutStream: OutStream;
        InputText: BigText;
        OutputText: BigText;
        SubText: BigText;
        TextPosition: Integer;
    begin
        // This function replaces the date value in the Request Page Parameter XML string
        // that is stored as a BLOB in the field "Request Page Parameters"
        // - pTextToFind    = '<Field name="StartDate">';
        // - pTextToReplace = '<Field name="StartDate">2020-01-01';

        // get the XML string from the BLOB through the BigText VAR parameter "InputText"
        GetRequestPageParametersBigText(precDocumentMatrix, InputText);

        // search for the string in the BigText, an replace it with the new string
        TextPosition := InputText.TEXTPOS(pTextToFind);
        WHILE TextPosition <> 0 DO BEGIN
          InputText.GETSUBTEXT(SubText,1,TextPosition - 1);
          OutputText.ADDTEXT(SubText);
          OutputText.ADDTEXT(pTextToReplace);                                                                                  // pTextToReplace includes the date string
          InputText.GETSUBTEXT(InputText,TextPosition + STRLEN(pTextToFind) + (STRLEN(pTextToReplace) - STRLEN(pTextToFind))); // Difference is for the missing date in pTextToFind
          TextPosition := InputText.TEXTPOS(pTextToFind);
        END;
        OutputText.ADDTEXT(InputText);

        // write the changed XML string back to the BLOB through the BigText VAR parameter "OutputText"
        SetRequestPageParametersBigText(precDocumentMatrix, OutputText);
    end;

    local procedure __unused_functions()
    begin
        // OBSOLTE FUNCTIONS
    end;

    local procedure u_SetRequestPageParametersFile(var pOutputText: BigText)
    var
        TextFile: File;
        OutStream: OutStream;
    begin
        // this function does the same as "SetRequestPageParametersBigText" but with a file variable
        // it is not used for the moment
        TextFile.TEXTMODE(FALSE);
        TextFile.CREATE('C:\TEMP\TextFile3.txt');
        TextFile.CREATEOUTSTREAM(OutStream);
        pOutputText.WRITE(OutStream);
        TextFile.CLOSE;
    end;

    local procedure u_GetRequestPageParametersFile(var pInputText: BigText)
    var
        TextFile: File;
        InStream: InStream;
    begin
        // this function does the same as "GetRequestPageParametersBigText" but with a file variable
        // it is not used for the moment
        TextFile.TEXTMODE(FALSE);
        TextFile.OPEN('C:\TEMP\TextFile1.txt');
        TextFile.CREATEINSTREAM(InStream);
        pInputText.READ(InStream);
        TextFile.CLOSE;
    end;
}

