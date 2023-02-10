report 50072 "DEL Suggest Vendor Payments" //393
{

    Caption = 'Suggest Vendor Payments';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.")
                                WHERE(Blocked = FILTER(= ' '));
            RequestFilterFields = "No.", "Payment Method Code";

            trigger OnAfterGetRecord()
            begin
                CLEAR(VendorBalance);
                CALCFIELDS("Balance (LCY)");
                VendorBalance := "Balance (LCY)";

                IF StopPayments THEN
                    CurrReport.BREAK();
                Window.UPDATE(1, "No.");
                IF VendorBalance > 0 THEN BEGIN
                    GetVendLedgEntries(TRUE, FALSE);
                    GetVendLedgEntries(FALSE, FALSE);
                    CheckAmounts(FALSE);
                    ClearNegative();
                END;
            end;

            trigger OnPostDataItem()
            begin
                IF UsePriority AND NOT StopPayments THEN BEGIN
                    RESET();
                    COPYFILTERS(Vend2);
                    SETCURRENTKEY(Priority);
                    SETRANGE(Priority, 0);
                    IF FIND('-') THEN
                        REPEAT
                            CLEAR(VendorBalance);
                            CALCFIELDS("Balance (LCY)");
                            VendorBalance := "Balance (LCY)";
                            IF VendorBalance > 0 THEN BEGIN
                                Window.UPDATE(1, "No.");
                                GetVendLedgEntries(TRUE, FALSE);
                                GetVendLedgEntries(FALSE, FALSE);
                                CheckAmounts(FALSE);
                                ClearNegative();
                            END;
                        UNTIL (NEXT() = 0) OR StopPayments;
                END;

                IF UsePaymentDisc AND NOT StopPayments THEN BEGIN
                    RESET();
                    COPYFILTERS(Vend2);
                    Window2.OPEN(Text007);
                    IF FIND('-') THEN
                        REPEAT
                            CLEAR(VendorBalance);
                            CALCFIELDS("Balance (LCY)");
                            VendorBalance := "Balance (LCY)";
                            Window2.UPDATE(1, "No.");
                            TempPayableVendLedgEntry.SETRANGE("Vendor No.", "No.");
                            IF VendorBalance > 0 THEN BEGIN
                                GetVendLedgEntries(TRUE, TRUE);
                                GetVendLedgEntries(FALSE, TRUE);
                                CheckAmounts(TRUE);
                                ClearNegative();
                            END;
                        UNTIL (NEXT() = 0) OR StopPayments;
                    Window2.CLOSE();
                END ELSE
                    IF FIND('-') THEN
                        REPEAT
                            ClearNegative();
                        UNTIL NEXT() = 0;

                DimSetEntry.LOCKTABLE();
                GenJnlLine.LOCKTABLE();
                GenJnlTemplate.GET(GenJnlLine."Journal Template Name");
                GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
                GenJnlLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                IF GenJnlLine.FINDLAST() THEN BEGIN
                    LastLineNo := GenJnlLine."Line No.";
                    GenJnlLine.INIT();
                END;

                Window2.OPEN(Text008);

                TempPayableVendLedgEntry.RESET();
                TempPayableVendLedgEntry.SETRANGE(Priority, 1, 2147483647);
                MakeGenJnlLines();
                TempPayableVendLedgEntry.RESET();
                TempPayableVendLedgEntry.SETRANGE(Priority, 0);
                MakeGenJnlLines();
                TempPayableVendLedgEntry.RESET();
                TempPayableVendLedgEntry.DELETEALL();

                Window2.CLOSE();
                Window.CLOSE();
                ShowMessage(MessageText);
            end;

            trigger OnPreDataItem()
            begin
                IF LastDueDateToPayReq = 0D THEN
                    ERROR(Text000);
                IF (PostingDate = 0D) AND (NOT UseDueDateAsPostingDate) THEN
                    ERROR(Text001);

                BankPmtType := GenJnlLine2."Bank Payment Type".AsInteger();
                BalAccType := GenJnlLine2."Bal. Account Type".AsInteger();
                BalAccNo := GenJnlLine2."Bal. Account No.";
                GenJnlLineInserted := FALSE;
                SeveralCurrencies := FALSE;
                MessageText := '';

                IF ((BankPmtType = BankPmtType::" ") OR
                    SummarizePerVend) AND
                   (NextDocNo = '')
                THEN
                    ERROR(Text002);

                IF ((BankPmtType = BankPmtType::"Manual Check") AND
                    NOT SummarizePerVend AND
                    NOT DocNoPerLine)
                THEN
                    ERROR(Text017, GenJnlLine2.FIELDCAPTION("Bank Payment Type"), SELECTSTR(BankPmtType + 1, Text023));

                IF UsePaymentDisc AND (LastDueDateToPayReq < WORKDATE()) THEN
                    IF NOT CONFIRM(Text003, FALSE, WORKDATE()) THEN
                        ERROR(Text005);

                Vend2.COPYFILTERS(Vendor);

                OriginalAmtAvailable := AmountAvailable;
                IF UsePriority THEN BEGIN
                    SETCURRENTKEY(Priority);
                    SETRANGE(Priority, 1, 2147483647);
                    UsePriority := TRUE;
                END;
                Window.OPEN(Text006);

                SelectedDim.SETRANGE("User ID", USERID);
                SelectedDim.SETRANGE("Object Type", 3);
                SelectedDim.SETRANGE("Object ID", REPORT::"Suggest Vendor Payments");
                SummarizePerDim := SelectedDim.FIND('-') AND SummarizePerVend;

                NextEntryNo := 1;
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
                    group("Find Payments")
                    {
                        Caption = 'Find Payments';
                        field(LastPaymentDate; LastDueDateToPayReq)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Last Payment Date';
                            ToolTip = 'Specifies the latest payment date that can appear on the vendor ledger entries to be included in the batch job. Only entries that have a due date or a payment discount date before or on this date will be included. If the payment date is earlier than the system date, a warning will be displayed.';
                        }
                        field(FindPaymentDiscounts; UsePaymentDisc)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Find Payment Discounts';
                            Importance = Additional;
                            MultiLine = true;
                            ToolTip = 'Specifies if you want the batch job to include vendor ledger entries for which you can receive a payment discount.';

                            trigger OnValidate()
                            begin
                                IF UsePaymentDisc AND UseDueDateAsPostingDate THEN
                                    ERROR(PmtDiscUnavailableErr);
                            end;
                        }
                        field(UseVendorPriority; UsePriority)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Use Vendor Priority';
                            Importance = Additional;
                            ToolTip = 'Specifies if the Priority field on the vendor cards will determine in which order vendor entries are suggested for payment by the batch job. The batch job always prioritizes vendors for payment suggestions if you specify an available amount in the Available Amount (LCY) field.';

                            trigger OnValidate()
                            begin
                                IF NOT UsePriority AND (AmountAvailable <> 0) THEN
                                    ERROR(Text011);
                            end;
                        }
                        field("Available Amount (LCY)"; AmountAvailable)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Available Amount (LCY)';
                            Importance = Additional;
                            ToolTip = 'Specifies a maximum amount (in LCY) that is available for payments. The batch job will then create a payment suggestion on the basis of this amount and the Use Vendor Priority check box. It will only include vendor entries that can be paid fully.';

                            trigger OnValidate()
                            begin
                                IF AmountAvailable <> 0 THEN
                                    UsePriority := TRUE;
                            end;
                        }
                        field(SkipExportedPayments; SkipExportedPayments)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Skip Exported Payments';
                            Importance = Additional;
                            ToolTip = 'Specifies if you do not want the batch job to insert payment journal lines for documents for which payments have already been exported to a bank file.';
                        }
                    }
                    group("Summarize Results")
                    {
                        Caption = 'Summarize Results';
                        field(SummarizePerVendor; SummarizePerVend)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Summarize per Vendor';
                            ToolTip = 'Specifies if you want the batch job to make one line per vendor for each currency in which the vendor has ledger entries. If, for example, a vendor uses two currencies, the batch job will create two lines in the payment journal for this vendor. The batch job then uses the Applies-to ID field when the journal lines are posted to apply the lines to vendor ledger entries. If you do not select this check box, then the batch job will make one line per invoice.';

                            trigger OnValidate()
                            begin
                                IF SummarizePerVend AND UseDueDateAsPostingDate THEN
                                    ERROR(PmtDiscUnavailableErr);
                            end;
                        }
                        field(SummarizePerDimText; SummarizePerDimText)
                        {
                            ApplicationArea = Suite;
                            Caption = 'By Dimension';
                            Editable = false;
                            Enabled = SummarizePerDimTextEnable;
                            Importance = Additional;
                            ToolTip = 'Specifies the dimensions that you want the batch job to consider.';

                            trigger OnAssistEdit()
                            var
                                DimSelectionBuf: Record "Dimension Selection Buffer";
                            begin
                                DimSelectionBuf.SetDimSelectionMultiple(3, REPORT::"Suggest Vendor Payments", SummarizePerDimText);
                            end;
                        }
                    }
                    group("Fill in Journal Lines")
                    {
                        Caption = 'Fill in Journal Lines';
                        field(PostingDate; PostingDate)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Posting Date';
                            Editable = UseDueDateAsPostingDate = FALSE;
                            Importance = Promoted;
                            ToolTip = 'Specifies the date for the posting of this batch job. By default, the working date is entered, but you can change it.';

                            trigger OnValidate()
                            begin
                                ValidatePostingDate();
                            end;
                        }
                        field(UseDueDateAsPostingDate; UseDueDateAsPostingDate)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Calculate Posting Date from Applies-to-Doc. Due Date';
                            Importance = Additional;
                            ToolTip = 'Specifies if the due date on the purchase invoice will be used as a basis to calculate the payment posting date.';

                            trigger OnValidate()
                            begin
                                IF UseDueDateAsPostingDate AND (SummarizePerVend OR UsePaymentDisc) THEN
                                    ERROR(PmtDiscUnavailableErr);
                                IF NOT UseDueDateAsPostingDate THEN
                                    CLEAR(DueDateOffset);
                            end;
                        }
                        field(DueDateOffset; DueDateOffset)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Applies-to-Doc. Due Date Offset';
                            Editable = UseDueDateAsPostingDate;
                            Enabled = UseDueDateAsPostingDate;
                            Importance = Additional;
                            ToolTip = 'Specifies a period of time that will separate the payment posting date from the due date on the invoice. Example 1: To pay the invoice on the Friday in the week of the due date, enter CW-2D (current week minus two days). Example 2: To pay the invoice two days before the due date, enter -2D (minus two days).';
                        }
                        field(StartingDocumentNo; NextDocNo)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Starting Document No.';
                            ToolTip = 'Specifies the next available number in the number series for the journal batch that is linked to the payment journal. When you run the batch job, this is the document number that appears on the first payment journal line. You can also fill in this field manually.';

                            //TODO: codeunit 41 (textmanagement) should be changed to (Filter Tokens)& EvaluateIncStr does not exist
                            //             trigger OnValidate()
                            //             var
                            //                 TextManagement: Codeunit "Filter Tokens";
                            //             begin
                            //                 IF NextDocNo <> '' THEN
                            //  TextManagement.EvaluateIncStr(NextDocNo, StartingDocumentNoErr);
                            //             end;
                        }
                        field(NewDocNoPerLine; DocNoPerLine)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'New Doc. No. per Line';
                            Importance = Additional;
                            ToolTip = 'Specifies if you want the batch job to fill in the payment journal lines with consecutive document numbers, starting with the document number specified in the Starting Document No. field.';

                            trigger OnValidate()
                            begin
                                IF NOT UsePriority AND (AmountAvailable <> 0) THEN
                                    ERROR(Text013);
                            end;
                        }
                        field(BalAccountType; GenJnlLine2."Bal. Account Type")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Account Type';
                            Importance = Additional;
                            OptionCaption = 'G/L Account,,,Bank Account';
                            ToolTip = 'Specifies the balancing account type that payments on the payment journal are posted to.';

                            trigger OnValidate()
                            begin
                                GenJnlLine2."Bal. Account No." := '';
                            end;
                        }
                        field(BalAccountNo; GenJnlLine2."Bal. Account No.")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bal. Account No.';
                            Importance = Additional;
                            ToolTip = 'Specifies the balancing account number that payments on the payment journal are posted to.';

                            trigger OnLookup(var Text: Text): Boolean
                            begin
                                CASE GenJnlLine2."Bal. Account Type" OF
                                    GenJnlLine2."Bal. Account Type"::"G/L Account":
                                        IF PAGE.RUNMODAL(0, GLAcc) = ACTION::LookupOK THEN
                                            GenJnlLine2."Bal. Account No." := GLAcc."No.";
                                    GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Vendor:
                                        ERROR(Text009, GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                                    GenJnlLine2."Bal. Account Type"::"Bank Account":
                                        IF PAGE.RUNMODAL(0, BankAcc) = ACTION::LookupOK THEN
                                            GenJnlLine2."Bal. Account No." := BankAcc."No.";
                                END;
                            end;

                            trigger OnValidate()
                            begin
                                IF GenJnlLine2."Bal. Account No." <> '' THEN
                                    CASE GenJnlLine2."Bal. Account Type" OF
                                        GenJnlLine2."Bal. Account Type"::"G/L Account":
                                            GLAcc.GET(GenJnlLine2."Bal. Account No.");
                                        GenJnlLine2."Bal. Account Type"::Customer, GenJnlLine2."Bal. Account Type"::Vendor:
                                            ERROR(Text009, GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                                        GenJnlLine2."Bal. Account Type"::"Bank Account":
                                            BankAcc.GET(GenJnlLine2."Bal. Account No.");
                                    END;
                            end;
                        }
                        field(BankPaymentType; GenJnlLine2."Bank Payment Type")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Bank Payment Type';
                            Importance = Additional;
                            OptionCaption = ' ,Computer Check,Manual Check';
                            ToolTip = 'Specifies the check type to be used, if you use Bank Account as the balancing account type.';

                            trigger OnValidate()
                            begin
                                IF (GenJnlLine2."Bal. Account Type" <> GenJnlLine2."Bal. Account Type"::"Bank Account") AND
                                   (GenJnlLine2."Bank Payment Type" > 0)
                                THEN
                                    ERROR(
                                      Text010,
                                      GenJnlLine2.FIELDCAPTION("Bank Payment Type"),
                                      GenJnlLine2.FIELDCAPTION("Bal. Account Type"));
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            SummarizePerDimTextEnable := TRUE;
            SkipExportedPayments := TRUE;
        end;

        trigger OnOpenPage()
        begin
            IF LastDueDateToPayReq = 0D THEN
                LastDueDateToPayReq := WORKDATE();
            IF PostingDate = 0D THEN
                PostingDate := WORKDATE();
            ValidatePostingDate();
            SetDefaults();
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        COMMIT();
        IF NOT TempVendorLedgEntry.ISEMPTY THEN
            IF CONFIRM(Text024) THEN
                PAGE.RUNMODAL(0, TempVendorLedgEntry);
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET();
        TempVendorLedgEntry.DELETEALL();
        ShowPostingDateWarning := FALSE;
    end;

    var
        BankAcc: Record "Bank Account";
        CompanyInformation: Record "Company Information";
        DimSetEntry: Record "Dimension Set Entry";
        GLAcc: Record "G/L Account";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLine2: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        TempPayableVendLedgEntry: Record "Payable Vendor Ledger Entry" temporary;
        TempOldPaymentBuffer: Record "Payment Buffer" temporary;
        TempPaymentBuffer: Record "Payment Buffer" temporary;
        SelectedDim: Record "Selected Dimension";
        Vend2: Record Vendor;
        TempVendorLedgEntry: Record "Vendor Ledger Entry" temporary;
        VendLedgEntry: Record "Vendor Ledger Entry";
        DimBufMgt: Codeunit "Dimension Buffer Management";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DueDateOffset: DateFormula;
        DocNoPerLine: Boolean;
        GenJnlLineInserted: Boolean;
        SeveralCurrencies: Boolean;
        ShowPostingDateWarning: Boolean;
        SkipExportedPayments: Boolean;
        StopPayments: Boolean;
        SummarizePerDim: Boolean;
        [InDataSet]
        SummarizePerDimTextEnable: Boolean;
        SummarizePerVend: Boolean;
        UseDueDateAsPostingDate: Boolean;
        UsePaymentDisc: Boolean;
        UsePriority: Boolean;
        BalAccNo: Code[20];
        NextDocNo: Code[20];
        LastDueDateToPayReq: Date;
        PostingDate: Date;
        AmountAvailable: Decimal;
        OriginalAmtAvailable: Decimal;
        VendorBalance: Decimal;
        Window: Dialog;
        Window2: Dialog;
        LastLineNo: Integer;
        NextEntryNo: Integer;
        MessageToRecipientMsg: Label 'Payment of %1 %2 ';
        PmtDiscUnavailableErr: Label 'You cannot use Find Payment Discounts or Summarize per Vendor together with Calculate Posting Date from Applies-to-Doc. Due Date, because the resulting posting date might not match the payment discount date.';
        ReplacePostingDateMsg: Label 'For one or more entries, the requested posting date is before the work date.\\These posting dates will use the work date.';
        Text000: Label 'In the Last Payment Date field, specify the last possible date that payments must be made.';
        Text001: Label 'In the Posting Date field, specify the date that will be used as the posting date for the journal entries.';
        Text002: Label 'In the Starting Document No. field, specify the first document number to be used.';
        Text003: Label 'The payment date is earlier than %1.\\Do you still want to run the batch job?';
        Text005: Label 'The batch job was interrupted.';
        Text006: Label 'Processing vendors     #1##########';
        Text007: Label 'Processing vendors for payment discounts #1##########';
        Text008: Label 'Inserting payment journal lines #1##########';
        Text009: Label '%1 must be G/L Account or Bank Account.';
        Text010: Label '%1 must be filled only when %2 is Bank Account.';
        Text011: Label 'Use Vendor Priority must be activated when the value in the Amount Available field is not 0.';
        Text013: Label 'Use Vendor Priority must be activated when the value in the Amount Available Amount (LCY) field is not 0.';
        Text014: Label 'Payment to vendor %1';
        Text015: Label 'Payment of %1 %2';
        Text017: Label 'If %1 = %2 and you have not selected the Summarize per Vendor field,\ then you must select the New Doc. No. per Line.';
        Text020: Label 'You have only created suggested vendor payment lines for the %1 %2.\ However, there are other open vendor ledger entries in currencies other than %2.\\';
        Text021: Label 'You have only created suggested vendor payment lines for the %1 %2.\ There are no other open vendor ledger entries in other currencies.\\';
        Text022: label 'You have created suggested vendor payment lines for all currencies.\\';
        Text023: Label 'Computer Check,Manual Check';
        Text024: Label 'There are one or more entries for which no payment suggestions have been made because the posting dates of the entries are later than the requested posting date. Do you want to see the entries?';
        Text025: Label 'The %1 with the number %2 has a %3 with the number %4.';
        BankPmtType: Option " ","Computer Check","Manual Check";
        BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account";
        MessageText: Text;
        SummarizePerDimText: Text[250];

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine := NewGenJnlLine;
    end;

    local procedure ValidatePostingDate()
    begin
        GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        IF GenJnlBatch."No. Series" = '' THEN
            NextDocNo := ''
        ELSE BEGIN
            NextDocNo := NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series", PostingDate, FALSE);
            CLEAR(NoSeriesMgt);
        END;
    end;

    procedure InitializeRequest(LastPmtDate: Date; FindPmtDisc: Boolean; NewAvailableAmount: Decimal; NewSkipExportedPayments: Boolean; NewPostingDate: Date; NewStartDocNo: Code[20]; NewSummarizePerVend: Boolean; BalAccTypeP: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccN: Code[20]; BankPmtType: Option " ","Computer Check","Manual Check")
    begin
        LastDueDateToPayReq := LastPmtDate;
        UsePaymentDisc := FindPmtDisc;
        AmountAvailable := NewAvailableAmount;
        SkipExportedPayments := NewSkipExportedPayments;
        PostingDate := NewPostingDate;
        NextDocNo := NewStartDocNo;
        SummarizePerVend := NewSummarizePerVend;
        GenJnlLine2."Bal. Account Type" := BalAccTypeP;
        GenJnlLine2."Bal. Account No." := BalAccN;
        GenJnlLine2."Bank Payment Type" := BankPmtType;
    end;

    local procedure GetVendLedgEntries(Positive: Boolean; Future: Boolean)
    begin
        VendLedgEntry.RESET();
        VendLedgEntry.SETCURRENTKEY("Vendor No.", Open, Positive, "Due Date");
        VendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
        VendLedgEntry.SETRANGE(Open, TRUE);
        VendLedgEntry.SETRANGE(Positive, Positive);
        VendLedgEntry.SETRANGE("Applies-to ID", '');
        IF Future THEN BEGIN
            VendLedgEntry.SETRANGE("Due Date", LastDueDateToPayReq + 1, DMY2DATE(31, 12, 9999));
            VendLedgEntry.SETRANGE("Pmt. Discount Date", PostingDate, LastDueDateToPayReq);
            VendLedgEntry.SETFILTER("Remaining Pmt. Disc. Possible", '<>0');
        END ELSE
            VendLedgEntry.SETRANGE("Due Date", 0D, LastDueDateToPayReq);
        IF SkipExportedPayments THEN
            VendLedgEntry.SETRANGE("Exported to Payment File", FALSE);
        VendLedgEntry.SETRANGE("On Hold", '');
        VendLedgEntry.SETFILTER("Currency Code", Vendor.GETFILTER("Currency Filter"));
        VendLedgEntry.SETFILTER("Global Dimension 1 Code", Vendor.GETFILTER("Global Dimension 1 Filter"));
        VendLedgEntry.SETFILTER("Global Dimension 2 Code", Vendor.GETFILTER("Global Dimension 2 Filter"));

        IF VendLedgEntry.FIND('-') THEN
            REPEAT
                SaveAmount();
                IF VendLedgEntry."Accepted Pmt. Disc. Tolerance" OR
                   (VendLedgEntry."Accepted Payment Tolerance" <> 0)
                THEN BEGIN
                    VendLedgEntry."Accepted Pmt. Disc. Tolerance" := FALSE;
                    VendLedgEntry."Accepted Payment Tolerance" := 0;
                    CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
                END;
            UNTIL VendLedgEntry.NEXT() = 0;
    end;

    local procedure SaveAmount()
    var
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
    begin
        GenJnlLine.INIT();
        SetPostingDate(GenJnlLine, VendLedgEntry."Due Date", PostingDate);
        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
        GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
        Vend2.GET(VendLedgEntry."Vendor No.");
        Vend2.CheckBlockedVendOnJnls(Vend2, GenJnlLine."Document Type", FALSE);
        GenJnlLine.Description := Vend2.Name;
        GenJnlLine."Posting Group" := Vend2."Vendor Posting Group";
        GenJnlLine."Salespers./Purch. Code" := Vend2."Purchaser Code";
        GenJnlLine."Payment Terms Code" := Vend2."Payment Terms Code";
        GenJnlLine.VALIDATE("Bill-to/Pay-to No.", GenJnlLine."Account No.");
        GenJnlLine.VALIDATE("Sell-to/Buy-from No.", GenJnlLine."Account No.");
        GenJnlLine."Gen. Posting Type" := "General Posting Type"::" ";
        GenJnlLine."Gen. Bus. Posting Group" := '';
        GenJnlLine."Gen. Prod. Posting Group" := '';
        GenJnlLine."VAT Bus. Posting Group" := '';
        GenJnlLine."VAT Prod. Posting Group" := '';
        GenJnlLine.VALIDATE("Currency Code", VendLedgEntry."Currency Code");
        GenJnlLine.VALIDATE("Payment Terms Code");
        VendLedgEntry.CALCFIELDS("Remaining Amount");
        IF PaymentToleranceMgt.CheckCalcPmtDiscGenJnlVend(GenJnlLine, VendLedgEntry, 0, FALSE) THEN
            GenJnlLine.Amount := -(VendLedgEntry."Remaining Amount" - VendLedgEntry."Remaining Pmt. Disc. Possible")
        ELSE
            GenJnlLine.Amount := -VendLedgEntry."Remaining Amount";
        GenJnlLine.VALIDATE(Amount);

        IF UsePriority THEN
            TempPayableVendLedgEntry.Priority := Vendor.Priority
        ELSE
            TempPayableVendLedgEntry.Priority := 0;
        TempPayableVendLedgEntry."Vendor No." := VendLedgEntry."Vendor No.";
        TempPayableVendLedgEntry."Entry No." := NextEntryNo;
        TempPayableVendLedgEntry."Vendor Ledg. Entry No." := VendLedgEntry."Entry No.";
        TempPayableVendLedgEntry.Amount := GenJnlLine.Amount;
        TempPayableVendLedgEntry."Amount (LCY)" := GenJnlLine."Amount (LCY)";
        TempPayableVendLedgEntry.Positive := (TempPayableVendLedgEntry.Amount > 0);
        TempPayableVendLedgEntry.Future := (VendLedgEntry."Due Date" > LastDueDateToPayReq);
        TempPayableVendLedgEntry."Currency Code" := VendLedgEntry."Currency Code";
        TempPayableVendLedgEntry.INSERT();
        NextEntryNo := NextEntryNo + 1;
    end;

    local procedure CheckAmounts(Future: Boolean)
    var
        PrevCurrency: Code[10];
        CurrencyBalance: Decimal;
    begin
        TempPayableVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");
        TempPayableVendLedgEntry.SETRANGE(Future, Future);

        IF TempPayableVendLedgEntry.FIND('-') THEN BEGIN
            REPEAT
                IF TempPayableVendLedgEntry."Currency Code" <> PrevCurrency THEN BEGIN
                    IF CurrencyBalance > 0 THEN
                        AmountAvailable := AmountAvailable - CurrencyBalance;
                    CurrencyBalance := 0;
                    PrevCurrency := TempPayableVendLedgEntry."Currency Code";
                END;
                IF (OriginalAmtAvailable = 0) OR
                   (AmountAvailable >= CurrencyBalance + TempPayableVendLedgEntry."Amount (LCY)")
                THEN
                    CurrencyBalance := CurrencyBalance + TempPayableVendLedgEntry."Amount (LCY)"
                ELSE
                    TempPayableVendLedgEntry.DELETE();
            UNTIL TempPayableVendLedgEntry.NEXT() = 0;
            IF OriginalAmtAvailable > 0 THEN
                AmountAvailable := AmountAvailable - CurrencyBalance;
            IF (OriginalAmtAvailable > 0) AND (AmountAvailable <= 0) THEN
                StopPayments := TRUE;
        END;
        TempPayableVendLedgEntry.RESET();
    end;

    local procedure MakeGenJnlLines()
    var
        DimBuf: Record "Dimension Buffer";
        GenJnlLine1: Record "Gen. Journal Line";
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        RemainingAmtAvailable: Decimal;
    begin
        TempPaymentBuffer.RESET();
        TempPaymentBuffer.DELETEALL();

        IF BalAccType = BalAccType::"Bank Account" THEN BEGIN
            CheckCurrencies(BalAccType, BalAccNo, TempPayableVendLedgEntry);
            SetBankAccCurrencyFilter(BalAccType, BalAccNo, TempPayableVendLedgEntry);
        END;

        IF OriginalAmtAvailable <> 0 THEN BEGIN
            RemainingAmtAvailable := OriginalAmtAvailable;
            RemovePaymentsAboveLimit(TempPayableVendLedgEntry, RemainingAmtAvailable);
        END;
        IF TempPayableVendLedgEntry.FIND('-') THEN
            REPEAT
                TempPayableVendLedgEntry.SETRANGE("Vendor No.", TempPayableVendLedgEntry."Vendor No.");
                TempPayableVendLedgEntry.FIND('-');
                REPEAT
                    VendLedgEntry.GET(TempPayableVendLedgEntry."Vendor Ledg. Entry No.");
                    SetPostingDate(GenJnlLine1, VendLedgEntry."Due Date", PostingDate);
                    IF VendLedgEntry."Posting Date" <= GenJnlLine1."Posting Date" THEN BEGIN
                        TempPaymentBuffer."Vendor No." := VendLedgEntry."Vendor No.";
                        TempPaymentBuffer."Currency Code" := VendLedgEntry."Currency Code";
                        TempPaymentBuffer."Payment Method Code" := VendLedgEntry."Payment Method Code";
                        TempPaymentBuffer."Creditor No." := VendLedgEntry."Creditor No.";
                        TempPaymentBuffer."Payment Reference" := VendLedgEntry."Payment Reference";
                        TempPaymentBuffer."Exported to Payment File" := VendLedgEntry."Exported to Payment File";
                        TempPaymentBuffer."Applies-to Ext. Doc. No." := VendLedgEntry."External Document No.";

                        SetTempPaymentBufferDims(DimBuf);

                        VendLedgEntry.CALCFIELDS("Remaining Amount");

                        IF SummarizePerVend THEN BEGIN
                            TempPaymentBuffer."Vendor Ledg. Entry No." := 0;
                            IF TempPaymentBuffer.FIND() THEN BEGIN
                                TempPaymentBuffer.Amount := TempPaymentBuffer.Amount + TempPayableVendLedgEntry.Amount;
                                TempPaymentBuffer.MODIFY();
                            END ELSE BEGIN
                                TempPaymentBuffer."Document No." := NextDocNo;
                                NextDocNo := INCSTR(NextDocNo);
                                TempPaymentBuffer.Amount := TempPayableVendLedgEntry.Amount;
                                Window2.UPDATE(1, VendLedgEntry."Vendor No.");
                                TempPaymentBuffer.INSERT();
                            END;
                            VendLedgEntry."Applies-to ID" := TempPaymentBuffer."Document No.";
                        END ELSE
                            IF NOT IsEntryAlreadyApplied(GenJnlLine, VendLedgEntry) THEN BEGIN
                                TempPaymentBuffer."Vendor Ledg. Entry Doc. Type" := VendLedgEntry."Document Type";
                                TempPaymentBuffer."Vendor Ledg. Entry Doc. No." := VendLedgEntry."Document No.";
                                TempPaymentBuffer."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code";
                                TempPaymentBuffer."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code";
                                TempPaymentBuffer."Dimension Set ID" := VendLedgEntry."Dimension Set ID";
                                TempPaymentBuffer."Vendor Ledg. Entry No." := VendLedgEntry."Entry No.";
                                TempPaymentBuffer.Amount := TempPayableVendLedgEntry.Amount;
                                Window2.UPDATE(1, VendLedgEntry."Vendor No.");
                                TempPaymentBuffer.INSERT();
                            END;

                        VendLedgEntry."Amount to Apply" := VendLedgEntry."Remaining Amount";
                        CODEUNIT.RUN(CODEUNIT::"Vend. Entry-Edit", VendLedgEntry);
                    END ELSE BEGIN
                        TempVendorLedgEntry := VendLedgEntry;
                        TempVendorLedgEntry.INSERT();
                    END;

                    TempPayableVendLedgEntry.DELETE();
                    IF OriginalAmtAvailable <> 0 THEN BEGIN
                        RemainingAmtAvailable := RemainingAmtAvailable - TempPayableVendLedgEntry."Amount (LCY)";
                        RemovePaymentsAboveLimit(TempPayableVendLedgEntry, RemainingAmtAvailable);
                    END;

                UNTIL NOT TempPayableVendLedgEntry.FINDSET();
                TempPayableVendLedgEntry.DELETEALL();
                TempPayableVendLedgEntry.SETRANGE("Vendor No.");
            UNTIL NOT TempPayableVendLedgEntry.FIND('-');

        CLEAR(TempOldPaymentBuffer);
        TempPaymentBuffer.SETCURRENTKEY("Document No.");
        TempPaymentBuffer.SETFILTER(
          "Vendor Ledg. Entry Doc. Type", '<>%1&<>%2', TempPaymentBuffer."Vendor Ledg. Entry Doc. Type"::Refund,
          TempPaymentBuffer."Vendor Ledg. Entry Doc. Type"::Payment);
        IF TempPaymentBuffer.FIND('-') THEN
            REPEAT
                GenJnlLine.INIT();
                Window2.UPDATE(1, TempPaymentBuffer."Vendor No.");
                LastLineNo := LastLineNo + 10000;
                GenJnlLine."Line No." := LastLineNo;
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                GenJnlLine."Posting No. Series" := GenJnlBatch."Posting No. Series";
                IF SummarizePerVend THEN
                    GenJnlLine."Document No." := TempPaymentBuffer."Document No."
                ELSE
                    IF DocNoPerLine THEN BEGIN
                        IF TempPaymentBuffer.Amount < 0 THEN
                            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;

                        GenJnlLine."Document No." := NextDocNo;
                        NextDocNo := INCSTR(NextDocNo);
                    END ELSE
                        IF (TempPaymentBuffer."Vendor No." = TempOldPaymentBuffer."Vendor No.") AND
                           (TempPaymentBuffer."Currency Code" = TempOldPaymentBuffer."Currency Code")
                        THEN
                            GenJnlLine."Document No." := TempOldPaymentBuffer."Document No."
                        ELSE BEGIN
                            GenJnlLine."Document No." := NextDocNo;
                            NextDocNo := INCSTR(NextDocNo);
                            TempOldPaymentBuffer := TempPaymentBuffer;
                            TempOldPaymentBuffer."Document No." := GenJnlLine."Document No.";
                        END;
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                GenJnlLine.SetHideValidation(TRUE);
                ShowPostingDateWarning := ShowPostingDateWarning OR
                  SetPostingDate(GenJnlLine, GetApplDueDate(TempPaymentBuffer."Vendor Ledg. Entry No."), PostingDate);
                GenJnlLine.VALIDATE("Account No.", TempPaymentBuffer."Vendor No.");
                Vendor.GET(TempPaymentBuffer."Vendor No.");
                IF (Vendor."Pay-to Vendor No." <> '') AND (Vendor."Pay-to Vendor No." <> GenJnlLine."Account No.") THEN
                    MESSAGE(Text025, Vendor.TABLECAPTION, Vendor."No.", Vendor.FIELDCAPTION("Pay-to Vendor No."),
                      Vendor."Pay-to Vendor No.");
                GenJnlLine."Bal. Account Type" := BalAccType;
                GenJnlLine.VALIDATE("Bal. Account No.", BalAccNo);
                GenJnlLine.VALIDATE("Currency Code", TempPaymentBuffer."Currency Code");
                GenJnlLine."Message to Recipient" := GetMessageToRecipient(SummarizePerVend);
                GenJnlLine."Bank Payment Type" := BankPmtType;
                IF SummarizePerVend THEN BEGIN
                    GenJnlLine."Applies-to ID" := GenJnlLine."Document No.";
                    GenJnlLine.Description := STRSUBSTNO(Text014, TempPaymentBuffer."Vendor No.");
                END ELSE
                    GenJnlLine.Description :=
                      STRSUBSTNO(
                        Text015,
                        TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
                        TempPaymentBuffer."Vendor Ledg. Entry Doc. No.");
                GenJnlLine."Source Line No." := TempPaymentBuffer."Vendor Ledg. Entry No.";
                GenJnlLine."Shortcut Dimension 1 Code" := TempPaymentBuffer."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := TempPaymentBuffer."Global Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := TempPaymentBuffer."Dimension Set ID";
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                GenJnlLine."Reason Code" := GenJnlBatch."Reason Code";
                GenJnlLine.VALIDATE(Amount, TempPaymentBuffer.Amount);
                GenJnlLine."Applies-to Doc. Type" := TempPaymentBuffer."Vendor Ledg. Entry Doc. Type";
                GenJnlLine."Applies-to Doc. No." := TempPaymentBuffer."Vendor Ledg. Entry Doc. No.";
                GenJnlLine."Payment Method Code" := TempPaymentBuffer."Payment Method Code";
                GenJnlLine."Creditor No." := TempPaymentBuffer."Creditor No.";
                GenJnlLine."Payment Reference" := TempPaymentBuffer."Payment Reference";
                GenJnlLine."Exported to Payment File" := TempPaymentBuffer."Exported to Payment File";
                GenJnlLine."Applies-to Ext. Doc. No." := TempPaymentBuffer."Applies-to Ext. Doc. No.";

                IF VendorLedgerEntry.GET(TempPaymentBuffer."Vendor Ledg. Entry No.") THEN
                //STD : "Reference No." := VendorLedgerEntry."Reference No.";
                BEGIN
                    GenJnlLine."Reference No." := VendorLedgerEntry."Reference No.";
                    IF (VendorLedgerEntry."Recipient Bank Account" <> '') THEN
                        GenJnlLine."Recipient Bank Account" := VendorLedgerEntry."Recipient Bank Account";
                END;
                UpdateDimensions(GenJnlLine);
                GenJnlLine.INSERT();
                GenJnlLineInserted := TRUE;
            UNTIL TempPaymentBuffer.NEXT() = 0;
    end;

    local procedure UpdateDimensions(var GenJnlLineP: Record "Gen. Journal Line")
    var
        DimBuf: Record "Dimension Buffer";
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
        TempDimSetEntry2: Record "Dimension Set Entry" temporary;
        DimVal: Record "Dimension Value";
        DimSetIDArr: array[10] of Integer;
        NewDimensionID: Integer;
    begin
        NewDimensionID := GenJnlLineP."Dimension Set ID";
        IF SummarizePerVend THEN BEGIN
            DimBuf.RESET();
            DimBuf.DELETEALL();
            DimBufMgt.GetDimensions(TempPaymentBuffer."Dimension Entry No.", DimBuf);
            IF DimBuf.FINDSET() THEN
                REPEAT
                    DimVal.GET(DimBuf."Dimension Code", DimBuf."Dimension Value Code");
                    TempDimSetEntry."Dimension Code" := DimBuf."Dimension Code";
                    TempDimSetEntry."Dimension Value Code" := DimBuf."Dimension Value Code";
                    TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
                    TempDimSetEntry.INSERT();
                UNTIL DimBuf.NEXT() = 0;
            NewDimensionID := DimMgt.GetDimensionSetID(TempDimSetEntry);
            GenJnlLineP."Dimension Set ID" := NewDimensionID;
        END;
        GenJnlLineP.CreateDim(
          DimMgt.TypeToTableID1(GenJnlLineP."Account Type".AsInteger()), GenJnlLineP."Account No.",
          DimMgt.TypeToTableID1(GenJnlLineP."Bal. Account Type".AsInteger()), GenJnlLineP."Bal. Account No.",
          DATABASE::Job, GenJnlLineP."Job No.",
          DATABASE::"Salesperson/Purchaser", GenJnlLineP."Salespers./Purch. Code",
          DATABASE::Campaign, GenJnlLineP."Campaign No.");
        IF NewDimensionID <> GenJnlLineP."Dimension Set ID" THEN BEGIN
            DimSetIDArr[1] := GenJnlLineP."Dimension Set ID";
            DimSetIDArr[2] := NewDimensionID;
            GenJnlLineP."Dimension Set ID" :=
              DimMgt.GetCombinedDimensionSetID(DimSetIDArr, GenJnlLineP."Shortcut Dimension 1 Code", GenJnlLineP."Shortcut Dimension 2 Code");
        END;

        IF SummarizePerVend THEN BEGIN
            DimMgt.GetDimensionSet(TempDimSetEntry, GenJnlLineP."Dimension Set ID");
            IF AdjustAgainstSelectedDim(TempDimSetEntry, TempDimSetEntry2) THEN
                GenJnlLineP."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry2);
            DimMgt.UpdateGlobalDimFromDimSetID(GenJnlLineP."Dimension Set ID", GenJnlLineP."Shortcut Dimension 1 Code",
              GenJnlLineP."Shortcut Dimension 2 Code");
        END;
    end;

    local procedure SetBankAccCurrencyFilter(BalAccTypeP: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableVendLedgEntry: Record "Payable Vendor Ledger Entry")
    var
        BankAccL: Record "Bank Account";
    begin
        IF BalAccTypeP = BalAccTypeP::"Bank Account" THEN
            IF BalAccNo <> '' THEN BEGIN
                BankAccL.GET(BalAccNo);
                IF BankAccL."Currency Code" <> '' THEN
                    TmpPayableVendLedgEntry.SETRANGE("Currency Code", BankAccL."Currency Code");
            END;
    end;

    local procedure ShowMessage(Text: Text)
    begin
        IF GenJnlLineInserted THEN BEGIN
            IF ShowPostingDateWarning THEN
                Text += ReplacePostingDateMsg;
            IF Text <> '' THEN
                MESSAGE(Text);
        END;
    end;

    local procedure CheckCurrencies(BalAccType: Option "G/L Account",Customer,Vendor,"Bank Account"; BalAccNo: Code[20]; var TmpPayableVendLedgEntry: Record "Payable Vendor Ledger Entry")
    var
        BankAccL: Record "Bank Account";
        TmpPayableVendLedgEntry2: Record "Payable Vendor Ledger Entry" temporary;
    begin
        IF BalAccType = BalAccType::"Bank Account" THEN
            IF BalAccNo <> '' THEN BEGIN
                BankAccL.GET(BalAccNo);
                IF BankAccL."Currency Code" <> '' THEN BEGIN
                    TmpPayableVendLedgEntry2.RESET();
                    TmpPayableVendLedgEntry2.DELETEALL();
                    IF TmpPayableVendLedgEntry.FIND('-') THEN
                        REPEAT
                            TmpPayableVendLedgEntry2 := TmpPayableVendLedgEntry;
                            TmpPayableVendLedgEntry2.INSERT();
                        UNTIL TmpPayableVendLedgEntry.NEXT() = 0;

                    TmpPayableVendLedgEntry2.SETFILTER("Currency Code", '<>%1', BankAccL."Currency Code");
                    SeveralCurrencies := SeveralCurrencies OR TmpPayableVendLedgEntry2.FINDFIRST();

                    IF SeveralCurrencies THEN
                        MessageText :=
                          STRSUBSTNO(Text020, BankAccL.FIELDCAPTION("Currency Code"), BankAccL."Currency Code")
                    ELSE
                        MessageText :=
                          STRSUBSTNO(Text021, BankAccL.FIELDCAPTION("Currency Code"), BankAccL."Currency Code");
                END ELSE
                    MessageText := Text022;
            END;
    end;

    local procedure ClearNegative()
    var
        TempCurrency: Record Currency temporary;
        PayableVendLedgEntry2: Record "Payable Vendor Ledger Entry" temporary;
        CurrencyBalance: Decimal;
    begin
        CLEAR(TempPayableVendLedgEntry);
        TempPayableVendLedgEntry.SETRANGE("Vendor No.", Vendor."No.");

        WHILE TempPayableVendLedgEntry.NEXT() <> 0 DO BEGIN
            TempCurrency.Code := TempPayableVendLedgEntry."Currency Code";
            CurrencyBalance := 0;
            IF TempCurrency.INSERT() THEN BEGIN
                PayableVendLedgEntry2 := TempPayableVendLedgEntry;
                TempPayableVendLedgEntry.SETRANGE("Currency Code", TempPayableVendLedgEntry."Currency Code");
                REPEAT
                    CurrencyBalance := CurrencyBalance + TempPayableVendLedgEntry."Amount (LCY)"
                UNTIL TempPayableVendLedgEntry.NEXT() = 0;
                IF CurrencyBalance < 0 THEN BEGIN
                    TempPayableVendLedgEntry.DELETEALL();
                    AmountAvailable += CurrencyBalance;
                END;
                TempPayableVendLedgEntry.SETRANGE("Currency Code");
                TempPayableVendLedgEntry := PayableVendLedgEntry2;
            END;
        END;
        TempPayableVendLedgEntry.RESET();
    end;

    local procedure DimCodeIsInDimBuf(DimCode: Code[20]; DimBuf: Record "Dimension Buffer"): Boolean //360
    begin
        DimBuf.RESET();
        DimBuf.SETRANGE("Dimension Code", DimCode);
        EXIT(NOT DimBuf.ISEMPTY);
    end;

    local procedure RemovePaymentsAboveLimit(var PayableVendLedgEntry: Record "Payable Vendor Ledger Entry"; RemainingAmtAvailable: Decimal)
    begin
        PayableVendLedgEntry.SETFILTER("Amount (LCY)", '>%1', RemainingAmtAvailable);
        PayableVendLedgEntry.DELETEALL();
        PayableVendLedgEntry.SETRANGE("Amount (LCY)");
    end;

    local procedure InsertDimBuf(var DimBuf: Record "Dimension Buffer"; TableID: Integer; EntryNo: Integer; DimCode: Code[20]; DimValue: Code[20])
    begin
        DimBuf.INIT();
        DimBuf."Table ID" := TableID;
        DimBuf."Entry No." := EntryNo;
        DimBuf."Dimension Code" := DimCode;
        DimBuf."Dimension Value Code" := DimValue;
        DimBuf.INSERT();
    end;

    local procedure GetMessageToRecipient(SummarizePerVend: Boolean): Text[140]
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        IF SummarizePerVend THEN
            EXIT(CompanyInformation.Name);

        VendorLedgerEntry.GET(TempPaymentBuffer."Vendor Ledg. Entry No.");
        IF VendorLedgerEntry."Message to Recipient" <> '' THEN
            EXIT(VendorLedgerEntry."Message to Recipient");

        EXIT(
          STRSUBSTNO(
            MessageToRecipientMsg,
            TempPaymentBuffer."Vendor Ledg. Entry Doc. Type",
            TempPaymentBuffer."Applies-to Ext. Doc. No."));
    end;

    local procedure SetPostingDate(var GenJnlLine: Record "Gen. Journal Line"; DueDate: Date; PostingDate: Date): Boolean
    begin
        IF NOT UseDueDateAsPostingDate THEN BEGIN
            GenJnlLine.VALIDATE("Posting Date", PostingDate);
            EXIT(FALSE);
        END;

        IF DueDate = 0D THEN
            DueDate := GenJnlLine.GetAppliesToDocDueDate();
        EXIT(GenJnlLine.SetPostingDateAsDueDate(DueDate, DueDateOffset));
    end;

    local procedure GetApplDueDate(VendLedgEntryNo: Integer): Date
    var
        AppliedVendLedgEntry: Record "Vendor Ledger Entry";
    begin
        IF AppliedVendLedgEntry.GET(VendLedgEntryNo) THEN
            EXIT(AppliedVendLedgEntry."Due Date");

        EXIT(PostingDate);
    end;

    local procedure AdjustAgainstSelectedDim(var TempDimSetEntry: Record "Dimension Set Entry" temporary; var TempDimSetEntry2: Record "Dimension Set Entry" temporary): Boolean //480
    begin
        IF SelectedDim.FINDSET() THEN BEGIN
            REPEAT
                TempDimSetEntry.SETRANGE("Dimension Code", SelectedDim."Dimension Code");
                IF TempDimSetEntry.FINDFIRST() THEN BEGIN
                    TempDimSetEntry2.TRANSFERFIELDS(TempDimSetEntry, TRUE);
                    TempDimSetEntry2.INSERT();
                END;
            UNTIL SelectedDim.NEXT() = 0;
            EXIT(TRUE);
        END;
        EXIT(FALSE);
    end;

    local procedure SetTempPaymentBufferDims(var DimBuf: Record "Dimension Buffer")
    var
        GLSetup: Record "General Ledger Setup";
        EntryNo: Integer;
    begin
        IF SummarizePerDim THEN BEGIN
            DimBuf.RESET();
            DimBuf.DELETEALL();
            IF SelectedDim.FIND('-') THEN
                REPEAT
                    IF DimSetEntry.GET(
                         VendLedgEntry."Dimension Set ID", SelectedDim."Dimension Code")
                    THEN
                        InsertDimBuf(DimBuf, DATABASE::"Dimension Buffer", 0, DimSetEntry."Dimension Code",
                          DimSetEntry."Dimension Value Code");
                UNTIL SelectedDim.NEXT() = 0;
            EntryNo := DimBufMgt.FindDimensions(DimBuf);
            IF EntryNo = 0 THEN
                EntryNo := DimBufMgt.InsertDimensions(DimBuf);
            TempPaymentBuffer."Dimension Entry No." := EntryNo;
            IF TempPaymentBuffer."Dimension Entry No." <> 0 THEN BEGIN
                GLSetup.GET();
                IF DimCodeIsInDimBuf(GLSetup."Global Dimension 1 Code", DimBuf) THEN
                    TempPaymentBuffer."Global Dimension 1 Code" := VendLedgEntry."Global Dimension 1 Code"
                ELSE
                    TempPaymentBuffer."Global Dimension 1 Code" := '';
                IF DimCodeIsInDimBuf(GLSetup."Global Dimension 2 Code", DimBuf) THEN
                    TempPaymentBuffer."Global Dimension 2 Code" := VendLedgEntry."Global Dimension 2 Code"
                ELSE
                    TempPaymentBuffer."Global Dimension 2 Code" := '';
            END ELSE BEGIN
                TempPaymentBuffer."Global Dimension 1 Code" := '';
                TempPaymentBuffer."Global Dimension 2 Code" := '';
            END;
            TempPaymentBuffer."Dimension Set ID" := VendLedgEntry."Dimension Set ID";
        END ELSE BEGIN
            TempPaymentBuffer."Dimension Entry No." := 0;
            TempPaymentBuffer."Global Dimension 1 Code" := '';
            TempPaymentBuffer."Global Dimension 2 Code" := '';
            TempPaymentBuffer."Dimension Set ID" := 0;
        END;
    end;

    local procedure IsEntryAlreadyApplied(GenJnlLine3: Record "Gen. Journal Line"; VendLedgEntry2: Record "Vendor Ledger Entry"): Boolean
    var
        GenJnlLine4: Record "Gen. Journal Line";
    begin
        GenJnlLine4.SETRANGE("Journal Template Name", GenJnlLine3."Journal Template Name");
        GenJnlLine4.SETRANGE("Journal Batch Name", GenJnlLine3."Journal Batch Name");
        GenJnlLine4.SETRANGE("Account Type", GenJnlLine4."Account Type"::Vendor);
        GenJnlLine4.SETRANGE("Account No.", VendLedgEntry2."Vendor No.");
        GenJnlLine4.SETRANGE("Applies-to Doc. Type", VendLedgEntry2."Document Type");
        GenJnlLine4.SETRANGE("Applies-to Doc. No.", VendLedgEntry2."Document No.");
        EXIT(NOT GenJnlLine4.ISEMPTY);
    end;

    local procedure SetDefaults()
    begin
        GenJnlBatch.GET(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name");
        IF GenJnlBatch."Bal. Account No." <> '' THEN BEGIN
            GenJnlLine2."Bal. Account Type" := GenJnlBatch."Bal. Account Type";
            GenJnlLine2."Bal. Account No." := GenJnlBatch."Bal. Account No.";
        END;
    end;
}

