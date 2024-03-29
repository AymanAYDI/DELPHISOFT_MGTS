codeunit 50015 "DEL DocMatrix Management" //TODO
{
    trigger OnRun()
    begin
    end;

    var
        lcuProgressBar: Codeunit "DEL LogiProgressBar";
        FileManagement: Codeunit "File Management";
        Err001: Label 'The Sales Order %1 has no Contact assigend!';
        Err002: Label 'The Contact %1 in the Sales Order %2 has no Email Address!';


    procedure ShowDocMatrixSelection(pNo: Code[20]; pProcessType: Enum "DEL Process Type";
     pUsage: Integer; var precDocMatrixSelection: Record "DEL DocMatrix Selection";
     pPrintOnly: Boolean): Boolean
    var
        lpgDocMatrixSelection: Page "DEL DocMatrix Selection Card";
        lType: Enum "Credit Transfer Account Type";
        lErr001: Label 'There is no Document Matrix Configuration available for"%1".';
    begin
        IF CreateDocMatrixSelection(pNo, pProcessType, pUsage, precDocMatrixSelection, pPrintOnly) THEN BEGIN

            lpgDocMatrixSelection.LOOKUPMODE(TRUE);
            lpgDocMatrixSelection.SETRECORD(precDocMatrixSelection);
            lpgDocMatrixSelection.SetPostVisible((pUsage IN [1, 3]) AND (NOT pPrintOnly));  // 1 = S.Order
            IF lpgDocMatrixSelection.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                lpgDocMatrixSelection.GETRECORD(precDocMatrixSelection);
                EXIT(TRUE);
            END ELSE
                EXIT(FALSE);

        END ELSE BEGIN
            lType := GetTypeWithUsage(pUsage);
            ERROR(lErr001, FORMAT(lType), GetCustVendName(lType, pNo));
        END;
    end;

    procedure ProcessDocumentMatrix(pUsage: Integer; pProcessType: Enum "DEL Process Type";
    pRecordVariant: Variant; pFieldNo: Integer; pFieldDocNo: Integer;
     precDocMatrixSelection: Record "DEL DocMatrix Selection"; pFieldPurchCode: Integer)
    var
        lcuDocMatrixSingleInstance: Codeunit "DEL DocMatrix SingleInstance";
        FileManagementL: Codeunit "File Management";
        lboDeleteFileAtTheEnd: Boolean;
        lPurchCode: Code[10];
        lDocNo: Code[20];
        lNo: Code[20];
        lType: Enum "Credit Transfer Account Type";
        lAction: Enum "DEL Action100";
        lErr001: Label 'A unexpected problem with the parameter for the function "ProcessDocumentMatrix" occured.';
        lErrPrint: Text;
        ltxClientFile: Text;
        ltxClientPath: Text;
        ltxServerFile: Text;
    begin
        CLEAR(ltxClientFile);
        CLEAR(ltxServerFile);
        CLEAR(ltxClientPath);
        CLEAR(lNo);
        CLEAR(lboDeleteFileAtTheEnd);

        lcuProgressBar.FNC_ProgressBar_Init(1, 100, 1000, 'Process documents...', 6);

        lcuDocMatrixSingleInstance.SetDocumentMatrixProcessActive(TRUE);

        GetParameters(pUsage, pRecordVariant, pFieldNo, pFieldDocNo, lType, lNo, lDocNo, pFieldPurchCode, lPurchCode);

        IF (lNo <> '') AND (lDocNo <> '') THEN BEGIN

            FilterRecToProcessedDocument(pUsage, pRecordVariant, lDocNo, pFieldDocNo);

            CreatePathAndFileName(pUsage, lNo, lDocNo + '-' + GetReportName(GetReportIDWithUsage(pUsage)), ltxClientFile, ltxServerFile, ltxClientPath, FALSE, lPurchCode);

            IF ltxClientFile <> '' THEN
                SavePDF(pUsage, pRecordVariant, ltxClientFile, ltxServerFile);
            lcuProgressBar.FNC_ProgressBar_Update(1);

            IF CheckDocumentMatrixSelection(lAction::Save, precDocMatrixSelection) THEN
                LogAction(lAction::Save, lDocNo, precDocMatrixSelection, FALSE, '')
            ELSE
                lboDeleteFileAtTheEnd := TRUE;

            lcuProgressBar.FNC_ProgressBar_Update(1);

            IF CheckDocumentMatrixSelection(lAction::Print, precDocMatrixSelection) THEN BEGIN
                IF ltxClientFile <> '' THEN BEGIN
                    lErrPrint := SilentPrint(pUsage, ltxClientFile);
                    LogAction(lAction::Print, lDocNo, precDocMatrixSelection, lErrPrint <> '', '');
                END;
            END;

            // Progress Bar
            lcuProgressBar.FNC_ProgressBar_Update(1);

            // Mail
            IF CheckDocumentMatrixSelection(lAction::Mail, precDocMatrixSelection) THEN
                ProcessMail(pUsage, pProcessType, lAction::Mail, lNo, lDocNo, precDocMatrixSelection, ltxClientFile, pRecordVariant);

            // Progress Bar
            lcuProgressBar.FNC_ProgressBar_Update(1);

            // FTP1
            IF CheckDocumentMatrixSelection(lAction::FTP1, precDocMatrixSelection) THEN
                ProcessFTP(lAction::FTP1, lNo, lDocNo, precDocMatrixSelection, ltxClientFile);

            // Progress Bar
            lcuProgressBar.FNC_ProgressBar_Update(1);

            // FTP2
            IF CheckDocumentMatrixSelection(lAction::FTP2, precDocMatrixSelection) THEN
                ProcessFTP(lAction::FTP2, lNo, lDocNo, precDocMatrixSelection, ltxClientFile);

            // Progress Bar
            lcuProgressBar.FNC_ProgressBar_Update(1);

            // delete file if "Save PDF" is not active
            //TODO IF lboDeleteFileAtTheEnd AND (ltxClientFile <> '') THEN
            //     FileManagement.DeleteClientFile(ltxClientFile);

        END ELSE BEGIN
            lcuDocMatrixSingleInstance.SetDocumentMatrixProcessActive(FALSE);
            ERROR(lErr001);
        END;

        // reset SingleInstance var
        lcuDocMatrixSingleInstance.SetDocumentMatrixProcessActive(FALSE);

        // close Progress Bar
        lcuProgressBar.FNC_ProgressBar_Close(1);
    end;

    procedure ProcessDocumentMatrixAutomatic(pUsage: Integer)
    var
        lrecCustomer: Record Customer;
        lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
        lrecDocMatrixSetup: Record "DEL DocMatrix Setup";
        lrecDocumentMatrix: Record "DEL Document Matrix";
        lboActionForStatement: Boolean;
        lNo: Code[20];
        lDate: Date;
        lAction: Enum "DEL Action100";
        lProcessType: Enum "DEL Process Type";
        lintLogID: Integer;
        lLastStatementNo: Integer;
        lReportID: Integer;
        lType: Integer;
        ltxClientFile: Text;
        lvarCustomer: Variant;
    begin
        lReportID := GetReportIDWithUsage(pUsage);
        lDate := TODAY;
        lType := GetTypeWithUsage(pUsage);
        lProcessType := lProcessType::Automatic;
        CLEAR(lintLogID);
        IF lrecDocMatrixSetup.GET() THEN BEGIN
            IF lrecDocMatrixSetup."Test Active" AND (lrecDocMatrixSetup."Statement Test Date" <> 0D) THEN
                lDate := lrecDocMatrixSetup."Statement Test Date";
        END;

        // get the report record from the Document Matrix
        lrecDocumentMatrix.SETAUTOCALCFIELDS("Request Page Parameters");
        lrecDocumentMatrix.SETRANGE(Usage, pUsage);
        lrecDocumentMatrix.SETRANGE("Process Type", lProcessType);
        lrecDocumentMatrix.SETRANGE(Type, GetTypeWithUsage(pUsage));
        IF lrecDocumentMatrix.FINDSET() THEN BEGIN

            REPEAT

                // init
                CLEAR(lboActionForStatement);
                // create the "Document Matrix Selection" record, in order to pass it to other functions like "SendMail"
                // though here in the automatic process the user does not make a choice, so it is always the same as the main DocMatrix record
                CreateDocMatrixSelection(lrecDocumentMatrix."No.", lProcessType, pUsage, lrecDocMatrixSelection, FALSE);

                //the BLOB needs to contain the ReqPageParameter XML
                IF lrecDocumentMatrix."Request Page Parameters".HASVALUE THEN BEGIN

                    // since the report (currently only R116 is supported) must be executed for all customers, loop through all customers
                    lNo := lrecDocumentMatrix."No.";
                    IF lrecCustomer.GET(lNo) THEN BEGIN

                        // only execute the report, if the customer has statement values for TODAY (prevent empty PDF files)
                        IF CustomerHasStatmentRecords(lrecCustomer."No.", lDate) THEN BEGIN

                            // create the Statement PDF for each available customer in the Document Matrix
                            ltxClientFile := CreateStatementPDFforCustomer(lrecDocumentMatrix, pUsage, lrecCustomer."No.", lrecCustomer.FIELDNO("No."), lReportID, lDate, lLastStatementNo, lvarCustomer);

                            // Print is not supported in automatic mode, because this function is called from the Taskscheduler on the Server

                            // Mail
                            IF CheckDocumentMatrixSelection(lAction::Mail, lrecDocMatrixSelection) THEN
                                lboActionForStatement := ProcessMail(pUsage, lProcessType, lAction::Mail, lNo, FORMAT(lLastStatementNo), lrecDocMatrixSelection, ltxClientFile, lvarCustomer);

                            IF CheckDocumentMatrixSelection(lAction::FTP1, lrecDocMatrixSelection) THEN
                                lboActionForStatement := ProcessFTP(lAction::FTP1, lNo, FORMAT(lLastStatementNo), lrecDocMatrixSelection, ltxClientFile);

                            IF CheckDocumentMatrixSelection(lAction::FTP2, lrecDocMatrixSelection) THEN
                                lboActionForStatement := ProcessFTP(lAction::FTP2, lNo, FORMAT(lLastStatementNo), lrecDocMatrixSelection, ltxClientFile);

                            // log error that the customer was processed, but had no Action assigned
                            IF NOT lboActionForStatement THEN
                                LogAction(lAction::JobQueueEntry, '', lrecDocMatrixSelection, TRUE, 'No Action');

                        END ELSE  // CustomerHasStatmentRecords

                            // log action that the customer was processed, but had no statement to send
                            LogAction(lAction::JobQueueEntry, '', lrecDocMatrixSelection, FALSE, 'No Statement Records found for ' + FORMAT(lDate));


                    END;

                END ELSE BEGIN
                    LogAction(lAction::JobQueueEntry, '', lrecDocMatrixSelection, TRUE, 'No Request Page found');
                END;

            UNTIL lrecDocumentMatrix.NEXT() = 0;

        END;
    end;

    local procedure CheckDocumentMatrixSelection(pAction: Enum "DEL Action100"; precDocMatrixSelection: Record "DEL DocMatrix Selection"): Boolean
    begin
        CASE pAction OF
            pAction::Print:
                EXIT(precDocMatrixSelection."Print PDF");
            pAction::Save:
                EXIT(precDocMatrixSelection."Save PDF");
            pAction::Mail:
                EXIT((precDocMatrixSelection."E-Mail To 1" <> '') OR (precDocMatrixSelection."E-Mail To 2" <> '') OR (precDocMatrixSelection."E-Mail To 3" <> ''));
            pAction::FTP1:
                EXIT(precDocMatrixSelection."Send to FTP 1");
            pAction::FTP2:
                EXIT(precDocMatrixSelection."Send to FTP 2");
        END;
    end;

    local procedure CheckDocumentMatrix(pAction: Enum "DEL Action100"; pType: Enum "Credit Transfer Account Type"; pNo: Code[20]; pProcessType: Enum "DEL Process Type"; pUsage: Integer): Boolean
    var
        DocumentMatrix: Record "DEL Document Matrix";
    begin
        DocumentMatrix.RESET();
        DocumentMatrix.SETRANGE(Type, pType);
        DocumentMatrix.SETRANGE("No.", pNo);
        DocumentMatrix.SETRANGE("Process Type", pProcessType);
        DocumentMatrix.SETRANGE(Usage, pUsage);
        IF DocumentMatrix.FINDFIRST() THEN BEGIN
            CASE pAction OF
                pAction::Print:
                    EXIT(DocumentMatrix."Print PDF");
                pAction::Save:
                    EXIT(DocumentMatrix."Save PDF");
                pAction::Mail:
                    EXIT((DocumentMatrix."E-Mail To 1" <> '') OR (DocumentMatrix."E-Mail To 2" <> '') OR (DocumentMatrix."E-Mail To 3" <> ''));
                pAction::FTP1:
                    EXIT(DocumentMatrix."Send to FTP 1");
                pAction::FTP2:
                    EXIT(DocumentMatrix."Send to FTP 2");
            END;
        END;
    end;

    procedure SavePDF(pUsage: Integer; pRecordVariant: Variant; ptxClientFile: Text; ptxServerFile: Text)
    var
        RecLReportSelections: Record "Report Selections";
        FileManagementL: Codeunit "File Management";
        tempBlob: Codeunit "temp Blob";
        RecRef: RecordRef;
        Out: OutStream;
    begin
        TempBlob.CreateOutStream(Out, TEXTENCODING::UTF8);
        RecLReportSelections.RESET();
        RecLReportSelections.SETRANGE(Usage, pUsage);
        IF RecLReportSelections.FINDSET() THEN
            IF RecLReportSelections.FINDFIRST() THEN BEGIN
                REPEAT
                    // REPORT.SAVEASPDF(RecLReportSelections."Report ID", ptxServerFile, pRecordVariant); // TODO: ancient code
                    REPORT.SAVEAS(RecLReportSelections."Report ID", '', REPORTFORMAT::Pdf, Out, RecRef);
                    FileManagementL.BLOBExport(TempBlob, ptxServerFile, TRUE);
                    ManageFilesAfterProcess(ptxClientFile, ptxServerFile);
                    Clear(Out);
                UNTIL RecLReportSelections.NEXT() = 0;
            END;
    end;

    local procedure SilentPrint(pUsage: Integer; ptxClientFile: Text): Text
    var
        lErr001: Label 'Not able to print %1. \\ERROR: %2';
    begin
        //TODO IF NOT TrySilentPrint(pUsage, ptxClientFile) THEN
        //     EXIT(STRSUBSTNO(lErr001, ptxClientFile, GETLASTERRORTEXT));
    end;

    //[TryFunction]
    // TODO/ dotnet local procedure TrySilentPrint(pUsage: Integer; ptxClientPath: Text)
    // var
    //     [RunOnClient]
    //     ProcessStartInfo: DotNet ProcessStartInfo;
    //     [RunOnClient]
    //     ProcessWindowStyle: DotNet ProcessWindowStyle;
    //     [RunOnClient]
    //     Process: DotNet Process;
    //     AppMgt: Codeunit 1;
    //     ltxPrinterName: Text;
    // begin
    //     IF ISNULL(ProcessStartInfo) THEN
    //         ProcessStartInfo := ProcessStartInfo.ProcessStartInfo;
    //     ProcessStartInfo.UseShellExecute := TRUE;
    //     ProcessStartInfo.Verb := 'print';
    //     ProcessStartInfo.WindowStyle := ProcessWindowStyle.Hidden;
    //     ltxPrinterName := AppMgt.FindPrinter(GetReportIDWithUsage(pUsage));
    //     //ToDo: what happens if no printer is defined in printer selection?
    //     ProcessStartInfo.Arguments := ltxPrinterName;
    //     ProcessStartInfo.FileName := ptxClientPath;
    //     Process.Start(ProcessStartInfo);
    // end;

    local procedure ProcessMail(pUsage: Integer; pProcessType: Enum "DEL Process Type"; pAction: Enum "DEL Action100"; pNo: Code[20]; pDocNo: Code[20]; precDocMatrixSelection: Record "DEL DocMatrix Selection"; ptxClientFile: Text; pRecordVariant: Variant): Boolean
    var
        lintLogID: Integer;
        lErr002: Label 'There is no Attachement File available to send by Email.';
    begin
        CLEAR(lintLogID);
        IF ptxClientFile <> '' THEN BEGIN
            lintLogID := LogAction(pAction, pDocNo, precDocMatrixSelection, TRUE, '');
            SendMail(pUsage, pProcessType, pRecordVariant, pNo, ptxClientFile, precDocMatrixSelection, pDocNo);
            LogActionUpdateErrorStatus(lintLogID, FALSE, '');
        END ELSE
            LogActionUpdateErrorStatus(lintLogID, TRUE, lErr002);

        // this function always returns TRUE for automatic precess, manual process does not need the return value
        EXIT(TRUE);
    end;


    procedure SendMail(pUsage: Integer; pProcessType: Enum "DEL Process Type"; pRecordVariant: Variant; pNo: Code[20]; ptxAttachementFullPathFileName: Text; precDocMatrixSelection: Record "DEL DocMatrix Selection"; pDocNo: Code[20])
    var
        lrecCompanyInformation: Record "Company Information";
        lcuDocMatrixSingleInstance: Codeunit "DEL DocMatrix SingleInstance";
        larrMailBody: array[10] of Text;
        ltxSubjectMail: Text;
        txSendFromAddress: Text;
        txSendFromName: Text;
        txSendToAddress: Text;
    begin
        // this is the Name for the sender Email
        IF lrecCompanyInformation.GET() THEN;
        txSendFromName := lrecCompanyInformation.Name;

        // get the Email Address "To" from Document Matrix
        txSendToAddress := GetReciverMailAddressStringFromDocMxSel(precDocMatrixSelection, pDocNo);

        // get the Email Address "From" from Document Matrix
        txSendFromAddress := GetSenderMailAddressStringFromDocMxSel(precDocMatrixSelection);

        // put the "Send From Address" in a single instance variable, will be retrieved in function Cu260.EmailFile
        lcuDocMatrixSingleInstance.SetSendFromAddress(txSendFromAddress);

        // get the Mail Subject and Body-Text from the "DocMatrix Email Codes" table
        GetMailSubjectAndBodyFromMatrix(precDocMatrixSelection, larrMailBody, ltxSubjectMail);

        // insert values if place holders are defined in the Mail Subject
        ReplacePlaceHoldersWithValues(ltxSubjectMail, pRecordVariant, pUsage);

        // send the mail
        SendSMTPmail(txSendFromName, txSendFromAddress, txSendToAddress, ltxSubjectMail, ptxAttachementFullPathFileName, larrMailBody);

        // reset single instance var
        lcuDocMatrixSingleInstance.SetSendFromAddress('');

    end;

    local procedure ReplacePlaceHoldersWithValues(var ptxSubjectMail: Text; pRecordVariant: Variant; pUsage: Integer)
    var
        i: Integer;
        lPos: Integer;
        larrMailPlaceHolderValues: array[4] of Text;
    begin
        //first fill the array with all the available values
        FillMailPlaceHolderArray(larrMailPlaceHolderValues, pRecordVariant, pUsage);

        // now replace the percentage place holders with the values
        FOR i := 1 TO ARRAYLEN(larrMailPlaceHolderValues) DO BEGIN
            lPos := STRPOS(ptxSubjectMail, '%' + FORMAT(i));
            IF lPos <> 0 THEN
                IF lPos = 1 THEN
                    ptxSubjectMail := larrMailPlaceHolderValues[i] + COPYSTR(ptxSubjectMail, lPos + 2)
                ELSE
                    ptxSubjectMail := COPYSTR(ptxSubjectMail, 1, lPos - 1) + larrMailPlaceHolderValues[i] + COPYSTR(ptxSubjectMail, lPos + 2);
        END;
    end;

    local procedure FillMailPlaceHolderArray(var parrMailPlaceHolderValues: array[4] of Text; pRecordVariant: Variant; pUsage: Integer)
    var
        lrecCompanyInformation: Record "Company Information";
        lrecSalesHeader: Record "Sales Header";
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        // get Company Name
        IF lrecCompanyInformation.GET() THEN;
        parrMailPlaceHolderValues[1] := lrecCompanyInformation.Name;

        CASE pUsage OF
            //Sales Order
            1:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(lrecSalesHeader.FIELDNO("Sell-to Customer No."));
                    parrMailPlaceHolderValues[2] := FieldRef.VALUE;
                    FieldRef := RecRef.FIELD(lrecSalesHeader.FIELDNO("External Document No."));
                    parrMailPlaceHolderValues[3] := FieldRef.VALUE;
                    FieldRef := RecRef.FIELD(lrecSalesHeader.FIELDNO("Your Reference"));
                    parrMailPlaceHolderValues[4] := FieldRef.VALUE;
                END;
            //Sales Invoice
            2:
                BEGIN

                END;
            //Sales Credit Memo
            3:
                BEGIN

                END;
            //Purchase Order
            6:
                BEGIN

                END;
            //Purchase Invoice
            7:
                BEGIN

                END;
            //Customer Statement
            85:
                BEGIN

                END;
        END;

    end;

    local procedure SendSMTPmail(ptxFromAddressName: Text; ptxFromAddressString: Text; ptxToAddressString: Text; ptxSubject: Text; txAttachementFullPathFileName: Text; larrMailBody: array[10] of Text)
    var
        Email: Codeunit Email;
        lcuSMTP: Codeunit "Email Message";
        i: Integer;
    begin
        lcuSMTP.Create(ptxToAddressString, ptxSubject, '', TRUE);
        FOR i := 1 TO ARRAYLEN(larrMailBody) DO
            lcuSMTP.AppendToBody('<p>' + larrMailBody[i] + '</p>');
        Email.Send(lcuSMTP);
    end;

    local procedure ProcessFTP(pAction: Enum "DEL Action100"; pNo: Code[20]; pDocNo: Code[20]; precDocMatrixSelection: Record "DEL DocMatrix Selection"; ptxClientFile: Text): Boolean
    var
        lboFTPsuccessful: Boolean;
        lintLogID: Integer;
        ltxFTPResultDescr: Text;
    begin
        CLEAR(lintLogID);
        lintLogID := LogAction(pAction, pDocNo, precDocMatrixSelection, TRUE, '');
        lboFTPsuccessful := FTPProcessFile(pAction, ptxClientFile, pNo, ltxFTPResultDescr);
        LogActionUpdateErrorStatus(lintLogID, NOT (lboFTPsuccessful), ltxFTPResultDescr);

        // this function always returns TRUE for automatic precess, manual process does not need the return value
        EXIT(TRUE);
    end;

    local procedure FTPProcessFile(pAction: Enum "DEL Action100"; ptxFullPathFileName: Text; pCustNo: Code[20]; var pDescription: Text): Boolean
    var
        lrecFTPCustomer: Record "DEL DocMatrix Customer FTP";
        lboTransferSucessful: Boolean;
        lText001: Label 'The FTP setup for the customer %1 is missing.';
        lText002: Label 'There is no file to transfer.';
    begin
        // first check if there is a file to transfer
        IF ptxFullPathFileName = '' THEN BEGIN
            pDescription := lText002;
            EXIT(FALSE);
        END;

        // then check if a FTP configuration for the customer is available, and upload the file if yes
        IF lrecFTPCustomer.GET(pCustNo) THEN BEGIN
            CASE pAction OF
                pAction::FTP1:
                    BEGIN
                        IF (lrecFTPCustomer."FTP1 Server" = '') AND (lrecFTPCustomer."FTP1 UserName" = '') AND (lrecFTPCustomer."FTP1 Password" = '') THEN BEGIN
                            pDescription := STRSUBSTNO(lText001, pCustNo);
                            EXIT(FALSE);
                        END ELSE BEGIN
                            pDescription := UploadFileToFTP(lrecFTPCustomer."FTP1 Server", lrecFTPCustomer."FTP1 UserName", lrecFTPCustomer."FTP1 Password", ptxFullPathFileName, lboTransferSucessful);
                            EXIT(lboTransferSucessful);
                        END;
                    END;
                pAction::FTP2:
                    BEGIN
                        IF (lrecFTPCustomer."FTP2 Server" = '') AND (lrecFTPCustomer."FTP2 UserName" = '') AND (lrecFTPCustomer."FTP2 Password" = '') THEN BEGIN
                            pDescription := STRSUBSTNO(lText001, pCustNo);
                            EXIT(FALSE);
                        END ELSE BEGIN
                            pDescription := UploadFileToFTP(lrecFTPCustomer."FTP2 Server", lrecFTPCustomer."FTP2 UserName", lrecFTPCustomer."FTP2 Password", ptxFullPathFileName, lboTransferSucessful);
                            EXIT(lboTransferSucessful);
                        END;
                    END;
            END;
        END;
    end;

    local procedure UploadFileToFTP(ptxFTPServer: Text; ptxFTPUser: Text; ptxFTPPassword: Text; ptxFullPathFileName: Text; var pTransferSucessful: Boolean): Text
    var
        lErr001: Label 'Not able to make FTP connection. ERROR: %2';
        lStatusDescription: Text;
    begin
        //TODO IF NOT TryUploadFileToFTP(ptxFTPServer, ptxFTPUser, ptxFTPPassword, ptxFullPathFileName, lStatusDescription) THEN BEGIN
        //     pTransferSucessful := FALSE;
        //     EXIT(COPYSTR(STRSUBSTNO(lErr001, ptxFullPathFileName, GETLASTERRORTEXT), 1, 250))
        // END ELSE BEGIN
        //     pTransferSucessful := TRUE;
        //     EXIT(lStatusDescription);
        // END;
    end;

    // [TryFunction]
    //TODO local procedure TryUploadFileToFTP(ptxFTPServer: Text; ptxFTPUser: Text; ptxFTPPassword: Text; ptxFullPathFileName: Text; var pStatusDescription: Text)
    // var
    //     FTPWebRequest: DotNet FtpWebRequest;
    //     FTPWebResponse: DotNet FtpWebResponse;
    //     NetworkCredential: DotNet NetworkCredential;
    //     WebRequestMethods: DotNet WebRequestMethods_File;
    //     UTF8Encoding: DotNet UTF8Encoding;
    //     ResponseStream: InStream;
    //     FileStream: DotNet FileStream;
    //     Stream: DotNet Stream;
    //     FileDotNet: DotNet File;
    //     TempBlob: Record "99008535" temporary;
    //     FileName: Text;
    //     OutStream: OutStream;
    //     [RunOnClient]
    //     SearchOption: DotNet SearchOption;
    //     i: Integer;
    //     RelativeServerPath: Text;
    //     [RunOnClient]

    //     ClientFilePath: DotNet String;
    //     PathHelper: DotNet Path;
    // begin
    //     FTPWebRequest := FTPWebRequest.Create(ptxFTPServer + '/' + PathHelper.GetFileName(ptxFullPathFileName));
    //     FTPWebRequest.Credentials := NetworkCredential.NetworkCredential(ptxFTPUser, ptxFTPPassword);
    //     FTPWebRequest.UseBinary := TRUE;
    //     FTPWebRequest.UsePassive := TRUE;
    //     FTPWebRequest.KeepAlive := TRUE;
    //     FTPWebRequest.Method := 'STOR';

    //     FileStream := FileDotNet.OpenRead(ptxFullPathFileName);
    //     Stream := FTPWebRequest.GetRequestStream();
    //     FileStream.CopyTo(Stream);
    //     Stream.Close;

    //     FTPWebResponse := FTPWebRequest.GetResponse();
    //     FTPWebResponse.Close();

    //     pStatusDescription := FTPWebResponse.StatusDescription;
    // end;

    local procedure CreateStatementPDFforCustomer(precDocMatrixReqPageChanged: Record "DEL Document Matrix"; pUsage: Integer; pCustNo: Code[20]; pFieldCustNo: Integer; pReportID: Integer; pDate: Date; var pLastStatementNo: Integer; var pvarCustomer: Variant): Text
    var
        TempBlob: Codeunit "Temp Blob";
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
        lPurchCodeDummy: Code[10];
        IStream: InStream;
        OStream: OutStream;
        ltxClientFile: Text;
        ltxClientPath: Text;
        ltxServerFile: Text;
        XmlParameters: Text;
    begin
        // init
        XmlParameters := '';

        // define the Customer table as RecRef, so it can be passed to the report
        lRecRef.OPEN(DATABASE::Customer);
        lFieldRef := lRecRef.FIELD(pFieldCustNo);

        // change the the Date values in the Request Page Parameter to TODAY
        //precDocMatrixReqPageChanged := precDocMatrixChanged;
        ChangeRequestPageParameterForProcess(pDate, precDocMatrixReqPageChanged);

        // filter the RecRef to the porcessed customer (can not be done by changing ReqPageParameter)
        lFieldRef.SETRANGE(pCustNo);
        IF lRecRef.FINDFIRST() THEN
            pvarCustomer := lRecRef;

        // make use of all the fuzz, and get the Request Page Parameter
        precDocMatrixReqPageChanged."Request Page Parameters".CREATEINSTREAM(IStream, TEXTENCODING::UTF8);
        IStream.READTEXT(XmlParameters);

        // create the PDF file and OutStream for the report
        CreatePathAndFileName(pUsage, pCustNo, GetReportName(pReportID), ltxClientFile, ltxServerFile, ltxClientPath, TRUE, lPurchCodeDummy);
        // Content.CREATE(ltxClientFile);
        // Content.CREATEOUTSTREAM(OStream); // TODO: ancient code
        TempBlob.CreateOutStream(OStream, TEXTENCODING::UTF8);
        // finaly start the Report with the Request Page Parameter
        REPORT.SAVEAS(pReportID, XmlParameters, REPORTFORMAT::Pdf, OStream, pvarCustomer);
        Clear(OStream);
        // close file and RecRef vars
        // Content.CLOSE;
        lRecRef.CLOSE();

        // get the "Last Statement No." from the customer for R116 for the Log entry
        IF pReportID = REPORT::Statement THEN
            pLastStatementNo := GetLastStatementNoFromCust(pCustNo);

        EXIT(ltxClientFile);
    end;

    local procedure LogAction(pAction: Enum "DEL Action100"; pDocNo: Code[20]; precDocMatrixSelection: Record "DEL DocMatrix Selection"; pError: Boolean; pDescription: Text): Integer
    var
        lrecDocMatrixLog: Record "DEL DocMatrix Log";
    begin
        lrecDocMatrixLog.INIT();
        lrecDocMatrixLog.TRANSFERFIELDS(precDocMatrixSelection);
        lrecDocMatrixLog.UserId := USERID;
        lrecDocMatrixLog."Line No." := GetNextLogLineNo();
        lrecDocMatrixLog."Date Time Stamp" := CREATEDATETIME(TODAY, TIME);
        lrecDocMatrixLog.Action := pAction;
        lrecDocMatrixLog."Document No." := pDocNo;
        lrecDocMatrixLog.Error := pError;
        lrecDocMatrixLog."Process Result Description" := pDescription;
        lrecDocMatrixLog.INSERT();
        COMMIT();
        EXIT(lrecDocMatrixLog."Line No.");
    end;

    local procedure LogActionUpdateErrorStatus(pLogID: Integer; pboError: Boolean; ptxDescription: Text)
    var
        lrecDocMatrixLog: Record "DEL DocMatrix Log";
    begin
        lrecDocMatrixLog.SETRANGE("Line No.", pLogID);
        IF lrecDocMatrixLog.FINDFIRST() THEN BEGIN
            lrecDocMatrixLog.Error := pboError;
            lrecDocMatrixLog."Process Result Description" := ptxDescription;
            lrecDocMatrixLog.MODIFY();
        END;
    end;


    local procedure FilterRecToProcessedDocument(pUsage: Integer; var pRecordVariant: Variant; pDocNo: Code[20]; pFieldDocNo: Integer)
    var
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
    begin
        // define the processed table as RecRef, so it can be filtered and passed to the report
        lRecRef.OPEN(GetTableNoByUsage(pUsage));
        lFieldRef := lRecRef.FIELD(pFieldDocNo);
        lFieldRef.SETRANGE(pDocNo);
        IF lRecRef.FINDFIRST() THEN
            pRecordVariant := lRecRef;
    end;

    local procedure CreateDocMatrixSelection(pNo: Code[20]; pProcessType: Enum "DEL Process Type"; pUsage: Integer; var precDocMatrixSelection: Record "DEL DocMatrix Selection"; pPrintOnly: Boolean): Boolean
    var
        DocumentMatrix: Record "DEL Document Matrix";
        lPostOptionSOrder: Integer;
    begin
        // first delete old User record
        precDocMatrixSelection.RESET();
        precDocMatrixSelection.SETRANGE(UserId, USERID);
        precDocMatrixSelection.DELETEALL();

        // then create new User record with a copy of the saved record in Document Matrix table
        DocumentMatrix.RESET();
        DocumentMatrix.SETRANGE(Type, GetTypeWithUsage(pUsage));
        DocumentMatrix.SETRANGE("No.", pNo);
        DocumentMatrix.SETRANGE("Process Type", pProcessType);
        DocumentMatrix.SETRANGE(Usage, pUsage);
        IF DocumentMatrix.FINDFIRST() THEN BEGIN

            // check if it is a "Sales Order" (1) that is posted and take over the Post value from the "Sales Order" in order to show it
            // in the DocMatrix Selection page of the "Sales Invoice" (the post option value is on the "Sales Order", but processed is the "Sales Invoice")
            // Then also the Usage has to be set to S.Invoice, instead of S.Order
            // to be clear: a pUsage::S.Order can be called in page 42 from two action buttons
            // 1. to process a "Sales Order Confirmation"
            // 2. to post a "Sales Order" and then process the "Posted Sales Invoice"
            lPostOptionSOrder := 0;
            IF (DocumentMatrix.Post <> DocumentMatrix.Post::" ") AND (pUsage = 1) AND (NOT pPrintOnly) THEN BEGIN
                lPostOptionSOrder := DocumentMatrix.Post.AsInteger();
                DocumentMatrix.SETRANGE(Usage, DocumentMatrix.Usage::"S.Invoice");
            END;

            // set Post to empty if a "Sales Order Confirmation" is printed
            // the post option value is for posting the Sales Order", not for only printing it
            IF pPrintOnly THEN
                lPostOptionSOrder := DocumentMatrix.Post::" ".AsInteger();

            // now find the record again and create the Selection DocMatrix record
            IF DocumentMatrix.FINDFIRST() THEN BEGIN
                precDocMatrixSelection.INIT();
                precDocMatrixSelection.TRANSFERFIELDS(DocumentMatrix);
                precDocMatrixSelection.UserId := USERID;
                IF pUsage = 1 THEN
                    precDocMatrixSelection.Post := lPostOptionSOrder;
                precDocMatrixSelection.INSERT();
                COMMIT();
                EXIT(TRUE);
            END;

        END;
    end;


    procedure UpdateDocMatrixSelection(pNo: Code[20]; pProcessType: Enum "DEL Process Type"; pUsage: Integer; var precDocMatrixSelection: Record "DEL DocMatrix Selection"; pPrintOnly: Boolean)
    var
        DocumentMatrix: Record "DEL Document Matrix";
        lPostOptionSOrder: Integer;
    begin
        // find the Document Matrix record
        DocumentMatrix.RESET();
        DocumentMatrix.SETRANGE(Type, GetTypeWithUsage(pUsage));
        DocumentMatrix.SETRANGE("No.", pNo);
        DocumentMatrix.SETRANGE("Process Type", pProcessType);
        DocumentMatrix.SETRANGE(Usage, pUsage);
        IF DocumentMatrix.FINDFIRST() THEN BEGIN

            // check if it is a "Sales Order" (1) that is posted and take over the Post value from the "Sales Order" in order to show it
            // in the DocMatrix Selection page of the "Sales Invoice" (the post option value is on the "Sales Order", but processed is the "Sales Invoice")
            // Then also the Usage has to be set to S.Invoice, instead of S.Order
            // to be clear: a pUsage::S.Order can be called in page 42 from two action buttons
            // 1. to process a "Sales Order Confirmation"
            // 2. to post a "Sales Order" and then process the "Posted Sales Invoice"
            lPostOptionSOrder := 0;
            IF (precDocMatrixSelection.Post <> precDocMatrixSelection.Post::" ") AND (pUsage = 1) AND (NOT pPrintOnly) THEN BEGIN
                lPostOptionSOrder := precDocMatrixSelection.Post.AsInteger();
                DocumentMatrix.SETRANGE(Usage, DocumentMatrix.Usage::"S.Invoice");
            END;

            // set Post to empty if a "Sales Order Confirmation" is printed
            // the post option value is for posting the Sales Order", not for only printing it
            IF pPrintOnly THEN
                lPostOptionSOrder := DocumentMatrix.Post::" ".AsInteger();

            // now find the record again and modify the Selection DocMatrix record
            IF DocumentMatrix.FINDFIRST() THEN BEGIN
                precDocMatrixSelection.TRANSFERFIELDS(DocumentMatrix);
                precDocMatrixSelection.UserId := USERID;
                IF pUsage = 1 THEN
                    precDocMatrixSelection.Post := lPostOptionSOrder;
                precDocMatrixSelection.MODIFY();
                COMMIT();
            END;

        END;
    end;

    procedure GetPostedSalesInvoice(pNo: Code[20]; pCustNo: Code[20]; var precSalesInvoiceHeader: Record "Sales Invoice Header"): Boolean
    begin
        precSalesInvoiceHeader.RESET();
        precSalesInvoiceHeader.SETRANGE("Order No.", pNo);
        precSalesInvoiceHeader.SETRANGE("Sell-to Customer No.", pCustNo);
        EXIT(precSalesInvoiceHeader.FINDFIRST());
    end;

    procedure GetPostedSalesCreditMemo(pNo: Code[20]; pCustNo: Code[20]; var precSalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean
    begin
        precSalesCrMemoHeader.RESET();
        precSalesCrMemoHeader.SETRANGE("Pre-Assigned No.", pNo);
        precSalesCrMemoHeader.SETRANGE("Sell-to Customer No.", pCustNo);
        EXIT(precSalesCrMemoHeader.FINDFIRST());
    end;

    local procedure GetParameters(pUsage: Integer; pRecordVariant: Variant; pFieldNo: Integer; pFieldDocNo: Integer; var pType: Enum "Credit Transfer Account Type"; var pNo: Code[20]; var pDocNo: Code[20]; pFieldPurchCode: Integer; var pPurchCode: Code[10])
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
    begin
        //init vars
        CLEAR(pNo);
        CLEAR(pType);

        // get the No. from the Customer or Vendor table
        RecRef.GETTABLE(pRecordVariant);
        FieldRef := RecRef.FIELD(pFieldNo);
        pNo := FieldRef.VALUE;

        // get the "Document No." from the processed table
        RecRef.GETTABLE(pRecordVariant);
        FieldRef := RecRef.FIELD(pFieldDocNo);
        pDocNo := FieldRef.VALUE;

        // get the "Purchaser Code" from "Purchase Header" (T38)
        RecRef.GETTABLE(pRecordVariant);
        IF RecRef.NUMBER = 38 THEN BEGIN
            FieldRef := RecRef.FIELD(pFieldPurchCode);
            pPurchCode := FieldRef.VALUE;
        END;

        // get the type of contact
        pType := GetTypeWithUsage(pUsage);
    end;

    local procedure GetRecordByRecRefUsage(pUsage: Integer; pRecordVariant: Variant; var precSalesHeader: Record "Sales Header"; var precSalesInvoiceHeader: Record "Sales Invoice Header"; var precSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var precPurchaseHeader: Record "Purchase Header"; var precPurchInvHeader: Record "Purch. Inv. Header"; var precPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."): Boolean
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        lNo: Code[20];
        lDocType: Integer;
    begin

        CASE pUsage OF
            1:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precSalesHeader.FIELDNO("Document Type"));
                    lDocType := FieldRef.VALUE;
                    FieldRef := RecRef.FIELD(precSalesHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precSalesHeader.RESET();
                    precSalesHeader.SETRANGE("Document Type", lDocType);
                    precSalesHeader.SETRANGE("No.", lNo);
                    EXIT(precSalesHeader.FINDFIRST());
                END;
            2:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precSalesInvoiceHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precSalesInvoiceHeader.RESET();
                    precSalesInvoiceHeader.SETRANGE("No.", lNo);
                    EXIT(precSalesInvoiceHeader.FINDFIRST());
                END;
            3:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precSalesCrMemoHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precSalesCrMemoHeader.RESET();
                    precSalesCrMemoHeader.SETRANGE("No.", lNo);
                    EXIT(precSalesCrMemoHeader.FINDFIRST());
                END;
            6:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precPurchaseHeader.FIELDNO("Document Type"));
                    lDocType := FieldRef.VALUE;
                    FieldRef := RecRef.FIELD(precPurchaseHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precPurchaseHeader.RESET();
                    precPurchaseHeader.SETRANGE("Document Type", lDocType);
                    precPurchaseHeader.SETRANGE("No.", lNo);
                    EXIT(precPurchaseHeader.FINDFIRST());
                END;
            7:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precPurchInvHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precPurchInvHeader.RESET();
                    precPurchInvHeader.SETRANGE("No.", lNo);
                    EXIT(precPurchInvHeader.FINDFIRST());
                END;
        END;
    end;

    local procedure GetTableNoByUsage(pUsage: Integer): Integer
    begin
        CASE pUsage OF
            1:
                EXIT(DATABASE::"Sales Header");
            2:
                EXIT(DATABASE::"Sales Invoice Header");
            3:
                EXIT(DATABASE::"Sales Cr.Memo Header");
            6:
                EXIT(DATABASE::"Purchase Header");
            7:
                EXIT(DATABASE::"Purch. Inv. Header");
        END;
    end;

    local procedure GetReportName(pReportID: Integer): Text[250]
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        IF AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Report, pReportID) THEN
            EXIT(DELCHR(RemoveSpecialCharacters(AllObjWithCaption."Object Caption"), '='));
    end;


    procedure GetCustVendName(pType: Enum "Credit Transfer Account Type"; pNo: Code[20]): Text[50]
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        CASE pType OF
            pType::Customer:
                IF Customer.GET(pNo) THEN
                    EXIT(RemoveSpecialCharacters(Customer.Name));
            pType::Vendor:
                IF Vendor.GET(pNo) THEN
                    EXIT(RemoveSpecialCharacters(Vendor.Name));
        END;
    end;


    procedure GetCustVendLanguageCode(pType: Enum "Credit Transfer Account Type"; pNo: Code[20]): Code[10]
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        CASE pType OF
            pType::Customer:
                IF Customer.GET(pNo) THEN
                    EXIT(Customer."Language Code");
            pType::Vendor:
                IF Vendor.GET(pNo) THEN
                    EXIT(Vendor."Language Code");
        END;
    end;


    procedure GetReportIDWithUsage(pUsage: Integer): Integer
    var
        ReportSelections: Record "Report Selections";
    begin
        ReportSelections.RESET();
        ReportSelections.SETRANGE(Usage, pUsage);
        IF ReportSelections.FINDFIRST() THEN
            EXIT(ReportSelections."Report ID");
    end;

    local procedure GetTypeWithUsage(pUsage: Integer): Integer
    var
        lType: Enum "Credit Transfer Account Type";
    begin
        // get the type of contact
        CASE pUsage OF
            1, 2, 3, 85:
                EXIT(lType::Customer.AsInteger());
            6, 7:
                EXIT(lType::Vendor.AsInteger());
        END;
    end;

    local procedure GetEmailFromSalesOrder(pDocNo: Code[20]): Text[80]
    var
        lrecContact: Record Contact;
        lrecSalesOrder: Record "Sales Header";
    begin
        IF lrecSalesOrder.GET(lrecSalesOrder."Document Type"::Order, pDocNo) THEN
            IF lrecContact.GET(lrecSalesOrder."Sell-to Contact No.") THEN BEGIN
                IF lrecContact."E-Mail" = '' THEN BEGIN
                    IF GUIALLOWED THEN
                        ERROR(Err002, lrecSalesOrder."Sell-to Contact No.", pDocNo)
                END ELSE
                    EXIT(lrecContact."E-Mail")
            END ELSE
                IF GUIALLOWED THEN
                    ERROR(Err001, pDocNo);
    end;

    local procedure GetReciverMailAddressStringFromDocMxSel(precDocMatrixSelection: Record "DEL DocMatrix Selection"; pDocNo: Code[20]): Text[1024]
    var
        ltxMailAddressString: Text[1024];
    begin
        IF ((precDocMatrixSelection."E-Mail To 1" <> '') OR
            (precDocMatrixSelection."E-Mail To 2" <> '') OR
            (precDocMatrixSelection."E-Mail To 3" <> ''))
        THEN BEGIN
            IF precDocMatrixSelection."E-Mail from Sales Order" THEN
                ltxMailAddressString := precDocMatrixSelection."E-Mail To 1" + ';'
                                      + precDocMatrixSelection."E-Mail To 2" + ';'
                                      + precDocMatrixSelection."E-Mail To 3" + ';'
                                      + GetEmailFromSalesOrder(pDocNo)
            ELSE
                ltxMailAddressString := precDocMatrixSelection."E-Mail To 1" + ';' + precDocMatrixSelection."E-Mail To 2" + ';' + precDocMatrixSelection."E-Mail To 3";
        END;

        EXIT(CheckMailAddressString(ltxMailAddressString));
    end;

    local procedure GetSenderMailAddressStringFromDocMxSel(precDocMatrixSelection: Record "DEL DocMatrix Selection"): Text[1024]
    var
        lErr001: Label 'The "E-Mail From" in the Document Matrix Setup can not be empty!';
    begin
        IF precDocMatrixSelection."E-Mail From" = '' THEN
            ERROR(lErr001)
        ELSE
            EXIT(precDocMatrixSelection."E-Mail From");
    end;

    local procedure GetNextLogLineNo(): Integer
    var
        lrecDocMatrixLog: Record "DEL DocMatrix Log";
    begin
        lrecDocMatrixLog.LOCKTABLE();
        lrecDocMatrixLog.SETCURRENTKEY("Line No.");
        IF lrecDocMatrixLog.FINDLAST() THEN
            EXIT(lrecDocMatrixLog."Line No." + 1)
        ELSE
            EXIT(1);
    end;

    local procedure GetLastStatementNoFromCust(pCustNo: Code[20]): Integer
    var
        lrecCustomer: Record Customer;
    begin
        lrecCustomer.RESET();
        IF lrecCustomer.GET(pCustNo) THEN
            EXIT(lrecCustomer."Last Statement No.");
    end;

    local procedure GetMailSubjectAndBodyFromMatrix(precDocMatrixSelection: Record "DEL DocMatrix Selection"; var pMyTextArray: array[10] of Text; var ptxMySubject: Text)
    var
        lrecDocMatrixEmailCodes: Record "DEL DocMatrix Email Codes";
        BLOBInStream: InStream;
        i: Integer;
    begin
        lrecDocMatrixEmailCodes.RESET();
        lrecDocMatrixEmailCodes.SETRANGE(Code, precDocMatrixSelection."Mail Text Code");
        lrecDocMatrixEmailCodes.SETRANGE("Language Code", precDocMatrixSelection."Mail Text Langauge Code");
        IF NOT lrecDocMatrixEmailCodes.FINDFIRST() THEN
            lrecDocMatrixEmailCodes.SETRANGE("Language Code");
        IF lrecDocMatrixEmailCodes.FINDFIRST() THEN BEGIN

            // get the Subject text
            ptxMySubject := lrecDocMatrixEmailCodes.Subject;

            // extract the Body text from the BLOB
            lrecDocMatrixEmailCodes.CALCFIELDS(Body);
            IF lrecDocMatrixEmailCodes.Body.HASVALUE THEN BEGIN
                i := 1;
                lrecDocMatrixEmailCodes.Body.CREATEINSTREAM(BLOBInStream);
                WHILE NOT BLOBInStream.EOS AND (i <= 10) DO BEGIN
                    BLOBInStream.READTEXT(pMyTextArray[i]);
                    i += 1;
                END;

            END;
        END;
    end;

    local procedure GetDateStamp(): Text[8]
    begin
        EXIT(FORMAT(TODAY, 0, '<year4><month,2><day,2>'));
    end;

    local procedure GetDateTimeStamp(): Text[14]
    begin
        EXIT(FORMAT(TODAY, 0, '<year4><month,2><day,2>' + FORMAT(TIME, 0, '<Hours24><Minutes,2><Seconds,2>')));
    end;

    local procedure CheckMailAddressString(ptxMailAddressString: Text[1024]): Text[1024]
    var
        EmailCount: Integer;
        i: Integer;
        NewMailAddressString: Text[1024];
    begin
        ptxMailAddressString := DELCHR(ptxMailAddressString, '<>', ';;');

        NewMailAddressString := '';
        FOR EmailCount := 1 TO 4 DO BEGIN
            i := STRPOS(ptxMailAddressString, ';');
            IF i = 0 THEN BEGIN
                NewMailAddressString := NewMailAddressString + COPYSTR(ptxMailAddressString, 1) + ';';
                ptxMailAddressString := DELSTR(ptxMailAddressString, 1);
            END ELSE BEGIN
                NewMailAddressString := NewMailAddressString + COPYSTR(ptxMailAddressString, 1, i - 1) + ';';
                IF COPYSTR(ptxMailAddressString, i + 1, 1) = ';' THEN
                    ptxMailAddressString := DELSTR(ptxMailAddressString, 1, i + 1)
                ELSE
                    ptxMailAddressString := DELSTR(ptxMailAddressString, 1, i);
            END;
        END;
        NewMailAddressString := DELCHR(NewMailAddressString, '>', ';');
        EXIT(NewMailAddressString);

    end;


    procedure RemoveSpecialCharacters(InputText: Text[50]): Text[50]
    begin
        EXIT(DELCHR(InputText, '=', '~!$^&*(){}[]\|;:''"?/,<>@#`.-+='));
    end;

    local procedure FormatDateSepWithDashYYYYMMDD(pdtDate: Date): Text
    begin
        EXIT(FORMAT(pdtDate, 0, '<year4>-<month,2>-<day,2>'));
    end;

    local procedure CreateFileName(pNo: Code[20]; pDocNo: Text; pExt: Text[5]; pCreateTimeStamp: Boolean; pPurchCode: Code[10]): Text
    var
        lSep: Text[1];
    begin
        IF pPurchCode <> '' THEN
            lSep := '-'
        ELSE
            lSep := '';
        IF pCreateTimeStamp THEN
            EXIT(GetDateTimeStamp() + '-' + pPurchCode + lSep + pNo + '-' + pDocNo + pExt)
        ELSE
            EXIT(pPurchCode + lSep + pNo + '-' + pDocNo + pExt);
    end;



    local procedure CreatePathAndFileName(pUsage: Integer; pNo: Code[20]; pDocNo: Text; var ptxClientFile: Text; var ptxServerFile: Text; var ptxClientPath: Text; pCreateTimeStamp: Boolean; pPurchCode: Code[10])
    var
        txOnlyFileName: Text;
    begin
        ptxClientPath := CheckAndCreateServerPath(pUsage, pNo);
        txOnlyFileName := CreateFileName(pNo, pDocNo, '.pdf', pCreateTimeStamp, pPurchCode);
        ptxClientFile := ptxClientPath + txOnlyFileName;
        //TODO ptxServerFile := TEMPORARYPATH + txOnlyFileName;
        ptxServerFile := txOnlyFileName;
        //TODO 
        // IF EXISTS(ptxServerFile) THEN
        //     ERASE(ptxServerFile);
        if StrLen(ptxServerFile) = 0 then
            ptxServerFile := '';
    end;

    local procedure CheckAndCreateServerPath(pUsage: Integer; pNo: Code[20]): Text
    var
        lrecDocMatrixSetup: Record "DEL DocMatrix Setup";
        lType: Enum "Credit Transfer Account Type";
        i: Integer;
        ltxtStorageLocation: Text;
    begin

        // get the general path for the Document Type from setup
        IF lrecDocMatrixSetup.GET() THEN;
        CASE pUsage OF
            1, 2, 3, 85:
                BEGIN
                    lType := lType::Customer;
                    ltxtStorageLocation := lrecDocMatrixSetup.GetStorageLocation(lType);
                END;
            6, 7:
                BEGIN
                    lType := lType::Vendor;
                    ltxtStorageLocation := lrecDocMatrixSetup.GetStorageLocation(lType);
                END;
        END;

        IF COPYSTR(ltxtStorageLocation, STRLEN(ltxtStorageLocation), 1) <> '\' THEN
            ltxtStorageLocation := ltxtStorageLocation + '\';

        FOR i := 1 TO 2 DO BEGIN
            IF i = 1 THEN
                ltxtStorageLocation := ltxtStorageLocation + GetReportName(GetReportIDWithUsage(pUsage))
            ELSE
                ltxtStorageLocation := ltxtStorageLocation + '\' + GetCustVendName(lType, pNo);
            //TODO : these 2 functions ares no longer used in BC
            // IF NOT FileManagement.ClientFileExists(ltxtStorageLocation) THEN
            //    FileManagement.CreateClientDirectory(ltxtStorageLocation);
        END;

        EXIT(ltxtStorageLocation + '\');
    end;

    local procedure ChangeRequestPageParameterForProcess(pDate: Date; var precDocumentMatrix: Record "DEL Document Matrix")
    var
        i: Integer;
        ltxReplaceWithText: array[2] of Text;
        ltxTextToFind: array[2] of Text;
    begin

        CLEAR(ltxTextToFind);
        CLEAR(ltxReplaceWithText);

        // define the find and replace strings, the replace string recives the processing date
        ltxTextToFind[1] := '<Field name="StartDate">';
        ltxReplaceWithText[1] := '<Field name="StartDate">' + FormatDateSepWithDashYYYYMMDD(pDate);
        ltxTextToFind[2] := '<Field name="EndDate">';
        ltxReplaceWithText[2] := '<Field name="EndDate">' + FormatDateSepWithDashYYYYMMDD(pDate);
        FOR i := 1 TO 2 DO BEGIN
            precDocumentMatrix.ChangeRequestPageParameters(precDocumentMatrix, ltxTextToFind[i], ltxReplaceWithText[i]);
        END;
        COMMIT();
    end;

    local procedure CustomerHasStatmentRecords(pNo: Code[20]; pDate: Date): Boolean
    var
        lrecCustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        lrecCustLedgerEntry.RESET();
        lrecCustLedgerEntry.SETRANGE("Posting Date", pDate);
        lrecCustLedgerEntry.SETRANGE("Customer No.", pNo);
        lrecCustLedgerEntry.SETRANGE(Open, TRUE);
        EXIT(lrecCustLedgerEntry.FINDSET());
    end;

    local procedure ManageFilesAfterProcess(ptxClientFile: Text; ptxServerFile: Text)
    begin
        // CduLFileManagement.DownloadToFile(ptxServerFile, ptxClientFile); TODO:
        // CduLFileManagement.DeleteServerFile(ptxServerFile);  TODO:
    end;

    procedure TestShipmentSelectionBeforeUptdateRequest(precSalesHeader: Record "Sales Header";
     var precDealShipmentSelection
    : Record "DEL Deal Shipment Selection"; var pcdUpdateRequestID: Code[20]
    ; var pboShipmentSelected: Boolean)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        GLAccount_Re_Loc: Record "G/L Account";
        salesLine_Re_Loc: Record "Sales Line";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
    begin
        pboShipmentSelected := FALSE;

        //On gère les "Document Type" commandes, notes de crédit et les factures
        IF
        (
          (precSalesHeader."Document Type" = precSalesHeader."Document Type"::Order)
          OR
          (precSalesHeader."Document Type" = precSalesHeader."Document Type"::"Credit Memo")
          OR
          (precSalesHeader."Document Type" = precSalesHeader."Document Type"::Invoice)
        )
        THEN BEGIN
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", precSalesHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            IF dealShipmentSelection_Re_Loc.FIND('-') THEN BEGIN

                precDealShipmentSelection := dealShipmentSelection_Re_Loc;
                pboShipmentSelected := TRUE;

                IF precSalesHeader."Document Type" = precSalesHeader."Document Type"::Invoice THEN BEGIN

                    //pour les factures vente, on veut 0 ou 1 livraison liée
                    IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                        ERROR('Il faut choisir au maximum 1 livraison liée !');

                END ELSE
                    IF (precSalesHeader."Document Type" = precSalesHeader."Document Type"::Order) THEN BEGIN

                        //pour les commandes il faut exactement 1 livraison liée
                        IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                            ERROR('Il faut choisir exactement 1 livraison liée !');

                    END ELSE
                        IF (precSalesHeader."Document Type" = precSalesHeader."Document Type"::"Credit Memo") THEN BEGIN

                            //pour les notes de crédit, il faut exactement 1 livraison liée
                            IF dealShipmentSelection_Re_Loc.COUNT() > 1 THEN
                                ERROR('Il faut choisir exactement 1 livraison liée !');

                            //il faut aussi impérativement avoir une facture liée à cette note de crédit
                            IF dealShipmentSelection_Re_Loc."Sales Invoice No." = '' THEN
                                ERROR('La livraison liée n''a pas de Sales Invoice sur laquelle elle doit être liée !');

                        END;

                //On crée une updateRequest, comme ca, si NAV plante plus loin, on sait ce qui n'a pas été updaté comme il faut
                pcdUpdateRequestID := updateRequestManager_Cu.FNC_Add_Request(
                  dealShipmentSelection_Re_Loc.Deal_ID,
                  dealShipmentSelection_Re_Loc."Document Type".AsInteger(),
                  dealShipmentSelection_Re_Loc."Document No.",
                  CURRENTDATETIME
                );

                //aucune livraison n'a été sélectionnée
            END ELSE BEGIN

                IF precSalesHeader."Document Type" = precSalesHeader."Document Type"::Order THEN BEGIN

                    ERROR('Il faut choisir exactement 1 livraison liée !');

                    //si le type de ligne est "G/L Account" et le num 3400, 3401 ou 3410, ... alors pas d'erreur
                END ELSE
                    IF precSalesHeader."Document Type" = precSalesHeader."Document Type"::"Credit Memo" THEN BEGIN

                        //on vérifie les lignes du document
                        salesLine_Re_Loc.RESET();
                        salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::"Credit Memo");
                        salesLine_Re_Loc.SETRANGE("Document No.", precSalesHeader."No.");
                        IF salesLine_Re_Loc.FIND('-') THEN BEGIN
                            REPEAT
                                //si c'est pas un compte alors c'est déjà grillé -> erreur
                                IF (salesLine_Re_Loc.Type <> salesLine_Re_Loc.Type::"G/L Account") THEN
                                    ERROR('Il faut choisir exactement 1 livraison liée !')
                                ELSE
                                    IF (GLAccount_Re_Loc.GET(salesLine_Re_Loc."No.")) THEN
                                        // si coché, exclure du contrôle de liaison
                                        IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                            ERROR('Il faut choisir exactement 1 livraison liée !')
                            UNTIL (salesLine_Re_Loc.NEXT() = 0);
                        END;
                    END
                    ELSE
                        IF precSalesHeader."Document Type" = precSalesHeader."Document Type"::Invoice THEN BEGIN

                            //on vérifie les lignes du document
                            salesLine_Re_Loc.RESET();
                            salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::Invoice);
                            salesLine_Re_Loc.SETRANGE("Document No.", precSalesHeader."No.");
                            IF salesLine_Re_Loc.FindSet() THEN BEGIN
                                REPEAT
                                    //si c'est pas un compte alors c'est déjà grillé -> erreur
                                    IF (salesLine_Re_Loc.Type <> salesLine_Re_Loc.Type::"G/L Account") THEN
                                        ERROR('Il faut choisir exactement 1 livraison liée !')
                                    ELSE
                                        IF (GLAccount_Re_Loc.GET(salesLine_Re_Loc."No.")) THEN
                                            // si coché, exclure du contrôle de liaison
                                            IF NOT (GLAccount_Re_Loc."DEL Shipment Binding Control") THEN
                                                ERROR('Il faut choisir exactement 1 livraison liée !')
                                UNTIL (salesLine_Re_Loc.NEXT() = 0);

                            END;
                        END;
            END;
        END;
    end;

    procedure ManageRequestAfterPosting(pcdSalesHeaderNo: Code[20]; pboShipmentSelected: Boolean; pcdUpdateRequestID: Code[20])
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        Deal_Cu: Codeunit "DEL Deal";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
    begin
        IF pboShipmentSelected THEN BEGIN
            //La facture a été associée à une et une seule livraison et donc, on réinitialise l'affaire qui appartient à cette livraison
            Deal_Cu.FNC_Reinit_Deal(dealShipmentSelection_Re_Loc.Deal_ID, FALSE, FALSE);

            //Le deal a été réinitialisé, on peut valider l'updateRequest
            updateRequestManager_Cu.FNC_Validate_Request(pcdUpdateRequestID);

            //On vide la table Deal Shipment Selection pour qu'elle soit mise à jour lors de la prochaine ouverture..
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", pcdSalesHeaderNo);
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            dealShipmentSelection_Re_Loc.DELETEALL();
        END;
    end;
}

