codeunit 50015 "DEL DocMatrix Management"
{
    trigger OnRun()
    begin
    end;

    var
        lcuProgressBar: Codeunit LogiProgressBar;
        Type: Option Customer,Vendor;
        ProcessType: Option Manual,Automatic;
        SalesUsage: Option "Order Confirmation","Work Order","Pick Instruction";
        FileManagement: Codeunit "File Management";
        Err001: Label 'The Sales Order %1 has no Contact assigend!';
        Err002: Label 'The Contact %1 in the Sales Order %2 has no Email Address!';


    procedure ShowDocMatrixSelection(pNo: Code[20]; pProcessType: Option Manual,Automatic; pUsage: Integer; var precDocMatrixSelection: Record "DEL DocMatrix Selection"; pPrintOnly: Boolean): Boolean
    var
        DocumentMatrix: Record "DEL Document Matrix";
        lpgDocMatrixSelection: Page "DEL DocMatrix Selection Card";
        lErr001: Label 'There is no Document Matrix Configuration available for"%1".';
        lType: Option Customer,Vendor;
    begin
        // -------------------------------------------------------------------------------------------------------------------------------
        // -- This function will be called from the different page action buttons, where the user can change the saved parameters
        // -- for the specific document that is processed. The user can change the saved parameters for the specific document that is processed.
        // -- The function "CheckDocumentMatrixSelection" will check the actions against the User selected values in table "DocMatrix Selection" (T50071),
        // -- instead against the saved values of the tabel "Document Matrix" (T50067)
        // -------------------------------------------------------------------------------------------------------------------------------

        // if available create new User record with a copy of the saved record in Document Matrix table
        IF CreateDocMatrixSelection(pNo, pProcessType, pUsage, precDocMatrixSelection, pPrintOnly) THEN BEGIN

            // show the values of the saved process parameters to the user, he can change them to his needs
            lpgDocMatrixSelection.LOOKUPMODE(TRUE);
            lpgDocMatrixSelection.SETRECORD(precDocMatrixSelection);
            lpgDocMatrixSelection.SetPostVisible((pUsage IN [1, 3]) AND (NOT pPrintOnly));  // 1 = S.Order
            IF lpgDocMatrixSelection.RUNMODAL = ACTION::LookupOK THEN BEGIN
                lpgDocMatrixSelection.GETRECORD(precDocMatrixSelection);
                EXIT(TRUE);
            END ELSE
                EXIT(FALSE);

        END ELSE BEGIN
            lType := GetTypeWithUsage(pUsage);
            ERROR(lErr001, FORMAT(lType), GetCustVendName(lType, pNo));
        END;
    end;

    procedure ProcessDocumentMatrix(pUsage: Integer; pProcessType: Option Manual,Automatic; pRecordVariant: Variant; pFieldNo: Integer; pFieldDocNo: Integer; precDocMatrixSelection: Record "DEL DocMatrix Selection"; pFieldPurchCode: Integer)
    var
        DummyReportSelections: Record "Report Selections";
        lAction: Option Print,Save,Mail,FTP1,FTP2;
        lType: Option Customer,Vendor;
        DocumentPrint: Codeunit "Document-Print";
        lNo: Code[20];
        lErr001: Label 'A unexpected problem with the parameter for the function "ProcessDocumentMatrix" occured.';
        lboDeleteFileAtTheEnd: Boolean;
        DocumentSendingProfile: Record "Document Sending Profile";
        lDocMatrixUsage: Option ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Statement;
        FileManagement: Codeunit "File Management";
        lDocNo: Code[20];
        ltxServerFile: Text;
        ltxClientFile: Text;
        ltxClientPath: Text;
        lcuDocMatrixSingleInstance: Codeunit "DEL DocMatrix SingleInstance";
        lErrPrint: Text;
        lPurchCode: Code[10];
    begin
        // -------------------------------------------------------------------------------------------------------------------------------
        // -- This is the Main Function for "Process Type"::Manual that is calles from the different page action buttons
        // -- for now the process is limited to a fixed set of documents (parameter "pUsage")
        // -- the restriction is done on entering level of the Document Matrix Table (T50067) through the field "Usage"
        // -- if the field "Usage" will be expanded in the future, it needs to be analyzed whether the functions need to be adapted
        // -- here are the supported document types:  (see Option field T77.Usage)
        //    - 1 = S.Order = T36
        //    - 2 = S.Invoice = T112
        //    - 3 = S.Cr.Memo = T114
        //    - 6 = P.Order = T38
        //    - 7 = P.Invoice = T122
        //    - 85 = C.Statement (R116)
        // -------------------------------------------------------------------------------------------------------------------------------

        // init
        CLEAR(ltxClientFile);
        CLEAR(ltxServerFile);
        CLEAR(ltxClientPath);
        CLEAR(lNo);
        CLEAR(lboDeleteFileAtTheEnd);

        // init Progress Bar
        lcuProgressBar.FNC_ProgressBar_Init(1, 100, 1000, 'Process documents...', 6);

        // some NAV standard function call MODIFY statements, that are not allowed in Try-Functions, set a SingleInstance var to prevent error
        lcuDocMatrixSingleInstance.SetDocumentMatrixProcessActive(TRUE);

        // first check what document is processed, and set some variables accordingly
        GetParameters(pUsage, pRecordVariant, pFieldNo, pFieldDocNo, lType, lNo, lDocNo, pFieldPurchCode, lPurchCode);

        // then if the parameters are set, check the Document Matrix and process all available actions
        IF (lNo <> '') AND (lDocNo <> '') THEN BEGIN

            // first filter the record table to the processed document
            FilterRecToProcessedDocument(pUsage, pRecordVariant, lDocNo, pFieldDocNo);

            // create path and file name for the processed document
            CreatePathAndFileName(pUsage, lNo, lDocNo + '-' + GetReportName(GetReportIDWithUsage(pUsage)), ltxClientFile, ltxServerFile, ltxClientPath, FALSE, lPurchCode);

            // create the PDF if the file name and path is available (the PDF will always be created)
            IF ltxClientFile <> '' THEN
                SavePDF(pUsage, pRecordVariant, ltxClientFile, ltxServerFile);

            // Progress Bar
            lcuProgressBar.FNC_ProgressBar_Update(1);

            // Save PDF (the PDF will be deleted at the end of the process, if it is not needed)
            IF CheckDocumentMatrixSelection(lAction::Save, precDocMatrixSelection) THEN
                LogAction(lAction::Save, lDocNo, precDocMatrixSelection, FALSE, '')
            ELSE
                lboDeleteFileAtTheEnd := TRUE;

            // Progress Bar
            lcuProgressBar.FNC_ProgressBar_Update(1);

            // Print
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
            IF lboDeleteFileAtTheEnd AND (ltxClientFile <> '') THEN
                FileManagement.DeleteClientFile(ltxClientFile);

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
        lrecDocumentMatrix: Record "DEL Document Matrix";
        lrecDocMatrixChanged: Record "DEL Document Matrix";
        lrecDocMatrixSetup: Record "DEL DocMatrix Setup";
        lErr001: Label 'No Request Page Parameters found!';
        lReportID: Integer;
        lDate: Date;
        lType: Integer;
        lProcessType: Option Manual,Automatic;
        lAction: Option Print,Save,Mail,FTP1,FTP2,,,,,,JobQueueEntry;
        lNo: Code[20];
        lLastStatementNo: Integer;
        lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
        ltxClientFile: Text;
        lvarCustomer: Variant;
        lintLogID: Integer;
        lboActionForStatement: Boolean;
        ltxFTPResultDescr: Text;
        lboFTPsuccessful: Boolean;
        lErr002: Label 'There is no Attachement File available to send by Email.';
    begin
        // -------------------------------------------------------------------------------------------------------------------------------
        // -- This is the Main Function for "Process Type"::Automatic that is called from a "Job Queue Entries" record
        // -- for now the process is limited to the one document (parameter "pReportID") "Statement" (R116)
        // -- the restriction is done on entering level of the Document Matrix Table (T50067) through the field "Usage"
        // -- if the field "Usage" will be expanded in the future, it needs to be analyzed whether the functions need to be adapted
        // -- here are the supported document types: (see Option field T77.Usage)
        //    - 54 = Statement (R116)
        // -------------------------------------------------------------------------------------------------------------------------------

        // init
        lReportID := GetReportIDWithUsage(pUsage);
        lDate := TODAY;
        lType := GetTypeWithUsage(pUsage);
        lProcessType := lProcessType::Automatic;
        CLEAR(lintLogID);

        // Job Queue: Testing a date with values, avoid using WORKDATE for testing, because server via Job Queue has WORKDATE = TODAY
        //lDate := 311219D; -> OK
        //lDate := 200120D; -> OK
        IF lrecDocMatrixSetup.GET THEN BEGIN
            IF lrecDocMatrixSetup."Test Active" AND (lrecDocMatrixSetup."Statement Test Date" <> 0D) THEN
                lDate := lrecDocMatrixSetup."Statement Test Date";
        END;

        // get the report record from the Document Matrix
        lrecDocumentMatrix.SETAUTOCALCFIELDS("Request Page Parameters");
        lrecDocumentMatrix.SETRANGE(Usage, pUsage);
        lrecDocumentMatrix.SETRANGE("Process Type", lProcessType);
        lrecDocumentMatrix.SETRANGE(Type, GetTypeWithUsage(pUsage));
        IF lrecDocumentMatrix.FINDSET THEN BEGIN

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

                            // FTP1
                            IF CheckDocumentMatrixSelection(lAction::FTP1, lrecDocMatrixSelection) THEN
                                lboActionForStatement := ProcessFTP(lAction::FTP1, lNo, FORMAT(lLastStatementNo), lrecDocMatrixSelection, ltxClientFile);

                            // FTP2
                            IF CheckDocumentMatrixSelection(lAction::FTP2, lrecDocMatrixSelection) THEN
                                lboActionForStatement := ProcessFTP(lAction::FTP2, lNo, FORMAT(lLastStatementNo), lrecDocMatrixSelection, ltxClientFile);

                            // log error that the customer was processed, but had no Action assigned
                            IF NOT lboActionForStatement THEN
                                LogAction(lAction::JobQueueEntry, '', lrecDocMatrixSelection, TRUE, 'No Action');

                        END ELSE  // CustomerHasStatmentRecords

                            // log action that the customer was processed, but had no statement to send
                            LogAction(lAction::JobQueueEntry, '', lrecDocMatrixSelection, FALSE, 'No Statement Records found for ' + FORMAT(lDate));


                    END; // GET lrecCustomer

                END ELSE BEGIN // BLOB HASVALUE
                    LogAction(lAction::JobQueueEntry, '', lrecDocMatrixSelection, TRUE, 'No Request Page found');
                    //ERROR(lErr001);
                END;

            UNTIL lrecDocumentMatrix.NEXT = 0;

        END; // lrecDocumentMatrix
    end;

    local procedure CheckDocumentMatrixSelection(pAction: Option Print,Save,Mail,FTP1,FTP2; precDocMatrixSelection: Record "DEL DocMatrix Selection"): Boolean
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        DocumentMatrix: Record "DEL Document Matrix";
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

    local procedure CheckDocumentMatrix(pAction: Option Print,Save,Mail,FTP1,FTP2; pType: Option Customer,Vendor; pNo: Code[20]; pProcessType: Option Manual,Automatic; pUsage: Integer): Boolean
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
        DocumentMatrix: Record "DEL Document Matrix";
    begin
        DocumentMatrix.RESET;
        DocumentMatrix.SETRANGE(Type, pType);
        DocumentMatrix.SETRANGE("No.", pNo);
        DocumentMatrix.SETRANGE("Process Type", pProcessType);
        DocumentMatrix.SETRANGE(Usage, pUsage);
        IF DocumentMatrix.FINDFIRST THEN BEGIN
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
        lErr001: Label 'Not able to save PDF %1. \\ERROR: %2';
    begin
        RecLReportSelections.RESET;
        RecLReportSelections.SETRANGE(Usage, pUsage);
        IF RecLReportSelections.FINDSET THEN
            IF RecLReportSelections.FINDFIRST THEN BEGIN
                REPEAT
                    REPORT.SAVEASPDF(RecLReportSelections."Report ID", ptxServerFile, pRecordVariant);
                    ManageFilesAfterProcess(ptxClientFile, ptxServerFile);
                UNTIL RecLReportSelections.NEXT = 0;
            END;
    end;

    local procedure SilentPrint(pUsage: Integer; ptxClientFile: Text): Text
    var
        lErr001: Label 'Not able to print %1. \\ERROR: %2';
    begin
        IF NOT TrySilentPrint(pUsage, ptxClientFile) THEN
            EXIT(STRSUBSTNO(lErr001, ptxClientFile, GETLASTERRORTEXT));
    end;

    [TryFunction]
    local procedure TrySilentPrint(pUsage: Integer; ptxClientPath: Text)
    var
        [RunOnClient]
        ProcessStartInfo: DotNet ProcessStartInfo;
        [RunOnClient]
        ProcessWindowStyle: DotNet ProcessWindowStyle;
        [RunOnClient]
        Process: DotNet Process;
        AppMgt: Codeunit 1;
        ltxPrinterName: Text;
    begin
        IF ISNULL(ProcessStartInfo) THEN
            ProcessStartInfo := ProcessStartInfo.ProcessStartInfo;
        ProcessStartInfo.UseShellExecute := TRUE;
        ProcessStartInfo.Verb := 'print';
        ProcessStartInfo.WindowStyle := ProcessWindowStyle.Hidden;
        ltxPrinterName := AppMgt.FindPrinter(GetReportIDWithUsage(pUsage));
        //ToDo: what happens if no printer is defined in printer selection?
        ProcessStartInfo.Arguments := ltxPrinterName;
        ProcessStartInfo.FileName := ptxClientPath;
        Process.Start(ProcessStartInfo);
    end;

    local procedure ProcessMail(pUsage: Integer; pProcessType: Option Manual,Automatic; pAction: Option Print,Save,Mail,FTP1,FTP2; pNo: Code[20]; pDocNo: Code[20]; precDocMatrixSelection: Record "DEL DocMatrix Selection"; ptxClientFile: Text; pRecordVariant: Variant): Boolean
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


    procedure SendMail(pUsage: Integer; pProcessType: Option Manual,Automatic; pRecordVariant: Variant; pNo: Code[20]; ptxAttachementFullPathFileName: Text; precDocMatrixSelection: Record "DEL DocMatrix Selection"; pDocNo: Code[20])
    var
        Cst001: Label 'We must add a e email template';
        lrecCompanyInformation: Record "Company Information";
        txSendFromName: Text;
        txSendToAddress: Text;
        txSendFromAddress: Text;
        ltxSubjectMail: Text;
        larrMailBody: array[10] of Text;
        lcuDocMatrixSingleInstance: Codeunit "DEL DocMatrix SingleInstance";
        lcuDocumentMailing: Codeunit "Document-Mailing";
        TxtMailBody: Text;
    begin
        // this is the Name for the sender Email
        IF lrecCompanyInformation.GET THEN;
        txSendFromName := lrecCompanyInformation.Name;

        // get the Email Address "To" from Document Matrix
        //20200915/DEL/PD/CR100.begin
        //txSendToAddress := GetReciverMailAddressStringFromDocMxSel(precDocMatrixSelection);
        txSendToAddress := GetReciverMailAddressStringFromDocMxSel(precDocMatrixSelection, pDocNo);
        //20200915/DEL/PD/CR100.end

        // get the Email Address "From" from Document Matrix
        txSendFromAddress := GetSenderMailAddressStringFromDocMxSel(precDocMatrixSelection);

        // put the "Send From Address" in a single instance variable, will be retrieved in function Cu260.EmailFile
        lcuDocMatrixSingleInstance.SetSendFromAddress(txSendFromAddress);

        // get the Mail Subject and Body-Text from the "DocMatrix Email Codes" table
        GetMailSubjectAndBodyFromMatrix(precDocMatrixSelection, larrMailBody, ltxSubjectMail);

        // insert values if place holders are defined in the Mail Subject
        ReplacePlaceHoldersWithValues(ltxSubjectMail, pRecordVariant, pUsage);

        /*--- test "Send From Address" is always "report_MGTS@mgts.com" with old code version
        // Test "Send From Address" with old code version begin
            lcuDocMatrixSingleInstance.SetSendFromAddress(txSendFromAddress);
            lcuDocumentMailing.EmailFile(ptxAttachementFullPathFileName,'',TxtMailBody,'Test 1001',txSendToAddress,'',TRUE,pUsage); //ToDo: Document No
            lcuDocMatrixSingleInstance.SetSendFromAddress('');
        // Test "Send From Address" with old code version end
        ---*/

        // send the mail
        SendSMTPmail(txSendFromName, txSendFromAddress, txSendToAddress, ltxSubjectMail, ptxAttachementFullPathFileName, larrMailBody);

        // reset single instance var
        lcuDocMatrixSingleInstance.SetSendFromAddress('');

    end;

    local procedure ReplacePlaceHoldersWithValues(var ptxSubjectMail: Text; pRecordVariant: Variant; pUsage: Integer)
    var
        larrMailPlaceHolderValues: array[4] of Text;
        i: Integer;
        lPos: Integer;
    begin
        //first fill the array with all the available values
        FillMailPlaceHolderArray(larrMailPlaceHolderValues, pRecordVariant, pUsage);

        // now replace the percentage place holders with the values
        //ptxSubjectMail := STRSUBSTNO(ptxSubjectMail,ptxSendFromName,'PlaceHolder2','PlaceHolder3');
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
        IF lrecCompanyInformation.GET THEN;
        parrMailPlaceHolderValues[1] := lrecCompanyInformation.Name;

        //pUsage: ,S.Order,S.Invoice,S.Cr.Memo,,,P.Order,P.Invoice,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,C.Statement
        CASE pUsage OF
            //Sales Order
            1:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    //'Sell-to Customer No.'
                    FieldRef := RecRef.FIELD(lrecSalesHeader.FIELDNO("Sell-to Customer No."));
                    parrMailPlaceHolderValues[2] := FieldRef.VALUE;
                    //'External Document No.';
                    FieldRef := RecRef.FIELD(lrecSalesHeader.FIELDNO("External Document No."));
                    parrMailPlaceHolderValues[3] := FieldRef.VALUE;
                    //'Your Reference'
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

        /*---
        // get the "Purchaser Code" from "Purchase Header" (T38)
        RecRef.GETTABLE(pRecordVariant);
        IF RecRef.NUMBER = 38 THEN BEGIN
          FieldRef := RecRef.FIELD(1);
          //pPurchCode := FieldRef.VALUE;
        END;
        ---*/

    end;

    local procedure SendSMTPmail(ptxFromAddressName: Text; ptxFromAddressString: Text; ptxToAddressString: Text; ptxSubject: Text; txAttachementFullPathFileName: Text; larrMailBody: array[10] of Text)
    var
        lcuSMTP: Codeunit 400;
        lcuFileManagement: Codeunit "File Management";
        i: Integer;
    begin
        lcuSMTP.CreateMessage(ptxFromAddressName, ptxFromAddressString, ptxToAddressString, ptxSubject, '', TRUE);
        FOR i := 1 TO ARRAYLEN(larrMailBody) DO
            lcuSMTP.AppendBody('<p>' + larrMailBody[i] + '</p>');
        lcuSMTP.AddAttachment(txAttachementFullPathFileName, lcuFileManagement.GetFileName(txAttachementFullPathFileName));
        lcuSMTP.Send;
    end;

    local procedure ProcessFTP(pAction: Option Print,Save,Mail,FTP1,FTP2; pNo: Code[20]; pDocNo: Code[20]; precDocMatrixSelection: Record "DEL DocMatrix Selection"; ptxClientFile: Text): Boolean
    var
        lintLogID: Integer;
        ltxFTPResultDescr: Text;
        lboFTPsuccessful: Boolean;
    begin
        CLEAR(lintLogID);
        lintLogID := LogAction(pAction, pDocNo, precDocMatrixSelection, TRUE, '');
        lboFTPsuccessful := FTPProcessFile(pAction, ptxClientFile, pNo, ltxFTPResultDescr);
        LogActionUpdateErrorStatus(lintLogID, NOT (lboFTPsuccessful), ltxFTPResultDescr);

        // this function always returns TRUE for automatic precess, manual process does not need the return value
        EXIT(TRUE);
    end;

    local procedure FTPProcessFile(pAction: Option Print,Save,Mail,FTP1,FTP2; ptxFullPathFileName: Text; pCustNo: Code[20]; var pDescription: Text): Boolean
    var
        lrecCompanyInformation: Record "Company Information";
        CduLFileManagement: Codeunit "File Management";
        ltxFileName: Text;
        lrecFTPCustomer: Record "DEL DocMatrix Customer FTP";
        lText001: Label 'The FTP setup for the customer %1 is missing.';
        lText002: Label 'There is no file to transfer.';
        lboTransferSucessful: Boolean;
    begin
        // first check if there is a file to transfer
        IF ptxFullPathFileName = '' THEN BEGIN
            pDescription := lText002;
            EXIT(FALSE);
        END;

        // then check if a FTP configuration for the customer is available, and upload the file if yes
        WITH lrecFTPCustomer DO BEGIN
            IF GET(pCustNo) THEN BEGIN
                CASE pAction OF
                    pAction::FTP1:
                        BEGIN
                            IF ("FTP1 Server" = '') AND ("FTP1 UserName" = '') AND ("FTP1 Password" = '') THEN BEGIN
                                pDescription := STRSUBSTNO(lText001, pCustNo);
                                EXIT(FALSE);
                            END ELSE BEGIN
                                pDescription := UploadFileToFTP("FTP1 Server", "FTP1 UserName", "FTP1 Password", ptxFullPathFileName, lboTransferSucessful);
                                EXIT(lboTransferSucessful);
                            END;
                        END;
                    pAction::FTP2:
                        BEGIN
                            IF ("FTP2 Server" = '') AND ("FTP2 UserName" = '') AND ("FTP2 Password" = '') THEN BEGIN
                                pDescription := STRSUBSTNO(lText001, pCustNo);
                                EXIT(FALSE);
                            END ELSE BEGIN
                                pDescription := UploadFileToFTP("FTP2 Server", "FTP2 UserName", "FTP2 Password", ptxFullPathFileName, lboTransferSucessful);
                                EXIT(lboTransferSucessful);
                            END;
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
        IF NOT TryUploadFileToFTP(ptxFTPServer, ptxFTPUser, ptxFTPPassword, ptxFullPathFileName, lStatusDescription) THEN BEGIN
            pTransferSucessful := FALSE;
            EXIT(COPYSTR(STRSUBSTNO(lErr001, ptxFullPathFileName, GETLASTERRORTEXT), 1, 250))
        END ELSE BEGIN
            pTransferSucessful := TRUE;
            EXIT(lStatusDescription);
        END;
    end;

    [TryFunction]
    local procedure TryUploadFileToFTP(ptxFTPServer: Text; ptxFTPUser: Text; ptxFTPPassword: Text; ptxFullPathFileName: Text; var pStatusDescription: Text)
    var
        FTPWebRequest: DotNet FtpWebRequest;
        FTPWebResponse: DotNet FtpWebResponse;
        NetworkCredential: DotNet NetworkCredential;
        WebRequestMethods: DotNet WebRequestMethods_File;
        UTF8Encoding: DotNet UTF8Encoding;
        ResponseStream: InStream;
        FileStream: DotNet FileStream;
        Stream: DotNet Stream;
        FileDotNet: DotNet File;
        TempBlob: Record "99008535" temporary;
        FileName: Text;
        OutStream: OutStream;
        [RunOnClient]
        SearchOption: DotNet SearchOption;
        i: Integer;
        RelativeServerPath: Text;
        [RunOnClient]
        ClientFilePath: DotNet String;
        PathHelper: DotNet Path;
    begin
        FTPWebRequest := FTPWebRequest.Create(ptxFTPServer + '/' + PathHelper.GetFileName(ptxFullPathFileName));
        FTPWebRequest.Credentials := NetworkCredential.NetworkCredential(ptxFTPUser, ptxFTPPassword);
        FTPWebRequest.UseBinary := TRUE;
        FTPWebRequest.UsePassive := TRUE;
        FTPWebRequest.KeepAlive := TRUE;
        FTPWebRequest.Method := 'STOR';

        FileStream := FileDotNet.OpenRead(ptxFullPathFileName);
        Stream := FTPWebRequest.GetRequestStream();
        FileStream.CopyTo(Stream);
        Stream.Close;

        FTPWebResponse := FTPWebRequest.GetResponse();
        FTPWebResponse.Close();

        pStatusDescription := FTPWebResponse.StatusDescription;
    end;

    local procedure CreateStatementPDFforCustomer(precDocMatrixReqPageChanged: Record "DEL Document Matrix"; pUsage: Integer; pCustNo: Code[20]; pFieldCustNo: Integer; pReportID: Integer; pDate: Date; var pLastStatementNo: Integer; var pvarCustomer: Variant): Text
    var
        lrecDocMatrixReqPageChanged: Record "DEL Document Matrix";
        lRecRef: RecordRef;
        lFieldRef: FieldRef;
        ltxClientFile: Text;
        ltxServerFile: Text;
        ltxClientPath: Text;
        OStream: OutStream;
        IStream: InStream;
        Content: File;
        XmlParameters: Text;
        lPurchCodeDummy: Code[10];
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
        IF lRecRef.FINDFIRST THEN
            pvarCustomer := lRecRef;

        // make use of all the fuzz, and get the Request Page Parameter
        precDocMatrixReqPageChanged."Request Page Parameters".CREATEINSTREAM(IStream, TEXTENCODING::UTF8);
        IStream.READTEXT(XmlParameters);

        // create the PDF file and OutStream for the report
        CreatePathAndFileName(pUsage, pCustNo, GetReportName(pReportID), ltxClientFile, ltxServerFile, ltxClientPath, TRUE, lPurchCodeDummy);
        Content.CREATE(ltxClientFile);
        Content.CREATEOUTSTREAM(OStream);

        // finaly start the Report with the Request Page Parameter
        REPORT.SAVEAS(pReportID, XmlParameters, REPORTFORMAT::Pdf, OStream, pvarCustomer);

        // close file and RecRef vars
        Content.CLOSE;
        lRecRef.CLOSE;

        // get the "Last Statement No." from the customer for R116 for the Log entry
        IF pReportID = REPORT::Statement THEN
            pLastStatementNo := GetLastStatementNoFromCust(pCustNo);

        EXIT(ltxClientFile);
    end;

    local procedure LogAction(pAction: Option Print,Save,Mail,FTP1,FTP2,,,,,,JobQueueEntry; pDocNo: Code[20]; precDocMatrixSelection: Record "DEL DocMatrix Selection"; pError: Boolean; pDescription: Text): Integer
    var
        lrecDocMatrixLog: Record "DEL DocMatrix Log";
    begin
        lrecDocMatrixLog.INIT;
        lrecDocMatrixLog.TRANSFERFIELDS(precDocMatrixSelection);
        lrecDocMatrixLog.UserId := USERID;
        lrecDocMatrixLog."Line No." := GetNextLogLineNo;
        lrecDocMatrixLog."Date Time Stamp" := CREATEDATETIME(TODAY, TIME);
        lrecDocMatrixLog.Action := pAction;
        lrecDocMatrixLog."Document No." := pDocNo;
        lrecDocMatrixLog.Error := pError;
        lrecDocMatrixLog."Process Result Description" := pDescription;
        lrecDocMatrixLog.INSERT;
        COMMIT;
        EXIT(lrecDocMatrixLog."Line No.");
    end;

    local procedure LogActionUpdateErrorStatus(pLogID: Integer; pboError: Boolean; ptxDescription: Text)
    var
        lrecDocMatrixLog: Record "DEL DocMatrix Log";
    begin
        lrecDocMatrixLog.SETRANGE("Line No.", pLogID);
        IF lrecDocMatrixLog.FINDFIRST THEN BEGIN
            lrecDocMatrixLog.Error := pboError;
            lrecDocMatrixLog."Process Result Description" := ptxDescription;
            lrecDocMatrixLog.MODIFY;
        END;
    end;

    local procedure __Helper_Functions__()
    begin
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
        IF lRecRef.FINDFIRST THEN
            pRecordVariant := lRecRef;
    end;

    local procedure CreateDocMatrixSelection(pNo: Code[20]; pProcessType: Option Manual,Automatic; pUsage: Integer; var precDocMatrixSelection: Record "DEL DocMatrix Selection"; pPrintOnly: Boolean): Boolean
    var
        DocumentMatrix: Record "DEL Document Matrix";
        lPostOptionSOrder: Integer;
    begin
        // first delete old User record
        precDocMatrixSelection.RESET;
        precDocMatrixSelection.SETRANGE(UserId, USERID);
        precDocMatrixSelection.DELETEALL;

        // then create new User record with a copy of the saved record in Document Matrix table
        DocumentMatrix.RESET;
        DocumentMatrix.SETRANGE(Type, GetTypeWithUsage(pUsage));
        DocumentMatrix.SETRANGE("No.", pNo);
        DocumentMatrix.SETRANGE("Process Type", pProcessType);
        DocumentMatrix.SETRANGE(Usage, pUsage);
        IF DocumentMatrix.FINDFIRST THEN BEGIN

            // check if it is a "Sales Order" (1) that is posted and take over the Post value from the "Sales Order" in order to show it
            // in the DocMatrix Selection page of the "Sales Invoice" (the post option value is on the "Sales Order", but processed is the "Sales Invoice")
            // Then also the Usage has to be set to S.Invoice, instead of S.Order
            // to be clear: a pUsage::S.Order can be called in page 42 from two action buttons
            // 1. to process a "Sales Order Confirmation"
            // 2. to post a "Sales Order" and then process the "Posted Sales Invoice"
            lPostOptionSOrder := 0;
            IF (DocumentMatrix.Post <> DocumentMatrix.Post::" ") AND (pUsage = 1) AND (NOT pPrintOnly) THEN BEGIN
                lPostOptionSOrder := DocumentMatrix.Post;
                DocumentMatrix.SETRANGE(Usage, DocumentMatrix.Usage::"S.Invoice");
            END;

            // set Post to empty if a "Sales Order Confirmation" is printed
            // the post option value is for posting the Sales Order", not for only printing it
            IF pPrintOnly THEN
                lPostOptionSOrder := DocumentMatrix.Post::" ";

            // now find the record again and create the Selection DocMatrix record
            IF DocumentMatrix.FINDFIRST THEN BEGIN
                precDocMatrixSelection.INIT;
                precDocMatrixSelection.TRANSFERFIELDS(DocumentMatrix);
                precDocMatrixSelection.UserId := USERID;
                IF pUsage = 1 THEN
                    precDocMatrixSelection.Post := lPostOptionSOrder;
                precDocMatrixSelection.INSERT;
                COMMIT;
                EXIT(TRUE);
            END;

        END;
    end;


    procedure UpdateDocMatrixSelection(pNo: Code[20]; pProcessType: Option Manual,Automatic; pUsage: Integer; var precDocMatrixSelection: Record "DEL DocMatrix Selection"; pPrintOnly: Boolean)
    var
        DocumentMatrix: Record "DEL Document Matrix";
        lPostOptionSOrder: Integer;
    begin
        // find the Document Matrix record
        DocumentMatrix.RESET;
        DocumentMatrix.SETRANGE(Type, GetTypeWithUsage(pUsage));
        DocumentMatrix.SETRANGE("No.", pNo);
        DocumentMatrix.SETRANGE("Process Type", pProcessType);
        DocumentMatrix.SETRANGE(Usage, pUsage);
        IF DocumentMatrix.FINDFIRST THEN BEGIN

            // check if it is a "Sales Order" (1) that is posted and take over the Post value from the "Sales Order" in order to show it
            // in the DocMatrix Selection page of the "Sales Invoice" (the post option value is on the "Sales Order", but processed is the "Sales Invoice")
            // Then also the Usage has to be set to S.Invoice, instead of S.Order
            // to be clear: a pUsage::S.Order can be called in page 42 from two action buttons
            // 1. to process a "Sales Order Confirmation"
            // 2. to post a "Sales Order" and then process the "Posted Sales Invoice"
            lPostOptionSOrder := 0;
            IF (precDocMatrixSelection.Post <> precDocMatrixSelection.Post::" ") AND (pUsage = 1) AND (NOT pPrintOnly) THEN BEGIN
                lPostOptionSOrder := precDocMatrixSelection.Post;
                DocumentMatrix.SETRANGE(Usage, DocumentMatrix.Usage::"S.Invoice");
            END;

            // set Post to empty if a "Sales Order Confirmation" is printed
            // the post option value is for posting the Sales Order", not for only printing it
            IF pPrintOnly THEN
                lPostOptionSOrder := DocumentMatrix.Post::" ";

            // now find the record again and modify the Selection DocMatrix record
            IF DocumentMatrix.FINDFIRST THEN BEGIN
                precDocMatrixSelection.TRANSFERFIELDS(DocumentMatrix);
                precDocMatrixSelection.UserId := USERID;
                IF pUsage = 1 THEN
                    precDocMatrixSelection.Post := lPostOptionSOrder;
                precDocMatrixSelection.MODIFY;
                COMMIT;
            END;

        END;
    end;

    procedure GetPostedSalesInvoice(pNo: Code[20]; pCustNo: Code[20]; var precSalesInvoiceHeader: Record "Sales Invoice Header"): Boolean
    begin
        precSalesInvoiceHeader.RESET;
        precSalesInvoiceHeader.SETRANGE("Order No.", pNo);
        precSalesInvoiceHeader.SETRANGE("Sell-to Customer No.", pCustNo);
        EXIT(precSalesInvoiceHeader.FINDFIRST);
    end;

    procedure GetPostedSalesCreditMemo(pNo: Code[20]; pCustNo: Code[20]; var precSalesCrMemoHeader: Record "Sales Cr.Memo Header"): Boolean
    begin
        precSalesCrMemoHeader.RESET;
        precSalesCrMemoHeader.SETRANGE("Pre-Assigned No.", pNo);
        precSalesCrMemoHeader.SETRANGE("Sell-to Customer No.", pCustNo);
        EXIT(precSalesCrMemoHeader.FINDFIRST);
    end;

    local procedure GetParameters(pUsage: Integer; pRecordVariant: Variant; pFieldNo: Integer; pFieldDocNo: Integer; var pType: Option Customer,Vendor; var pNo: Code[20]; var pDocNo: Code[20]; pFieldPurchCode: Integer; var pPurchCode: Code[10])
    var
        DummyReportSelection: Record "Report Selections";
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
        // "pUsage" same as Table 77 "Report Selections" field 1 "Usage" (Option)
        // 0 = S.Quote (not used)
        // 1 = S.Order
        // 2 = S.Invoice
        // 3 = S.Cr.Memo
        // 4 = S.Test (not used)
        // 5 = P.Quote (not used)
        // 6 = P.Order
        // 7 = P.Invoice
        // 85 = C.Statement

        CASE pUsage OF
            1:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precSalesHeader.FIELDNO("Document Type"));
                    lDocType := FieldRef.VALUE;
                    FieldRef := RecRef.FIELD(precSalesHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precSalesHeader.RESET;
                    precSalesHeader.SETRANGE("Document Type", lDocType);
                    precSalesHeader.SETRANGE("No.", lNo);
                    EXIT(precSalesHeader.FINDFIRST);
                END;
            2:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precSalesInvoiceHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precSalesInvoiceHeader.RESET;
                    precSalesInvoiceHeader.SETRANGE("No.", lNo);
                    EXIT(precSalesInvoiceHeader.FINDFIRST);
                END;
            3:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precSalesCrMemoHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precSalesCrMemoHeader.RESET;
                    precSalesCrMemoHeader.SETRANGE("No.", lNo);
                    EXIT(precSalesCrMemoHeader.FINDFIRST);
                END;
            6:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precPurchaseHeader.FIELDNO("Document Type"));
                    lDocType := FieldRef.VALUE;
                    FieldRef := RecRef.FIELD(precPurchaseHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precPurchaseHeader.RESET;
                    precPurchaseHeader.SETRANGE("Document Type", lDocType);
                    precPurchaseHeader.SETRANGE("No.", lNo);
                    EXIT(precPurchaseHeader.FINDFIRST);
                END;
            7:
                BEGIN
                    RecRef.GETTABLE(pRecordVariant);
                    FieldRef := RecRef.FIELD(precPurchInvHeader.FIELDNO("No."));
                    lNo := FieldRef.VALUE;
                    precPurchInvHeader.RESET;
                    precPurchInvHeader.SETRANGE("No.", lNo);
                    EXIT(precPurchInvHeader.FINDFIRST);
                END;
        END;
    end;

    local procedure GetTableNoByUsage(pUsage: Integer): Integer
    begin
        // "pUsage" same as Table 77 "Report Selections" field 1 "Usage" (Option)
        // 0 = S.Quote (not used)
        // 1 = S.Order
        // 2 = S.Invoice
        // 3 = S.Cr.Memo
        // 4 = S.Test (not used)
        // 5 = P.Quote (not used)
        // 6 = P.Order
        // 7 = P.Invoice
        // 85 = C.Statement

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


    procedure GetCustVendName(pType: Option Customer,Vendor; pNo: Code[20]): Text[50]
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


    procedure GetCustVendLanguageCode(pType: Option Customer,Vendor; pNo: Code[20]): Code[10]
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
        ReportSelections.RESET;
        ReportSelections.SETRANGE(Usage, pUsage);
        IF ReportSelections.FINDFIRST THEN
            EXIT(ReportSelections."Report ID");
    end;

    local procedure GetTypeWithUsage(pUsage: Integer): Integer
    var
        lType: Option Customer,Vendor;
    begin
        // "pUsage" same as Table 77 "Report Selections" field 1 "Usage" (Option)
        // 0 = S.Quote (not used)
        // 1 = S.Order
        // 2 = S.Invoice
        // 3 = S.Cr.Memo
        // 4 = S.Test (not used)
        // 5 = P.Quote (not used)
        // 6 = P.Order
        // 7 = P.Invoice
        // 85 = C.Statement

        // get the type of contact
        CASE pUsage OF
            1, 2, 3, 85:
                EXIT(lType::Customer);
            6, 7:
                EXIT(lType::Vendor);
        END;
    end;

    local procedure GetEmailFromSalesOrder(pDocNo: Code[20]): Text[80]
    var
        lrecSalesOrder: Record "Sales Header";
        lrecContact: Record Contact;
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
        Customer: Record Customer;
        Vendor: Record Vendor;
        DocumentMatrix: Record "DEL Document Matrix";
        ltxMailAddressString: Text[1024];
    begin
        IF ((precDocMatrixSelection."E-Mail To 1" <> '') OR
            (precDocMatrixSelection."E-Mail To 2" <> '') OR
            (precDocMatrixSelection."E-Mail To 3" <> ''))
        THEN BEGIN
            //20200915/DEL/PD/CR100.begin
            //ltxMailAddressString := precDocMatrixSelection."E-Mail To 1" + ';' + precDocMatrixSelection."E-Mail To 2" + ';' + precDocMatrixSelection."E-Mail To 3";
            IF precDocMatrixSelection."E-Mail from Sales Order" THEN
                ltxMailAddressString := precDocMatrixSelection."E-Mail To 1" + ';'
                                      + precDocMatrixSelection."E-Mail To 2" + ';'
                                      + precDocMatrixSelection."E-Mail To 3" + ';'
                                      + GetEmailFromSalesOrder(pDocNo)
            ELSE
                ltxMailAddressString := precDocMatrixSelection."E-Mail To 1" + ';' + precDocMatrixSelection."E-Mail To 2" + ';' + precDocMatrixSelection."E-Mail To 3";
            //20200915/DEL/PD/CR100.end
        END;

        EXIT(CheckMailAddressString(ltxMailAddressString));
    end;

    local procedure GetSenderMailAddressStringFromDocMxSel(precDocMatrixSelection: Record "DEL DocMatrix Selection"): Text[1024]
    var
        DocumentMatrix: Record "DEL Document Matrix";
        lErr001: Label 'The "E-Mail From" in the Document Matrix Setup can not be empty!';
    begin
        IF precDocMatrixSelection."E-Mail From" = '' THEN
            ERROR(lErr001) // ToDo: -> catch ERROR if the process should not be interuppted
        ELSE
            EXIT(precDocMatrixSelection."E-Mail From");
    end;

    local procedure GetNextLogLineNo(): Integer
    var
        lrecDocMatrixLog: Record "DEL DocMatrix Log";
    begin
        lrecDocMatrixLog.LOCKTABLE;
        lrecDocMatrixLog.SETCURRENTKEY("Line No.");
        IF lrecDocMatrixLog.FINDLAST THEN
            EXIT(lrecDocMatrixLog."Line No." + 1)
        ELSE
            EXIT(1);
    end;

    local procedure GetLastStatementNoFromCust(pCustNo: Code[20]): Integer
    var
        lrecCustomer: Record Customer;
    begin
        lrecCustomer.RESET;
        IF lrecCustomer.GET(pCustNo) THEN
            EXIT(lrecCustomer."Last Statement No.");
    end;

    local procedure GetMailSubjectAndBodyFromMatrix(precDocMatrixSelection: Record "DEL DocMatrix Selection"; var pMyTextArray: array[10] of Text; var ptxMySubject: Text)
    var
        lrecDocMatrixEmailCodes: Record "DEL DocMatrix Email Codes";
        BLOBInStream: InStream;
        i: Integer;
    begin
        lrecDocMatrixEmailCodes.RESET;
        lrecDocMatrixEmailCodes.SETRANGE(Code, precDocMatrixSelection."Mail Text Code");
        lrecDocMatrixEmailCodes.SETRANGE("Language Code", precDocMatrixSelection."Mail Text Langauge Code");
        IF NOT lrecDocMatrixEmailCodes.FINDFIRST THEN
            lrecDocMatrixEmailCodes.SETRANGE("Language Code");
        IF lrecDocMatrixEmailCodes.FINDFIRST THEN BEGIN

            // get the Subject text
            ptxMySubject := lrecDocMatrixEmailCodes.Subject;

            // extract the Body text from the BLOB
            lrecDocMatrixEmailCodes.CALCFIELDS(Body);
            IF lrecDocMatrixEmailCodes.Body.HASVALUE THEN BEGIN

                // like this the text is not respecting NewLines entered by user
                //CLEAR(MyBigText);
                //lrecDocMatrixEmailCodes.Body.CREATEINSTREAM(BLOBInStream);
                //MyBigText.READ(BLOBInStream);
                //MyBigText.GETSUBTEXT(MyText, 1, 1024);

                // like this the text is read line by line
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
        i: Integer;
        EmailCount: Integer;
        NewMailAddressString: Text[1024];
    begin
        // the user has three fields ("E-Mail To 1", "E-Mail To 2" and "E-Mail To 3") where he can enter E-Mail Adress values
        // the problem is, that the user can decide to only fill one or two of the existing three fields
        // in this case a E-Mail Address string sent to SMTP would look as follow
        // - "name@domain.com;;"                   -> SMPT error: An invalid character was found in the mail header ','.
        // - "name@domain.com;"                    -> SMPT error: An invalid character was found in the mail header ','.
        // - ";name@domain.com"                    -> No error: for some reason this can be handled by SMTP
        // - ";;name@domain.com"                   -> SMPT error: An invalid character was found in the mail header ','.
        // - ";name@domain.com;"                   -> SMPT error: An invalid character was found in the mail header ','.
        // - "name1@domain.com;;name2@domain.com"  -> SMPT error: An invalid character was found in the mail header ','.
        // 1st case: user only fills the first or the two first E-Mail Address fields
        // 2nd case: user only fills the last or the two last E-Mail Address fields
        // 3rd case: user leavs "E-Mail-2" field empty

        //20200915/DEL/PD/CR100.begin
        // - "name1@domain.com;;;name2@domain.com"  -> SMPT error: An invalid character was found in the mail header ','.
        // 4th case: with CR100 there can be an additional Email Address
        //20200915/DEL/PD/CR100.end

        // 1st and 2nd case
        ptxMailAddressString := DELCHR(ptxMailAddressString, '<>', ';;');

        //20200915/DEL/PD/CR100.begin
        /*---
        // 3rd case
        IF COPYSTR(ptxMailAddressString, STRPOS(ptxMailAddressString, ';') + 1, 1) = ';' THEN
          EXIT(DELSTR(ptxMailAddressString, STRPOS(ptxMailAddressString, ';'), 1))
        ELSE
          EXIT(ptxMailAddressString);
        ---*/
        // 3rd and 4th case
        //20210215/DEL/PD/Support.begin
        /*---
        WHILE COPYSTR(ptxMailAddressString, STRPOS(ptxMailAddressString, ';') + 1, 1) = ';' DO
          ptxMailAddressString := DELSTR(ptxMailAddressString, STRPOS(ptxMailAddressString, ';'), 1);
        EXIT(ptxMailAddressString);
        ---*/
        // new implementation, now create NewMailString and copy Email-Addres one by one (4 possible)
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
        //20210215/DEL/PD/Support.end
        //20200915/DEL/PD/CR100.end

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
            EXIT(GetDateTimeStamp + '-' + pPurchCode + lSep + pNo + '-' + pDocNo + pExt)
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
        ptxServerFile := TEMPORARYPATH + txOnlyFileName;

        // delete existing file on server
        IF EXISTS(ptxServerFile) THEN
            ERASE(ptxServerFile);
    end;

    local procedure CheckAndCreateServerPath(pUsage: Integer; pNo: Code[20]): Text
    var
        lrecDocMatrixSetup: Record "DEL DocMatrix Setup";
        ltxtStorageLocation: Text;
        i: Integer;
        lType: Option Customer,Vendor;
    begin
        // "pUsage" same as Table 77 "Report Selections" field 1 "Usage" (Option)
        // 0 = S.Quote (not used)
        // 1 = S.Order
        // 2 = S.Invoice
        // 3 = S.Cr.Memo
        // 4 = S.Test (not used)
        // 5 = P.Quote (not used)
        // 6 = P.Order
        // 7 = P.Invoice
        // 85 = C.Statement

        // get the general path for the Document Type from setup
        IF lrecDocMatrixSetup.GET THEN;
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

        // make sure that the string ends with a Backslash
        IF COPYSTR(ltxtStorageLocation, STRLEN(ltxtStorageLocation), 1) <> '\' THEN
            ltxtStorageLocation := ltxtStorageLocation + '\';

        // check if the foders exist, if not create 1st the Document Type and 2nd the Customer/Vendor folder
        FOR i := 1 TO 2 DO BEGIN
            IF i = 1 THEN
                ltxtStorageLocation := ltxtStorageLocation + GetReportName(GetReportIDWithUsage(pUsage))
            ELSE
                ltxtStorageLocation := ltxtStorageLocation + '\' + GetCustVendName(lType, pNo);
            IF NOT FileManagement.ClientFileExists(ltxtStorageLocation) THEN
                FileManagement.CreateClientDirectory(ltxtStorageLocation);
        END;

        EXIT(ltxtStorageLocation + '\');
    end;

    local procedure ChangeRequestPageParameterForProcess(pDate: Date; var precDocumentMatrix: Record "DEL Document Matrix")
    var
        ltxTextToFind: array[2] of Text;
        ltxReplaceWithText: array[2] of Text;
        i: Integer;
    begin
        // the changeing of Customer No. in the request page parameter string was replaced by the RecRef code in the function "ProcessDocumentMatrixAutomatic"
        // because even though the string was changed correctly, it had no effect on the report in the Repeat loop. Always the first customer was in the report.
        //   ltxTextToFind[3] := '<DataItem name="Customer">VERSION(1) SORTING(Field1)</DataItem>';
        //   ltxReplaceWithText[3] := '<DataItem name="Customer">VERSION(1) SORTING(Field1) WHERE(Field1=1(' + lrecCustomer."No." + '))</DataItem>';
        //   lrecDocumentMatrix.ChangeRequestPageParameters(pReportID, ltxTextToFind[3], ltxReplaceWithText[3], lReplaceType::CustomerNo);

        //init
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
        COMMIT;
    end;

    local procedure CustomerHasStatmentRecords(pNo: Code[20]; pDate: Date): Boolean
    var
        lrecCustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        lrecCustLedgerEntry.RESET;
        lrecCustLedgerEntry.SETRANGE("Posting Date", pDate);
        lrecCustLedgerEntry.SETRANGE("Customer No.", pNo);
        lrecCustLedgerEntry.SETRANGE(Open, TRUE);
        EXIT(lrecCustLedgerEntry.FINDSET);
    end;

    local procedure ManageFilesAfterProcess(ptxClientFile: Text; ptxServerFile: Text)
    var
        CduLFileManagement: Codeunit "File Management";
    begin
        //IF NOT CduLFileManagement.ClientDirectoryExists(txClientPath) THEN
        //  CduLFileManagement.CreateClientDirectory(txClientPath);
        //IF EXISTS(txClientFile)THEN
        //  ERASE(txClientFile);
        CduLFileManagement.DownloadToFile(ptxServerFile, ptxClientFile);
        CduLFileManagement.DeleteServerFile(ptxServerFile);
    end;

    local procedure __MGTS_Functions__()
    begin
    end;


    procedure TestShipmentSelectionBeforeUptdateRequest(precSalesHeader: Record "Sales Header"; var precDealShipmentSelection: Record "DEL Deal Shipment Selection"; var pcdUpdateRequestID: Code[20]; var pboShipmentSelected: Boolean)
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        salesLine_Re_Loc: Record "Sales Line";
        GLAccount_Re_Loc: Record "G/L Account";
    begin
        //DEL/PD/20190304/LOP003.begin

        //MIG2017 START
        // T-00551-DEAL -
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
                  dealShipmentSelection_Re_Loc."Document Type",
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
                                        IF NOT (GLAccount_Re_Loc."Shipment Binding Control") THEN
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
                            IF salesLine_Re_Loc.FIND('-') THEN BEGIN
                                REPEAT
                                    //si c'est pas un compte alors c'est déjà grillé -> erreur
                                    IF (salesLine_Re_Loc.Type <> salesLine_Re_Loc.Type::"G/L Account") THEN
                                        ERROR('Il faut choisir exactement 1 livraison liée !')
                                    ELSE
                                        IF (GLAccount_Re_Loc.GET(salesLine_Re_Loc."No.")) THEN
                                            // si coché, exclure du contrôle de liaison
                                            IF NOT (GLAccount_Re_Loc."Shipment Binding Control") THEN
                                                ERROR('Il faut choisir exactement 1 livraison liée !')
                                UNTIL (salesLine_Re_Loc.NEXT() = 0);

                            END;
                        END;
            END;
        END;
        // T-00551-DEAL +

        //MIG2017 END

        //DEL/PD/20190304/LOP003.end
    end;

    procedure ManageRequestAfterPosting(pcdSalesHeaderNo: Code[20]; pboShipmentSelected: Boolean; pcdUpdateRequestID: Code[20])
    var
        Deal_Cu: Codeunit "DEL Deal";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
    begin
        //DEL/PD/20190304/LOP003.begin

        //MIG2017 START
        // T-00551-DEAL -
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
        // T-00551-DEAL +

        //END MIG2017

        //DEL/PD/20190304/LOP003.end
    end;
}

