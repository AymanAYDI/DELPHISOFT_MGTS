codeunit 50053 "DEL D365FM PDF Email Send"
{


    Permissions = TableData "Issued Reminder Header" = rm,
                  TableData "Service Header" = rm,
                  TableData "Service Invoice Header" = rm;

    trigger OnRun()
    begin
        CASE Param OF
            'FctLaunchExport':
                FctLaunchExport();
        END;
    end;

    var
        //TODO  CduGSMTPMail: Codeunit 400;
        BooGManualyRun: Boolean;
        IntGLanguage: Integer;
        TxtGObject: Text[250];
        TxtGSender: Text[250];
        TxtGCustEmail: Text[250];
        TxtGCci: Text;
        CodGLanguage: Code[20];
        OptGDocType: Option " ","Service Invoice","Service Credit Memo","Issued Reminder";
        Param: Text;
        RecRefMaster: RecordRef;
        RemTermsCod: Code[20];
        RemLevelInt: Integer;
        AttachmentInstream: InStream;
        AttachmentOutStream: OutStream;
        //TODO TempBlob: Record "99008535";
        ServerAttachmentFilePath: Text;
        RenewalStdTextCode: Code[20];
        PrintPicture: Boolean;
        EntryNo: Integer;
        NewPage: Boolean;
        TemplateMailString: Text[250];


    procedure FctLaunchExport(): Boolean
    var
        Text001: Label 'Escompte pour paiement à réception : 0.3% par mois. ';
        Text002: Label 'Conformément à l''article L441-6 du Code de Commerce, des pénalités de retard seront appliquées dès le jour suivant la date de règlement mentionnée sur la facture au taux directeur de la BCE + 10 points ainsi qu''une indemnité forfaitaire de 40€ pour frais de recouvrement. ';
        Text003: Label 'Adresse de facturation ne doit pas être vide.';
        Text004: Label 'Adresse de livraison de doit pas être vide.';
        Text005: Label 'Adresse de commande ne doit pas être vide.';
        ServiceInvoiceHeader: Record "Service Invoice Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        RecLCompanyInfo: Record "Company Information";
        RecLCust: Record Customer;
        RefLRecordRef: RecordRef;
        FldLFieldRef: FieldRef;
        TxtLEmailBodyText: Text;
        ToFile: Text;
        OutSteam: OutStream;
        //TODO  RecLBLOBRef: Record "99008535";
        Text006: Label 'E-mail is empty.';
        Text007: Label 'E-mail template to apply not found.';
        Text008: Label 'Sender is empty.';
        LanguageTemplateMail: Record "DEL D365FM Mail Template";
        ServiceHeader: Record "Service Header";
        ServiceInvoiceHeader2: Record "Service Invoice Header";
        IssuedReminderHeader2: Record "Issued Reminder Header";
        ServiceHeader2: Record "Service Header";
        JobQueueEntry: Record "Job Queue Entry";
    begin
        RecRefMaster.SETRECFILTER();

        CLEAR(CduGSMTPMail);

        IF NOT GetTemplateWithLanguage(RecRefMaster, OptGDocType, CodGLanguage, RecLBLOBRef, TxtGObject, TxtGSender, TxtGCci, RemTermsCod, RemLevelInt, LanguageTemplateMail) THEN
            ERROR(Text007);

        CASE RecRefMaster.NUMBER OF
            // Service Invoice
            5992:
                BEGIN
                    RecRefMaster.SETTABLE(ServiceInvoiceHeader);
                    ServiceInvoiceHeader.FINDSET;
                    TxtGObject := STRSUBSTNO(TxtGObject, ServiceInvoiceHeader."No.");
                END;
            // Service Header
            5900:
                BEGIN
                    RecRefMaster.SETTABLE(ServiceHeader);
                    ServiceHeader.FINDSET;
                    TxtGObject := STRSUBSTNO(TxtGObject, ServiceHeader."No.");
                END;
            // Issue reminder
            297:
                BEGIN
                    RecRefMaster.SETTABLE(IssuedReminderHeader);
                    IssuedReminderHeader.FINDSET;
                    TxtGObject := STRSUBSTNO(TxtGObject, IssuedReminderHeader."No.");
                END;
        END;


        IF TxtGSender = '' THEN
            ERROR(Text008);

        IF TxtGCustEmail = '' THEN
            ERROR(Text006);

        CduGSMTPMail.CreateMessage(COMPANYNAME, TxtGSender, '', TxtGObject, '', TRUE);
        CduGSMTPMail.AddRecipients(TxtGCustEmail);

        IF TxtGCci <> '' THEN
            CduGSMTPMail.AddBCC(TxtGCci);

        CASE RecRefMaster.NUMBER OF
            // Service Invoice
            5992:
                BEGIN
                    RecRefMaster.SETTABLE(ServiceInvoiceHeader);

                    LoadMailBody(RecLBLOBRef, TxtLEmailBodyText, RecRefMaster);
                    CduGSMTPMail.AppendBody(TxtLEmailBodyText);
                    ToFile := SaveReportAsPDF(RecRefMaster);
                    CduGSMTPMail.AddAttachment(ToFile, 'Facture.pdf');
                    GetAttachmentDocuments(EntryNo);
                    IF CduGSMTPMail.TrySend THEN BEGIN
                        //ServiceInvoiceHeader2.GET(ServiceInvoiceHeader."No.");
                        //ServiceInvoiceHeader2."DEL No. Send Email" +=1;
                        //ServiceInvoiceHeader2.MODIFY;
                    END;
                END;
            // Service header
            5900:
                BEGIN
                    RecRefMaster.SETTABLE(ServiceHeader);

                    LoadMailBody(RecLBLOBRef, TxtLEmailBodyText, RecRefMaster);
                    CduGSMTPMail.AppendBody(TxtLEmailBodyText);
                    ToFile := SaveReportAsPDF(RecRefMaster);
                    CduGSMTPMail.AddAttachment(ToFile, 'Facture.pdf');
                    GetAttachmentDocuments(EntryNo);
                    IF CduGSMTPMail.TrySend THEN BEGIN
                        //ServiceHeader2.GET(ServiceHeader."Document Type",ServiceHeader."No.");
                        //ServiceHeader2."DEL No. Send Email" +=1;
                        //ServiceHeader2."DEL Subscribtion Print Date" := TODAY;
                        ServiceHeader2.MODIFY;
                    END;
                END;
            // Issue reminder
            297:
                BEGIN
                    RecRefMaster.SETTABLE(IssuedReminderHeader);

                    LoadMailBody(RecLBLOBRef, TxtLEmailBodyText, RecRefMaster);
                    CduGSMTPMail.AppendBody(TxtLEmailBodyText);
                    ToFile := SaveReportAsPDF(RecRefMaster);
                    CduGSMTPMail.AddAttachment(ToFile, 'Relance.pdf');
                    GetAttachmentDocuments(EntryNo);
                    IF CduGSMTPMail.TrySend THEN BEGIN
                        //IssuedReminderHeader2.GET(IssuedReminderHeader."No.");
                        //IssuedReminderHeader2."DEL No. Send Email" +=1;
                        //IssuedReminderHeader2.MODIFY;
                    END;
                END;
            //>>D365FM14.00.00.11
            472:
                BEGIN
                    RecRefMaster.SETTABLE(JobQueueEntry);

                    LoadMailBody(RecLBLOBRef, TxtLEmailBodyText, RecRefMaster);
                    CduGSMTPMail.AppendBody(TxtLEmailBodyText);

                    IF CduGSMTPMail.TrySend THEN BEGIN
                    END;
                END;
        END;

        EXIT(TRUE);
    end;


    procedure LoadMailBody(var RecPBLOBRef: Record TempBlob; var TxtPEmailBody: Text; var RecPRef: RecordRef)
    var
        TxtLRepeatLine: Text[1024];
        BooLStop: Boolean;
        y: Integer;
        InStreamTemplate: InStream;
        TxtLTempPath: Text[1024];
        InSReadChar: Text[1];
        Body: Text[1024];
        CharNo: Text[30];
        I: Integer;
        BooLSkip: Boolean;
        BooWrongEnd: Boolean;
        z: Integer;
    begin
        CLEAR(TxtPEmailBody);


        TxtLTempPath := TEMPORARYPATH + 'TempTemplate.HTM';
        RecPBLOBRef.Blob.CREATEINSTREAM(InStreamTemplate, TEXTENCODING::Windows);

        WHILE InStreamTemplate.READ(InSReadChar, 1) <> 0 DO BEGIN
            IF InSReadChar = '%' THEN BEGIN
                TxtPEmailBody += Body;
                Body := InSReadChar;

                IF InStreamTemplate.READ(InSReadChar, 1) <> 0 THEN;

                IF InSReadChar = 'n' THEN BEGIN
                    TxtLRepeatLine := '';
                    BooLStop := FALSE;
                    y := 1;

                    WHILE (NOT BooLStop) DO BEGIN
                        IF InStreamTemplate.READ(InSReadChar, 1) <> 0 THEN;
                        TxtLRepeatLine += InSReadChar;

                        IF y > 1 THEN BEGIN
                            IF (FORMAT(TxtLRepeatLine[y - 1]) + FORMAT(TxtLRepeatLine[y])) = '%n' THEN BEGIN
                                TxtLRepeatLine := DELSTR(TxtLRepeatLine, STRPOS(TxtLRepeatLine, '%n'), 2);
                                BooLStop := TRUE;
                            END;
                        END;
                        y += 1;
                    END;

                    WHILE (NOT BooLSkip) DO BEGIN
                        Body := '';
                        FOR y := 1 TO STRLEN(TxtLRepeatLine) DO BEGIN
                            IF TxtLRepeatLine[y] = '%' THEN BEGIN
                                Body += '%';

                                y += 1;
                                IF (TxtLRepeatLine[y] >= '0') AND (TxtLRepeatLine[y] <= '9') THEN BEGIN
                                    Body := Body + '1';
                                    CharNo := FORMAT(TxtLRepeatLine[y]);
                                    y += 1;
                                    WHILE ((TxtLRepeatLine[y] >= '0') AND (TxtLRepeatLine[y] <= '9')) OR (TxtLRepeatLine[y] = '/') DO BEGIN
                                        CharNo := CharNo + FORMAT(TxtLRepeatLine[y]);
                                        y += 1;
                                    END;
                                    Body += FORMAT(TxtLRepeatLine[y]);
                                    FillTemplate(Body, CharNo, '', 0, RecPRef);
                                    TxtPEmailBody += (CONVERTSTR(Body, '|', '%'));
                                    Body := '';

                                END ELSE
                                    Body += FORMAT(TxtLRepeatLine[y]);
                            END ELSE BEGIN
                                Body += FORMAT(TxtLRepeatLine[y]);
                            END;
                        END;
                        TxtPEmailBody += (CONVERTSTR(Body, '|', '%'));
                        Body := '';
                        BooLSkip := TRUE
                    END;
                END ELSE BEGIN
                    IF (InSReadChar >= '0') AND (InSReadChar <= '9') THEN BEGIN
                        Body := Body + '1';
                        CharNo := InSReadChar;
                        WHILE (InSReadChar >= '0') AND (InSReadChar <= '9') DO BEGIN
                            IF InStreamTemplate.READ(InSReadChar, 1) <> 0 THEN;
                            IF (InSReadChar >= '0') AND (InSReadChar <= '9') THEN
                                CharNo := CharNo + InSReadChar;
                        END;
                    END ELSE
                        Body := Body + InSReadChar;

                    FillTemplate(Body, CharNo, '', 0, RecPRef);
                    TxtPEmailBody += (CONVERTSTR(Body, '|', '%'));
                    Body := InSReadChar;
                END;

            END ELSE BEGIN
                Body += InSReadChar;
                I := I + 1;
                IF I = 500 THEN BEGIN
                    TxtPEmailBody += (CONVERTSTR(Body, '|', '%'));
                    Body := '';
                    I := 0;
                END;
            END;
        END;
        TxtPEmailBody += (CONVERTSTR(Body, '|', '%'));

    end;


    procedure FillTemplate(var Body: Text[1024]; TextNo: Text[30]; TxtPSpecialText: Text[200]; IntPPageNo: Integer; var RecPRef: RecordRef)
    var
        FldLRef: FieldRef;
        FldLRef2: FieldRef;
        IntLFieldNumber: Integer;
        IntLFieldNumber2: Integer;
        IntLOptionValue: Integer;
        i: Integer;
        TxtLOptionString: Text[1024];
        TxtLMySelectedOptionString: Text[1024];
        DecLValue1: Decimal;
        DecLValue2: Decimal;
        RecLActiveSession: Record "Active Session";
        RecLCompanyInfo: Record "Company Information";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        DocNo: Code[20];
        PostingDate: Date;
        ServiceHeader: Record "Service Header";
        JobQueueEntry: Record "Job Queue Entry";
    begin
        IF TextNo = '' THEN
            EXIT;

        CASE RecPRef.NUMBER OF
            5992:
                BEGIN
                    RecPRef.SETTABLE(ServiceInvoiceHeader);
                    ServiceInvoiceHeader.FINDSET;
                    DocNo := ServiceInvoiceHeader."No.";
                    PostingDate := ServiceInvoiceHeader."Posting Date";
                END;
            5900:
                BEGIN
                    RecPRef.SETTABLE(ServiceHeader);
                    ServiceHeader.FINDSET;
                    DocNo := ServiceHeader."No.";
                    PostingDate := ServiceHeader."Posting Date";
                END;
            297:
                BEGIN
                    RecPRef.SETTABLE(IssuedReminderHeader);
                    IssuedReminderHeader.FINDSET;
                    DocNo := IssuedReminderHeader."No.";
                    PostingDate := IssuedReminderHeader."Posting Date";
                END;
            472:
                BEGIN
                    RecPRef.SETTABLE(JobQueueEntry);
                    JobQueueEntry.FINDSET;
                END;
        END;

        IF STRPOS(TextNo, '/') = 0 THEN BEGIN
            EVALUATE(IntLFieldNumber, TextNo);
            CASE IntLFieldNumber OF
                10000:
                    Body := STRSUBSTNO(Body, TxtPSpecialText);
                200000001:
                    BEGIN
                        RecLActiveSession.SETRANGE("Server Instance ID", SERVICEINSTANCEID());
                        RecLActiveSession.SETRANGE("Session ID", SESSIONID());
                        RecLActiveSession.FINDFIRST;
                        Body := STRSUBSTNO(Body, ConvertString(RecLActiveSession."Server Computer Name"));
                    END;
                200000004:
                    BEGIN
                        RecLActiveSession.SETRANGE("Server Instance ID", SERVICEINSTANCEID());
                        RecLActiveSession.SETRANGE("Session ID", SESSIONID());
                        RecLActiveSession.FINDFIRST;
                        Body := STRSUBSTNO(Body, ConvertString(RecLActiveSession."Database Name"));
                    END;
                200000005:
                    Body := STRSUBSTNO(Body, ConvertString(COMPANYNAME));
                200000006:
                    Body := STRSUBSTNO(Body, FORMAT(WORKDATE()));
                200000007:
                    Body := STRSUBSTNO(Body, FORMAT(DocNo));
                200000008:
                    Body := STRSUBSTNO(Body, FORMAT(PostingDate));
                300000001:
                    BEGIN
                        RecLCompanyInfo.GET;
                        Body := STRSUBSTNO(Body, ConvertString(RecLCompanyInfo.City));
                    END;
                //>>D365FM14.00.00.11
                400000001:
                    BEGIN
                        Body := STRSUBSTNO(Body, FORMAT(JobQueueEntry.Status));
                    END;
                400000002:
                    BEGIN
                        Body := STRSUBSTNO(Body, FORMAT(JobQueueEntry."Object Type to Run"));
                    END;
                400000003:
                    BEGIN
                        Body := STRSUBSTNO(Body, FORMAT(JobQueueEntry."Object ID to Run"));
                    END;
                400000004:
                    BEGIN
                        Body := STRSUBSTNO(Body, FORMAT(JobQueueEntry.Description));
                    END;
                400000005:
                    BEGIN
                        Body := STRSUBSTNO(Body, FORMAT(JobQueueEntry."Error Message"));
                    END;
            END;
        END
    end;

    local procedure ConvertString(TxtPStringToConvert: Text[1024]) TxtRStringToConvert: Text[1024]
    var
        BooLFirst: Boolean;
    begin
        BooLFirst := TRUE;
        TxtRStringToConvert := '';
        IF STRPOS(TxtPStringToConvert, ' ') <> 0 THEN BEGIN
            WHILE (STRPOS(TxtPStringToConvert, ' ') <> 0) DO BEGIN
                IF BooLFirst THEN
                    TxtRStringToConvert += COPYSTR(TxtPStringToConvert, 1, STRPOS(TxtPStringToConvert, ' ') - 1)
                ELSE
                    TxtRStringToConvert += '%20' + COPYSTR(TxtPStringToConvert, 1, STRPOS(TxtPStringToConvert, ' ') - 1);
                BooLFirst := FALSE;

                TxtPStringToConvert := COPYSTR(TxtPStringToConvert, STRPOS(TxtPStringToConvert, ' ') + 1, STRLEN(TxtPStringToConvert));
            END;
            TxtRStringToConvert += '%20' + TxtPStringToConvert;
        END ELSE
            TxtRStringToConvert := TxtPStringToConvert;
    end;

    local procedure GetWindowsLanguageID(CodPLanguageCode: Code[10]): Integer
    var
        RecLLanguage: Record Language;
    begin
        IF (CodPLanguageCode <> '') THEN BEGIN
            RecLLanguage.GET(CodPLanguageCode);
            EXIT(RecLLanguage."Windows Language ID");
        END ELSE
            EXIT(IntGLanguage);
    end;

    local procedure SaveReportAsPDF(var RecPRef: RecordRef): Text
    var
        FileManagement: Codeunit "File Management";
        ServerSaveAsPdfFailedErr: Label 'Impossible d''ouvrir le document car il est vide ou ne peut pas être créé.';
        ServiceInvoiceHeader: Record "Service Invoice Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        ServiceHeader: Record "Service Header";
        ReportSelection: Record "Report Selections";
    begin
    end;


    procedure InitValue(var NewTxtPObject: Text; var NewTxtPSender: Text; var NewTxtPCustEmail: Text[250];
     NewOptPDocType: Option " ",
    "Service Invoice","Service Credit Memo","Issued Reminder"; NewCodGLanguage: Code[20];
     NewPRemTermsCod: Code[20]; NewPRemLevelInt: Integer; NewEntryNo: Integer; NewParam: Text)
    begin
        TxtGObject := NewTxtPObject;
        TxtGSender := NewTxtPSender;
        TxtGCustEmail := NewTxtPCustEmail;
        OptGDocType := NewOptPDocType;
        CodGLanguage := NewCodGLanguage;
        RemTermsCod := NewPRemTermsCod;
        RemLevelInt := NewPRemLevelInt;
        EntryNo := NewEntryNo;
        Param := NewParam;
    end;


    procedure GetTemplateWithLanguage(var RecPRef: RecordRef; OptPDocumentType: Option " ","Service Invoice","Service Credit Memo","Issued Reminder","Service Header"; CodPLanguage: Code[10]; var RecPBLOBRef: Record "99008535"; var TxtPObject: Text; var TxtPSender: Text; var TxtPCCI: Text; "Code": Code[20]; Level: Integer; var LanguageTemplateMail: Record "DEL D365FM Mail Template"): Boolean
    begin
        CASE RecPRef.NUMBER OF
            5992:
                BEGIN
                    LanguageTemplateMail.SETRANGE("Document Type", OptPDocumentType);
                    LanguageTemplateMail.SETRANGE("Language Code", CodPLanguage);
                    IF LanguageTemplateMail.FINDFIRST THEN BEGIN
                        LanguageTemplateMail.CALCFIELDS("Template mail");
                        RecPBLOBRef.Blob := LanguageTemplateMail."Template mail";
                        TxtPObject := LanguageTemplateMail.Title;
                        TxtPSender := LanguageTemplateMail."Sender Address";
                        TxtPCCI := LanguageTemplateMail.Cci;
                    END ELSE BEGIN
                        LanguageTemplateMail.SETRANGE("Language Code");
                        LanguageTemplateMail.SETRANGE(Default, TRUE);
                        IF NOT LanguageTemplateMail.FINDFIRST THEN
                            EXIT(FALSE);
                        LanguageTemplateMail.CALCFIELDS("Template mail");
                        RecPBLOBRef.Blob := LanguageTemplateMail."Template mail";
                        TxtPObject := LanguageTemplateMail.Title;
                        TxtPSender := LanguageTemplateMail."Sender Address";
                        TxtPCCI := LanguageTemplateMail.Cci;
                    END;

                    EXIT(TRUE);
                END;
            5900:
                BEGIN
                    LanguageTemplateMail.SETRANGE("Document Type", OptPDocumentType);
                    LanguageTemplateMail.SETRANGE("Language Code", CodPLanguage);
                    IF LanguageTemplateMail.FINDFIRST THEN BEGIN
                        LanguageTemplateMail.CALCFIELDS("Template mail");
                        RecPBLOBRef.Blob := LanguageTemplateMail."Template mail";
                        TxtPObject := LanguageTemplateMail.Title;
                        TxtPSender := LanguageTemplateMail."Sender Address";
                        TxtPCCI := LanguageTemplateMail.Cci;
                    END ELSE BEGIN
                        LanguageTemplateMail.SETRANGE("Language Code");
                        LanguageTemplateMail.SETRANGE(Default, TRUE);
                        IF NOT LanguageTemplateMail.FINDFIRST THEN
                            EXIT(FALSE);
                        LanguageTemplateMail.CALCFIELDS("Template mail");
                        RecPBLOBRef.Blob := LanguageTemplateMail."Template mail";
                        TxtPObject := LanguageTemplateMail.Title;
                        TxtPSender := LanguageTemplateMail."Sender Address";
                        TxtPCCI := LanguageTemplateMail.Cci;
                    END;

                    EXIT(TRUE);
                END;
            297:
                BEGIN
                    LanguageTemplateMail.SETRANGE("Document Type", OptPDocumentType);
                    LanguageTemplateMail.SETRANGE("Language Code", CodPLanguage);
                    LanguageTemplateMail.SETRANGE("Reminder Terms Code", Code);
                    LanguageTemplateMail.SETRANGE("Reminder Level", Level);
                    IF LanguageTemplateMail.ISEMPTY THEN BEGIN
                        LanguageTemplateMail.SETRANGE("Reminder Level");
                        LanguageTemplateMail.SETRANGE("Reminder Terms Code");
                        LanguageTemplateMail.SETRANGE(Default, TRUE);
                    END;

                    IF LanguageTemplateMail.FINDFIRST THEN BEGIN
                        LanguageTemplateMail.CALCFIELDS("Template mail");
                        RecPBLOBRef.Blob := LanguageTemplateMail."Template mail";
                        TxtPObject := LanguageTemplateMail.Title;
                        TxtPSender := LanguageTemplateMail."Sender Address";
                        TxtPCCI := LanguageTemplateMail.Cci;
                    END ELSE BEGIN
                        LanguageTemplateMail.SETRANGE("Language Code");
                        LanguageTemplateMail.SETRANGE(Default, TRUE);
                        IF NOT LanguageTemplateMail.FINDFIRST THEN
                            EXIT(FALSE);
                        LanguageTemplateMail.CALCFIELDS("Template mail");
                        RecPBLOBRef.Blob := LanguageTemplateMail."Template mail";
                        TxtPObject := LanguageTemplateMail.Title;
                        TxtPSender := LanguageTemplateMail."Sender Address";
                        TxtPCCI := LanguageTemplateMail.Cci;
                    END;

                    EXIT(TRUE);
                END;
            472:
                BEGIN
                    LanguageTemplateMail.SETRANGE("Parameter String", TemplateMailString);
                    IF LanguageTemplateMail.FINDFIRST THEN BEGIN
                        LanguageTemplateMail.CALCFIELDS("Template mail");
                        RecPBLOBRef.Blob := LanguageTemplateMail."Template mail";
                        TxtPObject := LanguageTemplateMail.Title;
                        TxtPSender := LanguageTemplateMail."Sender Address";
                        TxtPCCI := LanguageTemplateMail.Cci;
                    END ELSE
                        EXIT(FALSE);

                    EXIT(TRUE);
                END;
        END;
    end;


    procedure SetRecRef(var RecPRefMaster: RecordRef)
    begin
        RecRefMaster := RecPRefMaster;
    end;


    procedure SetParam(RenewalStdTextCode_P: Code[20]; PrintPicture_P: Boolean; NewPage_P: Boolean)
    begin
        RenewalStdTextCode := RenewalStdTextCode_P;
        PrintPicture := PrintPicture_P;
        NewPage := NewPage_P;
    end;


    procedure SetTemplateMailString(pTemplateMailString: Text[250])
    begin
        TemplateMailString := pTemplateMailString;
    end;

    local procedure GetAttachmentDocuments(EntryNo: Integer)
    var
        lTempBlob: Record "99008535";
        OutputFile: File;
        ServerAttachmentFilePath: Text;
        FileManagement: Codeunit "File Management";
        lAttachmentOutStream: OutStream;
        lAttachmentInstream: InStream;
    begin
    end;
}

