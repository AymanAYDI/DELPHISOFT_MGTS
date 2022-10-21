report 50074 "DEL Purchase - Invoice" //406
{
    DefaultLayout = RDLC;
    RDLCLayout = './PurchaseInvoice.rdlc';

    Caption = 'Purchase - Invoice';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Invoice';
            column(No_PurchInvHeader; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(DocumentCaption; DocumentCaption())
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    column(VendAddr1; VendAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(VendAddr2; VendAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(VendAddr3; VendAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(VendAddr4; VendAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(VendAddr5; VendAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(VendAddr6; VendAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEMail; CompanyInfo."E-Mail")
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
                    column(PaytoVendorNo_PurchInvHeader; "Purch. Inv. Header"."Pay-to Vendor No.")
                    {
                    }
                    column(PaytoVendorNameCity_PurchInvHeader; "Purch. Inv. Header"."Pay-to Name" + ',' + "Purch. Inv. Header"."Pay-to City")
                    {
                    }
                    column(BuyFromVendorNameCity_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor Name" + ',' + "Purch. Inv. Header"."Buy-from City")
                    {
                    }
                    column(ExpectedRcptDate_PurchInvoiceHeader; "Purch. Inv. Header"."Expected Receipt Date")
                    {
                    }
                    column(InvoiceAddressCaption; ML_InvAdr)
                    {
                    }
                    column(OrderAddressCaption; ML_OrderAdr)
                    {
                    }
                    column(ShippingDateCaption; ML_ShipDate)
                    {
                    }
                    column(FooterLabel5; FooterLabel[5])
                    {
                    }
                    column(FooterLabel1; FooterLabel[1])
                    {
                    }
                    column(FooterLabel2; FooterLabel[2])
                    {
                    }
                    column(FooterLabel3; FooterLabel[3])
                    {
                    }
                    column(FooterLabel4; FooterLabel[4])
                    {
                    }
                    column(FooterLabel6; FooterLabel[6])
                    {
                    }
                    column(FooterTxt1; FooterTxt[1])
                    {
                    }
                    column(FooterTxt2; FooterTxt[2])
                    {
                    }
                    column(FooterTxt3; FooterTxt[3])
                    {
                    }
                    column(FooterTxt4; FooterTxt[4])
                    {
                    }
                    column(FooterTxt5; FooterTxt[5])
                    {
                    }
                    column(FooterTxt6; FooterTxt[6])
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
                    column(DocDate04_PurchInvHeader; FORMAT("Purch. Inv. Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                    {
                    }
                    column(VATNoTxt; VATNoText)
                    {
                    }
                    column(VATRegNo_PurchInvHeader; "Purch. Inv. Header"."VAT Registration No.")
                    {
                    }
                    column(DueDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Due Date"))
                    {
                    }
                    column(PurchaserTxt; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchInvHeader; "Purch. Inv. Header"."No.")
                    {
                    }
                    column(RefTxt; ReferenceText)
                    {
                    }
                    column(YourRef_PurchInvHeader; "Purch. Inv. Header"."Your Reference")
                    {
                    }
                    column(OrderNoTxt; OrderNoText)
                    {
                    }
                    column(OrderNo_PurchInvHeader; "Purch. Inv. Header"."Order No.")
                    {
                    }
                    column(VendAddr7; VendAddr[7])
                    {
                    }
                    column(VendAddr8; VendAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PostingDate_PurchInvHeader; FORMAT("Purch. Inv. Header"."Posting Date"))
                    {
                    }
                    column(PricesIncludingVAT_PurchInvHeader; "Purch. Inv. Header"."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(VATBaseDis_PurchInvHeader; "Purch. Inv. Header"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(RegNoTxt; RegNoText)
                    {
                    }
                    column(RegNo_PurchInvHeader; "Purch. Inv. Header"."Registration No.")
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDescription; ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegistrationNoCaption; CompanyInfoVATRegistrationNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCaption; CompanyInfoBankNameCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankAccountNoCaption; CompanyInfoBankAccountNoCaptionLbl)
                    {
                    }
                    column(PurchInvHeaderDueDateCaption; PurchInvHeaderDueDateCaptionLbl)
                    {
                    }
                    column(InvoiceNoCaption; InvoiceNoCaptionLbl)
                    {
                    }
                    column(PurchInvHeaderPostingDateCaption; PurchInvHeaderPostingDateCaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(PaymentTermsDescriptionCaption; PaymentTermsDescriptionCaptionLbl)
                    {
                    }
                    column(ShipmentMethodDescriptionCaption; ShipmentMethodDescriptionCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATCaption; VATAmountLineVATCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATBaseCaption; VATAmountLineVATBaseCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATAmountCaption; VATAmountLineVATAmountCaptionLbl)
                    {
                    }
                    column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                    {
                    }
                    column(VATAmountLineInvoiceDiscountAmountCaption; VATAmountLineInvoiceDiscountAmountCaptionLbl)
                    {
                    }
                    column(VATAmountLineInvDiscBaseAmountCaption; VATAmountLineInvDiscBaseAmountCaptionLbl)
                    {
                    }
                    column(VATAmountLineLineAmountCaption; VATAmountLineLineAmountCaptionLbl)
                    {
                    }
                    column(VATAmountLineVATIdentifierCaption; VATAmountLineVATIdentifierCaptionLbl)
                    {
                    }
                    column(VATBaseCaption; VATBaseCaptionLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyInfoEMailCaption; CompanyInfoEMailCaptionLbl)
                    {
                    }
                    column(PaytoVendorNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Pay-to Vendor No."))
                    {
                    }
                    column(PricesIncludingVAT_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(VendorNoCaption; VendorNoCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimTxt; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDFIRST() THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO(
                                      '%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
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
                            UNTIL (DimSetEntry1.NEXT() = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Inv. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(LineAmt_PurchInvLine; "Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(Desc_PurchInvLine; Description)
                        {
                            IncludeCaption = false;
                        }
                        column(No_PurchInvLine; "No.")
                        {
                        }
                        column(Qty_PurchInvLine; Quantity)
                        {
                        }
                        column(uom_PurchInvLine; "Unit of Measure")
                        {
                        }
                        column(DirectUnitCost_PurchInvLine; "Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode();
                            AutoFormatType = 2;
                        }
                        column(LineDis_PurchInvLine; "Line Discount %")
                        {
                        }
                        column(AllowInvDisc_PurchInvLine; "Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(VATIdentifier_PurchInvLine; "VAT Identifier")
                        {
                        }
                        column(LineNo_PurchInvLine; "Purch. Inv. Line"."Line No.")
                        {
                        }
                        column(AllowVATDisctxt_PurchInvLine; AllowVATDisctxt)
                        {
                        }
                        column(TypeNo_PurchInvLine; PurchInLineTypeNo)
                        {
                        }
                        column(VATAmtTxt_PurchInvLine; VATAmountText)
                        {
                        }
                        column(InvDisAmt; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalTxt_PurchInvLine; TotalText)
                        {
                        }
                        column(Amt_PurchInvLine; Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATTxt_PurchInvLine; TotalInclVATText)
                        {
                        }
                        column(AmtIncludingVAT_PurchInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(AmtIncludingVATAmt; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = "Purch. Inv. Line".GetCurrencyCode();
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtTxt; VATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATTxt_PurchInvLine; TotalExclVATText)
                        {
                        }
                        column(VATPercentage_PurchInvLine; "VAT %")
                        {
                        }
                        column(DocNo_PurchInvLine; "Document No.")
                        {
                        }
                        column(TotalSubTotal_PurchInvLine; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDisAmt; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmt_PurchInvLine; TotalAmount)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtInclVAT_PurchInvLine; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmtVAT_PurchInvLine; TotalAmountVAT)
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDisOnVAT_PurchInvLine; TotalPaymentDiscountOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(DirectUnitCostCaption; DirectUnitCostCaptionLbl)
                        {
                        }
                        column(PurchInvLineLineDiscountCaption; PurchInvLineLineDiscountCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDiscountOnVATCaption; PaymentDiscountOnVATCaptionLbl)
                        {
                        }
                        column(AllowInvoiveDiscountCaption; AllowInvoiveDiscountCaptionLbl)
                        {
                        }
                        column(PurchInvLineDescriptionCaption; PurchInvLineDescriptionCaptionLbl)
                        {
                        }
                        column(No_PurchInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_PurchInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(uom_PurchInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_PurchInvLineCaption; FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(VATPercentageCaption_PurchInvLine; FIELDCAPTION("VAT %"))
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimTxt_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDFIRST() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO(
                                          '%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DimSetEntry2.NEXT() = 0);
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purch. Inv. Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "No." := '';
                            IF (Type <> Type::" ") AND (Quantity = 0) THEN
                                CurrReport.SKIP();
                            VATAmountLine.INIT();
                            VATAmountLine."VAT Identifier" := "Purch. Inv. Line"."VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."Use Tax" := "Use Tax";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine.InsertLine();

                            AllowVATDisctxt := FORMAT("Purch. Inv. Line"."Allow Invoice Disc.");
                            PurchInLineTypeNo := "Purch. Inv. Line".Type;

                            TotalSubTotal += "Line Amount";
                            TotalInvoiceDiscountAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                        end;

                        trigger OnPreDataItem()
                        var
                            PurchInvLine: Record "Purch. Inv. Line";
                            VATIdentifier: Code[10];
                        begin
                            VATAmountLine.DELETEALL();
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                            CurrReport.CREATETOTALS("Line Amount", "Inv. Discount Amount", Amount, "Amount Including VAT");

                            PurchInvLine.SETRANGE("Document No.", "Purch. Inv. Header"."No.");
                            PurchInvLine.SETFILTER(Type, '<>%1', 0);
                            VATAmountText := '';
                            IF PurchInvLine.FIND('-') THEN BEGIN
                                VATAmountText := STRSUBSTNO(Text011, PurchInvLine."VAT %");
                                VATIdentifier := PurchInvLine."VAT Identifier";
                                REPEAT
                                    IF (PurchInvLine."VAT Identifier" <> VATIdentifier) AND (PurchInvLine.Quantity <> 0) THEN
                                        VATAmountText := Text012;
                                UNTIL PurchInvLine.NEXT() = 0;
                            END;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDisAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purch. Inv. Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATId; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATAmtLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercent; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code",
                                "Purch. Inv. Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purch. Inv. Header"."Currency Code" = '')
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purch. Inv. Header"."Posting Date", "Purch. Inv. Header"."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / "Purch. Inv. Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(BuyfromVendNo_PurchInvHeader; "Purch. Inv. Header"."Buy-from Vendor No.")
                        {
                        }
                        column(BuyfromVendNo_PurchInvHeaderCaption; "Purch. Inv. Header".FIELDCAPTION("Buy-from Vendor No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF "Purch. Inv. Header"."Buy-from Vendor No." = "Purch. Inv. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
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
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ShipToAddr[1] = '' THEN
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        OutputNo := OutputNo + 1;
                        CopyText := FormatDocument.GetCOPYText();
                    END;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscountOnVAT := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        CODEUNIT.RUN(CODEUNIT::"Purch. Inv.-Printed", "Purch. Inv. Header");
                end;

                trigger OnPreDataItem()
                begin
                    OutputNo := 1;
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Purch. Inv. Header");
                FormatDocumentFields("Purch. Inv. Header");
                PricesInclVATtxt := FORMAT("Prices Including VAT");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                PrepareHeader();
                PrepareFooter();

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          14, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
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
            LogInteraction := SegManagement.FindInteractTmplCode(14) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
    end;

    var
        CompanyInfo: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry"; //480
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Language: Record Language;
        PaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        VATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;

        CalculatedExchRate: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalPaymentDiscountOnVAT: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        PurchInLineTypeNo: Integer;
        AllowInvoiveDiscountCaptionLbl: Label 'Allow Invoice Discount';
        AmountCaptionLbl: Label 'Amount';
        CompanyInfoBankAccountNoCaptionLbl: Label 'Account No.';
        CompanyInfoBankNameCaptionLbl: Label 'Bank';
        CompanyInfoEMailCaptionLbl: Label 'Email';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoHomePageCaptionLbl: Label 'Home Page';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegistrationNoCaptionLbl: Label 'VAT Registration No.';
        ContinuedCaptionLbl: Label 'Continued';
        DirectUnitCostCaptionLbl: Label 'Direct Unit Cost';
        DocumentDateCaptionLbl: Label 'Date';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        InvoiceNoCaptionLbl: Label 'Invoice No.';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        ML_InvAdr: Label 'Invoice Address';
        ML_InvoiceNo: Label 'Ext Invoice No.';
        ML_OrderAdr: Label 'Order Address';
        ML_OrderNo: Label 'Order No.';
        ML_PmtTerms: Label 'Payment Terms';
        ML_PurchPerson: Label 'Purchaser';
        ML_Reference: Label 'Reference';
        ML_ShipAdr: Label 'Shipping Address';
        ML_ShipCond: Label 'Shipping Conditions';
        ML_ShipDate: Label 'Shipping Date';
        PageCaptionLbl: Label 'Page';
        PaymentDiscountOnVATCaptionLbl: Label 'Payment Discount on VAT';
        PaymentTermsDescriptionCaptionLbl: Label 'Payment Terms';
        PurchInvHeaderDueDateCaptionLbl: Label 'Due Date';
        PurchInvHeaderPostingDateCaptionLbl: Label 'Posting Date';
        PurchInvLineDescriptionCaptionLbl: Label 'Description';
        PurchInvLineLineDiscountCaptionLbl: Label 'Discount %';
        ShipmentMethodDescriptionCaptionLbl: Label 'Shipment Method';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        SubtotalCaptionLbl: Label 'Subtotal';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        Text011: Label '%1% VAT';
        Text012: Label 'VAT Amount';
        Text11500: Label 'Invoice';
        Text11501: Label 'Prepayment Invoice';
        VATAmountLineInvDiscBaseAmountCaptionLbl: Label 'Invoice Discount Base Amount';
        VATAmountLineInvoiceDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLineLineAmountCaptionLbl: Label 'Line Amount';
        VATAmountLineVATAmountCaptionLbl: Label 'VAT Amount';
        VATAmountLineVATBaseCaptionLbl: Label 'VAT Base';
        VATAmountLineVATCaptionLbl: Label 'VAT %';
        VATAmountLineVATIdentifierCaptionLbl: Label 'VAT Identifier';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATBaseCaptionLbl: Label 'Total';
        VendorNoCaptionLbl: Label 'Vendor No.';
        RegNoText: Text[20];
        AllowVATDisctxt: Text[30];
        CopyText: Text[30];
        FooterLabel: array[20] of Text[30];
        HeaderLabel: array[20] of Text[30];
        PricesInclVATtxt: Text[30];
        PurchaserText: Text[30];
        VATAmountText: Text[30];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        OrderNoText: Text[80];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];
        FooterTxt: array[20] of Text[120];
        HeaderTxt: array[20] of Text[120];

    local procedure DocumentCaption(): Text[250]
    begin
        IF "Purch. Inv. Header"."Prepayment Invoice" THEN
            EXIT(Text11501);
        EXIT(Text11500);
    end;

    procedure PrepareHeader()
    begin
        CLEAR(HeaderLabel);
        CLEAR(HeaderTxt);

        FormatAddr.PurchInvPayTo(VendAddr, "Purch. Inv. Header");

        IF "Purch. Inv. Header"."Order No." <> '' THEN BEGIN
            HeaderLabel[1] := ML_OrderNo;
            HeaderTxt[1] := "Purch. Inv. Header"."Order No.";
        END;

        IF "Purch. Inv. Header"."Vendor Invoice No." <> '' THEN BEGIN
            HeaderLabel[2] := ML_InvoiceNo;
            HeaderTxt[2] := "Purch. Inv. Header"."Vendor Invoice No.";
        END;

        IF SalesPurchPerson.GET("Purch. Inv. Header"."Purchaser Code") THEN BEGIN
            HeaderLabel[3] := ML_PurchPerson;
            HeaderTxt[3] := SalesPurchPerson.Name;
        END;

        IF "Purch. Inv. Header"."Your Reference" <> '' THEN BEGIN
            HeaderLabel[4] := ML_Reference;
            HeaderTxt[4] := "Purch. Inv. Header"."Your Reference";
        END;

        COMPRESSARRAY(HeaderLabel);
        COMPRESSARRAY(HeaderTxt);
    end;

    procedure PrepareFooter()
    var
        PmtMethod: Record "Payment Terms";
        ShipMethod: Record "Shipment Method";
    begin
        CLEAR(FooterLabel);
        CLEAR(FooterTxt);

        IF PmtMethod.GET("Purch. Inv. Header"."Payment Terms Code") THEN BEGIN
            FooterLabel[1] := ML_PmtTerms;
            PmtMethod.TranslateDescription(PmtMethod, "Purch. Inv. Header"."Language Code");
            FooterTxt[1] := PmtMethod.Description;
        END;

        // Shipping Conditions
        IF ShipMethod.GET("Purch. Inv. Header"."Shipment Method Code") THEN BEGIN
            FooterLabel[2] := ML_ShipCond;
            ShipMethod.TranslateDescription(ShipMethod, "Purch. Inv. Header"."Language Code");
            FooterTxt[2] := ShipMethod.Description;
        END;

        // Shipping Address
        IF "Purch. Inv. Header"."Ship-to Code" <> '' THEN BEGIN
            FooterLabel[3] := ML_ShipAdr;
            FooterTxt[3] := "Purch. Inv. Header"."Ship-to Name" + ' ' + "Purch. Inv. Header"."Ship-to City";
        END;

        // Invoice and Order Address
        IF "Purch. Inv. Header"."Buy-from Vendor No." <> "Purch. Inv. Header"."Pay-to Vendor No." THEN BEGIN
            FooterLabel[4] := ML_InvAdr;
            FooterTxt[4] := "Purch. Inv. Header"."Pay-to Name" + ', ' + "Purch. Inv. Header"."Pay-to City";
            FooterLabel[5] := ML_OrderAdr;
            FooterTxt[5] := "Purch. Inv. Header"."Buy-from Vendor Name" + ', ' + "Purch. Inv. Header"."Buy-from City";
        END;

        // Shipping Date if <> Document Date
        IF NOT ("Purch. Inv. Header"."Expected Receipt Date" IN ["Purch. Inv. Header"."Document Date", 0D]) THEN BEGIN
            FooterLabel[6] := ML_ShipDate;
            FooterTxt[6] := FORMAT("Purch. Inv. Header"."Expected Receipt Date", 0, 4);
        END;

        COMPRESSARRAY(FooterLabel);
        COMPRESSARRAY(FooterTxt);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatAddressFields(var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        FormatAddr.GetCompanyAddr(PurchInvHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchInvPayTo(VendAddr, PurchInvHeader);
        FormatAddr.PurchInvShipTo(ShipToAddr, PurchInvHeader);
    end;

    local procedure FormatDocumentFields(PurchInvHeader: Record "Purch. Inv. Header")
    begin
        FormatDocument.SetTotalLabels(PurchInvHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchInvHeader."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchInvHeader."Payment Terms Code", PurchInvHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchInvHeader."Shipment Method Code", PurchInvHeader."Language Code");

        OrderNoText := FormatDocument.SetText(PurchInvHeader."Order No." <> '', PurchInvHeader.FIELDCAPTION("Order No."));
        ReferenceText := FormatDocument.SetText(PurchInvHeader."Your Reference" <> '', PurchInvHeader.FIELDCAPTION("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchInvHeader."VAT Registration No." <> '', PurchInvHeader.FIELDCAPTION("VAT Registration No."));
    end;
}

