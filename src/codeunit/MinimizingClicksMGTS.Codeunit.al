codeunit 50012 "DEL Minimizing Clicks - MGTS"
{
    trigger OnRun()
    begin
    end;


    procedure FctSalesOrderConfirmationPDFSave(RecPSalesHeader: Record "Sales Header")
    var
        RecLSalesHeader: Record "Sales Header";
        RecLSalesSetup: Record "Sales & Receivables Setup";
        RecLReportSelections: Record "Report Selections";
        CduLFileManagement: Codeunit "File Management";
        TxtLServerFilename: Text;
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
    begin
        RecLSalesSetup.GET();
        RecLSalesSetup.TESTFIELD("DEL PDF Registration Customer Path");
        RecLSalesHeader.SETRANGE("No.", RecPSalesHeader."No.");
        IF RecLSalesHeader.FINDFIRST() THEN BEGIN
            TxtLClientPath := RecLSalesSetup."DEL PDF Registration Customer Path" + '\' + RecLSalesHeader."Bill-to Customer No.";
            TxtLServerFilename := TEMPORARYPATH + RecLSalesHeader."No." + '-' + RecLSalesHeader."Bill-to Customer No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLSalesHeader."No." + '-' + RecLSalesHeader."Bill-to Customer No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET();
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Order");
            IF RecLReportSelections.FINDSET() THEN
                REPEAT
                    REPORT.SAVEASPDF(RecLReportSelections."Report ID", TxtLServerFilename, RecLSalesHeader);
                    IF NOT CduLFileManagement.ClientDirectoryExists(TxtLClientPath) THEN
                        CduLFileManagement.CreateClientDirectory(TxtLClientPath);
                    IF EXISTS(TxtLClientFilename) THEN
                        ERASE(TxtLClientFilename);
                    CduLFileManagement.DownloadToFile(TxtLServerFilename, TxtLClientFilename);
                    CduLFileManagement.DeleteServerFile(TxtLServerFilename);
                UNTIL RecLReportSelections.NEXT() = 0;
        END;
    end;

    procedure FctPurchaseOrderPDFSave(RecPPurchaseHeader: Record "Purchase Header"): Text
    var
        RecLPurchaseHeader: Record "Purchase Header";
        RecLPurchasesSetup: Record "Purchases & Payables Setup";
        RecLReportSelections: Record "Report Selections";
        CduLFileManagement: Codeunit "File Management";
        TxtLServerFilename: Text;
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
    begin
        RecLPurchasesSetup.GET();
        RecLPurchasesSetup.TESTFIELD("DEL PDF Registr. Vendor Path");
        RecLPurchaseHeader.SETRANGE("No.", RecPPurchaseHeader."No.");
        IF RecLPurchaseHeader.FINDFIRST() THEN BEGIN
            TxtLClientPath := RecLPurchasesSetup."DEL PDF Registr. Vendor Path" + '\' + RecLPurchaseHeader."Buy-from Vendor No.";
            TxtLServerFilename := TEMPORARYPATH + RecLPurchaseHeader."No." + '-' + RecLPurchaseHeader."Buy-from Vendor No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLPurchaseHeader."No." + '-' + RecLPurchaseHeader."Buy-from Vendor No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET();
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"P.Order");
            IF RecLReportSelections.FINDFIRST() THEN BEGIN
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


    procedure FctSendMailPurchOrder(RecPPurchaseHeader: Record "Purchase Header")

    var
        CduLMail: Codeunit Mail;
        CduSMTPMail: Codeunit 400;
        TxtLSenderName: Text;
        TxtLSenderAddress: Text;
        RecLCompanyInformation: Record "Company Information";
        TxtLSubjectMail: Text;
        TxtMailBody: Text;
        RecLPurchaseHeader: Record "Purchase Header";
        RecLReportSelection: Record "Report Selections";
        TxtLServerFileName: Text;
        TxtLClientFileName: Text;
        TxtLRecipientName: Text;
        RecLVendor: Record Vendor;
        CodLEmailTemplate: Code[20];
        TxtLNomTiersDocument: Text;
        TxtLCodeTierDocument: Text;
        CodLNDocument: Code[20];
        Cst001: Label 'We must add a e email template';
        DocumentMailing: Codeunit "Document-Mailing";
    begin
        RecLCompanyInformation.GET();
        TxtLSenderName := RecLCompanyInformation.Name;
        RecLCompanyInformation.TESTFIELD("DEL Purchase E-Mail");
        RecLVendor.GET(RecPPurchaseHeader."Buy-from Vendor No.");
        RecLVendor.TESTFIELD("E-Mail");
        TxtLSenderAddress := RecLVendor."E-Mail" + ';' + RecLCompanyInformation."DEL Purchase E-Mail";
        RecLPurchaseHeader.SETRANGE("No.", RecPPurchaseHeader."No.");
        IF RecLPurchaseHeader.FINDFIRST() THEN BEGIN
            RecLReportSelection.SETRANGE(Usage, RecLReportSelection.Usage::"P.Order");
            IF NOT (RecLReportSelection.ISEMPTY) THEN BEGIN
                RecLReportSelection.FINDSET();
                REPEAT
                    IF RecLReportSelection."Use for Email Body" THEN BEGIN
                        TxtLSubjectMail := RecLPurchaseHeader."No.";
                        RecLReportSelection.GetEmailBodyVendor(TxtMailBody, RecLReportSelection.Usage::"P.Order", RecLPurchaseHeader, RecLPurchaseHeader."Buy-from Vendor No.", TxtLRecipientName);
                    END
                UNTIL (RecLReportSelection.NEXT() = 0) OR (RecLReportSelection."Use for Email Body");
            END;
            DocumentMailing.EmailFile(FctPurchaseOrderPDFSave(RecPPurchaseHeader), '', TxtMailBody, RecLPurchaseHeader."No.",
                    TxtLSenderAddress, '', TRUE, RecLReportSelection.Usage::"P.Order");
        END;
    end;

    procedure FctSendMailSalesInvoice(RecPSalesInvoiceHeader: Record "Sales Invoice Header")
    var
        CduLMail: Codeunit Mail;
        CduSMTPMail: Codeunit 400;
        TxtLSenderName: Text;
        TxtLSenderAddress: Text;
        RecLCompanyInformation: Record "Company Information";
        TxtLSubjectMail: Text;
        TxtMailBody: Text;
        RecLSalesInvoiceHeader: Record "Sales Invoice Header";
        RecLReportSelection: Record "Report Selections";
        TxtLServerFileName: Text;
        TxtLClientFileName: Text;
        TxtLRecipientName: Text;
        RecLCustomer: Record Customer;
        CodLEmailTemplate: Code[20];
        TxtLNomTiersDocument: Text;
        TxtLCodeTierDocument: Text;
        CodLNDocument: Code[20];
        Cst001: Label 'We must add a e email template';
        DocumentMailing: Codeunit "Document-Mailing";
    begin
        RecLCompanyInformation.GET();
        TxtLSenderName := RecLCompanyInformation.Name;
        //TxtLSenderAddress := RecLCompanyInformation."E-Mail";
        RecLCustomer.GET(RecPSalesInvoiceHeader."Sell-to Customer No.");
        RecLCustomer.TESTFIELD("E-Mail");
        TxtLSenderAddress := RecLCustomer."E-Mail";
        RecLSalesInvoiceHeader.SETRANGE("No.", RecPSalesInvoiceHeader."No.");
        IF RecLSalesInvoiceHeader.FINDFIRST() THEN BEGIN
            RecLReportSelection.SETRANGE(Usage, RecLReportSelection.Usage::"S.Invoice");
            IF NOT (RecLReportSelection.ISEMPTY) THEN BEGIN
                RecLReportSelection.FINDSET();
                REPEAT
                    IF RecLReportSelection."Use for Email Body" THEN BEGIN
                        TxtLSubjectMail := RecLSalesInvoiceHeader."No.";
                        RecLReportSelection.GetEmailBody(TxtMailBody, RecLReportSelection.Usage::"S.Invoice", RecLSalesInvoiceHeader, RecLSalesInvoiceHeader."Sell-to Customer No.", TxtLRecipientName);
                    END
                UNTIL (RecLReportSelection.NEXT() = 0) OR (RecLReportSelection."Use for Email Body");
            END;
            DocumentMailing.EmailFile(FctSalesInvoicePDFSave(RecLSalesInvoiceHeader), '', TxtMailBody, RecLSalesInvoiceHeader."No.",
                  TxtLSenderAddress, '', TRUE, RecLReportSelection.Usage::"S.Invoice");
        END;
    end;

    procedure FctSalesInvoicePDFSave(RecPSalesInvoiceHeader: Record "Sales Invoice Header"): Text
    var
        RecLSalesInvoiceHeader: Record "Sales Invoice Header";
        RecLSalesSetup: Record "Sales & Receivables Setup";
        TxtLServerFilename: Text;
        RecLReportSelections: Record "Report Selections";
        CduLFileManagement: Codeunit "File Management";
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
    begin
        RecLSalesSetup.GET();
        RecLSalesSetup.TESTFIELD("DEL PDF Registration PostedSalesIn");
        RecLSalesInvoiceHeader.SETRANGE("No.", RecPSalesInvoiceHeader."No.");
        IF RecLSalesInvoiceHeader.FINDFIRST() THEN BEGIN
            TxtLClientPath := RecLSalesSetup."DEL PDF Registration PostedSalesIn" + '\' + RecLSalesInvoiceHeader."Bill-to Customer No.";
            TxtLServerFilename := TEMPORARYPATH + RecLSalesInvoiceHeader."No." + '-' + RecLSalesInvoiceHeader."Bill-to Customer No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLSalesInvoiceHeader."No." + '-' + RecLSalesInvoiceHeader."Bill-to Customer No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET();
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Invoice");
            IF RecLReportSelections.FINDSET() THEN
                REPEAT
                    REPORT.SAVEASPDF(RecLReportSelections."Report ID", TxtLServerFilename, RecLSalesInvoiceHeader);
                    IF NOT CduLFileManagement.ClientDirectoryExists(TxtLClientPath) THEN
                        CduLFileManagement.CreateClientDirectory(TxtLClientPath);
                    IF EXISTS(TxtLClientFilename) THEN
                        ERASE(TxtLClientFilename);
                    CduLFileManagement.DownloadToFile(TxtLServerFilename, TxtLClientFilename);
                    CduLFileManagement.DeleteServerFile(TxtLServerFilename);
                UNTIL RecLReportSelections.NEXT() = 0;
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

    procedure FctPrintSalesInvoiceMGTS(RecPSalesInvoiceHeader: Record "Sales Invoice Header")
    var
        RecLCustomer: Record Customer;
        RecLCompanyInfo: Record "Company Information";
        CduLFileManagement: Codeunit "File Management";
        TxtLPathClient: Text;
        TxtLFileName: Text;
    begin
        RecLCustomer.GET(RecPSalesInvoiceHeader."Sell-to Customer No.");
        IF RecLCustomer."DEL FTP Save" THEN BEGIN
            TxtLPathClient := FctSalesInvoicePDFSave(RecPSalesInvoiceHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET();
            RecLCompanyInfo.TESTFIELD("DEL FTP Server");
            RecLCompanyInfo.TESTFIELD("DEL FTP UserName");
            RecLCompanyInfo.TESTFIELD("DEL FTP Password");
            FctFTPUploadFile(RecLCompanyInfo."DEL FTP Server", RecLCompanyInfo."DEL FTP UserName", RecLCompanyInfo."DEL FTP Password", TxtLPathClient, TxtLFileName);
        END;
        IF RecLCustomer."DEL FTP Save 2" THEN BEGIN
            TxtLPathClient := FctSalesInvoicePDFSave(RecPSalesInvoiceHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET();
            RecLCompanyInfo.TESTFIELD("DEL FTP2 Server");
            RecLCompanyInfo.TESTFIELD("DEL FTP2 UserName");
            RecLCompanyInfo.TESTFIELD("DEL FTP2 Password");
            FctFTPUploadFile(RecLCompanyInfo."DEL FTP2 Server", RecLCompanyInfo."DEL FTP2 UserName", RecLCompanyInfo."DEL FTP2 Password", TxtLPathClient, TxtLFileName);
        END;
        IF (NOT RecLCustomer."DEL FTP Save") AND (NOT RecLCustomer."DEL FTP Save 2") THEN
            FctSendMailSalesInvoice(RecPSalesInvoiceHeader);
    end;

    procedure FctSalesCrMemoHeaderPDFSave(RecPSalesCrMemoHeader: Record "Sales Cr.Memo Header"): Text
    var
        RecLSalesSetup: Record "Sales & Receivables Setup";
        TxtLServerFilename: Text;
        CduLFileManagement: Codeunit "File Management";
        TxtLClientFilename: Text;
        TxtLClientPath: Text;
        RecLReportSelections: Record "Report Selections";
        RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        RecLSalesSetup.GET();
        RecLSalesSetup.TESTFIELD("DEL PDF Registration Sales C.Memo");
        RecLSalesCrMemoHeader.SETRANGE("No.", RecPSalesCrMemoHeader."No.");
        IF RecLSalesCrMemoHeader.FINDFIRST() THEN BEGIN
            TxtLClientPath := RecLSalesSetup."DEL PDF Registration Sales C.Memo" + '\' + RecLSalesCrMemoHeader."Bill-to Customer No.";
            TxtLServerFilename := TEMPORARYPATH + RecLSalesCrMemoHeader."No." + '-' + RecLSalesCrMemoHeader."Bill-to Customer No." + '.pdf';
            TxtLClientFilename := TxtLClientPath + '\' + RecLSalesCrMemoHeader."No." + '-' + RecLSalesCrMemoHeader."Bill-to Customer No." + '.pdf';
            IF EXISTS(TxtLServerFilename) THEN
                ERASE(TxtLServerFilename);
            RecLReportSelections.RESET();
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Cr.Memo");
            IF RecLReportSelections.FINDSET() THEN
                REPEAT
                    REPORT.SAVEASPDF(RecLReportSelections."Report ID", TxtLServerFilename, RecLSalesCrMemoHeader);
                    IF NOT CduLFileManagement.ClientDirectoryExists(TxtLClientPath) THEN
                        CduLFileManagement.CreateClientDirectory(TxtLClientPath);
                    IF EXISTS(TxtLClientFilename) THEN
                        ERASE(TxtLClientFilename);
                    CduLFileManagement.DownloadToFile(TxtLServerFilename, TxtLClientFilename);
                    CduLFileManagement.DeleteServerFile(TxtLServerFilename);
                UNTIL RecLReportSelections.NEXT() = 0;
        END;
        EXIT(TxtLClientFilename);
    end;

    procedure FctSendMailSalesCrMemoHeader(RecPSalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        RecLReportSelections: Record "Report Selections";
        RecLSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        RecLCompanyInformation: Record "Company Information";
        TxtLSenderName: Text;
        TxtLSenderAddress: Text;
        TxtLSubjectMail: Text;
        TxtMailBody: Text;
        TxtLServerFileName: Text;
        TxtLClientFileName: Text;
        TxtLRecipientName: Text;
        RecLCustomer: Record Customer;
        DocumentMailing: Codeunit "Document-Mailing";
    begin
        RecLCompanyInformation.GET();
        TxtLSenderName := RecLCompanyInformation.Name;
        //TxtLSenderAddress := RecLCompanyInformation."E-Mail";
        RecLCustomer.GET(RecPSalesCrMemoHeader."Sell-to Customer No.");
        RecLCustomer.TESTFIELD("E-Mail");
        TxtLSenderAddress := RecLCustomer."E-Mail";
        RecLSalesCrMemoHeader.SETRANGE("No.", RecPSalesCrMemoHeader."No.");
        IF RecLSalesCrMemoHeader.FINDFIRST() THEN BEGIN
            RecLReportSelections.SETRANGE(Usage, RecLReportSelections.Usage::"S.Cr.Memo");
            IF NOT (RecLReportSelections.ISEMPTY) THEN BEGIN
                RecLReportSelections.FINDSET();
                REPEAT
                    IF RecLReportSelections."Use for Email Body" THEN BEGIN
                        TxtLSubjectMail := RecLSalesCrMemoHeader."No.";
                        RecLReportSelections.GetEmailBody(TxtMailBody, RecLReportSelections.Usage::"S.Cr.Memo", RecLSalesCrMemoHeader, RecLSalesCrMemoHeader."Sell-to Customer No.", TxtLRecipientName);
                    END
                UNTIL (RecLReportSelections.NEXT() = 0) OR (RecLReportSelections."Use for Email Body");
            END;
            DocumentMailing.EmailFile(FctSalesCrMemoHeaderPDFSave(RecLSalesCrMemoHeader), '', TxtMailBody, RecLSalesCrMemoHeader."No.",
                  TxtLSenderAddress, '', TRUE, RecLReportSelections.Usage::"S.Cr.Memo");
        END;
    end;

    procedure FctPrintCrMemoMGTS(RecPSalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        RecLCustomer: Record Customer;
        RecLCompanyInfo: Record "Company Information";
        CduLFileManagement: Codeunit "File Management";
        TxtLPathClient: Text;
        TxtLFileName: Text;
    begin

        RecLCustomer.GET(RecPSalesCrMemoHeader."Sell-to Customer No.");
        IF RecLCustomer."DEL FTP Save" THEN BEGIN
            TxtLPathClient := FctSalesCrMemoHeaderPDFSave(RecPSalesCrMemoHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET();
            RecLCompanyInfo.TESTFIELD("DEL FTP Server");
            RecLCompanyInfo.TESTFIELD("DEL FTP UserName");
            RecLCompanyInfo.TESTFIELD("DEL FTP Password");
            FctFTPUploadFile(RecLCompanyInfo."DEL FTP Server", RecLCompanyInfo."DEL FTP UserName", RecLCompanyInfo."DEL FTP Password", TxtLPathClient, TxtLFileName);
        END;
        IF RecLCustomer."DEL FTP Save 2" THEN BEGIN
            TxtLPathClient := FctSalesCrMemoHeaderPDFSave(RecPSalesCrMemoHeader);
            TxtLFileName := CduLFileManagement.GetFileName(TxtLPathClient);
            RecLCompanyInfo.GET();
            RecLCompanyInfo.TESTFIELD("DEL FTP2 Server");
            RecLCompanyInfo.TESTFIELD("DEL FTP2 UserName");
            RecLCompanyInfo.TESTFIELD("DEL FTP2 Password");
            FctFTPUploadFile(RecLCompanyInfo."DEL FTP2 Server", RecLCompanyInfo."DEL FTP2 UserName", RecLCompanyInfo."DEL FTP2 Password", TxtLPathClient, TxtLFileName);
        END;
        IF (NOT RecLCustomer."DEL FTP Save") AND (NOT RecLCustomer."DEL FTP Save 2") THEN
            FctSendMailSalesCrMemoHeader(RecPSalesCrMemoHeader);
        //<< FTP+Mail 05/06/2018
    end;
}

