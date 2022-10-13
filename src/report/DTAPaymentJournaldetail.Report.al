report 50001 "DEL DTA Payment Journal detail"
{
    DefaultLayout = RDLC;
    RDLCLayout = './DTAPaymentJournaldetail.rdlc';

    Caption = 'DTA Payment Journal Detail';

    dataset
    {
        dataitem(DataItem7024; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Journal Template Name", "Journal Batch Name", "Posting Date", Clearing, "Debit Bank");
            column(JournalBatchName_GenJournalLine; "Journal Batch Name")
            {
            }
            column(PageNumber; CurrReport.PAGENO)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(intLayout; intLayout)
            {
            }
            column(AccountNo_GenJournalLine; "Account No.")
            {
            }
            column(VendorLedgerEntryDueDate; FORMAT(VendorLedgerEntry."Due Date"))
            {
            }
            column(AppliestoDocNo_GenJournalLine; "Applies-to Doc. No.")
            {
            }
            column(CurrencyCode_GenJournalLine; "Currency Code")
            {
            }
            column(Amount_GenJournalLine; Amount)
            {
            }
            column(CashDiscAmtFC; "CashDiscAmtFC")
            {
            }
            column(CashDeductAmt; CashDeductAmt)
            {
            }
            column(AgeDays; AgeDays)
            {
            }
            column(CashDiscDays; CashDiscDays)
            {
            }
            column(DueDays; DueDays)
            {
            }
            column(OpenRemAmtFC; OpenRemAmtFC)
            {
            }
            column(RestAfterPmt; RestAfterPmt)
            {
            }
            column(VendorName; Vendor.Name)
            {
            }
            column(PmtToleranceAmount; PmtToleranceAmount)
            {
            }
            column(VendorBankAccountPaymentForm; VendorBankAccount."Payment Form")
            {
                OptionCaption = 'ESR,ESR+,Post Payment Domestic,Bank Payment Domestic,Cash Outpayment Order Domestic,Post Payment Abroad,Bank Payment Abroad,SWIFT Payment Abroad,Cash Outpayment Order Abroad';
                OptionMembers = ESR,"ESR+","Post Payment Domestic","Bank Payment Domestic","Cash Outpayment Order Domestic","Post Payment Abroad","Bank Payment Abroad","SWIFT Payment Abroad","Cash Outpayment Order Abroad";
            }
            column(xAcc; xAcc)
            {
            }
            column(xTxt; xTxt)
            {
            }
            column(BankCode_GenJournalLine; "Recipient Bank Account")
            {
            }
            column(DebitBank_GenJournalLine; "Debit Bank")
            {
            }
            column(VendorLedgerEntryExternalDocumentNo; VendorLedgerEntry."External Document No.")
            {
            }
            column(TotalVendorTxt; TotalVendorTxt)
            {
            }
            column(AmountLCY_GenJournalLine; "Amount (LCY)")
            {
            }
            column(GenJournalLineTotalBankDebitBank; Text006Msg + ' ' + "Debit Bank")
            {
            }
            column(GlSetupLCYCode; GLSetup."LCY Code")
            {
            }
            column(n; n)
            {
            }
            column(LargestAmt; LargestAmt)
            {
            }
            column(PostingDate_GenJournalLine; FORMAT("Posting Date"))
            {
            }
            column(TotalPaymentGlSetupLCYCode; STRSUBSTNO(Text007Lbl, GLSetup."LCY Code"))
            {
            }
            column(LargestAmtGlSetupLCYCode; STRSUBSTNO(Text008Lbl, GLSetup."LCY Code"))
            {
            }
            column(BatchNameCaption; BatchNameCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(DTAPaymentJournalCaption; DTAPaymentJournalCaptionLbl)
            {
            }
            column(PaymentCaption; PaymentCaptionLbl)
            {
            }
            column(AgeCaption; AgeCaptionLbl)
            {
            }
            column(PossCaption; PossCaptionLbl)
            {
            }
            column(DeduCaption; DeduCaptionLbl)
            {
            }
            column(VendorCaption; VendorCaptionLbl)
            {
            }
            column(CashDiscCaption; CashDiscCaptionLbl)
            {
            }
            column(BeforePmtCaption; BeforePmtCaptionLbl)
            {
            }
            column(RestAfterPmtCaption; RestAfterPmtCaptionLbl)
            {
            }
            column(OpenRemAmountCaption; OpenRemAmountCaptionLbl)
            {
            }
            column(ApplicationCaption; ApplicationCaptionLbl)
            {
            }
            column(DateDaysCaption; DateDaysCaptionLbl)
            {
            }
            column(DueCaption; DueCaptionLbl)
            {
            }
            column(CashDiscDaysCaption; CashDiscDaysCaptionLbl)
            {
            }
            column(ToleranceCaption; ToleranceCaptionLbl)
            {
            }
            column(CurrencyCodeCaption_GenJournalLine; FIELDCAPTION("Currency Code"))
            {
            }
            column(BankCaption; BankCaptionLbl)
            {
            }
            column(ReferenceCommentCaption; ReferenceCommentCaptionLbl)
            {
            }
            column(PaymentTypeCaption; PaymentTypeCaptionLbl)
            {
            }
            column(AccountCaption; AccountCaptionLbl)
            {
            }
            column(DebitBankCaption; DebitBankCaptionLbl)
            {
            }
            column(ExternalDocumentCaption; ExternalDocumentCaptionLbl)
            {
            }
            column(VendorBankCaption; VendorBankCaptionLbl)
            {
            }
            column(NoOfPaymentsCaption; NoOfPaymentsCaptionLbl)
            {
            }
            column(PostingDateCaption; PostingDateCaptionLbl)
            {
            }
            column(LineNo_GenJournalLine; "Line No.")
            {
            }
            column(Clearing_GenJournalLine; Clearing)
            {
            }
            column(TotalText; TotalText)
            {
            }
            dataitem(DataItem1000000000; Table25)
            {
                DataItemLink = Vendor No.=FIELD(Account No.),
                               Currency Code=FIELD(Currency Code),
                               Applies-to ID=FIELD(Document No.);
                DataItemTableView = SORTING(Entry No.)
                                    WHERE(Open=CONST(Yes));
                column(DocumentNo; "Document No.")
                {
                }
                column(RemainingAmount; "Remaining Amount")
                {
                }

                trigger OnPreDataItem()
                begin
                    IF "Gen. Journal Line"."Applies-to Doc. No." <> '' THEN CurrReport.SKIP;
                    IF "Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."Account Type"::Vendor THEN CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ("Account No." = '') AND (Amount = 0) THEN
                  CurrReport.SKIP;

                IF oldAccNo <> "Account No." THEN BEGIN
                  oldAccNo := "Account No.";
                  NoOfLinesPerVendor := 0;
                END;

                AgeDays := 0;
                CashDiscDays := 0;
                DueDays := 0;
                CashDeductAmt := 0;
                RestAfterPmt := 0;
                PmtToleranceAmount := 0;
                xTxt := '';
                xAcc := '';
                CLEAR(VendorLedgerEntry);
                CLEAR(VendorBankAccount);
                Vendor.GET("Account No.");

                // Vendor Entries
                IF "Applies-to Doc. No." = '' THEN
                  xTxt := Text000Err
                ELSE BEGIN
                  VendorLedgerEntry.SETCURRENTKEY("Document No.");
                  VendorLedgerEntry.SETRANGE("Document Type","Applies-to Doc. Type");
                  VendorLedgerEntry.SETRANGE("Document No.","Applies-to Doc. No.");
                  VendorLedgerEntry.SETRANGE("Vendor No.","Account No.");
                  IF NOT VendorLedgerEntry.FINDFIRST THEN
                    xTxt := Text001Err
                  ELSE BEGIN
                    IF NOT VendorLedgerEntry.Open THEN
                      xTxt := Text002Err;

                    VendorLedgerEntry.CALCFIELDS("Remaining Amount");

                    // Calc day for age, due date and cash disc.
                    IF VendorLedgerEntry."Posting Date" > 0D THEN
                      AgeDays := "Posting Date" - VendorLedgerEntry."Posting Date";
                    IF VendorLedgerEntry."Pmt. Discount Date" > 0D THEN
                      CashDiscDays := VendorLedgerEntry."Pmt. Discount Date" - "Posting Date";
                    IF VendorLedgerEntry."Due Date" > 0D THEN
                      DueDays := VendorLedgerEntry."Due Date" - "Posting Date";

                    OpenRemAmtFC := -VendorLedgerEntry."Remaining Amount";
                    CashDiscAmtFC := -VendorLedgerEntry."Remaining Pmt. Disc. Possible";

                    // Open entry and remaining for multicurrency. Convert to pmt currency
                    IF VendorLedgerEntry."Currency Code" <> "Currency Code" THEN BEGIN
                      OpenRemAmtFC :=
                        CurrencyExchangeRate.ExchangeAmtFCYToFCY(
                          "Posting Date",VendorLedgerEntry."Currency Code","Currency Code",-VendorLedgerEntry."Remaining Amount");
                      CashDiscAmtFC :=
                        CurrencyExchangeRate.ExchangeAmtFCYToFCY(
                          "Posting Date",VendorLedgerEntry."Currency Code","Currency Code",-VendorLedgerEntry."Original Pmt. Disc. Possible");
                    END;

                    IF (VendorLedgerEntry."Pmt. Discount Date" >= "Posting Date") OR
                       ((VendorLedgerEntry."Pmt. Disc. Tolerance Date" >= "Posting Date") AND
                        VendorLedgerEntry."Accepted Pmt. Disc. Tolerance")
                    THEN
                      CashDeductAmt := -VendorLedgerEntry."Remaining Pmt. Disc. Possible";

                    PmtToleranceAmount := -VendorLedgerEntry."Accepted Payment Tolerance";

                    // Calc rest after pmt (and evtl. cash disc)
                    RestAfterPmt := OpenRemAmtFC - Amount - CashDeductAmt - PmtToleranceAmount;
                    IF RestAfterPmt > 0 THEN BEGIN
                      RestAfterPmt := RestAfterPmt + CashDeductAmt;
                      CashDeductAmt := 0;
                    END;
                  END;
                END;

                // Vendor Bank Account
                IF "Recipient Bank Account" = '' THEN
                  xTxt := Text003Err
                ELSE
                  IF NOT VendorBankAccount.GET("Account No.","Recipient Bank Account") THEN
                    xTxt := Text004Err;

                IF xTxt = '' THEN
                  CASE VendorBankAccount."Payment Form" OF
                    VendorBankAccount."Payment Form"::ESR,VendorBankAccount."Payment Form"::"ESR+":
                      BEGIN
                        xAcc := VendorBankAccount."ESR Account No.";
                        xTxt := VendorLedgerEntry."Reference No.";
                      END;
                    VendorBankAccount."Payment Form"::"Post Payment Domestic":
                      BEGIN
                        IF VendorBankAccount.IBAN <> '' THEN
                          xAcc := DTAMgt.IBANDELCHR(VendorBankAccount.IBAN)
                        ELSE
                          xAcc := VendorBankAccount."Giro Account No.";
                      END;
                    VendorBankAccount."Payment Form"::"Bank Payment Domestic":
                      IF VendorBankAccount.IBAN <> '' THEN
                        xAcc := DTAMgt.IBANDELCHR(VendorBankAccount.IBAN)
                      ELSE BEGIN
                        xTxt := VendorBankAccount."Clearing No.";
                        xAcc := VendorBankAccount."Bank Account No.";
                      END;
                    VendorBankAccount."Payment Form"::"Post Payment Abroad":
                      BEGIN
                        IF VendorBankAccount.IBAN <> '' THEN
                          xAcc := DTAMgt.IBANDELCHR(VendorBankAccount.IBAN)
                        ELSE
                          xAcc := VendorBankAccount."Bank Account No.";
                      END;
                    VendorBankAccount."Payment Form"::"Bank Payment Abroad":
                      IF VendorBankAccount.IBAN <> '' THEN
                        xAcc := DTAMgt.IBANDELCHR(VendorBankAccount.IBAN)
                      ELSE BEGIN
                        xTxt := VendorBankAccount."Bank Identifier Code";
                        xAcc := VendorBankAccount."Bank Account No.";
                      END;
                    VendorBankAccount."Payment Form"::"SWIFT Payment Abroad":
                      IF VendorBankAccount.IBAN <> '' THEN
                        xAcc := DTAMgt.IBANDELCHR(VendorBankAccount.IBAN)
                      ELSE BEGIN
                        xTxt := VendorBankAccount."SWIFT Code";
                        xAcc := VendorBankAccount."Bank Account No.";
                      END;
                  END;

                n := n + 1;
                IF "Amount (LCY)" > LargestAmt THEN
                  LargestAmt := "Amount (LCY)";

                NoOfLinesPerVendor := NoOfLinesPerVendor + 1;
                IF NoOfLinesPerVendor > 1 THEN
                  TotalVendorTxt := Text005Msg + ' ' + "Account No." + ' ' + Vendor.Name;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(Amount,"Amount (LCY)");
                SETRANGE("Account Type","Account Type"::Vendor);
                SETRANGE("Document Type","Document Type"::Payment);

                intLayout := Layout;
                oldAccNo := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Layout; Layout)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Layout';
                        OptionCaption = 'Amounts,Bank';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        GLSetup.GET;
    end;

    var
        Text000Err: Label 'No application number';
        Text001Err: Label 'Vendor entry not found';
        Text002Err: Label 'Vendor entry not open';
        Text003Err: Label 'Bankcode not defined';
        Text004Err: Label 'Vendor bank not found';
        Text005Msg: Label 'Total vendor';
        Text006Msg: Label 'Total bank';
        Text007Lbl: Label 'Total Payment in %1';
        Text008Lbl: Label 'Largest Amount in %1';
        VendorBankAccount: Record "Vendor Bank Account";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        Vendor: Record Vendor;
        //TODO DTAMgt: Codeunit "DTA Setup"; //3010541
        n: Integer;
        "Layout": Option Amounts,Bank;
        xTxt: Text[40];
        xAcc: Text;
        LargestAmt: Decimal;
        TotalVendorTxt: Text[80];
        NoOfLinesPerVendor: Integer;
        AgeDays: Integer;
        CashDiscDays: Integer;
        DueDays: Integer;
        OpenRemAmtFC: Decimal;
        CashDiscAmtFC: Decimal;
        CashDeductAmt: Decimal;
        PmtToleranceAmount: Decimal;
        RestAfterPmt: Decimal;
        intLayout: Integer;
        oldAccNo: Code[20];
        BatchNameCaptionLbl: Label 'Batch Name';
        PageCaptionLbl: Label 'Page';
        DTAPaymentJournalCaptionLbl: Label 'DTA - Payment Journal';
        PaymentCaptionLbl: Label 'Payment';
        AgeCaptionLbl: Label 'Age';
        PossCaptionLbl: Label 'Poss.';
        DeduCaptionLbl: Label 'Dedu.';
        VendorCaptionLbl: Label 'Vendor';
        CashDiscCaptionLbl: Label 'Cash Disc.';
        BeforePmtCaptionLbl: Label 'before Pmt.';
        RestAfterPmtCaptionLbl: Label 'after Pmt.';
        OpenRemAmountCaptionLbl: Label 'Open Rem. Amount';
        ApplicationCaptionLbl: Label 'Application';
        DateDaysCaptionLbl: Label 'Date / Days';
        DueCaptionLbl: Label 'Due';
        CashDiscDaysCaptionLbl: Label 'C Dis.';
        ToleranceCaptionLbl: Label 'Tolerance';
        BankCaptionLbl: Label 'Bank';
        ReferenceCommentCaptionLbl: Label 'Reference / Comment';
        PaymentTypeCaptionLbl: Label 'Pmt. Type';
        AccountCaptionLbl: Label 'Account';
        DebitBankCaptionLbl: Label 'Debit Bank';
        ExternalDocumentCaptionLbl: Label 'Ext. Doc.';
        VendorBankCaptionLbl: Label 'Vendor Bank';
        NoOfPaymentsCaptionLbl: Label 'No. of payments';
        PostingDateCaptionLbl: Label 'Posting Date';
        TotalText: Label 'Journal total';
}

