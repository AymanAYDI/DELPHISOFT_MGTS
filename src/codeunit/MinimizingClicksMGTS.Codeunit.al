codeunit 50012 "Minimizing Clicks - MGTS"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   #Create CodeUnit
    // 
    // MGTS:EDD001.02 :TU 06/06/2018 : Minimisation des clics :
    //                               - Create new function "FctSalesCrMemoHeaderPDFSave"
    //                               - Create new function "FctSendMailSalesCrMemoHeader"
    //                               - Create new function "FctPrintCrMemoMGTS"
    // 
    // +----------------------------------------------------------------------------------------------------------------+


    trigger OnRun()
    begin
    end;

    [Scope('Internal')]
    procedure FctSalesOrderConfirmationPDFSave(RecPSalesHeader: Record "36")
    var
        RecLSalesHeader: Record "36";
        RecLSalesSetup: Record "311";
        TxtLServerFilename: Text;
        RecLReportSelections: Record "77";
        CduLFileManagement: Codeunit "419";
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
    begin
        RecLSalesSetup.GET;
        RecLSalesSetup.TESTFIELD("PDF Registration Customer Path");
        RecLSalesHeader.SETRANGE("No.", RecPSalesHeader."No.");
        IF RecLSalesHeader.FINDFIRST THEN BEGIN
            TxtLClientPath := RecLSalesSetup."PDF Registration Customer Path" + '\' + RecLSalesHeader."Bill-to Customer No.";
            TxtLServerFilename := TEMPORARYPATH + RecLSalesHeader."No." + '-' + RecLSalesHeader."Bill-to Customer No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLSalesHeader."No." + '-' + RecLSalesHeader."Bill-to Customer No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET;
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Order");
            IF RecLReportSelections.FINDSET THEN
                REPEAT
                    REPORT.SAVEASPDF(RecLReportSelections."Report ID", TxtLServerFilename, RecLSalesHeader);
                    IF NOT CduLFileManagement.ClientDirectoryExists(TxtLClientPath) THEN
                        CduLFileManagement.CreateClientDirectory(TxtLClientPath);
                    IF EXISTS(TxtLClientFilename) THEN
                        ERASE(TxtLClientFilename);
                    CduLFileManagement.DownloadToFile(TxtLServerFilename, TxtLClientFilename);
                    CduLFileManagement.DeleteServerFile(TxtLServerFilename);
                UNTIL RecLReportSelections.NEXT = 0;
        END;
    end;

    [Scope('Internal')]
    procedure FctPurchaseOrderPDFSave(RecPPurchaseHeader: Record "38"): Text
    var
        RecLPurchaseHeader: Record "38";
        RecLPurchasesSetup: Record "312";
        TxtLServerFilename: Text;
        RecLReportSelections: Record "77";
        CduLFileManagement: Codeunit "419";
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
    begin
        RecLPurchasesSetup.GET;
        RecLPurchasesSetup.TESTFIELD("PDF Registration Vendor Path");
        RecLPurchaseHeader.SETRANGE("No.", RecPPurchaseHeader."No.");
        IF RecLPurchaseHeader.FINDFIRST THEN BEGIN
            TxtLClientPath := RecLPurchasesSetup."PDF Registration Vendor Path" + '\' + RecLPurchaseHeader."Buy-from Vendor No.";
            TxtLServerFilename := TEMPORARYPATH + RecLPurchaseHeader."No." + '-' + RecLPurchaseHeader."Buy-from Vendor No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLPurchaseHeader."No." + '-' + RecLPurchaseHeader."Buy-from Vendor No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET;
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"P.Order");
            IF RecLReportSelections.FINDFIRST THEN BEGIN
                REPORT.SAVEASPDF(RecLReportSelections."Report ID", TxtLServerFilename, RecLPurchaseHeader);
                IF NOT CduLFileManagement.ClientDirectoryExists(TxtLClientPath) THEN
                    CduLFileManagement.CreateClientDirectory(TxtLClientPath);
                IF EXISTS(TxtLClientFilename) THEN
                    ERASE(TxtLClientFilename);
                CduLFileManagement.DownloadToFile(TxtLServerFilename, TxtLClientFilename);
                CduLFileManagement.DeleteServerFile(TxtLServerFilename);
                EXIT(TxtLClientFilename);
            END;
        END;
    end;

    [Scope('Internal')]
    procedure FctSendMailPurchOrder(RecPPurchaseHeader: Record "38")
    var
        CduLMail: Codeunit "397";
        CduSMTPMail: Codeunit "400";
        TxtLSenderName: Text;
        TxtLSenderAddress: Text;
        RecLCompanyInformation: Record "79";
        TxtLSubjectMail: Text;
        TxtMailBody: Text;
        RecLPurchaseHeader: Record "38";
        RecLReportSelection: Record "77";
        TxtLServerFileName: Text;
        TxtLClientFileName: Text;
        TxtLRecipientName: Text;
        RecLVendor: Record "23";
        CodLEmailTemplate: Code[20];
        TxtLNomTiersDocument: Text;
        TxtLCodeTierDocument: Text;
        CodLNDocument: Code[20];
        Cst001: Label 'We must add a e email template';
        DocumentMailing: Codeunit "260";
    begin
        RecLCompanyInformation.GET;
        TxtLSenderName := RecLCompanyInformation.Name;
        RecLCompanyInformation.TESTFIELD("Purchase E-Mail");
        RecLVendor.GET(RecPPurchaseHeader."Buy-from Vendor No.");
        RecLVendor.TESTFIELD("E-Mail");
        TxtLSenderAddress := RecLVendor."E-Mail" + ';' + RecLCompanyInformation."Purchase E-Mail";
        RecLPurchaseHeader.SETRANGE("No.", RecPPurchaseHeader."No.");
        IF RecLPurchaseHeader.FINDFIRST THEN BEGIN
            RecLReportSelection.SETRANGE(Usage, RecLReportSelection.Usage::"P.Order");
            IF NOT (RecLReportSelection.ISEMPTY) THEN BEGIN
                RecLReportSelection.FINDSET;
                REPEAT
                    IF RecLReportSelection."Use for Email Body" THEN BEGIN
                        TxtLSubjectMail := RecLPurchaseHeader."No.";
                        RecLReportSelection.GetEmailBodyVendor(TxtMailBody, RecLReportSelection.Usage::"P.Order", RecLPurchaseHeader, RecLPurchaseHeader."Buy-from Vendor No.", TxtLRecipientName);
                    END
                UNTIL (RecLReportSelection.NEXT = 0) OR (RecLReportSelection."Use for Email Body");
            END;
            DocumentMailing.EmailFile(FctPurchaseOrderPDFSave(RecPPurchaseHeader), '', TxtMailBody, RecLPurchaseHeader."No.",
                    TxtLSenderAddress, '', TRUE, RecLReportSelection.Usage::"P.Order");
        END;
    end;

    [Scope('Internal')]
    procedure FctSendMailSalesInvoice(RecPSalesInvoiceHeader: Record "112")
    var
        CduLMail: Codeunit "397";
        CduSMTPMail: Codeunit "400";
        TxtLSenderName: Text;
        TxtLSenderAddress: Text;
        RecLCompanyInformation: Record "79";
        TxtLSubjectMail: Text;
        TxtMailBody: Text;
        RecLSalesInvoiceHeader: Record "112";
        RecLReportSelection: Record "77";
        TxtLServerFileName: Text;
        TxtLClientFileName: Text;
        TxtLRecipientName: Text;
        RecLCustomer: Record "18";
        CodLEmailTemplate: Code[20];
        TxtLNomTiersDocument: Text;
        TxtLCodeTierDocument: Text;
        CodLNDocument: Code[20];
        Cst001: Label 'We must add a e email template';
        DocumentMailing: Codeunit "260";
    begin
        RecLCompanyInformation.GET;
        TxtLSenderName := RecLCompanyInformation.Name;
        //TxtLSenderAddress := RecLCompanyInformation."E-Mail";
        RecLCustomer.GET(RecPSalesInvoiceHeader."Sell-to Customer No.");
        RecLCustomer.TESTFIELD("E-Mail");
        TxtLSenderAddress := RecLCustomer."E-Mail";
        RecLSalesInvoiceHeader.SETRANGE("No.", RecPSalesInvoiceHeader."No.");
        IF RecLSalesInvoiceHeader.FINDFIRST THEN BEGIN
            RecLReportSelection.SETRANGE(Usage, RecLReportSelection.Usage::"S.Invoice");
            IF NOT (RecLReportSelection.ISEMPTY) THEN BEGIN
                RecLReportSelection.FINDSET;
                REPEAT
                    IF RecLReportSelection."Use for Email Body" THEN BEGIN
                        TxtLSubjectMail := RecLSalesInvoiceHeader."No.";
                        RecLReportSelection.GetEmailBody(TxtMailBody, RecLReportSelection.Usage::"S.Invoice", RecLSalesInvoiceHeader, RecLSalesInvoiceHeader."Sell-to Customer No.", TxtLRecipientName);
                    END
                UNTIL (RecLReportSelection.NEXT = 0) OR (RecLReportSelection."Use for Email Body");
            END;
            DocumentMailing.EmailFile(FctSalesInvoicePDFSave(RecLSalesInvoiceHeader), '', TxtMailBody, RecLSalesInvoiceHeader."No.",
                  TxtLSenderAddress, '', TRUE, RecLReportSelection.Usage::"S.Invoice");
        END;
    end;

    [Scope('Internal')]
    procedure FctSalesInvoicePDFSave(RecPSalesInvoiceHeader: Record "112"): Text
    var
        RecLSalesInvoiceHeader: Record "112";
        RecLSalesSetup: Record "311";
        TxtLServerFilename: Text;
        RecLReportSelections: Record "77";
        CduLFileManagement: Codeunit "419";
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
    begin
        RecLSalesSetup.GET;
        RecLSalesSetup.TESTFIELD("PDF Registration PostedSalesIn");
        RecLSalesInvoiceHeader.SETRANGE("No.", RecPSalesInvoiceHeader."No.");
        IF RecLSalesInvoiceHeader.FINDFIRST THEN BEGIN
            TxtLClientPath := RecLSalesSetup."PDF Registration PostedSalesIn" + '\' + RecLSalesInvoiceHeader."Bill-to Customer No.";
            TxtLServerFilename := TEMPORARYPATH + RecLSalesInvoiceHeader."No." + '-' + RecLSalesInvoiceHeader."Bill-to Customer No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLSalesInvoiceHeader."No." + '-' + RecLSalesInvoiceHeader."Bill-to Customer No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET;
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Invoice");
            IF RecLReportSelections.FINDSET THEN
                REPEAT
                    REPORT.SAVEASPDF(RecLReportSelections."Report ID", TxtLServerFilename, RecLSalesInvoiceHeader);
                    IF NOT CduLFileManagement.ClientDirectoryExists(TxtLClientPath) THEN
                        CduLFileManagement.CreateClientDirectory(TxtLClientPath);
                    IF EXISTS(TxtLClientFilename) THEN
                        ERASE(TxtLClientFilename);
                    CduLFileManagement.DownloadToFile(TxtLServerFilename, TxtLClientFilename);
                    CduLFileManagement.DeleteServerFile(TxtLServerFilename);
                UNTIL RecLReportSelections.NEXT = 0;
        END;
        EXIT(TxtLClientFilename);
    end;

    local procedure FctFTPUploadFile(TxtPAddress: Text; TxtPLogin: Text; TxtPPassword: Text; TxtPPath: Text; TxtPFileNameFTP: Text)
    var
        DotLNetworkCredential: DotNet NetworkCredential;
        DotLWebClient: DotNet WebClient;
    begin
        DotLWebClient := DotLWebClient.WebClient();
        DotLWebClient.Credentials := DotLNetworkCredential.NetworkCredential(TxtPLogin, TxtPPassword);
        DotLWebClient.UploadFile(TxtPAddress + '/' + TxtPFileNameFTP, TxtPPath);
    end;

    [Scope('Internal')]
    procedure FctPrintSalesInvoiceMGTS(RecPSalesInvoiceHeader: Record "112")
    var
        RecLCustomer: Record "18";
        TxtLPathClient: Text;
        RecLCompanyInfo: Record "79";
        CduLFileManagement: Codeunit "419";
        TxtLFileName: Text;
    begin
        RecLCustomer.GET(RecPSalesInvoiceHeader."Sell-to Customer No.");
        IF RecLCustomer."FTP Save" THEN BEGIN
            TxtLPathClient := FctSalesInvoicePDFSave(RecPSalesInvoiceHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET;
            RecLCompanyInfo.TESTFIELD("FTP Server");
            RecLCompanyInfo.TESTFIELD("FTP UserName");
            RecLCompanyInfo.TESTFIELD("FTP Password");
            FctFTPUploadFile(RecLCompanyInfo."FTP Server", RecLCompanyInfo."FTP UserName", RecLCompanyInfo."FTP Password", TxtLPathClient, TxtLFileName);
        END;
        IF RecLCustomer."FTP Save 2" THEN BEGIN
            TxtLPathClient := FctSalesInvoicePDFSave(RecPSalesInvoiceHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET;
            RecLCompanyInfo.TESTFIELD("FTP2 Server");
            RecLCompanyInfo.TESTFIELD("FTP2 UserName");
            RecLCompanyInfo.TESTFIELD("FTP2 Password");
            FctFTPUploadFile(RecLCompanyInfo."FTP2 Server", RecLCompanyInfo."FTP2 UserName", RecLCompanyInfo."FTP2 Password", TxtLPathClient, TxtLFileName);
        END;
        IF (NOT RecLCustomer."FTP Save") AND (NOT RecLCustomer."FTP Save 2") THEN
            FctSendMailSalesInvoice(RecPSalesInvoiceHeader);
    end;

    [Scope('Internal')]
    procedure FctSalesCrMemoHeaderPDFSave(RecPSalesCrMemoHeader: Record "114"): Text
    var
        RecLSalesSetup: Record "311";
        TxtLServerFilename: Text;
        CduLFileManagement: Codeunit "419";
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
        RecLReportSelections: Record "77";
        RecLSalesCrMemoHeader: Record "114";
    begin
        RecLSalesSetup.GET;
        RecLSalesSetup.TESTFIELD("PDF Registration Sales C.Memo");
        RecLSalesCrMemoHeader.SETRANGE("No.", RecPSalesCrMemoHeader."No.");
        IF RecLSalesCrMemoHeader.FINDFIRST THEN BEGIN
            TxtLClientPath := RecLSalesSetup."PDF Registration Sales C.Memo" + '\' + RecLSalesCrMemoHeader."Bill-to Customer No.";
            TxtLServerFilename := TEMPORARYPATH + RecLSalesCrMemoHeader."No." + '-' + RecLSalesCrMemoHeader."Bill-to Customer No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLSalesCrMemoHeader."No." + '-' + RecLSalesCrMemoHeader."Bill-to Customer No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET;
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Cr.Memo");
            IF RecLReportSelections.FINDSET THEN
                REPEAT
                    REPORT.SAVEASPDF(RecLReportSelections."Report ID", TxtLServerFilename, RecLSalesCrMemoHeader);
                    IF NOT CduLFileManagement.ClientDirectoryExists(TxtLClientPath) THEN
                        CduLFileManagement.CreateClientDirectory(TxtLClientPath);
                    IF EXISTS(TxtLClientFilename) THEN
                        ERASE(TxtLClientFilename);
                    CduLFileManagement.DownloadToFile(TxtLServerFilename, TxtLClientFilename);
                    CduLFileManagement.DeleteServerFile(TxtLServerFilename);
                UNTIL RecLReportSelections.NEXT = 0;
        END;
        EXIT(TxtLClientFilename);
    end;

    [Scope('Internal')]
    procedure FctSendMailSalesCrMemoHeader(RecPSalesCrMemoHeader: Record "114")
    var
        RecLReportSelections: Record "77";
        RecLSalesCrMemoHeader: Record "114";
        RecLCompanyInformation: Record "79";
        TxtLSenderName: Text;
        TxtLSenderAddress: Text;
        TxtLSubjectMail: Text;
        TxtMailBody: Text;
        TxtLServerFileName: Text;
        TxtLClientFileName: Text;
        TxtLRecipientName: Text;
        RecLCustomer: Record "18";
        DocumentMailing: Codeunit "260";
    begin
        RecLCompanyInformation.GET;
        TxtLSenderName := RecLCompanyInformation.Name;
        //TxtLSenderAddress := RecLCompanyInformation."E-Mail";
        RecLCustomer.GET(RecPSalesCrMemoHeader."Sell-to Customer No.");
        RecLCustomer.TESTFIELD("E-Mail");
        TxtLSenderAddress := RecLCustomer."E-Mail";
        RecLSalesCrMemoHeader.SETRANGE("No.", RecPSalesCrMemoHeader."No.");
        IF RecLSalesCrMemoHeader.FINDFIRST THEN BEGIN
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Cr.Memo");
            IF NOT (RecLReportSelections.ISEMPTY) THEN BEGIN
                RecLReportSelections.FINDSET;
                REPEAT
                    IF RecLReportSelections."Use for Email Body" THEN BEGIN
                        TxtLSubjectMail := RecLSalesCrMemoHeader."No.";
                        RecLReportSelections.GetEmailBody(TxtMailBody, RecLReportSelections.Usage::"S.Cr.Memo", RecLSalesCrMemoHeader, RecLSalesCrMemoHeader."Sell-to Customer No.", TxtLRecipientName);
                    END
                UNTIL (RecLReportSelections.NEXT = 0) OR (RecLReportSelections."Use for Email Body");
            END;
            DocumentMailing.EmailFile(FctSalesCrMemoHeaderPDFSave(RecLSalesCrMemoHeader), '', TxtMailBody, RecLSalesCrMemoHeader."No.",
                  TxtLSenderAddress, '', TRUE, RecLReportSelections.Usage::"S.Cr.Memo");
        END;
    end;

    [Scope('Internal')]
    procedure FctPrintCrMemoMGTS(RecPSalesCrMemoHeader: Record "114")
    var
        RecLCustomer: Record "18";
        TxtLPathClient: Text;
        RecLCompanyInfo: Record "79";
        CduLFileManagement: Codeunit "419";
        TxtLFileName: Text;
    begin

        RecLCustomer.GET(RecPSalesCrMemoHeader."Sell-to Customer No.");
        IF RecLCustomer."FTP Save" THEN BEGIN
            TxtLPathClient := FctSalesCrMemoHeaderPDFSave(RecPSalesCrMemoHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET;
            RecLCompanyInfo.TESTFIELD("FTP Server");
            RecLCompanyInfo.TESTFIELD("FTP UserName");
            RecLCompanyInfo.TESTFIELD("FTP Password");
            FctFTPUploadFile(RecLCompanyInfo."FTP Server", RecLCompanyInfo."FTP UserName", RecLCompanyInfo."FTP Password", TxtLPathClient, TxtLFileName);
        END;
        IF RecLCustomer."FTP Save 2" THEN BEGIN
            TxtLPathClient := FctSalesCrMemoHeaderPDFSave(RecPSalesCrMemoHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET;
            RecLCompanyInfo.TESTFIELD("FTP2 Server");
            RecLCompanyInfo.TESTFIELD("FTP2 UserName");
            RecLCompanyInfo.TESTFIELD("FTP2 Password");
            FctFTPUploadFile(RecLCompanyInfo."FTP2 Server", RecLCompanyInfo."FTP2 UserName", RecLCompanyInfo."FTP2 Password", TxtLPathClient, TxtLFileName);
        END;
        IF (NOT RecLCustomer."FTP Save") AND (NOT RecLCustomer."FTP Save 2") THEN
            FctSendMailSalesCrMemoHeader(RecPSalesCrMemoHeader);
        //<< FTP+Mail 05/06/2018
    end;
}

