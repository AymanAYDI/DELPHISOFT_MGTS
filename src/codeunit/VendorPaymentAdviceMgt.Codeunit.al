codeunit 50057 "DEL Vendor Payment Advice Mgt."
{

    var
        JournalBatchName: Code[10];
        JournalTemplateName: Code[10];
        FileNameLbl: Label '';
        Text001: Label 'Vendor : ##################1################## \\ @@@@@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@@@@';
        Text002: Label 'Processing completed !';


    procedure SendPaymentAdvice(_JournalTemplateName: Code[10]; _JournalBatchName: Code[10])
    var

        CompanyInfo: Record "Company Information";
        GeneralSetup: Record "DEL General Setup";
        GenJournalLine: Record "Gen. Journal Line";
        TempVendor: Record Vendor temporary;
        Vendor: Record Vendor;
        ProgressionDialog: Dialog;
        Counter: Integer;
        RecordNumber: Integer;
        ServerFile: Text;
        MailBody: Text;
        SendFromAddress: Text;
        SendToAddress: Text;
        SubjectMail: Text;
        SendFromName: Text[100];
    begin
        //Sender Name
        CompanyInfo.GET();
        SendFromName := CompanyInfo.Name;

        //Sender Email Address
        GeneralSetup.GET();
        GeneralSetup.TESTFIELD("Sender Email Payment Advice");
        SendFromAddress := GeneralSetup."Sender Email Payment Advice";

        //Get All Vendors to Send Payment Advices
        GenJournalLine.SETRANGE("Journal Template Name", _JournalTemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", _JournalBatchName);
        GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::Vendor);
        IF NOT GenJournalLine.ISEMPTY THEN BEGIN
            GenJournalLine.FINDSET();
            REPEAT
                IF GenJournalLine."Account No." <> '' THEN BEGIN
                    TempVendor."No." := GenJournalLine."Account No.";
                    IF TempVendor.INSERT() THEN;
                END;
            UNTIL GenJournalLine.NEXT() = 0;
        END;

        TempVendor.RESET();

        IF NOT TempVendor.ISEMPTY THEN BEGIN
            IF GUIALLOWED THEN BEGIN
                RecordNumber := TempVendor.COUNT;
                ProgressionDialog.OPEN(Text001);
            END;

            TempVendor.FINDSET();
            REPEAT
                IF GUIALLOWED THEN BEGIN
                    Counter += 1;
                    ProgressionDialog.UPDATE(1, TempVendor."No.");
                    ProgressionDialog.UPDATE(2, ROUND(Counter / RecordNumber * 10000, 1));
                END;

                //Receipt Email Address
                Vendor.GET(TempVendor."No.");
                Vendor.TESTFIELD("E-Mail");
                SendToAddress := Vendor."E-Mail";

                //Mail Subject and Body-Text
                GetMailSubjectAndBodyFromModel(Vendor."DEL Email Payment Advice", Vendor."Language Code", SubjectMail, MailBody);

                //Create PDF file
                SavePDF(_JournalTemplateName, _JournalBatchName, Vendor."No.", ServerFile);

                //Send mail
                //TODO // IF EXISTS(ServerFile) THEN
                if ServerFile <> '' then
                    SendMail(SendToAddress, SubjectMail, MailBody, ServerFile, STRSUBSTNO(FileNameLbl, Vendor."No."), ''); //TODO a voir le contentType si necessaire 
            UNTIL TempVendor.NEXT() = 0;
            IF GUIALLOWED THEN
                ProgressionDialog.CLOSE();
            MESSAGE(Text002);
        END;
    end;

    local procedure SendSMTPmail(_SenderName: Text; _SenderAddress: Text; _Recipients: Text;
    _Subject: Text; _Body: Text; _AttachementFullPathFileName: Text; _FileName: Text)
    var
        //TODO: à vérifier lors du test si on est besoin de mettre le sender name en parametre : j'ai dupliquer la fct 
        Email: codeunit "Email";
        MailMessage: Codeunit "Email Message";

    begin
        // SMTPMail.CreateMessage(_SenderName, _SenderAddress, _Recipients, _Subject, '', TRUE);
        MailMessage.Create(_Recipients, _Subject, '', TRUE);
        MailMessage.AppendToBody(_Body);
        //TODO: MailMessage.AddAttachment(_AttachementFullPathFileName, _FileName);
        Email.Send(MailMessage);

    end;

    local procedure SendMail(_Recipients: Text; _Subject: Text; _Body: Text; _AttachementFullPathFileName: Text[250]; _FileName: Text[250]; ContentType: text[250])
    var
        Email: codeunit "Email";
        MailMessage: Codeunit "Email Message";
    begin
        MailMessage.Create(_Recipients, _Subject, '', true);
        MailMessage.AppendToBody(_Body);
        MailMessage.AddAttachment(_AttachementFullPathFileName, _FileName, ContentType);
        Email.Send(MailMessage);
    end;

    local procedure GetMailSubjectAndBodyFromModel(EmailCode: Code[20]; LanguageCode: Code[10]; var MySubject: Text; var TextBody: Text)
    var
        DocMatrixEmailCodes: Record "DEL DocMatrix Email Codes";
        GeneralSetup: Record "DEL General Setup";
    begin
        IF EmailCode = '' THEN BEGIN
            GeneralSetup.GET();
            GeneralSetup.TESTFIELD("Default Email Template");
            EmailCode := GeneralSetup."Default Email Template";
        END;

        DocMatrixEmailCodes.SETRANGE(Code, EmailCode);
        IF LanguageCode = '' THEN BEGIN
            DocMatrixEmailCodes.SETRANGE("Language Code", '');
            IF NOT DocMatrixEmailCodes.FIND() THEN
                EXIT;
        END ELSE BEGIN
            DocMatrixEmailCodes.SETRANGE("Language Code", LanguageCode);
            IF NOT DocMatrixEmailCodes.FINDSET() THEN BEGIN
                DocMatrixEmailCodes.SETRANGE("All Language Codes", TRUE);
                DocMatrixEmailCodes.SETRANGE("Language Code", '');
                IF NOT DocMatrixEmailCodes.FINDSET() THEN
                    EXIT;
            END;
        END;

        MySubject := DocMatrixEmailCodes.Subject;
        TextBody := GetBody(DocMatrixEmailCodes);
    end;
    //TODO
    //----------- j'ai essayé de modifier la procedure GetBOdy : à valider !!----//
    local procedure GetBody(var DocMatrixEmailCodes: Record "DEL DocMatrix Email Codes"): Text
    var
        //TempBlob: Record "99008535" temporary; //ancien
        TempBlob: Codeunit "Temp Blob";
        //TempBlob: Record "99008535" temporary;
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
        CR: Text;
    begin
        DocMatrixEmailCodes.CALCFIELDS(Body);
        IF NOT DocMatrixEmailCodes.Body.HASVALUE THEN
            EXIT('');
        CR := '<p>';
        //   TempBlob.Blob := DocMatrixEmailCodes.Body; => code source
        //    EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::UTF8));   => code source
        TempBlob.FromRecord(DocMatrixEmailCodes, DocMatrixEmailCodes.FieldNo(Body));
        TempBlob.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.ReadAsTextWithSeparator(InStream, CR));
    end;


    procedure SavePDF(_JournalTemplateName: Code[10]; _JournalBatchName: Code[10]; _VendorNo: Code[20]; var _ServerAttachmentFilePath: Text)
    var
        CustRec: Record Customer;
        GenJournalLine: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        VendorPaymentAdvice: Report "DEL SR Vendor Pay. Advi. Detai";
        FileMgt: Codeunit "File Management";
        //---------
        TempBlob_lRec: Codeunit "Temp Blob";
        RecRef: RecordRef;
        BlobOutStream: OutStream;

    begin
        //TODO   // _ServerAttachmentFilePath := COPYSTR(FileMgt.ServerTempFileName('pdf'), 1, 250);

        GenJournalLine."Journal Template Name" := _JournalTemplateName;
        GenJournalLine."Journal Batch Name" := _JournalBatchName;
        Vendor.SETRANGE("No.", _VendorNo);
        VendorPaymentAdvice.SETTABLEVIEW(Vendor);
        VendorPaymentAdvice.DefineJourBatch(GenJournalLine);
        VendorPaymentAdvice.SkipMessage(TRUE);
        //TODO VendorPaymentAdvice.SAVEASPDF(_ServerAttachmentFilePath);  => code source
        /////--------- à corriger
        TempBlob_lRec.CreateOutStream(BlobOutStream, TEXTENCODING::UTF8);
        CustRec.SetRange(Blocked, Blocked::All);
        REPORT.SAVEAS(Report::"Customer - List", _ServerAttachmentFilePath, REPORTFORMAT::Pdf, BlobOutStream, RecRef);
        FileMgt.BLOBExport(TempBlob_lRec, 'pdf', TRUE);
    end;


    procedure DefineJourBatch(_GnlJourLine: Record "Gen. Journal Line")
    begin
        JournalBatchName := _GnlJourLine."Journal Batch Name";
        JournalTemplateName := _GnlJourLine."Journal Template Name";
    end;

}

