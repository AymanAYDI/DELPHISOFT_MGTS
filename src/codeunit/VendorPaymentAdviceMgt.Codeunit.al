codeunit 50057 "DEL Vendor Payment Advice Mgt."
{

    var
        JournalBatchName: Code[10];
        JournalTemplateName: Code[10];
        FileNameLbl: Label 'PaymentAdvice_%1.pdf';
        Text001: Label 'Vendor : ##################1################## \\ @@@@@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@@@@';
        Text002: Label 'Processing completed !';


    procedure SendPaymentAdvice(_JournalTemplateName: Code[10]; _JournalBatchName: Code[10])
    var

        GenJournalLine: Record "Gen. Journal Line";
        TempVendor: Record Vendor temporary;
        Vendor: Record Vendor;
        CompanyInfo: Record "Company Information";
        GeneralSetup: Record "DEL General Setup";
        SendFromName: Text;
        SendFromAddress: Text;
        SendToAddress: Text;
        SubjectMail: Text;
        MailBody: Text;
        ServerFile: Text;
        RecordNumber: Integer;
        Counter: Integer;
        ProgressionDialog: Dialog;
    begin
        //Sender Name
        CompanyInfo.GET;
        SendFromName := CompanyInfo.Name;

        //Sender Email Address
        GeneralSetup.GET;
        GeneralSetup.TESTFIELD("Sender Email Payment Advice");
        SendFromAddress := GeneralSetup."Sender Email Payment Advice";

        //Get All Vendors to Send Payment Advices
        GenJournalLine.SETRANGE("Journal Template Name", _JournalTemplateName);
        GenJournalLine.SETRANGE("Journal Batch Name", _JournalBatchName);
        GenJournalLine.SETRANGE("Document Type", GenJournalLine."Document Type"::Payment);
        GenJournalLine.SETRANGE("Account Type", GenJournalLine."Account Type"::Vendor);
        IF NOT GenJournalLine.ISEMPTY THEN BEGIN
            GenJournalLine.FINDSET;
            REPEAT
                IF GenJournalLine."Account No." <> '' THEN BEGIN
                    TempVendor."No." := GenJournalLine."Account No.";
                    IF TempVendor.INSERT THEN;
                END;
            UNTIL GenJournalLine.NEXT = 0;
        END;

        TempVendor.RESET;

        IF NOT TempVendor.ISEMPTY THEN BEGIN
            IF GUIALLOWED THEN BEGIN
                RecordNumber := TempVendor.COUNT;
                ProgressionDialog.OPEN(Text001);
            END;

            TempVendor.FINDSET;
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
                IF EXISTS(ServerFile) THEN
                    SendSMTPmail(SendFromName, SendFromAddress, SendToAddress, SubjectMail, MailBody, ServerFile, STRSUBSTNO(FileNameLbl, Vendor."No."));
            UNTIL TempVendor.NEXT = 0;

            IF GUIALLOWED THEN
                ProgressionDialog.CLOSE();
            MESSAGE(Text002);
        END;
    end;

    // local procedure SendSMTPmail(_SenderName: Text; _SenderAddress: Text; _Recipients: Text; _Subject: Text; _Body: Text; _AttachementFullPathFileName: Text; _FileName: Text)
    // var
    //     //TODO: à vérifier
    //     SMTPMail: Codeunit "Email Message";
    // begin
    //    // SMTPMail.CreateMessage(_SenderName, _SenderAddress, _Recipients, _Subject, '', TRUE);
    //    SMTPMail.Create(_SenderName, _SenderAddress, _Recipients, _Subject, '', TRUE);
    //     SMTPMail.AppendBody(_Body);
    //     SMTPMail.AddAttachment(_AttachementFullPathFileName, _FileName);
    //     SMTPMail.Send;
    // end;
    local procedure SendSMTPmail(_SenderName: List of [Text]; _SenderAddress: Text;
    _Recipients: Text; _Subject: Text; _Body: Text; _AttachementFullPathFileName: List of [Text]; _FileName: Text)
    var

        SMTPMail: Codeunit "Email Message";
    begin
        SMTPMail.Create(_SenderName, _SenderAddress, _Recipients, _Subject, '', TRUE);

        SMTPMail.AppendToBody(_Body);
        //TODO SMTPMail.AddAttachment(_AttachementFullPathFileName, _FileName);
        //TODO SMTPMail.Send;
    end;

    local procedure GetMailSubjectAndBodyFromModel(EmailCode: Code[20]; LanguageCode: Code[10]; var MySubject: Text; var TextBody: Text)
    var
        DocMatrixEmailCodes: Record "DEL DocMatrix Email Codes";
        GeneralSetup: Record "DEL General Setup";

        I: Integer;
    begin
        IF EmailCode = '' THEN BEGIN
            GeneralSetup.GET;
            GeneralSetup.TESTFIELD("Default Email Template");
            EmailCode := GeneralSetup."Default Email Template";
        END;

        DocMatrixEmailCodes.SETRANGE(Code, EmailCode);
        IF LanguageCode = '' THEN BEGIN
            DocMatrixEmailCodes.SETRANGE("Language Code", '');
            IF NOT DocMatrixEmailCodes.FIND THEN
                EXIT;
        END ELSE BEGIN
            DocMatrixEmailCodes.SETRANGE("Language Code", LanguageCode);
            IF NOT DocMatrixEmailCodes.FINDSET THEN BEGIN
                DocMatrixEmailCodes.SETRANGE("All Language Codes", TRUE);
                DocMatrixEmailCodes.SETRANGE("Language Code", '');
                IF NOT DocMatrixEmailCodes.FINDSET THEN
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
        //TempBlob: Record "99008535" temporary;
        TypeHelper: Codeunit "Type Helper";
        TempBlob: Codeunit "Temp Blob";
        InStream: InStream;

        CR: Text;
    begin
        DocMatrixEmailCodes.CALCFIELDS(Body);
        IF NOT DocMatrixEmailCodes.Body.HASVALUE THEN
            EXIT('');
        CR := '<p>';
        //   TempBlob.Blob := DocMatrixEmailCodes.Body; => code source
        //    EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::UTF8));
        TempBlob.FromRecord(DocMatrixEmailCodes, DocMatrixEmailCodes.FieldNo(Body));
        TempBlob.CreateInStream(InStream, TEXTENCODING::UTF8);

        exit(TypeHelper.ReadAsTextWithSeparator(InStream, CR));

    end;


    procedure SavePDF(_JournalTemplateName: Code[10]; _JournalBatchName: Code[10]; _VendorNo: Code[20]; var _ServerAttachmentFilePath: Text)
    var

        Vendor: Record Vendor;
        GenJournalLine: Record "Gen. Journal Line";
        FileMgt: Codeunit "File Management";
        VendorPaymentAdvice: Report "DEL SR Vendor Pay. Advi. Detai";
    begin
        //TODO     _ServerAttachmentFilePath := COPYSTR(FileMgt.ServerTempFileName('pdf'), 1, 250);

        GenJournalLine."Journal Template Name" := _JournalTemplateName;
        GenJournalLine."Journal Batch Name" := _JournalBatchName;

        Vendor.SETRANGE("No.", _VendorNo);
        VendorPaymentAdvice.SETTABLEVIEW(Vendor);
        VendorPaymentAdvice.DefineJourBatch(GenJournalLine);
        VendorPaymentAdvice.SkipMessage(TRUE);
        //TODO       VendorPaymentAdvice.SAVEASPDF(_ServerAttachmentFilePath);
    end;


    procedure DefineJourBatch(_GnlJourLine: Record "Gen. Journal Line")
    begin
        JournalBatchName := _GnlJourLine."Journal Batch Name";
        JournalTemplateName := _GnlJourLine."Journal Template Name";
    end;
}

