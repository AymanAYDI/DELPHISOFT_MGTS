report 50035 "DEL SR Vendor Pay. Advi. Detai"
{

    DefaultLayout = RDLC;
    RDLCLayout = './SRVendorPaymentAdviceDetai.rdlc';

    Caption = 'Vendor Payment Advice detail';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Vendor Posting Group", "Country/Region Code";
            column(CompanyInfoCityTodayFormatted; CompanyInformation.City + ', ' + FORMAT(TODAY, 0, 4))
            {
            }
            column(VendorAdr1; VendorAdr[1])
            {
            }
            column(CompanyAdr1; CompanyAdr[1])
            {
            }
            column(VendorAdr2; VendorAdr[2])
            {
            }
            column(CompanyAdr2; CompanyAdr[2])
            {
            }
            column(VendorAdr3; VendorAdr[3])
            {
            }
            column(CompanyAdr3; CompanyAdr[3])
            {
            }
            column(VendorAdr4; VendorAdr[4])
            {
            }
            column(CompanyAdr4; CompanyAdr[4])
            {
            }
            column(VendorAdr5; VendorAdr[5])
            {
            }
            column(CompanyAdr5; CompanyAdr[5])
            {
            }
            column(VendorAdr6; VendorAdr[6])
            {
            }
            column(CompanyAdr6; CompanyAdr[6])
            {
            }
            column(VendorAdr7; VendorAdr[7])
            {
            }
            column(VendorAdr8; VendorAdr[8])
            {
            }
            column(MsgTxt; MsgTxt)
            {
            }
            column(PaymentCaption; PaymentCaptionLbl)
            {
            }
            column(PaymentAdviceCaption; PaymentAdviceCaptionLbl)
            {
            }
            column(PosCaption; PosCaptionLbl)
            {
            }
            column(DescCaption_GenJnlLine; "Gen. Journal Line".FIELDCAPTION(Description))
            {
            }
            column(OurDocNoCaption; OurDocNoCaptionLbl)
            {
            }
            column(YrDocNoCaption; YrDocNoCaptionLbl)
            {
            }
            column(InvoiceCaption; InvoiceCaptionLbl)
            {
            }
            column(InvDateCaption; InvDateCaptionLbl)
            {
            }
            column(CurrCaption; CurrCaptionLbl)
            {
            }
            column(PmtDiscPmtTolCaption; PmtDiscPmtTolCaptionLbl)
            {
            }
            column(No_Vendor; "No.")
            {
            }
            dataitem("Gen. Journal Line"; "Gen. Journal Line")
            {
                DataItemTableView = SORTING("Account Type", "Account No.", "Applies-to Doc. Type", "Applies-to Doc. No.");
                column(Amount_GenJnlLine; Amount)
                {
                }
                column(Desc_GenJnlLine; Description)
                {
                }
                column(VendEntryExternalDocNo; VendEntry."External Document No.")
                {
                }
                column(VendEntryDocDate; FORMAT(VendEntry."Document Date"))
                {
                }
                column(VendEntryDocNo; VendEntry."Document No.")
                {
                }
                column(VendEntryAmount; -VendEntry.Amount)
                {
                }
                column(Pos; Pos)
                {
                }
                column(CurrencyCode_GenJnlLine; "Currency Code")
                {
                }
                column(PmtDiscAmtPmtTolerance; PmtDiscAmt + PmtTolerance)
                {
                }
                column(iCurr1; iCurr[1])
                {
                }
                column(iCurr2; iCurr[2])
                {
                }
                column(iCurr3; iCurr[3])
                {
                }
                column(iAmt3; iAmt[3])
                {
                }
                column(iAmt2; iAmt[2])
                {
                }
                column(iCurr4; iCurr[4])
                {
                }
                column(iAmt4; iAmt[4])
                {
                }
                column(iAmt1; iAmt[1])
                {
                }
                column(CompanyInfName; CompanyInformation.Name)
                {
                }
                column(RespPerson; RespPerson)
                {
                }
                column(TransferCaption; TransferCaptionLbl)
                {
                }
                column(TotalpaymentCaption; TotalpaymentCaptionLbl)
                {
                }
                column(YourssincerelyCaption; YourssincerelyCaptionLbl)
                {
                }
                column(TempName_GenJnlLine; "Journal Template Name")
                {
                }
                column(JnlBatchName_GenJnlLine; "Journal Batch Name")
                {
                }
                column(LineNo_GenJnlLine; "Line No.")
                {
                }
                dataitem(PmtVendEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(PostingDate_PartPmtVendorEntry; FORMAT(TempVendLedgEntry."Posting Date"))
                    {
                    }
                    column(DocType_PartPmtVendorEntry; TempVendLedgEntry."Document Type")
                    {
                    }
                    column(DocNo_PartPmtVendorEntry; TempVendLedgEntry."Document No.")
                    {
                    }
                    column(CurrCode_PartPmtVendorEntry; TempVendLedgEntry."Currency Code")
                    {
                    }
                    column(Amount; -TempVendLedgEntry.Amount)
                    {
                    }
                    column(ExternalDocNo_PartPmtVendorEntry; TempVendLedgEntry."External Document No.")
                    {
                    }
                    column(EntryNo_PartPmtVendorEntry; TempVendLedgEntry."Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number > 1 THEN
                            IF TempVendLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;

                        IF TempVendLedgEntry."Currency Code" = '' THEN
                            TempVendLedgEntry."Currency Code" := GlSetup."LCY Code";

                        TempVendLedgEntry.CALCFIELDS(Amount);
                    end;

                    trigger OnPreDataItem()
                    begin
                        TempVendLedgEntry.RESET;
                        IF NOT TempVendLedgEntry.FINDSET THEN
                            CurrReport.BREAK;
                    end;
                }
                dataitem(RelatedPmtVendEntryLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = FILTER(1 ..));
                    column(DocNo_PartPmtVendorEntry2; TempRelatedVendLedgEntry."Document No.")
                    {
                    }
                    column(CurrCode_PartPmtVendorEntry2; TempRelatedVendLedgEntry."Currency Code")
                    {
                    }
                    column(Amount_PartPmtVendorEntry2; -TempRelatedVendLedgEntry.Amount)
                    {
                    }
                    column(ExternalDocNo_PartPmtVendorEntry2; TempRelatedVendLedgEntry."External Document No.")
                    {
                    }
                    column(PostingDate_PartPmtVendorEntry2; FORMAT(TempRelatedVendLedgEntry."Posting Date"))
                    {
                    }
                    column(DocType_PartPmtVendorEntry2; TempRelatedVendLedgEntry."Document Type")
                    {
                    }
                    column(EntryNo_PartPmtVendorEntry2; TempRelatedVendLedgEntry."Entry No.")
                    {
                    }
                    column(ClosedbyEntryNo_PartPmtVendorEntry2; TempRelatedVendLedgEntry."Closed by Entry No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF Number > 1 THEN
                            IF TempRelatedVendLedgEntry.NEXT = 0 THEN
                                CurrReport.BREAK;

                        IF TempRelatedVendLedgEntry."Currency Code" = '' THEN
                            TempRelatedVendLedgEntry."Currency Code" := GlSetup."LCY Code";

                        TempRelatedVendLedgEntry.CALCFIELDS(Amount);
                    end;

                    trigger OnPreDataItem()
                    begin
                        TempRelatedVendLedgEntry.RESET;
                        IF NOT TempRelatedVendLedgEntry.FINDSET THEN
                            CurrReport.BREAK;
                    end;
                }
                dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Vendor No." = FIELD("Account No."),
                                   "Currency Code" = FIELD("Currency Code"),
                                   "Applies-to ID" = FIELD("Document No.");
                    DataItemTableView = SORTING("Entry No.")
                                        WHERE(Open = CONST(true));
                    column(DocumentNo; "Document No.")
                    {
                    }
                    column(RemainingAmount; -"Remaining Amount")
                    {
                    }
                    column(DocNo_PartPmtVendorEntry3; "Document No.")
                    {
                    }
                    column(CurrCode_PartPmtVendorEntry3; "Currency Code")
                    {
                    }
                    column(ExternalDocNo_PartPmtVendorEntry3; "External Document No.")
                    {
                    }
                    column(PostingDate_PartPmtVendorEntry3; FORMAT("Posting Date"))
                    {
                    }
                    column(DocType_PartPmtVendorEntry3; "Document Type")
                    {
                    }
                    column(EntryNo_PartPmtVendorEntry3; "Entry No.")
                    {
                    }
                    column(ClosedbyEntryNo_PartPmtVendorEntry3; "Closed by Entry No.")
                    {
                    }
                    column(Amount_PartPmtVendorEntry3; -Amount)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        CALCFIELDS(Amount);
                    end;

                    trigger OnPreDataItem()
                    begin
                        /*IF "Gen. Journal Line"."Applies-to Doc. No." <> '' THEN CurrReport.SKIP;
                        IF "Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."Account Type"::Vendor THEN CurrReport.SKIP;*/

                    end;
                }

                trigger OnAfterGetRecord()
                var
                    OpenRemAmtFC: Decimal;
                begin
                    // ESR Zlg nicht avisieren
                    IF NOT ShowEsrPayments THEN BEGIN
                        IF NOT VendBank.GET("Account No.", "Recipient Bank Account") THEN  // Bankverbindung

                        ERROR(Text002, "Recipient Bank Account", "Account No.");

                        IF VendBank."Payment Form" IN [VendBank."Payment Form"::ESR, VendBank."Payment Form"::"ESR+"] THEN
                            CurrReport.SKIP;
                    END;

                    // Rechnungsposten für Rech. Betrag

                    PmtDiscAmt := 0;
                    PmtTolerance := 0;

                    VendEntry.SETCURRENTKEY("Document No.");
                    IF "Applies-to Doc. No." <> '' THEN BEGIN
                        VendEntry.SETRANGE("Document Type", VendEntry."Document Type"::Invoice);
                        VendEntry.SETRANGE("Document No.", "Applies-to Doc. No.");
                        VendEntry.SETRANGE("Vendor No.", "Account No.");
                        IF NOT VendEntry.FIND('-') THEN
                            VendEntry.INIT;

                        VendEntry.CALCFIELDS(Amount, "Remaining Amount");

                        IF (VendEntry."Pmt. Discount Date" >= "Posting Date") OR
                           ((VendEntry."Pmt. Disc. Tolerance Date" >= "Posting Date") AND
                            VendEntry."Accepted Pmt. Disc. Tolerance")
                        THEN
                            PmtDiscAmt := VendEntry."Remaining Pmt. Disc. Possible";

                        PmtTolerance := VendEntry."Accepted Payment Tolerance";
                        OpenRemAmtFC := -VendEntry."Remaining Amount";

                        // Open entry and remaining for multicurrency. Convert to pmt currency
                        IF VendEntry."Currency Code" <> "Currency Code" THEN
                            OpenRemAmtFC :=
                              ExchRate.ExchangeAmtFCYToFCY(
                                "Posting Date", VendEntry."Currency Code", "Currency Code", -VendEntry."Remaining Amount");

                        // Applied entry is not closed
                        IF (OpenRemAmtFC - Amount + PmtDiscAmt + PmtTolerance) > 0 THEN
                            PmtDiscAmt := 0;
                        IF Amount > OpenRemAmtFC THEN
                            PmtDiscAmt := 0;
                    END ELSE BEGIN
                        VendEntry."Entry No." := 0;
                        VendEntry."Document No." := '';
                        VendEntry.CALCFIELDS(Amount, "Remaining Amount");
                    END;
                    BuildPmtVendLedgEntryBuffer(VendEntry."Entry No.");

                    Pos := Pos + 1;
                    NoOfPayments := NoOfPayments + 1;

                    // Total pro Währung summieren
                    i := 1;
                    IF "Currency Code" = '' THEN
                        "Currency Code" := GlSetup."LCY Code";

                    WHILE (iCurr[i] <> "Currency Code") AND (iCurr[i] <> '') DO
                        i := i + 1;

                    IF i = 6 THEN
                        ERROR(Text003, i - 1);

                    iCurr[i] := "Currency Code";
                    iAmt[i] := iAmt[i] + Amount;
                    iAmtLCY[i] := iAmtLCY[i] + "Amount (LCY)";
                end;

                trigger OnPostDataItem()
                begin
                    IF Pos > 0 THEN
                        NoOfVendors := NoOfVendors + 1;
                end;

                trigger OnPreDataItem()
                begin
                    // Nur Zeilen vom Typ Kreditor/Zahlungen vom ausgewählten Journal für den aktuellen Kreditor
                    SETCURRENTKEY("Account Type", "Account No.");
                    SETRANGE("Document Type", "Document Type"::Payment);
                    SETRANGE("Account Type", "Account Type"::Vendor);
                    SETRANGE("Account No.", Vendor."No.");
                    SETRANGE("Journal Template Name", JourBatchName);
                    SETRANGE("Journal Batch Name", JourBatch);

                    Pos := 0;
                    CLEAR(iCurr);
                    CLEAR(iAmt);
                    CLEAR(iAmtLCY);
                    CurrReport.CREATETOTALS(Amount);

                    // Nur drucken, falls bestimmte Anzahl Zlg pro Kred.

                    CLEAR(TempGenJourLine);
                    TempGenJourLine.COPYFILTERS("Gen. Journal Line");

                    IF NOT ShowEsrPayments THEN
                        SetEsrFilter(TempGenJourLine);
                    IF TempGenJourLine.COUNT < PrintFromNoOfVendorInvoices THEN
                        CurrReport.BREAK;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FormatAdr.Vendor(VendorAdr, Vendor);
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
                    field(PrintFromNoOfVendorInvoices; PrintFromNoOfVendorInvoices)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print from Payments/Vendor';
                    }
                    field(ShowEsrPayments; ShowEsrPayments)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Advice ESR Payments';
                    }
                    field(RespPerson; RespPerson)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Responsible Person';
                    }
                    field(MsgTxt; MsgTxt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Message';
                        MultiLine = true;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        var
            User: Record User;
        begin
            IF MsgTxt = '' THEN
                MsgTxt := Text004;

            IF PrintFromNoOfVendorInvoices = 0 THEN
                PrintFromNoOfVendorInvoices := 1;

            IF (RespPerson = '') AND (USERID <> '') THEN BEGIN
                User.SETRANGE("User Name", USERID);
                IF User.FINDFIRST THEN
                    RespPerson := User."Full Name";
            END;
        end;
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //>>MGTS10.00.06.00
        IF NOT BooGSkipMessage THEN
            //<<MGTS10.00.06.00
            MESSAGE(
          Text001,
          NoOfVendors, NoOfPayments, "Gen. Journal Line".GETFILTER("Journal Batch Name"));
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        FormatAdr.Company(CompanyAdr, CompanyInformation);

        GlSetup.GET;
        IF GlSetup."LCY Code" = '' THEN
            GlSetup."LCY Code" := Text000;
    end;

    var
        CompanyInformation: Record "Company Information";
        ExchRate: Record "Currency Exchange Rate";
        TempGenJourLine: Record "Gen. Journal Line";
        GlSetup: Record "General Ledger Setup";
        VendBank: Record "Vendor Bank Account";
        TempRelatedVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        TempVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        VendEntry: Record "Vendor Ledger Entry";
        FormatAdr: Codeunit "Format Address";
        BooGSkipMessage: Boolean;
        ShowEsrPayments: Boolean;
        iCurr: array[20] of Code[10];
        JourBatch: Code[20];
        JourBatchName: Code[20];
        iAmt: array[20] of Decimal;
        iAmtLCY: array[20] of Decimal;
        PmtDiscAmt: Decimal;
        PmtTolerance: Decimal;
        i: Integer;
        NoOfPayments: Integer;
        NoOfVendors: Integer;
        Pos: Integer;
        PrintFromNoOfVendorInvoices: Integer;
        CurrCaptionLbl: Label 'Curr.';
        InvDateCaptionLbl: Label 'Inv. Date';
        InvoiceCaptionLbl: Label 'Invoice';
        OurDocNoCaptionLbl: Label 'Our. Doc. No';
        PaymentAdviceCaptionLbl: Label 'Payment Advice';
        PaymentCaptionLbl: Label 'Payment';
        PmtDiscPmtTolCaptionLbl: Label 'Pmt.Disc./ Pmt.Tol. ';
        PosCaptionLbl: Label 'Pos.';
        Text000: Label 'CHF';
        Text001: Label 'Payment advice processed for %1 vendors. %2 payments processed from journal %3.';
        Text002: Label 'Bank %1 does not exist for vendor %2.';
        Text003: Label 'More than %1 currencies cannot be processed.';
        Text004: Label 'We have advices our bank to remit the following amount to your account in the next few days.';
        TotalpaymentCaptionLbl: Label 'Total payment';
        TransferCaptionLbl: Label 'Transfer';
        YourssincerelyCaptionLbl: Label 'Yours sincerely';
        YrDocNoCaptionLbl: Label 'Yr. Doc. No.';
        CompanyAdr: array[8] of Text[50];
        RespPerson: Text[50];
        VendorAdr: array[8] of Text[50];
        MsgTxt: Text[250];


    procedure DefineJourBatch(_GnlJourLine: Record "Gen. Journal Line")
    begin
        JourBatch := _GnlJourLine."Journal Batch Name";
        JourBatchName := _GnlJourLine."Journal Template Name";
    end;


    procedure SetEsrFilter(var TempGenJourLine: Record "Gen. Journal Line")
    var
        VendBank: Record "Vendor Bank Account";
    begin
        IF TempGenJourLine.FIND('-') THEN BEGIN
            REPEAT
                IF NOT VendBank.GET(TempGenJourLine."Account No.", TempGenJourLine."Recipient Bank Account") THEN
                    ERROR(Text002, TempGenJourLine."Recipient Bank Account", TempGenJourLine."Account No.");
                IF NOT (VendBank."Payment Form" IN [VendBank."Payment Form"::ESR, VendBank."Payment Form"::"ESR+"]) THEN
                    TempGenJourLine.MARK(TRUE)
                ELSE
                    TempGenJourLine.MARK(FALSE);
            UNTIL TempGenJourLine.NEXT = 0;
        END;
        TempGenJourLine.MARKEDONLY(TRUE);
    end;

    local procedure BuildPmtVendLedgEntryBuffer(EntryNo: Integer)
    begin
        IF EntryNo = 0 THEN
            EXIT;

        TempVendLedgEntry.RESET;
        TempVendLedgEntry.DELETEALL;
        TempRelatedVendLedgEntry.RESET;
        TempRelatedVendLedgEntry.DELETEALL;

        UpdateVendLedgEntryBufferRecursively(TempVendLedgEntry, TempRelatedVendLedgEntry, EntryNo);
    end;

    local procedure UpdateVendLedgEntryBufferRecursively(var VendLedgEntryBuffer: Record "Vendor Ledger Entry"; var RelatedVendLedgEntryBuffer: Record "Vendor Ledger Entry"; EntryNo: Integer)
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SETRANGE("Closed by Entry No.", EntryNo);
        IF VendLedgEntry.FINDSET THEN
            REPEAT
                VendLedgEntryBuffer := VendLedgEntry;
                IF VendLedgEntryBuffer.INSERT THEN;
                UpdateVendLedgEntryBufferRecursively(
                  RelatedVendLedgEntryBuffer, RelatedVendLedgEntryBuffer, VendLedgEntry."Entry No.");
            UNTIL VendLedgEntry.NEXT = 0;
    end;


    procedure SkipMessage(_SkipMessage: Boolean)
    begin
        BooGSkipMessage := _SkipMessage;
    end;
}

