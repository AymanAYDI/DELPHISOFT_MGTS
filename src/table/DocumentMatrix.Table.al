table 50067 "DEL Document Matrix"
{

    Caption = 'Document Matrix';

    fields
    {
        field(1; Type; Enum "Credit Transfer Account Type")
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
                Name := DocumentMatrixMgt.GetCustVendName(Type, "No.");
                "Mail Text Langauge Code" := DocumentMatrixMgt.GetCustVendLanguageCode(Type, "No.");
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
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report));

            trigger OnValidate()
            begin
                CALCFIELDS("Report Caption");
            end;
        }
        field(5; "Report Caption"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(AllObjWithCaption."Object Caption"
            WHERE("Object Type" = CONST(Report),

        "Object ID" = FIELD("Report ID")));
            Caption = 'Report Caption';
            Editable = false;

        }
        field(6; Usage; Enum "DEL Usage DocMatrix Selection")
        {
            Caption = 'Usage';

            trigger OnValidate()
            begin
                CheckSetup();
                VALIDATE("Report ID", DocumentMatrixMgt.GetReportIDWithUsage(Usage));
                IF Usage = Usage::"C.Statement" THEN BEGIN
                    "Process Type" := "Process Type"::Automatic;
                    "Save PDF" := TRUE;
                END;
                CheckUsage();

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
                IF (xRec."E-Mail To 1" = '') AND ("E-Mail To 1" <> '') THEN
                    IF NOT "Save PDF" THEN BEGIN
                        "Save PDF" := TRUE;
                        SendNotificationInfo(Text001);
                    END;
            end;
        }
        field(21; "E-Mail To 2"; Text[80])
        {
            Caption = 'E-Mail To 2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 2" = '') AND ("E-Mail To 2" <> '') THEN
                    IF NOT "Save PDF" THEN BEGIN
                        "Save PDF" := TRUE;
                        SendNotificationInfo(Text001);
                    END;
            end;
        }
        field(22; "E-Mail To 3"; Text[80])
        {
            Caption = 'E-Mail To 3';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF (xRec."E-Mail To 3" = '') AND ("E-Mail To 3" <> '') THEN
                    IF NOT "Save PDF" THEN BEGIN
                        "Save PDF" := TRUE;
                        SendNotificationInfo(Text001);
                    END;
            end;
        }
        field(23; "E-Mail From"; Text[80])
        {
            Caption = 'E-Mail From';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF EMailAddresExists() AND (xRec."E-Mail From" <> '') AND ("E-Mail From" = '') THEN
                    ERROR(Err003);
            end;
        }
        field(30; "Save PDF"; Boolean)
        {
            Caption = 'Save PDF';
            DataClassification = ToBeClassified;


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
            TableRelation = "DEL DocMatrix Email Codes" WHERE("Language Code" = FILTER('MAIL TEXT LANGAUGE CODE' | ''));
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
        field(70; Post; Enum "DEL Post DocMatrix")
        {
            Caption = 'Post';
            DataClassification = ToBeClassified;


            trigger OnValidate()
            begin
                IF (Post IN [1, 2, 3]) AND (Usage <> Usage::"S.Order") THEN
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


            trigger OnValidate()
            begin

                TESTFIELD(Type, Type::Customer);
                TESTFIELD(Usage, Usage::"S.Order");

            end;
        }
    }

    keys
    {
        key(Key1; Type, "No.", "Process Type", Usage)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "Save PDF" := SavePDFmandatory();
        "E-Mail From" := CheckEmailFromAddress();
    end;

    trigger OnModify()
    begin
        "E-Mail From" := CheckEmailFromAddress();
    end;

    var
        DocumentMatrixSetup: Record "DEL DocMatrix Setup";
        DocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
        boNotificationAlreadySent: Boolean;

        Err001: Label 'Please enter the Document Matrix Setup first.';
        Err003: Label 'You can not delete the "E-Mail From" Address, if a E-Mail Address is entered. First you have to delete all the E-Mail Addresses.';
        Err004: Label 'You can not activate "Print" if the "Process Type" is set to "Automatic"!';
        Err005: Label 'You can not "Post" documents of Type "%1".';
        Err006: Label 'You can select "Post = Yes" only for documents of Type "%1".';
        Err007: Label 'For documents of Type "%1" you have to select "Post = Yes", if you want to post it.';
        Err008: Label 'FTP can only be activated for Type "Customer".';
        Text001: Label 'The field "Save PDF" was set to TRUE to fit the Business Logic.';
        Text003: Label 'Please check if you have to change the field "Usage".';

    local procedure CheckUsage()
    var
        lErr001: Label 'The selected Usage/Type combination is not valid!';
        lErr002: Label 'The selected Usage/Process Type combination is not valid!';
    begin
        CASE TRUE OF
            (Usage = Usage::"P.Invoice") AND (Type = Type::Customer):
                ERROR(lErr001);
            (Usage = Usage::"P.Order") AND (Type = Type::Customer):
                ERROR(lErr001);
            (Usage = Usage::"S.Cr.Memo") AND (Type = Type::Vendor):
                ERROR(lErr001);
            (Usage = Usage::"S.Invoice") AND (Type = Type::Vendor):
                ERROR(lErr001);
            (Usage = Usage::"S.Order") AND (Type = Type::Vendor):
                ERROR(lErr001);
        //TODO (Usage = Usage::54) AND ("Process Type" = "Process Type"::Manual):
        // ERROR(lErr002);
        END;
    end;

    local procedure CheckSetup()
    begin
        IF NOT DocumentMatrixSetup.GET() THEN
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
        IF NotificationsActive() THEN BEGIN
            IF boNotificationAlreadySent THEN
                EXIT;
            MyNotification.MESSAGE := ptxNotificationText;
            MyNotification.SCOPE := NOTIFICATIONSCOPE::LocalScope;
            MyNotification.SEND();
            boNotificationAlreadySent := TRUE;
        END;
    end;

    local procedure NotificationsActive(): Boolean
    begin
        IF DocumentMatrixSetup.GET() THEN
            EXIT(DocumentMatrixSetup."Show Notifications");
    end;

    local procedure SavePDFmandatory(): Boolean
    begin
        EXIT(EMailAddresExists() OR FtpActivated() OR (Usage = Usage::"C.Statement"));
    end;

    procedure SaveRequestPageParameters(precDocumentMatrix: Record "DEL Document Matrix")
    var
        OStream: OutStream;
        XmlParameters: Text;
    begin
        XmlParameters := "REPORT".RUNREQUESTPAGE(precDocumentMatrix."Report ID");
        precDocumentMatrix.SETAUTOCALCFIELDS("Request Page Parameters");
        precDocumentMatrix."Request Page Parameters".CREATEOUTSTREAM(OStream, TEXTENCODING::UTF8);
        OStream.WRITETEXT(XmlParameters);
        precDocumentMatrix.MODIFY();
    end;


    procedure SetRequestPageParametersText(precDocumentMatrix: Record "DEL DocMatrix Setup"; Value: Text)
    var
        BodyText: BigText;
        DataStream: OutStream;

    begin
        // write text to the BLOB field
        CLEAR("Request Page Parameters");
        BodyText.ADDTEXT(Value);
        "Request Page Parameters".CREATEOUTSTREAM(DataStream, TEXTENCODING::UTF8);
        BodyText.WRITE(DataStream);
        precDocumentMatrix.MODIFY(TRUE);
    end;


    procedure GetRequestPageParametersText(precDocumentMatrix: Record "DEL DocMatrix Setup") Value: Text
    var
        MyBigText: BigText;
        BLOBInStream: InStream;
    begin
        // get the text from the BLOB field
        CALCFIELDS("Request Page Parameters");
        IF "Request Page Parameters".HASVALUE THEN BEGIN
            CLEAR(MyBigText);
            "Request Page Parameters".CREATEINSTREAM(BLOBInStream);
            MyBigText.READ(BLOBInStream);
            MyBigText.GETSUBTEXT(Value, 1);
        END;
        EXIT(Value);
    end;


    procedure SetRequestPageParametersBigText(var precDocumentMatrix: Record "DEL DocMatrix Setup"; pBigText: BigText)
    var
        DataStream: OutStream;
    begin
        // write text to the BLOB field
        CLEAR("Request Page Parameters");
        "Request Page Parameters".CREATEOUTSTREAM(DataStream, TEXTENCODING::UTF8);
        pBigText.WRITE(DataStream);
        precDocumentMatrix.MODIFY(TRUE);
    end;


    procedure GetRequestPageParametersBigText(var precDocumentMatrix: Record "DEL DocMatrix Setup"; var pBigText: BigText)
    var
        BLOBInStream: InStream;
    begin
        // get the text from the BLOB field
        CALCFIELDS("Request Page Parameters");
        IF "Request Page Parameters".HASVALUE THEN BEGIN
            CLEAR(pBigText);
            "Request Page Parameters".CREATEINSTREAM(BLOBInStream);
            pBigText.READ(BLOBInStream);
        END;
    end;


    procedure ChangeRequestPageParameters(var precDocumentMatrix: Record "DEL DocMatrix Setup"; pTextToFind: Text; pTextToReplace: Text)
    var
        InputText: BigText;
        OutputText: BigText;
        SubText: BigText;



        TextPosition: Integer;
    begin

        GetRequestPageParametersBigText(precDocumentMatrix, InputText);

        TextPosition := InputText.TEXTPOS(pTextToFind);
        WHILE TextPosition <> 0 DO BEGIN
            InputText.GETSUBTEXT(SubText, 1, TextPosition - 1);
            OutputText.ADDTEXT(SubText);
            OutputText.ADDTEXT(pTextToReplace);                                                                                  // pTextToReplace includes the date string
            InputText.GETSUBTEXT(InputText, TextPosition + STRLEN(pTextToFind) + (STRLEN(pTextToReplace) - STRLEN(pTextToFind))); // Difference is for the missing date in pTextToFind
            TextPosition := InputText.TEXTPOS(pTextToFind);
        END;
        OutputText.ADDTEXT(InputText);


        SetRequestPageParametersBigText(precDocumentMatrix, OutputText);
    end;

    local procedure u_SetRequestPageParametersFile(var pOutputText: BigText)
    var
        TempBlob: Codeunit "Temp Blob";
        Outsr: OutStream;
        TextFile: File;
    begin
        //TODO: à corrigerr
        //TextFile.TEXTMODE(FALSE);
        // TextFile.CREATE('C:\TEMP\TextFile3.txt');
        // TextFile.CREATEOUTSTREAM(OutStream);
        // pOutputText.WRITE(OutStream);
        // TextFile.CLOSE;

        TempBlob.CreateOutStream(Outsr);
        pOutputText.WRITE(Outsr);
    end;

    local procedure u_GetRequestPageParametersFile(var pInputText: BigText)
    var
        TempBlob: Codeunit "Temp Blob";
        TextFile: file;
        Instr: InStream;
    begin
        //TODO : à corigerr
        //TextFile.TEXTMODE(FALSE);
        // TextFile.OPEN('C:\TEMP\TextFile1.txt');
        // TextFile.CREATEINSTREAM(InStream);
        // pInputText.READ(InStream);
        // TextFile.CLOSE;
        TempBlob.CreateInStream(Instr);
        WHILE NOT Instr.EOS DO BEGIN
            pInputText.READ(Instr);
        END;
    end;
}

