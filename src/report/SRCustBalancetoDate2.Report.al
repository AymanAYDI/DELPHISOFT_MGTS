report 50067 "SR Cust. - Balance to Date2"
{
    // MGTS10.00.06.00    | 07.01.2022 | Send Payment Advice : List of changes:
    //                                              Modify Design (Remove Amount LCY and Remove Line not applied)
    DefaultLayout = RDLC;
    RDLCLayout = './SRCustBalancetoDate2.rdlc';

    Caption = 'Customer - Balance to Date';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", Blocked;
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CustGetRangeMaxDateFilter; STRSUBSTNO(Text000, FORMAT(Customer.GETRANGEMAX("Date Filter"))))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(CustTableCaptionCustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(PrintOnePerPage; PrintOnePerPage)
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(No_Cust; "No.")
            {
            }
            column(Address; Name + ', ' + "Post Code" + ' ' + City)
            {
            }
            column(TransferAmt; TransferAmt)
            {
            }
            column(CustBalancetoDateCaption; CustBalancetoDateCaptionLbl)
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(AgeCaption; AgeCaptionLbl)
            {
            }
            column(DateCaption; DateCaptionLbl)
            {
            }
            column(DaysCaption; DaysCaptionLbl)
            {
            }
            column(ReferenceCaption; ReferenceCaptionLbl)
            {
            }
            column(EntryNoCaption; EntryNoCaptionLbl)
            {
            }
            column(NoCaption; NoCaptionLbl)
            {
            }
            column(DocumentCaption; DocumentCaptionLbl)
            {
            }
            column(DescriptionCaption; DescriptionCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(AmountLCYCaption; AmountLCYCaptionLbl)
            {
            }
            column(TransferCaption; TransferCaptionLbl)
            {
            }
            dataitem(CustLedgEntry3; "Cust. Ledger Entry")
            {
                DataItemTableView = SORTING("Entry No.");
                column(PostingDate_CustLedgEntry; FORMAT("Posting Date"))
                {
                }
                column(DocType_CustLedgEntry; "Document Type")
                {
                }
                column(DocNo_CustLedgEntry; "Document No.")
                {
                }
                column(Desc_CustLedgEntry; Description)
                {
                }
                column(OriginalAmt; OriginalAmt)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(EntryNo_CustLedgEntry; "Entry No.")
                {
                }
                column(CurrencyCode; CurrencyCode)
                {
                }
                column(AgeDays; AgeDays)
                {
                }
                column(DueDays; DueDays)
                {
                }
                column(DueDate_CustLedgEntry; FORMAT("Due Date"))
                {
                }
                column(NoOpenEntries; NoOpenEntries)
                {
                }
                column(OriginalAmtLCY; OriginalAmtLCY)
                {
                    AutoFormatExpression = CurrencyCode;
                    AutoFormatType = 1;
                }
                column(DateFilter_CustLedgEntry; "Date Filter")
                {
                }
                dataitem(DataItem6942; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No."),
                                   "Posting Date" = FIELD("Date Filter");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Posting Date")
                                        WHERE("Entry Type" = FILTER(<> "Initial Entry"));
                    column(EntryType_Integer; FORMAT("Entry Type", 0, 9))
                    {
                    }
                    column(EntryType_DtldCustLedgEntry; "Entry Type")
                    {
                    }
                    column(PostingDate_DtldCustLedgEntry; FORMAT("Posting Date"))
                    {
                    }
                    column(DocType_DtldCustLedgEntry; "Document Type")
                    {
                    }
                    column(DocNo_DtldCustLedgEntry; "Document No.")
                    {
                    }
                    column(Amt; Amt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CurrencyCode_DtldCustLedgEntry; CurrencyCode)
                    {
                    }
                    column(AmtLCY; AmtLCY)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(RemainingAmt; RemainingAmt)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CustLedgEntry3DocNo; Text001 + ' ' + CustLedgEntry3."Document No.")
                    {
                    }
                    column(RemainingAmtLCY; RemainingAmtLCY)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(EntryNo_DtldCustLedgEntry; "Entry No.")
                    {
                    }
                    column(ConsNo_DtldCustLedgEntry; ConsNoDtldCustLedgEntry)
                    {
                    }
                    column(CustLedgEntryNo_DtldCustLedgEntry; "Cust. Ledger Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF NOT PrintUnappliedEntries THEN
                            IF Unapplied THEN
                                CurrReport.SKIP();

                        AmtLCY := "Amount (LCY)";
                        Amt := Amount;
                        CurrencyCode := "Currency Code";

                        IF (Amt = 0) AND (AmtLCY = 0) THEN
                            CurrReport.SKIP();

                        IF CurrencyCode = '' THEN BEGIN
                            CurrencyCode := GLSetup."LCY Code";
                            Amt := 0;
                        END;
                        ConsNoDtldCustLedgEntry += 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        ConsNoDtldCustLedgEntry := 0;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CALCFIELDS("Original Amt. (LCY)", "Remaining Amt. (LCY)", "Original Amount", "Remaining Amount");
                    OriginalAmtLCY := "Original Amt. (LCY)";
                    RemainingAmtLCY := "Remaining Amt. (LCY)";
                    OriginalAmt := "Original Amount";
                    RemainingAmt := "Remaining Amount";
                    CurrencyCode := "Currency Code";
                    IF CurrencyCode = '' THEN
                        CurrencyCode := GLSetup."LCY Code";

                    CurrencyTotalBuffer.UpdateTotal(CurrencyCode, RemainingAmt, RemainingAmtLCY, Counter1);

                    AgeDays := FixedDay - "Posting Date";
                    IF ("Due Date" <> 0D) AND (FixedDay > "Due Date") THEN
                        DueDays := FixedDay - "Due Date"
                    ELSE
                        DueDays := 0;
                    NoOpenEntries := NoOpenEntries + 1;

                    IF CurrencyCode = GLSetup."LCY Code" THEN BEGIN
                        RemainingAmt := 0;
                        OriginalAmt := 0;
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    RESET();
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Posting Date", "Entry Type");
                    DtldCustLedgEntry.SETRANGE("Customer No.", Customer."No.");
                    DtldCustLedgEntry.SETRANGE("Posting Date", CALCDATE('<+1D>', FixedDay), 19991231D); // TODO: check date 12319999
                    DtldCustLedgEntry.SETRANGE("Entry Type", DtldCustLedgEntry."Entry Type"::Application);
                    IF NOT PrintUnappliedEntries THEN
                        DtldCustLedgEntry.SETRANGE(Unapplied, FALSE);

                    IF DtldCustLedgEntry.FINDSET() THEN
                        REPEAT
                            "Entry No." := DtldCustLedgEntry."Cust. Ledger Entry No.";
                            MARK(TRUE);
                        UNTIL DtldCustLedgEntry.NEXT() = 0;

                    SETCURRENTKEY("Customer No.", Open);
                    SETRANGE("Customer No.", Customer."No.");
                    SETRANGE(Open, TRUE);
                    SETRANGE("Posting Date", 0D, FixedDay);
                    IF FINDSET() THEN
                        REPEAT
                            MARK(TRUE);
                        UNTIL NEXT() = 0;

                    SETCURRENTKEY("Entry No.");
                    SETRANGE(Open);
                    MARKEDONLY(TRUE);
                    SETRANGE("Date Filter", 0D, FixedDay);
                end;
            }
            dataitem(Integer2; Integer)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number = FILTER(1 ..));
                column(TotalCustName; Text002 + ' ' + Customer.Name)
                {
                }
                column(CurrencyTotalBuffTotalAmt; CurrencyTotalBuffer."Total Amount")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(CurrencyTotalBuffCurrCode; CurrencyTotalBuffer."Currency Code")
                {
                }
                column(CurrencyTotalBuffTotalAmtLCY; CurrencyTotalBuffer."Total Amount (LCY)")
                {
                    AutoFormatExpression = CurrencyTotalBuffer."Currency Code";
                    AutoFormatType = 1;
                }
                column(GLSetupLCYCode; GLSetup."LCY Code")
                {
                }
                column(CustomerTotalLCY; CustomerTotalLCY)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN
                        OK := CurrencyTotalBuffer.FINDSET()
                    ELSE
                        OK := CurrencyTotalBuffer.NEXT() <> 0;
                    IF NOT OK THEN
                        CurrReport.BREAK();

                    CurrencyTotalBuffer2.UpdateTotal(
                      CurrencyTotalBuffer."Currency Code",
                      CurrencyTotalBuffer."Total Amount",
                      CurrencyTotalBuffer."Total Amount (LCY)",
                      Counter1);

                    CustomerTotalLCY += CurrencyTotalBuffer."Total Amount (LCY)";

                    IF (CurrencyTotalBuffer."Total Amount" = 0) AND
                       (CurrencyTotalBuffer."Total Amount (LCY)" = 0)
                    THEN
                        CurrReport.SKIP();
                end;

                trigger OnPostDataItem()
                begin
                    CurrencyTotalBuffer.DELETEALL();
                end;

                trigger OnPreDataItem()
                begin
                    CurrReport.CREATETOTALS(CurrencyTotalBuffer."Total Amount (LCY)");
                end;
            }

            trigger OnAfterGetRecord()
            begin
                SETRANGE("Date Filter", 0D, FixedDay);
                CustomerTotalLCY := 0;
                NoOpenEntries := 0;
                IF PrintOnePerPage THEN
                    OutputNo += 1;
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.NEWPAGEPERRECORD := PrintOnePerPage;
                GLSetup.GET();
                OutputNo := 0;
            end;
        }
        dataitem(Integer3; Integer)
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = FILTER(1 ..));
            column(CurrencyTotalBuff2CurrCode; CurrencyTotalBuffer2."Currency Code")
            {
            }
            column(CurrencyTotalBuff2TotalAmt; CurrencyTotalBuffer2."Total Amount")
            {
                AutoFormatExpression = CurrencyTotalBuffer2."Currency Code";
                AutoFormatType = 1;
            }
            column(TotalReportLCY; TotalReportLCY)
            {
                AutoFormatType = 1;
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(TotalBalancetoDateCaption; TotalBalancetoDateCaptionLbl)
            {
            }
            column(GLSetupLCYCode_Integer3; GLSetup."LCY Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF Number = 1 THEN
                    OK := CurrencyTotalBuffer2.FINDSET()
                ELSE
                    OK := CurrencyTotalBuffer2.NEXT() <> 0;
                IF NOT OK THEN
                    CurrReport.BREAK();

                TotalReportLCY := TotalReportLCY + CurrencyTotalBuffer2."Total Amount (LCY)";

                IF (CurrencyTotalBuffer2."Total Amount" = 0) AND
                   (CurrencyTotalBuffer2."Total Amount (LCY)" = 0)
                THEN
                    CurrReport.SKIP();
            end;

            trigger OnPostDataItem()
            begin
                CurrencyTotalBuffer2.DELETEALL();

                Customer.SETRANGE("Date Filter");
                IF CheckGLReceivables AND (Customer.GETFILTERS = '') THEN
                    CheckReceivablesAccounts();
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
                    field(FixedDay; FixedDay)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Fixed Day';
                        ToolTip = 'Specifies the date from which due customer payments are included.';
                    }
                    field(PrintOnePerPage; PrintOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per Customer';
                        ToolTip = 'Specifies if each customer balance is printed on a separate page.';
                    }
                    field(CheckGLReceivables; CheckGLReceivables)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Check Receivables Accounts';
                        ToolTip = 'Specifies if the calculated balance at close out matches the balance of the combined accounts receivable in the general ledger. A warning message is displayed if there is any variance.';
                    }
                    field(PrintUnappliedEntries; PrintUnappliedEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Unapplied Entries';
                        ToolTip = 'Specifies if the report includes unapplied entries.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF FixedDay = 0D THEN
                FixedDay := WORKDATE();
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
    end;

    var
        CurrencyTotalBuffer: Record "Currency Total Buffer" temporary;
        CurrencyTotalBuffer2: Record "Currency Total Buffer" temporary;
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        GLSetup: Record "General Ledger Setup";
        CheckGLReceivables: Boolean;
        OK: Boolean;
        PrintOnePerPage: Boolean;
        PrintUnappliedEntries: Boolean;
        CurrencyCode: Code[10];
        FixedDay: Date;
        Amt: Decimal;
        AmtLCY: Decimal;
        CustomerTotalLCY: Decimal;
        OriginalAmt: Decimal;
        OriginalAmtLCY: Decimal;
        RemainingAmt: Decimal;
        RemainingAmtLCY: Decimal;
        TotalReportLCY: Decimal;
        TransferAmt: Decimal;
        AgeDays: Integer;
        ConsNoDtldCustLedgEntry: Integer;
        Counter1: Integer;
        DueDays: Integer;
        NoOpenEntries: Integer;
        OutputNo: Integer;
        AgeCaptionLbl: Label 'Age';
        AmountCaptionLbl: Label 'Amount';
        AmountLCYCaptionLbl: Label 'Amount LCY';
        CustBalancetoDateCaptionLbl: Label 'Customer - Balance to Date';
        DateCaptionLbl: Label 'Date';
        DaysCaptionLbl: Label 'Days';
        DescriptionCaptionLbl: Label 'Description';
        DocumentCaptionLbl: Label 'Document';
        DueDateCaptionLbl: Label 'Due Date';
        EntryNoCaptionLbl: Label 'Entry No.';
        NoCaptionLbl: Label 'No.';
        PageNoCaptionLbl: Label 'Page';
        ReferenceCaptionLbl: Label 'Reference';
        Text000: Label 'Balance on %1';
        Text001: Label 'Remaining Amount Document';
        Text002: Label 'Total';
        Text003: Label 'The calculated balance of the report doesn''t meet the balance of all receivables accounts in G/L. There''s a difference of %1 %2. Please check if no direct postings have been done on this accounts.';
        TotalBalancetoDateCaptionLbl: Label 'Total Balance to Date';
        TotalCaptionLbl: Label 'Total';
        TransferCaptionLbl: Label 'Transfer';
        CustFilter: Text[250];


    procedure CheckReceivablesAccounts()
    var
        CustPostGroup: Record "Customer Posting Group";
        GLAcc: Record "G/L Account";
        TmpGLAcc: Record "G/L Account" temporary;
        TotalReceivables: Decimal;
    begin
        IF CustPostGroup.FINDSET() THEN BEGIN
            // Insert Receivabels Accounts in temp. table because the same account can be in
            // more than one posting groups
            REPEAT
                IF (NOT TmpGLAcc.GET(CustPostGroup."Receivables Account")) AND
                   (CustPostGroup."Receivables Account" <> '')
                THEN BEGIN
                    TmpGLAcc."No." := CustPostGroup."Receivables Account";
                    TmpGLAcc.INSERT();
                END;
            UNTIL CustPostGroup.NEXT() = 0;

            IF TmpGLAcc.FINDSET() THEN
                REPEAT
                    GLAcc.GET(TmpGLAcc."No.");
                    GLAcc.SETFILTER("Date Filter", '..%1', FixedDay);
                    GLAcc.CALCFIELDS("Balance at Date");
                    TotalReceivables := TotalReceivables + GLAcc."Balance at Date";
                UNTIL TmpGLAcc.NEXT() = 0;

            IF TotalReportLCY <> TotalReceivables THEN
                MESSAGE(Text003, GLSetup."LCY Code", ABS(TotalReportLCY - TotalReceivables));
        END;
    end;
}

