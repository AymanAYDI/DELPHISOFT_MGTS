report 1322 "Standard Purchase - Order"
{
    RDLCLayout = './StandardPurchaseOrder.rdlc';
    WordLayout = './StandardPurchaseOrder.docx';
    Caption = 'Purchase - Order';
    DefaultLayout = Word;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    WordMergeDataItem = "Purchase Header";

    dataset
    {
        dataitem(DataItem1; Table38)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Standard Purchase - Order';
            column(PHExpectedReceiptDat; FORMAT("Expected Receipt Date"))
            {
            }
            column(PHRequestedReceiptDat; FORMAT("Requested Receipt Date"))
            {
            }
            column(PHPromisedReceiptDat; FORMAT("Promised Receipt Date"))
            {
            }
            column(PHRequestedDeliveryDate; FORMAT("Requested Delivery Date"))
            {
            }
            column(PHShipPer; "Purchase Header"."Ship Per")
            {
            }
            column(PHPortdedepart; "Purchase Header"."Port de départ")
            {
            }
            column(PHPortdarrive; "Purchase Header"."Port d'arrivée")
            {
            }
            column(PHCodeevenement; FORMAT("Purchase Header"."Code événement"))
            {
            }
            column(PHForwardingAgentCod; "Purchase Header"."Forwarding Agent Code")
            {
            }
            column(PHNa; "Purchase Header"."Pay-to Name")
            {
            }
            column(PHShiptocode; "Purchase Header"."Ship-to Code")
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyHomePage_Lbl; HomePageCaptionLbl)
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEmail_Lbl; EmailIDCaptionLbl)
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoCaptionLbl)
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoCaptionLbl)
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameCaptionLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FIELDCAPTION("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoCaptionLbl)
            {
            }
            column(CompanyIBAN; CompanyInfo.IBAN)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FIELDCAPTION(IBAN))
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FIELDCAPTION("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            {
            }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            {
            }
            column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            {
            }
            column(DocType_PurchHeader; "Document Type")
            {
            }
            column(No_PurchHeader; "No.")
            {
            }
            column(DocumentTitle_Lbl; DocumentTitleLbl)
            {
            }
            column(Amount_Lbl; AmountCaptionLbl)
            {
            }
            column(PurchLineInvDiscAmt_Lbl; PurchLineInvDiscAmtCaptionLbl)
            {
            }
            column(Subtotal_Lbl; SubtotalCaptionLbl)
            {
            }
            column(VATAmtLineVAT_Lbl; VATAmtLineVATCaptionLbl)
            {
            }
            column(VATAmtLineVATAmt_Lbl; VATAmtLineVATAmtCaptionLbl)
            {
            }
            column(VATAmtSpec_Lbl; VATAmtSpecCaptionLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierCaptionLbl)
            {
            }
            column(VATAmtLineInvDiscBaseAmt_Lbl; VATAmtLineInvDiscBaseAmtCaptionLbl)
            {
            }
            column(VATAmtLineLineAmt_Lbl; VATAmtLineLineAmtCaptionLbl)
            {
            }
            column(VALVATBaseLCY_Lbl; VALVATBaseLCYCaptionLbl)
            {
            }
            column(Total_Lbl; TotalCaptionLbl)
            {
            }
            column(PaymentTermsDesc_Lbl; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShipmentMethodDesc_Lbl; ShipmentMethodDescCaptionLbl)
            {
            }
            column(PrepymtTermsDesc_Lbl; PrepymtTermsDescCaptionLbl)
            {
            }
            column(HomePage_Lbl; HomePageCaptionLbl)
            {
            }
            column(EmailID_Lbl; EmailIDCaptionLbl)
            {
            }
            column(AllowInvoiceDisc_Lbl; AllowInvoiceDiscCaptionLbl)
            {
            }
            column(CurrRepPageNo; STRSUBSTNO(PageLbl, FORMAT(CurrReport.PAGENO)))
            {
            }
            column(DocumentDate; FORMAT("Document Date"))
            {
            }
            column(DueDate; FORMAT("Due Date", 0, 4))
            {
            }
            column(ExptRecptDt_PurchaseHeader; FORMAT("Expected Receipt Date", 0, 4))
            {
            }
            column(OrderDate_PurchaseHeader; FORMAT("Order Date"))
            {
            }
            column(VATNoText; VATNoText)
            {
            }
            column(VATRegNo_PurchHeader; "VAT Registration No.")
            {
            }
            column(PurchaserText; PurchaserText)
            {
            }
            column(SalesPurchPersonName; SalespersonPurchaser.Name)
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }
            column(YourRef_PurchHeader; "Your Reference")
            {
            }
            column(BuyFrmVendNo_PurchHeader; "Buy-from Vendor No.")
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
            column(PricesIncludingVAT_Lbl; PricesIncludingVATCaptionLbl)
            {
            }
            column(PricesInclVAT_PurchHeader; "Prices Including VAT")
            {
            }
            column(OutputNo; OutputNo)
            {
            }
            column(VATBaseDisc_PurchHeader; "VAT Base Discount %")
            {
            }
            column(PricesInclVATtxt; PricesInclVATtxtLbl)
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
            column(DimText; DimText)
            {
            }
            column(OrderNo_Lbl; OrderNoCaptionLbl)
            {
            }
            column(Page_Lbl; PageCaptionLbl)
            {
            }
            column(DocumentDate_Lbl; DocumentDateCaptionLbl)
            {
            }
            column(BuyFrmVendNo_PurchHeader_Lbl; FIELDCAPTION("Buy-from Vendor No."))
            {
            }
            column(PricesInclVAT_PurchHeader_Lbl; FIELDCAPTION("Prices Including VAT"))
            {
            }
            column(Receiveby_Lbl; ReceivebyCaptionLbl)
            {
            }
            column(Buyer_Lbl; BuyerCaptionLbl)
            {
            }
            column(PayToVendNo_PurchHeader; "Pay-to Vendor No.")
            {
            }
            column(VendAddr8; VendAddr[8])
            {
            }
            column(VendAddr7; VendAddr[7])
            {
            }
            column(VendAddr6; VendAddr[6])
            {
            }
            column(VendAddr5; VendAddr[5])
            {
            }
            column(VendAddr4; VendAddr[4])
            {
            }
            column(VendAddr3; VendAddr[3])
            {
            }
            column(VendAddr2; VendAddr[2])
            {
            }
            column(VendAddr1; VendAddr[1])
            {
            }
            column(PaymentDetails_Lbl; PaymentDetailsCaptionLbl)
            {
            }
            column(VendNo_Lbl; VendNoCaptionLbl)
            {
            }
            column(SellToCustNo_PurchHeader; "Sell-to Customer No.")
            {
            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(ShiptoAddress_Lbl; ShiptoAddressCaptionLbl)
            {
            }
            column(SellToCustNo_PurchHeader_Lbl; FIELDCAPTION("Sell-to Customer No."))
            {
            }
            column(ItemNumber_Lbl; ItemNumberCaptionLbl)
            {
            }
            column(ItemDescription_Lbl; ItemDescriptionCaptionLbl)
            {
            }
            column(ItemQuantity_Lbl; ItemQuantityCaptionLbl)
            {
            }
            column(ItemUnit_Lbl; ItemUnitCaptionLbl)
            {
            }
            column(ItemUnitPrice_Lbl; ItemUnitPriceCaptionLbl)
            {
            }
            column(ItemLineAmount_Lbl; ItemLineAmountCaptionLbl)
            {
            }
            column(ToCaption_Lbl; ToCaptionLbl)
            {
            }
            column(VendorIDCaption_Lbl; VendorIDCaptionLbl)
            {
            }
            column(ConfirmToCaption_Lbl; ConfirmToCaptionLbl)
            {
            }
            column(PurchOrderCaption_Lbl; PurchOrderCaptionLbl)
            {
            }
            column(PurchOrderNumCaption_Lbl; PurchOrderNumCaptionLbl)
            {
            }
            column(PurchOrderDateCaption_Lbl; PurchOrderDateCaptionLbl)
            {
            }
            column(TaxIdentTypeCaption_Lbl; TaxIdentTypeCaptionLbl)
            {
            }
            column(OrderDate_Lbl; OrderDateLbl)
            {
            }
            dataitem(DataItem4; Table39)
            {
                DataItemLink = Document Type=FIELD(Document Type),
                               Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document Type,Document No.,Line No.);
                column(PHSSOrder;"Purchase Line"."Special Order Sales No.")
                {
                }
                column(LineNo_PurchLine;"Line No.")
                {
                }
                column(AllowInvDisctxt;AllowInvDisctxt)
                {
                }
                column(Type_PurchLine;FORMAT(Type,0,2))
                {
                }
                column(No_PurchLine;"No.")
                {
                }
                column(Desc_PurchLine;Description)
                {
                }
                column(Qty_PurchLine;Quantity)
                {
                }
                column(UOM_PurchLine;"Unit of Measure")
                {
                }
                column(DirUnitCost_PurchLine;"Direct Unit Cost")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 2;
                }
                column(LineDisc_PurchLine;"Line Discount %")
                {
                }
                column(LineAmt_PurchLine;"Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(AllowInvDisc_PurchLine;"Allow Invoice Disc.")
                {
                }
                column(VATIdentifier_PurchLine;"VAT Identifier")
                {
                }
                column(InvDiscAmt_PurchLine;-"Inv. Discount Amount")
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInclVAT;"Line Amount" - "Inv. Discount Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(DirectUniCost_Lbl;DirectUniCostCaptionLbl)
                {
                }
                column(PurchLineLineDisc_Lbl;PurchLineLineDiscCaptionLbl)
                {
                }
                column(VATDiscountAmount_Lbl;VATDiscountAmountCaptionLbl)
                {
                }
                column(No_PurchLine_Lbl;FIELDCAPTION("No."))
                {
                }
                column(Desc_PurchLine_Lbl;FIELDCAPTION(Description))
                {
                }
                column(Qty_PurchLine_Lbl;FIELDCAPTION(Quantity))
                {
                }
                column(UOM_PurchLine_Lbl;ItemUnitOfMeasureCaptionLbl)
                {
                }
                column(VATIdentifier_PurchLine_Lbl;FIELDCAPTION("VAT Identifier"))
                {
                }
                column(AmountIncludingVAT;"Amount Including VAT")
                {
                }
                column(TotalPriceCaption_Lbl;TotalPriceCaptionLbl)
                {
                }
                column(InvDiscCaption_Lbl;InvDiscCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    AllowInvDisctxt := FORMAT("Allow Invoice Disc.");
                    TotalSubTotal += "Line Amount";
                    TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;
                end;
            }
            dataitem(Totals;Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(VATAmountText;TempVATAmountLine.VATAmountText)
                {
                }
                column(TotalVATAmount;VATAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATDiscountAmount;-VATDiscountAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATBaseAmount;VATBaseAmount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountInclVAT;TotalAmountInclVAT)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalInclVATText;TotalInclVATText)
                {
                }
                column(TotalExclVATText;TotalExclVATText)
                {
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
                column(TotalText;TotalText)
                {
                }

                trigger OnAfterGetRecord()
                var
                    TempPrepmtPurchLine: Record "39" temporary;
                begin
                    CLEAR(TempPurchLine);
                    CLEAR(PurchPost);
                    TempPurchLine.DELETEALL;
                    TempVATAmountLine.DELETEALL;
                    PurchPost.GetPurchLines("Purchase Header",TempPurchLine,0);
                    TempPurchLine.CalcVATAmountLines(0,"Purchase Header",TempPurchLine,TempVATAmountLine);
                    TempPurchLine.UpdateVATOnLines(0,"Purchase Header",TempPurchLine,TempVATAmountLine);
                    VATAmount := TempVATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code","Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT;

                    TempPrepaymentInvLineBuffer.DELETEALL;
                    PurchasePostPrepayments.GetPurchLines("Purchase Header",0,TempPrepmtPurchLine);
                    IF NOT TempPrepmtPurchLine.ISEMPTY THEN BEGIN
                      PurchasePostPrepayments.GetPurchLinesToDeduct("Purchase Header",TempPurchLine);
                      IF NOT TempPurchLine.ISEMPTY THEN
                        PurchasePostPrepayments.CalcVATAmountLines("Purchase Header",TempPurchLine,TempPrePmtVATAmountLineDeduct,1);
                    END;
                    PurchasePostPrepayments.CalcVATAmountLines("Purchase Header",TempPrepmtPurchLine,TempPrepmtVATAmountLine,0);
                    TempPrepmtVATAmountLine.DeductVATAmountLine(TempPrePmtVATAmountLineDeduct);
                    PurchasePostPrepayments.UpdateVATOnLines("Purchase Header",TempPrepmtPurchLine,TempPrepmtVATAmountLine,0);
                    PurchasePostPrepayments.BuildInvLineBuffer2("Purchase Header",TempPrepmtPurchLine,0,TempPrepaymentInvLineBuffer);
                    PrepmtVATAmount := TempPrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := TempPrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := TempPrepmtVATAmountLine.GetTotalAmountInclVAT;
                end;
            }
            dataitem(VATCounter;Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(VATAmtLineVATBase;TempVATAmountLine."VAT Base")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineVATAmt;TempVATAmountLine."VAT Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineLineAmt;TempVATAmountLine."Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvDiscBaseAmt;TempVATAmountLine."Inv. Disc. Base Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineInvDiscAmt;TempVATAmountLine."Invoice Discount Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmtLineVAT;TempVATAmountLine."VAT %")
                {
                    DecimalPlaces = 0:5;
                }
                column(VATAmtLineVATIdentifier;TempVATAmountLine."VAT Identifier")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TempVATAmountLine.GetLine(Number);
                end;

                trigger OnPreDataItem()
                begin
                    IF VATAmount = 0 THEN
                      CurrReport.BREAK;
                    SETRANGE(Number,1,TempVATAmountLine.COUNT);
                    CurrReport.CREATETOTALS(
                      TempVATAmountLine."Line Amount",TempVATAmountLine."Inv. Disc. Base Amount",
                      TempVATAmountLine."Invoice Discount Amount",TempVATAmountLine."VAT Base",TempVATAmountLine."VAT Amount");
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
                    TempVATAmountLine.GetLine(Number);
                    VALVATBaseLCY :=
                      TempVATAmountLine.GetBaseLCY(
                        "Purchase Header"."Posting Date","Purchase Header"."Currency Code","Purchase Header"."Currency Factor");
                    VALVATAmountLCY :=
                      TempVATAmountLine.GetAmountLCY(
                        "Purchase Header"."Posting Date","Purchase Header"."Currency Code","Purchase Header"."Currency Factor");
                end;

                trigger OnPreDataItem()
                begin
                    IF (NOT GLSetup."Print VAT specification in LCY") OR
                       ("Purchase Header"."Currency Code" = '') OR
                       (TempVATAmountLine.GetTotalVATAmount = 0)
                    THEN
                      CurrReport.BREAK;

                    SETRANGE(Number,1,TempVATAmountLine.COUNT);

                    IF GLSetup."LCY Code" = '' THEN
                      VALSpecLCYHeader := VATAmountSpecificationLbl + LocalCurrentyLbl
                    ELSE
                      VALSpecLCYHeader := VATAmountSpecificationLbl + FORMAT(GLSetup."LCY Code");

                    CurrExchRate.FindCurrency("Purchase Header"."Posting Date","Purchase Header"."Currency Code",1);
                    VALExchRate := STRSUBSTNO(ExchangeRateLbl,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
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
                column(PrepmtInvBufGLAccNo;TempPrepaymentInvLineBuffer."G/L Account No.")
                {
                }
                column(PrepmtInvBufDesc;TempPrepaymentInvLineBuffer.Description)
                {
                }
                column(TotalInclVATText2;TotalInclVATText)
                {
                }
                column(TotalExclVATText2;TotalExclVATText)
                {
                }
                column(PrepmtInvBufAmt;TempPrepaymentInvLineBuffer.Amount)
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmountText;TempPrepmtVATAmountLine.VATAmountText)
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

                trigger OnAfterGetRecord()
                begin
                    IF Number = 1 THEN BEGIN
                      IF NOT TempPrepaymentInvLineBuffer.FIND('-') THEN
                        CurrReport.BREAK;
                    END ELSE
                      IF TempPrepaymentInvLineBuffer.NEXT = 0 THEN
                        CurrReport.BREAK;

                    IF "Purchase Header"."Prices Including VAT" THEN
                      PrepmtLineAmount := TempPrepaymentInvLineBuffer."Amount Incl. VAT"
                    ELSE
                      PrepmtLineAmount := TempPrepaymentInvLineBuffer.Amount;
                end;
            }
            dataitem(PrepmtVATCounter;Table2000000026)
            {
                DataItemTableView = SORTING(Number);
                column(PrepmtVATAmtLineVATAmt;TempPrepmtVATAmountLine."VAT Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineVATBase;TempPrepmtVATAmountLine."VAT Base")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineLineAmt;TempPrepmtVATAmountLine."Line Amount")
                {
                    AutoFormatExpression = "Purchase Header"."Currency Code";
                    AutoFormatType = 1;
                }
                column(PrepmtVATAmtLineVAT;TempPrepmtVATAmountLine."VAT %")
                {
                    DecimalPlaces = 0:5;
                }
                column(PrepmtVATAmtLineVATId;TempPrepmtVATAmountLine."VAT Identifier")
                {
                }
                column(PrepymtVATAmtSpecCaption;PrepymtVATAmtSpecCaptionLbl)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    TempPrepmtVATAmountLine.GetLine(Number);
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number,1,TempPrepmtVATAmountLine.COUNT);
                end;
            }
            dataitem(LetterText;Table2000000026)
            {
                DataItemTableView = SORTING(Number)
                                    WHERE(Number=CONST(1));
                column(GreetingText;GreetingLbl)
                {
                }
                column(BodyText;BodyLbl)
                {
                }
                column(ClosingText;ClosingLbl)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                TotalAmount := 0;
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Purchase Header");
                FormatDocumentFields("Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);

                  IF LogInteraction THEN
                    SegManagement.LogDocument(
                      13,"No.",0,0,DATABASE::Vendor,"Buy-from Vendor No.",
                      "Purchaser Code",'',"Posting Description",'');
                END;
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
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies whether to archive the order.';
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies whether to log interaction.';
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
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        PurchSetup.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
          InitLogInteraction;
    end;

    var
        PageLbl: Label 'Page %1', Comment='%1 = Page No.';
        VATAmountSpecificationLbl: Label 'VAT Amount Specification in ';
        LocalCurrentyLbl: Label 'Local Currency';
        ExchangeRateLbl: Label 'Exchange rate: %1/%2', Comment='%1 = CurrExchRate."Relational Exch. Rate Amount", %2 = CurrExchRate."Exchange Rate Amount"';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoBankAccNoCaptionLbl: Label 'Account No.';
        OrderNoCaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        DocumentDateCaptionLbl: Label 'Document Date';
        DirectUniCostCaptionLbl: Label 'Unit Price';
        PurchLineLineDiscCaptionLbl: Label 'Discount %';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
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
        PricesInclVATtxtLbl: Label 'Prices Including VAT';
        TotalCaptionLbl: Label 'Total';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShipmentMethodDescCaptionLbl: Label 'Shipment Method';
        PrepymtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        HomePageCaptionLbl: Label 'Home Page';
        EmailIDCaptionLbl: Label 'Email';
        AllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        GLSetup: Record "98";
        CompanyInfo: Record "79";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        PrepmtPaymentTerms: Record "3";
        SalespersonPurchaser: Record "13";
        TempVATAmountLine: Record "290" temporary;
        TempPrepmtVATAmountLine: Record "290" temporary;
        TempPurchLine: Record "39" temporary;
        TempPrepaymentInvLineBuffer: Record "461" temporary;
        TempPrePmtVATAmountLineDeduct: Record "290" temporary;
        RespCenter: Record "5714";
        Language: Record "8";
        CurrExchRate: Record "330";
        PurchSetup: Record "312";
        FormatAddr: Codeunit "365";
        FormatDocument: Codeunit "368";
        PurchPost: Codeunit "90";
        SegManagement: Codeunit "5051";
        PurchasePostPrepayments: Codeunit "444";
        ArchiveManagement: Codeunit "5063";
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
        OutputNo: Integer;
        DimText: Text[120];
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        AllowInvDisctxt: Text[30];
        [InDataSet]
        LogInteractionEnable: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        DocumentTitleLbl: Label 'Purchase Order';
        CompanyLogoPosition: Integer;
        ReceivebyCaptionLbl: Label 'Receive By';
        BuyerCaptionLbl: Label 'Buyer';
        ItemNumberCaptionLbl: Label 'Item No.';
        ItemDescriptionCaptionLbl: Label 'Description';
        ItemQuantityCaptionLbl: Label 'Quantity';
        ItemUnitCaptionLbl: Label 'Unit';
        ItemUnitPriceCaptionLbl: Label 'Unit Price';
        ItemLineAmountCaptionLbl: Label 'Line Amount';
        PricesIncludingVATCaptionLbl: Label 'Prices Including VAT';
        ItemUnitOfMeasureCaptionLbl: Label 'Unit';
        ToCaptionLbl: Label 'To:';
        VendorIDCaptionLbl: Label 'Vendor ID';
        ConfirmToCaptionLbl: Label 'Confirm To';
        PurchOrderCaptionLbl: Label 'PURCHASE ORDER';
        PurchOrderNumCaptionLbl: Label 'Purchase Order Number:';
        PurchOrderDateCaptionLbl: Label 'Purchase Order Date:';
        TaxIdentTypeCaptionLbl: Label 'Tax Ident. Type';
        TotalPriceCaptionLbl: Label 'Total Price';
        InvDiscCaptionLbl: Label 'Invoice Discount:';
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        BodyLbl: Label 'The purchase order is attached to this message.';
        OrderDateLbl: Label 'Order Date';
        ArchiveDocument: Boolean;

    [Scope('Internal')]
    procedure InitializeRequest(LogInteractionParam: Boolean)
    begin
        LogInteraction := LogInteractionParam;
    end;

    local procedure FormatAddressFields(var PurchaseHeader: Record "38")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr,PurchaseHeader);
        IF PurchaseHeader."Buy-from Vendor No." <> PurchaseHeader."Pay-to Vendor No." THEN
          FormatAddr.PurchHeaderPayTo(VendAddr,PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr,PurchaseHeader);
    end;

    local procedure FormatDocumentFields(PurchaseHeader: Record "38")
    begin
        WITH PurchaseHeader DO BEGIN
          FormatDocument.SetTotalLabels("Currency Code",TotalText,TotalInclVATText,TotalExclVATText);
          FormatDocument.SetPurchaser(SalespersonPurchaser,"Purchaser Code",PurchaserText);
          FormatDocument.SetPaymentTerms(PaymentTerms,"Payment Terms Code","Language Code");
          FormatDocument.SetPaymentTerms(PrepmtPaymentTerms,"Prepmt. Payment Terms Code","Language Code");
          FormatDocument.SetShipmentMethod(ShipmentMethod,"Shipment Method Code","Language Code");

          ReferenceText := FormatDocument.SetText("Your Reference" <> '',FIELDCAPTION("Your Reference"));
          VATNoText := FormatDocument.SetText("VAT Registration No." <> '',FIELDCAPTION("VAT Registration No."));
        END;
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';
    end;
}

