codeunit 50057 "Vendor Payment Advice Mgt."
{
    // MGTS10.00.06.00    | 07.01.2022 | Send Payment Advice : Create Object


    trigger OnRun()
    begin
    end;

    var
        JournalBatchName: Code[10];
        JournalTemplateName: Code[10];
        FileNameLbl: Label 'PaymentAdvice_%1.pdf';
        Text001: Label 'Vendor : ##################1################## \\ @@@@@@@@@@@@@@@@@@2@@@@@@@@@@@@@@@@@@';
        Text002: Label 'Processing completed !';

    [Scope('Internal')]
    procedure SendPaymentAdvice(_JournalTemplateName: Code[10]; _JournalBatchName: Code[10])
    var
        Cst001: Label 'We must add a e email template';
        GenJournalLine: Record "81";
        TempVendor: Record "23" temporary;
        Vendor: Record "23";
        CompanyInfo: Record "79";
        GeneralSetup: Record "50000";
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
                GetMailSubjectAndBodyFromModel(Vendor."Email Payment Advice", Vendor."Language Code", SubjectMail, MailBody);

                //Create PDF file
                SavePDF(_JournalTemplateName, _JournalBatchName, Vendor."No.", ServerFile);

                //Send mail
                IF EXISTS(ServerFile) THEN
                    SendSMTPmail(SendFromName, SendFromAddress, SendToAddress, SubjectMail, MailBody, ServerFile, STRSUBSTNO(FileNameLbl, Vendor."No."));
            UNTIL TempVendor.NEXT = 0;

            IF GUIALLOWED THEN
                ProgressionDialog.CLOSE;
            MESSAGE(Text002);
        END;
    end;

    local procedure SendSMTPmail(_SenderName: Text; _SenderAddress: Text; _Recipients: Text; _Subject: Text; _Body: Text; _AttachementFullPathFileName: Text; _FileName: Text)
    var
        SMTPMail: Codeunit "400";
    begin
        SMTPMail.CreateMessage(_SenderName, _SenderAddress, _Recipients, _Subject, '', TRUE);
        SMTPMail.AppendBody(_Body);
        SMTPMail.AddAttachment(_AttachementFullPathFileName, _FileName);
        SMTPMail.Send;
    end;

    local procedure GetMailSubjectAndBodyFromModel(EmailCode: Code[20]; LanguageCode: Code[10]; var MySubject: Text; var TextBody: Text)
    var
        DocMatrixEmailCodes: Record "50070";
        GeneralSetup: Record "50000";
        BLOBInStream: InStream;
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

        // get the Subject text
        MySubject := DocMatrixEmailCodes.Subject;

        // extract the Body text from the BLOB
        TextBody := GetBody(DocMatrixEmailCodes);
    end;

    local procedure GetBody(var DocMatrixEmailCodes: Record "50070"): Text
    var
        TempBlob: Record "99008535" temporary;
        CR: Text;
    begin
        DocMatrixEmailCodes.CALCFIELDS(Body);
        IF NOT DocMatrixEmailCodes.Body.HASVALUE THEN
            EXIT('');
        CR := '<p>';
        //CR[2] := 10;
        TempBlob.Blob := DocMatrixEmailCodes.Body;
        EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::UTF8));
    end;

    [Scope('Internal')]
    procedure SavePDF(_JournalTemplateName: Code[10]; _JournalBatchName: Code[10]; _VendorNo: Code[20]; var _ServerAttachmentFilePath: Text)
    var
        lErr001: Label 'Not able to save PDF %1. \\ERROR: %2';
        Vendor: Record "23";
        GenJournalLine: Record "81";
        FileMgt: Codeunit "419";
        VendorPaymentAdvice: Report "50035";
    begin
        _ServerAttachmentFilePath := COPYSTR(FileMgt.ServerTempFileName('pdf'), 1, 250);

        GenJournalLine."Journal Template Name" := _JournalTemplateName;
        GenJournalLine."Journal Batch Name" := _JournalBatchName;

        Vendor.SETRANGE("No.", _VendorNo);
        VendorPaymentAdvice.SETTABLEVIEW(Vendor);
        VendorPaymentAdvice.DefineJourBatch(GenJournalLine);
        VendorPaymentAdvice.SkipMessage(TRUE);
        VendorPaymentAdvice.SAVEASPDF(_ServerAttachmentFilePath);
    end;

    [Scope('Internal')]
    procedure DefineJourBatch(_GnlJourLine: Record "81")
    begin
        JournalBatchName := _GnlJourLine."Journal Batch Name";
        JournalTemplateName := _GnlJourLine."Journal Template Name";
    end;
}

