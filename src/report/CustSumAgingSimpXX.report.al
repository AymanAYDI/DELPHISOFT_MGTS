report 50002 "DEL Cust - Sum. Aging Simp. XX"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CustomerSumAgingSimpXX.rdlc';
    Caption = 'Customer - Summary Aging Simp.';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Statistics Group", "Payment Terms Code";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(STRSUBSTNO_Text001_FORMAT_StartDate__; STRSUBSTNO(Text001, FORMAT(StartDate)))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO())
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(STRSUBSTNO_Text002__Devise_Code_; STRSUBSTNO(Text002, Devise_Code))
            {
            }
            column(Customer_TABLECAPTION__________CustFilter; Customer.TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustBalanceDueLCY_5_; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4_; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3_; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2_; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1_; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_6_; CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(DataItem1100135009; CustBalanceDueLCY[1] + CustBalanceDueLCY[2] + CustBalanceDueLCY[3] + CustBalanceDueLCY[4] + CustBalanceDueLCY[5] + CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(CustBalanceDueLCY_5__Control25; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control26; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control27; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control28; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control29; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_6__Control1100135003; CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(DataItem1000000000; CustBalanceDueLCY[1] + CustBalanceDueLCY[2] + CustBalanceDueLCY[3] + CustBalanceDueLCY[4] + CustBalanceDueLCY[5] + CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control31; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control32; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control33; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control34; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control35; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_6__Control1100135005; CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(DataItem1000000001; CustBalanceDueLCY[1] + CustBalanceDueLCY[2] + CustBalanceDueLCY[3] + CustBalanceDueLCY[4] + CustBalanceDueLCY[5] + CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_5__Control37; CustBalanceDueLCY[5])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_4__Control38; CustBalanceDueLCY[4])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_3__Control39; CustBalanceDueLCY[3])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_2__Control40; CustBalanceDueLCY[2])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_1__Control41; CustBalanceDueLCY[1])
            {
                AutoFormatType = 1;
            }
            column(CustBalanceDueLCY_6__Control1100135007; CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(DataItem1000000002; CustBalanceDueLCY[1] + CustBalanceDueLCY[2] + CustBalanceDueLCY[3] + CustBalanceDueLCY[4] + CustBalanceDueLCY[5] + CustBalanceDueLCY[6])
            {
                AutoFormatType = 1;
            }
            column(Customer___Summary_Aging_Simp_Caption; Customer___Summary_Aging_Simp_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(CustBalanceDueLCY_5__Control25Caption; CustBalanceDueLCY_5__Control25CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_4__Control26Caption; CustBalanceDueLCY_4__Control26CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_3__Control27Caption; CustBalanceDueLCY_3__Control27CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_2__Control28Caption; CustBalanceDueLCY_2__Control28CaptionLbl)
            {
            }
            column(Plus_de_120_joursCaption; Plus_de_120_joursCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(V91_120_joursCaption; V91_120_joursCaptionLbl)
            {
            }
            column(CustBalanceDueLCY_5_Caption; CustBalanceDueLCY_5_CaptionLbl)
            {
            }
            column(CustBalanceDueLCY_5__Control31Caption; CustBalanceDueLCY_5__Control31CaptionLbl)
            {
            }
            column(TotalCaption_Control36; TotalCaption_Control36Lbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PrintCust := FALSE;
                FOR i := 1 TO 6 DO BEGIN
                    DtldCustLedgEntry.SETCURRENTKEY("Customer No.", "Initial Entry Due Date", "Posting Date");
                    DtldCustLedgEntry.SETRANGE("Customer No.", "No.");
                    DtldCustLedgEntry.SETRANGE("Posting Date", 0D, StartDate);
                    DtldCustLedgEntry.SETRANGE("Initial Entry Due Date", PeriodStartDate[i], PeriodStartDate[i + 1] - 1);
                    DtldCustLedgEntry.CALCSUMS("Amount (LCY)");
                    IF (Devise_Code = 'CHF') OR (Devise_Code = '') THEN
                        CustBalanceDueLCY[i] := DtldCustLedgEntry."Amount (LCY)"
                    ELSE BEGIN
                        DtldCustLedgEntry.SETRANGE("Currency Code", Devise_Code);
                        DtldCustLedgEntry.CALCSUMS(Amount);
                        CustBalanceDueLCY[i] := DtldCustLedgEntry.Amount;
                    END;
                    IF CustBalanceDueLCY[i] <> 0 THEN
                        PrintCust := TRUE;
                END;
                IF NOT PrintCust THEN
                    CurrReport.SKIP();
            end;

            trigger OnPreDataItem()
            begin
                CurrReport.CREATETOTALS(CustBalanceDueLCY);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Date Début';
                }
                field(Devise_Code; Devise_Code)
                {
                    Caption = 'Filtre Devise';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

            IF StartDate = 0D THEN
                StartDate := WORKDATE();
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        Devise_Code := 'CHF';
    end;

    trigger OnPreReport()
    begin
        CustFilter := Customer.GETFILTERS;
        PeriodStartDate[6] := StartDate;
        PeriodStartDate[7] := 19991231D; //12319999D
        FOR i := 5 DOWNTO 2 DO
            PeriodStartDate[i] := CALCDATE('<-30D>', PeriodStartDate[i + 1]);
    end;

    var
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";

        Text001: Label 'As of %1';
        StartDate: Date;
        CustFilter: Text[250];
        PeriodStartDate: array[7] of Date;
        CustBalanceDueLCY: array[6] of Decimal;
        PrintCust: Boolean;
        i: Integer;
        Devise_Code: Code[10];
        Text002: Label 'All amounts are in Euro %1';
        Customer___Summary_Aging_Simp_CaptionLbl: Label 'Customer - Summary Aging Simp.';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        CustBalanceDueLCY_5__Control25CaptionLbl: Label 'Not Due';
        CustBalanceDueLCY_4__Control26CaptionLbl: Label '0-30 days';
        CustBalanceDueLCY_3__Control27CaptionLbl: Label '31-60 days';
        CustBalanceDueLCY_2__Control28CaptionLbl: Label '61-90 days';
        Plus_de_120_joursCaptionLbl: Label 'Plus de 120 jours';
        TotalCaptionLbl: Label 'Total';
        V91_120_joursCaptionLbl: Label '91-120 jours';
        CustBalanceDueLCY_5_CaptionLbl: Label 'Continued';
        CustBalanceDueLCY_5__Control31CaptionLbl: Label 'Continued';
        TotalCaption_Control36Lbl: Label 'Total';
}

