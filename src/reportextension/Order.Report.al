report 405 "Order"
{
    // thm   21.03.18      add whereHouse
    // RiskItem And FirstPurch DEL.SAZ 13.06.18   Modify trigger RoundLoop - OnAfterGetRecord
    //                                    Modify Purchase Header - OnAfterGetRecord
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Emil Hr. Hristov = ehh
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.028
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version       Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS10.028    07.06.21    mhh     List of changes:
    //                                           Changed function: PrepareFooter()
    // ------------------------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './Order.rdlc';

    Caption = 'Order';

    dataset
    {
        dataitem(DataItem4458; Table38)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmtCaption; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(SubtotalCaption; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVATCaption; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmtCaption; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmtCaption; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmtCaption; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDescCaption; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDescCaption; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EmailIDCaption; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDiscCaption; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(Image; CompanyInfo.Picture)
            {
            }
            column(FooterLabel11; FooterLabel[1])
            {
            }
            column(FooterLabel21; FooterLabel[2])
            {
            }
            column(FooterLabel31; FooterLabel[3])
            {
            }
            column(FooterLabel41; FooterLabel[4])
            {
            }
            column(FooterLabel51; FooterLabel[5])
            {
            }
            column(FooterLabel61; FooterLabel[6])
            {
            }
            column(FooterLabel71; FooterLabel[7])
            {
            }
            column(FooterLabel81; FooterLabel[8])
            {
            }
            column(FooterTxt11; FooterTxt[1])
            {
            }
            column(FooterTxt21; FooterTxt[2])
            {
            }
            column(FooterTxt31; FooterTxt[3])
            {
            }
            column(FooterTxt41; FooterTxt[4])
            {
            }
            column(FooterTxt51; FooterTxt[5])
            {
            }
            column(FooterTxt61; FooterTxt[6])
            {
            }
            column(FooterTxt71; FooterTxt[7])
            {
            }
            column(FooterTxt81; FooterTxt[8])
            {
            }
            column(Caption_VATReg; "Purchase Header".FIELDCAPTION("Purchase Header"."VAT Registration No."))
            {
            }
            column(FooterLabel91; FooterLabel[9])
            {
            }
            column(FooterTxt91; FooterTxt[9])
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(ReportTitleCopyText; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CurrRepPageNo; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(DocDate_PurchHeader; FORMAT("Purchase Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchHeader; "Purchase Header"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchHeader; "Purchase Header"."Your Reference")
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(BuyFrmVendNo_PurchHeader; "Purchase Header"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr1; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr2; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr3; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr4; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr5; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr6; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr7; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr8; BuyFromAddr[8])
                    {
                    }
                    column(PricesInclVAT_PurchHeader; "Purchase Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(VATBaseDisc_PurchHeader; "Purchase Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PrepmtPaymentTermsDesc; PrepmtPaymentTerms.Description)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(DimText; DimText)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCaption; CompanyInfoBankAccNoCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(BuyFrmVendNo_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(PricesInclVAT_PurchHeaderCaption; "Purchase Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(CompanyInfoFaxNoCaption; CompanyInfoFaxNoCaptionLbl)
                    {
                    }
                    column(VendNoCaption; VendNoCaptionLbl)
                    {
                    }
                    column(HeaderLabel1; HeaderLabel[1])
                    {
                    }
                    column(HeaderLabel2; HeaderLabel[2])
                    {
                    }
                    column(HeaderLabel3; HeaderLabel[3])
                    {
                    }
                    column(HeaderLabel4; HeaderLabel[4])
                    {
                    }
                    column(HeaderLabel5; HeaderLabel[5])
                    {
                    }
                    column(HeaderLabel6; HeaderLabel[6])
                    {
                    }
                    column(HeaderLabel7; HeaderLabel[7])
                    {
                    }
                    column(HeaderLabel8; HeaderLabel[8])
                    {
                    }
                    column(HeaderTxt1; HeaderTxt[1])
                    {
                    }
                    column(HeaderTxt2; HeaderTxt[2])
                    {
                    }
                    column(HeaderTxt3; HeaderTxt[3])
                    {
                    }
                    column(HeaderTxt4; HeaderTxt[4])
                    {
                    }
                    column(HeaderTxt5; HeaderTxt[5])
                    {
                    }
                    column(HeaderTxt6; HeaderTxt[6])
                    {
                    }
                    column(HeaderTxt7; HeaderTxt[7])
                    {
                    }
                    column(HeaderTxt8; HeaderTxt[8])
                    {
                    }
                    column(NewItemShow; NewItemShow)
                    {
                    }
                    column(RiskItemShow; RiskItemShow)
                    {
                    }
                    dataitem(DimensionLoop1; Table2000000026)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(HdrDimCaption; HdrDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(DataItem6547; Table39)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.);
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Document Type,Document No.,Line No.);

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(LineAmt_PurchLine;PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineNo_PurchLine;"Purchase Line"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt;AllowInvDisctxt)
                        {
                        }
                        column(Type_PurchLine;FORMAT("Purchase Line".Type,0,2))
                        {
                        }
                        column(No_PurchLine;"Purchase Line"."No.")
                        {
                        }
                        column(Desc_PurchLine;"Purchase Line".Description)
                        {
                        }
                        column(Qty_PurchLine;"Purchase Line".Quantity)
                        {
                        }
                        column(UOM_PurchLine;"Purchase Line"."Unit of Measure")
                        {
                        }
                        column(Prix_Caption;Prix_Caption)
                        {
                        }
                        column(Qty_caption;Qty_caption)
                        {
                        }
                        column(RefVendor;RefVendor)
                        {
                        }
                        column(ref_fourn;ref_fourn)
                        {
                        }
                        column(DirUnitCost_PurchLine;"Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDisc_PurchLine;"Purchase Line"."Line Discount %")
                        {
                        }
                        column(LineAmt2_PurchLine;"Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_PurchLine;"Purchase Line"."Allow Invoice Disc.")
                        {
                        }
                        column(HomePage;CompanyInfo."Home Page")
                        {
                        }
                        column(EMail;CompanyInfo."E-Mail")
                        {
                        }
                        column(VAT_PurchLine;"Purchase Line"."VAT %")
                        {
                        }
                        column(VATIdentifier_PurchLine;"Purchase Line"."VAT Identifier")
                        {
                        }
                        column(InvDiscAmt_PurchLine;-PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVAT;PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(VATAmountText;VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount;VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount;-VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount;VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal;TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount;TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount;TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DirectUniCostCaption;DirectUniCostCaptionLbl)
                        {
                        }
                        column(PurchLineLineDiscCaption;PurchLineLineDiscCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption;VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_PurchLineCaption;"Purchase Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Desc_PurchLineCaption;"Purchase Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_PurchLineCaption;"Purchase Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_PurchLineCaption;"Purchase Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchLineCaption;"Purchase Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(VAT_PurchLineCaption;"Purchase Line".FIELDCAPTION("VAT %"))
                        {
                        }
                        column(FirstPurchOrder;"Purchase Line"."First Purch. Order")
                        {
                        }
                        column(RiskItem;"Purchase Line"."Risk Item")
                        {
                        }
                        column(Asterix;Asterix)
                        {
                        }
                        dataitem(DimensionLoop2;Table2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));
                            column(LineDimCaption;LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                  IF NOT DimSetEntry2.FINDSET THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2',DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        DimSetEntry2."Dimension Code",DimSetEntry2."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                  CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID","Purchase Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                              PurchLine.FIND('-')
                            ELSE
                              PurchLine.NEXT;
                            "Purchase Line" := PurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                              PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "Purchase Line"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line"."Allow Invoice Disc.");
                            TotalSubTotal += "Purchase Line"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line".Amount;

                            // NTO 2 -
                            Item_temp.SETRANGE(Item_temp."No.", "Purchase Line"."No.");
                            IF Item_temp.FINDFIRST THEN BEGIN
                              ref_fourn := FORMAT(Item_temp."Vendor Item No.");
                            END
                            ELSE
                            ref_fourn :='';
                            // NTO 2 +
                            //RiskItem And FirstPurch 13.06.18
                            IF "Purchase Line"."First Purch. Order" = TRUE THEN
                                Asterix := '*'

                            //ELSE IF "Purchase Line"."Risk Item" = TRUE THEN
                              //  Asterix := '**'
                            ELSE
                                Asterix :='';
                            //END RiskItem And FirstPurch 13.06.18
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2"= '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                              MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            PurchLine.SETRANGE("Line No.",0,PurchLine."Line No.");
                            SETRANGE(Number,1,PurchLine.COUNT);
                            CurrReport.CREATETOTALS(PurchLine."Line Amount",PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                              CurrReport.BREAK;
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount",VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount",VATAmountLine."VAT Base",VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate;VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader;VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Purchase Header"."Posting Date","Purchase Header"."Currency Code",
                                               VATAmountLine."VAT Base","Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Purchase Header"."Posting Date","Purchase Header"."Currency Code",
                                                 VATAmountLine."VAT Amount","Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purchase Header"."Currency Code"  = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                              CurrReport.BREAK;

                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text007 + Text008
                            ELSE
                              VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date","Purchase Header"."Currency Code",1);
                            VALExchRate := STRSUBSTNO(Text009,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(PayToVendNo_PurchHeader;"Purchase Header"."Pay-to Vendor No.")
                        {
                        }
                        column(FooterLabel1;FooterLabel[1])
                        {
                        }
                        column(FooterLabel2;FooterLabel[2])
                        {
                        }
                        column(FooterLabel3;FooterLabel[3])
                        {
                        }
                        column(FooterLabel4;FooterLabel[4])
                        {
                        }
                        column(FooterLabel5;FooterLabel[5])
                        {
                        }
                        column(FooterLabel6;FooterLabel[6])
                        {
                        }
                        column(FooterLabel7;FooterLabel[7])
                        {
                        }
                        column(FooterLabel8;FooterLabel[8])
                        {
                        }
                        column(FooterTxt1;FooterTxt[1])
                        {
                        }
                        column(FooterTxt2;FooterTxt[2])
                        {
                        }
                        column(FooterTxt3;FooterTxt[3])
                        {
                        }
                        column(FooterTxt4;FooterTxt[4])
                        {
                        }
                        column(FooterTxt5;FooterTxt[5])
                        {
                        }
                        column(FooterTxt6;FooterTxt[6])
                        {
                        }
                        column(FooterTxt7;FooterTxt[7])
                        {
                        }
                        column(FooterTxt8;FooterTxt[8])
                        {
                        }
                    }
                    dataitem(Total3;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(SellToCustNo_PurchHeader;"Purchase Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1;ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2;ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3;ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4;ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5;ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6;ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7;ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8;ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption;ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SellToCustNo_PurchHeaderCaption;"Purchase Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                              CurrReport.BREAK;
                        end;
                    }
                    dataitem(PrepmtLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=FILTER(1..));
                        column(PrepmtLineAmount;PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufGLAccNo;PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtInvBufDesc;PrepmtInvBuf.Description)
                        {
                        }
                        column(TotalInclVATText2;TotalInclVATText)
                        {
                        }
                        column(TotalExclVATText2;TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBufAmt;PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountText;PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtVATAmount;PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT;PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount;PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuDescCaption;PrepmtInvBuDescCaptionLbl)
                        {
                        }
                        column(PrepmtInvBufGLAccNoCaption;PrepmtInvBufGLAccNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption;PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop;Table2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                  IF NOT PrepmtDimSetEntry.FINDSET THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2',PrepmtDimSetEntry."Dimension Code",PrepmtDimSetEntry."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        PrepmtDimSetEntry."Dimension Code",PrepmtDimSetEntry."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL PrepmtDimSetEntry.NEXT = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                              IF NOT PrepmtInvBuf.FIND('-') THEN
                                CurrReport.BREAK;
                            END ELSE
                              IF PrepmtInvBuf.NEXT = 0 THEN
                                CurrReport.BREAK;

                            IF ShowInternalInfo THEN
                              PrepmtDimSetEntry.SETRANGE("Dimension Set ID",PrepmtInvBuf."Dimension Set ID");

                            IF "Purchase Header"."Prices Including VAT" THEN
                              PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            ELSE
                              PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(
                              PrepmtInvBuf.Amount,PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount",PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt;PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase;PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt;PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVAT;PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(PrepmtVATAmtLineVATId;PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepymtVATAmtSpecCaption;PrepymtVATAmtSpecCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number,1,PrepmtVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(PrepmtTotal;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(PrepmtPaymentTerms_Desc;PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepymtTermsDescCaption1;PrepymtTermsDescCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT PrepmtInvBuf.FIND('-') THEN
                               CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtPurchLine: Record "39" temporary;
                    TempPurchLine: Record "39" temporary;
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL;
                    VATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header",PurchLine,0);
                    PurchLine.CalcVATAmountLines(0,"Purchase Header",PurchLine,VATAmountLine);
                    PurchLine.UpdateVATOnLines(0,"Purchase Header",PurchLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code","Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DELETEALL;
                    PurchPostPrepmt.GetPurchLines("Purchase Header",0,PrepmtPurchLine);
                    IF (NOT PrepmtPurchLine.ISEMPTY) THEN BEGIN
                      PurchPostPrepmt.GetPurchLinesToDeduct("Purchase Header",TempPurchLine);
                      IF NOT TempPurchLine.ISEMPTY THEN
                        PurchPostPrepmt.CalcVATAmountLines("Purchase Header",TempPurchLine,PrePmtVATAmountLineDeduct,1);
                    END;
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header",PrepmtPurchLine,PrepmtVATAmountLine,0);
                    IF PrepmtVATAmountLine.FINDSET THEN
                      REPEAT
                        PrePmtVATAmountLineDeduct := PrepmtVATAmountLine;
                        IF PrePmtVATAmountLineDeduct.FIND THEN BEGIN
                          PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrePmtVATAmountLineDeduct."VAT Base";
                          PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrePmtVATAmountLineDeduct."VAT Amount";
                          PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                            PrePmtVATAmountLineDeduct."Amount Including VAT";
                          PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrePmtVATAmountLineDeduct."Line Amount";
                          PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                            PrePmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                          PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                            PrePmtVATAmountLineDeduct."Invoice Discount Amount";
                          PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                            PrePmtVATAmountLineDeduct."Calculated VAT Amount";
                          PrepmtVATAmountLine.MODIFY;
                        END;
                      UNTIL PrepmtVATAmountLine.NEXT = 0;
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header",PrepmtPurchLine,PrepmtVATAmountLine,0);
                    PurchPostPrepmt.BuildInvLineBuffer2("Purchase Header",PrepmtPurchLine,0,PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN
                      CopyText := Text003;
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;

                    TotalSubTotal := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                      PurchCountPrinted.RUN("Purchase Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchaseLine_Rec: Record "39";
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(CompanyInfo.Picture);
                PrepareHeader;
                PrepareFooter;
                
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                  FormatAddr.RespCenter(CompanyAddr,RespCenter);
                  CompanyInfo."Phone No." := RespCenter."Phone No.";
                  CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                  FormatAddr.Company(CompanyAddr,CompanyInfo);
                
                DimSetEntry1.SETRANGE("Dimension Set ID","Dimension Set ID");
                
                IF "Purchaser Code" = '' THEN BEGIN
                  SalesPurchPerson.INIT;
                  PurchaserText := '';
                END ELSE BEGIN
                  SalesPurchPerson.GET("Purchaser Code");
                  PurchaserText := Text000
                END;
                IF "Your Reference" = '' THEN
                  ReferenceText := ''
                ELSE
                  ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                  VATNoText := ''
                ELSE
                  VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                  GLSetup.TESTFIELD("LCY Code");
                  TotalText := STRSUBSTNO(Text001,GLSetup."LCY Code");
                  TotalInclVATText := STRSUBSTNO(Text002,GLSetup."LCY Code");
                  TotalExclVATText := STRSUBSTNO(Text006,GLSetup."LCY Code");
                END ELSE BEGIN
                  TotalText := STRSUBSTNO(Text001,"Currency Code");
                  TotalInclVATText := STRSUBSTNO(Text002,"Currency Code");
                  TotalExclVATText := STRSUBSTNO(Text006,"Currency Code");
                END;
                
                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr,"Purchase Header");
                IF "Buy-from Vendor No." <> "Pay-to Vendor No." THEN
                  FormatAddr.PurchHeaderPayTo(VendAddr,"Purchase Header");
                IF "Payment Terms Code" = '' THEN
                  PaymentTerms.INIT
                ELSE BEGIN
                  PaymentTerms.GET("Payment Terms Code");
                  PaymentTerms.TranslateDescription(PaymentTerms,"Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                  PrepmtPaymentTerms.INIT
                ELSE BEGIN
                  PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                  PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms,"Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                  ShipmentMethod.INIT
                ELSE BEGIN
                  ShipmentMethod.GET("Shipment Method Code");
                  ShipmentMethod.TranslateDescription(ShipmentMethod,"Language Code");
                END;
                
                
                FormatAddr.PurchHeaderShipTo(ShipToAddr,"Purchase Header");
                
                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);
                
                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    SegManagement.LogDocument(
                      13,"No.","Doc. No. Occurrence","No. of Archived Versions",DATABASE::Vendor,"Buy-from Vendor No.",
                      "Purchaser Code",'',"Posting Description",'');
                  END;
                END;
                PricesInclVATtxt := FORMAT("Prices Including VAT");
                //RiskItem And FirstPurch 13.06.18
                NewItemShow:='';
                PurchaseLine_Rec.RESET;
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document Type",PurchaseLine_Rec."Document Type"::Order);
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document No.","No.");
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec.Type,PurchaseLine_Rec.Type::Item);
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."First Purch. Order",TRUE);
                IF PurchaseLine_Rec.FINDFIRST THEN
                   NewItemShow:= NewItemText;
                RiskItemShow:='';
                /*PurchaseLine_Rec.RESET;
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document Type",PurchaseLine_Rec."Document Type"::Order);
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document No.","No.");
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec.Type,PurchaseLine_Rec.Type::Item);
                PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Risk Item",TRUE);
                IF PurchaseLine_Rec.FINDFIRST THEN
                   RiskItemShow:= RiskItemText;*/
                //END

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
                    field(NoofCopies;NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInformation;ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        Caption = 'Archive Document';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                              LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := PurchSetup."Arch. Orders and Ret. Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin

        GLSetup.GET;
        PurchSetup.GET;
    end;

    var
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        GLSetup: Record "98";
        CompanyInfo: Record "79";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        PrepmtPaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        VATAmountLine: Record "290" temporary;
        PrepmtVATAmountLine: Record "290" temporary;
        PrePmtVATAmountLineDeduct: Record "290" temporary;
        PurchLine: Record "39" temporary;
        DimSetEntry1: Record "480";
        DimSetEntry2: Record "480";
        PrepmtDimSetEntry: Record "480";
        PrepmtInvBuf: Record "461" temporary;
        RespCenter: Record "5714";
        Language: Record "8";
        CurrExchRate: Record "330";
        PurchSetup: Record "312";
        PurchCountPrinted: Codeunit "317";
        FormatAddr: Codeunit "365";
        PurchPost: Codeunit "90";
        ArchiveManagement: Codeunit "5063";
        SegManagement: Codeunit "5051";
        PurchPostPrepmt: Codeunit "444";
        VendAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        BuyFromAddr: array [8] of Text[50];
        PurchaserText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: Label 'VAT Amount Specification in ';
        Text004: Label 'PURCHASE ORDER N° %1';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtAmountInclVAT: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        PricesInclVATtxt: Text[30];
        AllowInvDisctxt: Text[30];
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        CompanyInfoFaxNoCaptionLbl: Label 'Fax No.';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        DocumentDateCaptionLbl: Label 'Date';
        HdrDimCaptionLbl: Label 'Header Dimensions';
        DirectUniCostCaptionLbl: Label 'Direct Unit Cost';
        PurchLineLineDiscCaptionLbl: Label 'Discount %';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        PaymentDetailsCaptionLbl: Label 'Payment Details';
        VendNoCaptionLbl: Label 'Vendor No.';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        PrepmtInvBuDescCaptionLbl: Label 'Description';
        PrepmtInvBufGLAccNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepymtVATAmtSpecCaptionLbl: Label 'Prepayment VAT Amount Specification';
        AmountCaptionLbl: Label 'Amount';
        PurchLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATAmtLineVATCaptionLbl: Label 'VAT %';
        VATAmtLineVATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        VATAmtLineInvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCaptionLbl: Label 'Line Amount';
        VALVATBaseLCYCaptionLbl: Label 'VAT Base';
        TotalCaptionLbl: Label 'Total';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        HomePageCaptionLbl: Label 'Home Page';
        EmailIDCaptionLbl: Label 'E-Mail';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        HeaderLabel: array [20] of Text[30];
        HeaderTxt: array [20] of Text[120];
        FooterLabel: array [20] of Text[30];
        FooterTxt: array [20] of Text[120];
        ML_PurchPerson: Label 'Purchaser';
        ML_Reference: Label 'Reference';
        ML_PmtTerms: Label 'Payment Terms';
        ML_ShipCond: Label 'Incoterm';
        ML_ShipAdr: Label 'Shipping Address';
        ML_InvAdr: Label 'Invoice Address';
        ML_OrderAdr: Label 'Order Address';
        ML_ShipDate: Label 'Shipping Date';
        ML_Continued: Label 'Continued';
        Prix_Caption: Label 'Price';
        Qty_caption: Label 'Qty';
        RefVendor: Label 'Vendor Ref';
        Item_temp: Record "27";
        ref_fourn: Text[30];
        ML_Forwarder: Label 'Forwarder';
        ML_Location_code: Label 'Port of';
        ML_Method: Label 'Ship per';
        ML_Date_Receipt: Label 'Shipment Date';
        ML_Destination: Label 'Final warehouse';
        Asterix: Text;
        NewItemText: Label '(*) 3 additional products to deliver as production sample, free of charge';
        RiskItemText: Label '(**) Risk product on the order';
        NewItemShow: Text;
        RiskItemShow: Text;

    [Scope('Internal')]
    procedure InitializeRequest(NewNoOfCopies: Integer;NewShowInternalInfo: Boolean;NewArchiveDocument: Boolean;NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        ArchiveDocument := NewArchiveDocument;
        LogInteraction := NewLogInteraction;
    end;

    [Scope('Internal')]
    procedure PrepareHeader()
    begin
        CLEAR(HeaderLabel);
        CLEAR(HeaderTxt);

        WITH "Purchase Header" DO BEGIN
          FormatAddr.PurchHeaderBuyFrom(VendAddr,"Purchase Header");

          IF SalesPurchPerson.GET("Purchaser Code") THEN BEGIN
            HeaderLabel[2] := ML_PurchPerson;
            HeaderTxt[2] := SalesPurchPerson.Name;
          END;

          IF "Your Reference" <> '' THEN BEGIN
            HeaderLabel[3] := ML_Reference;
            HeaderTxt[3] := "Your Reference";
          END;

          COMPRESSARRAY(HeaderLabel);
          COMPRESSARRAY(HeaderTxt);
        END;
    end;

    [Scope('Internal')]
    procedure PrepareFooter()
    var
        PmtMethod: Record "3";
        ShipMethod: Record "10";
        transitaire_Re_Loc: Record "50009";
    begin

        CLEAR(FooterLabel);
        CLEAR(FooterTxt);

        //"Purchase Header".GET();

        WITH "Purchase Header" DO BEGIN

          IF PmtMethod.GET("Payment Terms Code") THEN BEGIN
            FooterLabel[1] := ML_PmtTerms;
            FooterTxt[1]  := PmtMethod.Description;
          END;

          // Shipping Conditions
          IF ShipMethod.GET("Shipment Method Code") THEN BEGIN
            FooterLabel[2] := ML_ShipCond;
            FooterTxt[2]  := ShipMethod.Description;
          END;

        // NTO 3 -

          //START CHG01
          // Forwarder
          IF "Purchase Header"."Forwarding Agent Code" <> '' THEN BEGIN
            IF transitaire_Re_Loc.GET("Purchase Header"."Forwarding Agent Code") THEN BEGIN
              FooterLabel[3] := ML_Forwarder;
              FooterTxt[3]  := transitaire_Re_Loc.Description;
            END;
          END;
          //STOP CHG01

          // Location Code
          IF "Location Code" <> '' THEN BEGIN
            FooterLabel[4] := ML_Location_code;

            //MGTS10.028; 001; mhh; begin
            //deleted line: FooterTxt[4]  := "Location Code";
            FooterTxt[4]  := "Port d'arrivée";
            //MGTS10.028; 001; mhh; end

          END;

          // Ship per
          IF FORMAT("Purchase Header"."Ship Per") <> '' THEN BEGIN
            FooterLabel[5] := ML_Method;
            FooterTxt[5]  := FORMAT("Purchase Header"."Ship Per");
          END;
          //THM210318
          // Ship TO
          IF "Purchase Header"."Ship-to Code" <> '' THEN BEGIN
            FooterLabel[6] := ML_Destination;
            FooterTxt[6]  := FORMAT("Purchase Header"."Ship-to Name");
          END;
          //END THM210318
          // Shipment Date
          IF  FORMAT("Purchase Header"."Requested Receipt Date") <> '' THEN BEGIN
            FooterLabel[7] := ML_Date_Receipt;
            FooterTxt[7]  := FORMAT("Purchase Header"."Requested Receipt Date");
          END;

        // NTO 3 +

          // Invoice and Order Address
          IF "Buy-from Vendor No." <> "Pay-to Vendor No." THEN BEGIN
            FooterLabel[8] := ML_InvAdr;
            FooterTxt[8]  := "Pay-to Name" + ', ' + "Pay-to City";
            FooterLabel[9] := ML_OrderAdr;
            FooterTxt[9]  := "Buy-from Vendor Name" + ', ' + "Buy-from City";
          END;

          // Shipping Date if <> Document Date
          IF NOT ("Expected Receipt Date" IN ["Document Date",0D]) THEN BEGIN
            FooterLabel[10] := ML_ShipDate;
            FooterTxt[10] := FORMAT("Expected Receipt Date",0,4);
          END;

          COMPRESSARRAY(FooterLabel);
          COMPRESSARRAY(FooterTxt);
        END;
    end;
}

