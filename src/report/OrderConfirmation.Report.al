report 205 "Order Confirmation"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.007
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.007    12.03.20    mhh     List of changes:
    //                                              Changed trigger: RoundLoop - OnAfterGetRecord()
    //                                              Changed report layout
    // ------------------------------------------------------------------------------------------
    DefaultLayout = RDLC;
    RDLCLayout = './OrderConfirmation.rdlc';

    Caption = 'Order Confirmation';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem6640; Table36)
        {
            DataItemTableView = SORTING (Document Type, No.)
                                WHERE (Document Type=CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption; VATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(LineAmtCaption; LineAmtCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(DocExterne; "Sales Header"."External Document No.")
            {
            }
            column(DocExterne_Caption; "Sales Header".FIELDCAPTION("Sales Header"."External Document No."))
            {
            }
            column(Fax_Company; CompanyInfo."Fax No.")
            {
            }
            column(Fax_Company_Caption; CompanyInfo.FIELDCAPTION(CompanyInfo."Fax No."))
            {
            }
            column(Cost_Name; "Sales Header"."Sell-to Customer Name")
            {
            }
            column(Cost_Contact; "Sales Header"."Sell-to Contact")
            {
            }
            column(Cost_Adress; "Sales Header"."Sell-to Address")
            {
            }
            column(Cost_country; "Sales Header"."Sell-to Country/Region Code")
            {
            }
            column(Cost_Post; "Sales Header"."Sell-to Post Code" + ' ' + "Sales Header"."Sell-to City")
            {
            }
            column(Reference; "Sales Header"."Your Reference")
            {
            }
            column(Reference_Caption; Ref_Caption)
            {
            }
            column(Caption_dest; Caption_Adress)
            {
            }
            column(SelltoContac; "Sell-to Contact")
            {
            }
            column(TxtContact; TxtContact)
            {
            }
            dataitem(CopyLoop; Table2000000026)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Table2000000026)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(CopyText; CopyText)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(OrderConfirmCopyCaption; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
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
                    column(FooterLabel5; FooterLabel[5])
                    {
                    }
                    column(FooterLabel6; FooterLabel[6])
                    {
                    }
                    column(FooterLabel7; FooterLabel[7])
                    {
                    }
                    column(FooterLabel8; FooterLabel[8])
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
                    column(FooterTxt7; FooterTxt[7])
                    {
                    }
                    column(FooterTxt8; FooterTxt[8])
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
                    column(CompanyInfoPhNo; CompanyInfo."Phone No.")
                    {
                        IncludeCaption = false;
                    }
                    column(CustAddr6; CustAddr[6])
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
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT("Sales Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; "Sales Header"."VAT Registration No.")
                    {
                    }
                    column(ShptDate_SalesHeader; FORMAT("Sales Header"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(SalesOrderReference_SalesHeader; "Sales Header"."Your Reference")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PricesInclVAT_SalesHeader; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesHeader; FORMAT("Sales Header"."Prices Including VAT"))
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankCaption; BankCaptionLbl)
                    {
                    }
                    column(AccountNoCaption; AccountNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionCap)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(RegistrationNoCaption; RegistrationNoCaptionLbl)
                    {
                    }
                    column(CustomerNoCaption; CustomerNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoRegNo; CompanyInfo."Registration No.")
                    {
                    }
                    column(Location_Code; "Sales Line"."Location Code")
                    {
                    }
                    column(Location_Caption; Caption_Location)
                    {
                    }
                    column(NbrProdModif; NbrProdModif)
                    {
                    }
                    column(RequestedDeliveryDate; FORMAT("Sales Header"."Requested Delivery Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                    {
                    }
                    column(RequestedDeliveryDateCaption; "Sales Header".FIELDCAPTION("Requested Delivery Date"))
                    {
                    }
                    column(TxtEstDelDate; TxtEstDelDate)
                    {
                    }
                    dataitem(DimensionLoop1; Table2000000026)
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FIND('-') THEN
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
                    dataitem(DataItem2844; Table37)
                    {
                        DataItemLink = Document Type=FIELD(Document Type),
                                       Document No.=FIELD(No.);
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING(Document Type,Document No.,Line No.);

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLineAmt;SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesLine;SalesLine_Description)
                        {
                        }
                        column(NNCSalesLineLineAmt;NNCSalesLineLineAmt)
                        {
                        }
                        column(NNCSalesLineInvDiscAmt;NNCSalesLineInvDiscAmt)
                        {
                        }
                        column(NNCTotalLCY;NNCTotalLCY)
                        {
                        }
                        column(NNCTotalExclVAT;NNCTotalExclVAT)
                        {
                        }
                        column(NNCVATAmt;NNCVATAmt)
                        {
                        }
                        column(NNCTotalInclVAT;NNCTotalInclVAT)
                        {
                        }
                        column(NNCPmtDiscOnVAT;NNCPmtDiscOnVAT)
                        {
                        }
                        column(NNCTotalInclVAT2;NNCTotalInclVAT2)
                        {
                        }
                        column(NNCVATAmt2;NNCVATAmt2)
                        {
                        }
                        column(NNCTotalExclVAT2;NNCTotalExclVAT2)
                        {
                        }
                        column(VATBaseDisc_SalesHeader;"Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(DisplayAssemblyInfo;DisplayAssemblyInformation)
                        {
                        }
                        column(ShowInternalInfo;ShowInternalInfo)
                        {
                        }
                        column(No2_SalesLine;"Sales Line"."No.")
                        {
                        }
                        column(Qty_SalesLine;"Sales Line".Quantity)
                        {
                        }
                        column(UOM_SalesLine;"Sales Line"."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesLine;"Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                            IncludeCaption = false;
                        }
                        column(LineDisc_SalesLine;"Sales Line"."Line Discount %")
                        {
                        }
                        column(LineAmt_SalesLine;"Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine;"Sales Line"."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_SalesLine;"Sales Line"."VAT Identifier")
                        {
                        }
                        column(SubtotalNet_SalesLine;"Sales Line"."Subtotal Net")
                        {
                        }
                        column(Type_SalesLine;FORMAT("Sales Line".Type))
                        {
                        }
                        column(No_SalesLine;"Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvDiscountYesNo_SalesLine;FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(AsmInfoExistsForLine;AsmInfoExistsForLine)
                        {
                        }
                        column(SalesLineInvDiscAmt;SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText;TotalText)
                        {
                        }
                        column(SalsLinAmtExclLineDiscAmt;SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText;TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText3;VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText;TotalInclVATText)
                        {
                        }
                        column(VATAmount;VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclLineDisc;SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount;VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount;VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT;TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DiscountPercentCaption;DiscountPercentCaptionLbl)
                        {
                        }
                        column(SubtotalCaption;SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDiscountVATCaption;PaymentDiscountVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesLineCaption;"Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(No2_SalesLineCaption;"Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesLineCaption;"Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesLineCaption;"Sales Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesLineCaption;"Sales Line".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(VAT_SalesLine;"Sales Line"."VAT %")
                        {
                        }
                        column(VAT_SalesLineCaption;"Sales Line".FIELDCAPTION("VAT %"))
                        {
                        }
                        column(NewPageGroupNo;NewPageGroupNo)
                        {
                        }
                        column(NewPageLine;NewPageLine)
                        {
                        }
                        column(RefExterne;ItemCrossReferenceField)
                        {
                        }
                        column(Caption_RefExterne;Caption_Ref_Externe)
                        {
                        }
                        column(QteChanged;QteChanged)
                        {
                        }
                        column(QteChangedText;QteChangedText)
                        {
                        }
                        column(Requestedqtity;"Sales Line"."Requested qtity")
                        {
                        }
                        column(TxtQteConf;TxtQteConf)
                        {
                        }
                        column(TxtQteDem;TxtQteDem)
                        {
                        }
                        column(EstimatedDeliveryDate;FORMAT("Sales Line"."Estimated Delivery Date",0,'<Day,2>.<Month,2>.<Year4>'))
                        {
                        }
                        column(RelatePOCpt;RelatePOCpt)
                        {
                        }
                        column(SpecialOrderNo_SalesLine;"Sales Line"."Special Order Purchase No.")
                        {
                        }
                        dataitem(DimensionLoop2;Table2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));
                            column(DimText2;DimText)
                            {
                            }
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

                                DimSetEntry2.SETRANGE("Dimension Set ID","Sales Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop;Table2000000026)
                        {
                            DataItemTableView = SORTING(Number);
                            column(AsmLineType;AsmLine.Type)
                            {
                            }
                            column(AsmLineNo;BlanksForIndent + AsmLine."No.")
                            {
                            }
                            column(AsmLineDescription;BlanksForIndent + AsmLine.Description)
                            {
                            }
                            column(AsmLineQuantity;AsmLine.Quantity)
                            {
                            }
                            column(AsmLineUOMText;GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                  AsmLine.FINDSET
                                ELSE
                                  AsmLine.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                  CurrReport.BREAK;
                                IF NOT AsmInfoExistsForLine THEN
                                  CurrReport.BREAK;
                                AsmLine.SETRANGE("Document Type",AsmHeader."Document Type");
                                AsmLine.SETRANGE("Document No.",AsmHeader."No.");
                                SETRANGE(Number,1,AsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                              SalesLine.FIND('-')
                            ELSE
                              SalesLine.NEXT;
                            "Sales Line" := SalesLine;
                            IF DisplayAssemblyInformation THEN
                              AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);

                            IF NOT "Sales Header"."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                              SalesLine."Line Amount" := 0;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "Sales Line"."No." := '';

                            NNCSalesLineLineAmt += SalesLine."Line Amount";
                            NNCSalesLineInvDiscAmt += SalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount;
                            NNCTotalExclVAT2 := VATBaseAmount;

                            Sales_Nu_Type := SalesLine.Type;
                            Sales_Nu_Type_Title := SalesLine.Type::Title;

                            NewPageLine := "Sales Line".Type = "Sales Line".Type::"New Page";
                            IF NewPageLine THEN BEGIN
                              CurrPageFooterHiddenFlg := 1;
                              NewPageGroupNo += 1;
                            END ELSE
                              CurrPageFooterHiddenFlg := 0;
                            // NTO -
                            ItemCrossReferenceField :='';
                            ItemCrossReference.SETRANGE(ItemCrossReference."Item No.","Sales Line"."No.");
                            ItemCrossReference.SETRANGE(ItemCrossReference."Cross-Reference Type No.",SalesLine."Sell-to Customer No.");
                            IF ItemCrossReference.FINDFIRST THEN
                            ItemCrossReferenceField:=ItemCrossReference."Cross-Reference No.";
                            // NTO +
                            //DEL.SAZ 17.05.19

                            IF ("Sales Line"."Requested qtity" <> 0)  AND ("Sales Line".Quantity <> "Sales Line"."Requested qtity") THEN BEGIN

                               QteChanged:='*';
                               //NbrProdModif:= NbrProdModif+1;
                            END
                            ELSE
                              QteChanged:='';

                            //END DEL.SAZ

                            //MGTS10.00.007; 001; mhh; single
                            SalesLine_Description := COPYSTR("Sales Line".Description, 1, 20);
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                              MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                              CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.",0,SalesLine."Line No.");
                            SETRANGE(Number,1,SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount",SalesLine."Inv. Discount Amount");

                            NewPageLine := FALSE;
                        end;
                    }
                    dataitem(VATCounter;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase;VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt;VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt;VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt;VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt;VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier;VATAmountLine."VAT Identifier")
                        {
                        }
                        column(InvDiscBaseAmtCaption;InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption;VATIdentifierCaptionLbl)
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
                        column(VALVATBaseLCY;VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY;VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage2;VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(VATAmtLineVATIdentifier2;VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Header"."Posting Date","Sales Header"."Currency Code","Sales Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Header"."Posting Date","Sales Header"."Currency Code","Sales Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                              CurrReport.BREAK;

                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text007 + Text008
                            ELSE
                              VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Posting Date","Sales Header"."Currency Code",1);
                            VALExchRate := STRSUBSTNO(Text009,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=CONST(1));
                        column(SelltoCustNo_SalesHeader;"Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr8;ShipToAddr[8])
                        {
                        }
                        column(ShipToAddr7;ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr6;ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr5;ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr4;ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr3;ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr2;ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr1;ShipToAddr[1])
                        {
                        }
                        column(ShiptoAddrCaption;ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption;"Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                              CurrReport.BREAK;
                        end;
                    }
                    dataitem(PrepmtLoop;Table2000000026)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number=FILTER(1..));
                        column(PrepmtLineAmount;PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDesc;PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccNo;PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText2;TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtTxt;PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText2;TotalInclVATText)
                        {
                        }
                        column(PrepmtInvAmount;PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmount;PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvAmtInclVATAmt;PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText2;VATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtTotalAmountInclVAT;PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount;PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtLoopNumber;Number)
                        {
                        }
                        column(DescriptionCaption;DescriptionCaptionLbl)
                        {
                        }
                        column(GLAccountNoCaption;GLAccountNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption;PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop;Table2000000026)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number=FILTER(1..));
                            column(DimText3;DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                  IF NOT TempPrepmtDimSetEntry.FIND('-') THEN
                                    CurrReport.BREAK;
                                END ELSE
                                  IF NOT Continue THEN
                                    CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                  OldDimText := DimText;
                                  IF DimText = '' THEN
                                    DimText :=
                                      STRSUBSTNO('%1 %2',TempPrepmtDimSetEntry."Dimension Code",TempPrepmtDimSetEntry."Dimension Value Code")
                                  ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3',DimText,
                                        TempPrepmtDimSetEntry."Dimension Code",TempPrepmtDimSetEntry."Dimension Value Code");
                                  IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                  END;
                                UNTIL TempPrepmtDimSetEntry.NEXT = 0;
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
                              DimMgt.GetDimensionSet(TempPrepmtDimSetEntry,PrepmtInvBuf."Dimension Set ID");

                            IF "Sales Header"."Prices Including VAT" THEN
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
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase;PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt;PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATPerc;PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0:5;
                        }
                        column(PrepmtVATAmtLineVATIdent;PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATCounterNumber;Number)
                        {
                        }
                        column(PrepaymentVATAmtSpecCap;PrepaymentVATAmtSpecCapLbl)
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
                        column(PrepmtPmtTermsDesc;PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepmtPmtTermsDescCaption;PrepmtPmtTermsDescCaptionLbl)
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
                    PrepmtSalesLine: Record "37" temporary;
                    TempSalesLine: Record "37" temporary;
                    SalesPost: Codeunit "80";
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesLine.DELETEALL;
                    SalesPost.GetSalesLines("Sales Header",SalesLine,0);
                    SalesLine.CalcVATAmountLines(0,"Sales Header",SalesLine,VATAmountLine);
                    SalesLine.UpdateVATOnLines(0,"Sales Header",SalesLine,VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code","Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DELETEALL;
                    SalesPostPrepmt.GetSalesLines("Sales Header",0,PrepmtSalesLine);

                    IF NOT PrepmtSalesLine.ISEMPTY THEN BEGIN
                      SalesPostPrepmt.GetSalesLinesToDeduct("Sales Header",TempSalesLine);
                      IF NOT TempSalesLine.ISEMPTY THEN
                        SalesPostPrepmt.CalcVATAmountLines("Sales Header",TempSalesLine,PrepmtVATAmountLineDeduct,1);
                    END;
                    SalesPostPrepmt.CalcVATAmountLines("Sales Header",PrepmtSalesLine,PrepmtVATAmountLine,0);
                    PrepmtVATAmountLine.DeductVATAmountLine(PrepmtVATAmountLineDeduct);
                    SalesPostPrepmt.UpdateVATOnLines("Sales Header",PrepmtSalesLine,PrepmtVATAmountLine,0);
                    SalesPostPrepmt.BuildInvLineBuffer2("Sales Header",PrepmtSalesLine,0,PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN BEGIN
                      CopyText := FormatDocument.GetCOPYText;
                      OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    NNCTotalLCY := 0;
                    NNCTotalExclVAT := 0;
                    NNCVATAmt := 0;
                    NNCTotalInclVAT := 0;
                    NNCPmtDiscOnVAT := 0;
                    NNCTotalInclVAT2 := 0;
                    NNCVATAmt2 := 0;
                    NNCTotalExclVAT2 := 0;
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF Print THEN
                      CODEUNIT.RUN(CODEUNIT::"Sales-Printed","Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number,1,NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Sales Header");
                FormatDocumentFields("Sales Header");

                PrepareHeader;
                PrepareFooter;

                DimSetEntry1.SETRANGE("Dimension Set ID","Dimension Set ID");

                IF Print THEN BEGIN
                  IF CurrReport.USEREQUESTPAGE AND ArchiveDocument OR
                     NOT CurrReport.USEREQUESTPAGE AND SalesSetup."Arch. Orders and Ret. Orders"
                  THEN
                    ArchiveManagement.StoreSalesDocument("Sales Header",LogInteraction);

                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    IF "Bill-to Contact No." <> '' THEN
                      SegManagement.LogDocument(
                        SegManagement.SalesOrderConfirmInterDocType,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Contact,"Bill-to Contact No."
                        ,"Salesperson Code","Campaign No.","Posting Description","Opportunity No.")
                    ELSE
                      SegManagement.LogDocument(
                        SegManagement.SalesOrderConfirmInterDocType,"No.","Doc. No. Occurrence",
                        "No. of Archived Versions",DATABASE::Customer,"Bill-to Customer No.",
                        "Salesperson Code","Campaign No.","Posting Description","Opportunity No.");
                  END;
                END;
                IF "Sales Header"."Your Reference"<>'' THEN
                Ref_Caption:="Sales Header".FIELDCAPTION("Sales Header"."Your Reference")
                ELSE
                Ref_Caption:='';
                NbrProdModif:=0;//DEL.SAZ 17.05.19
                //DEL.SAZ 17.05.19
                SalesLine_Rec.SETRANGE(SalesLine_Rec."Document Type","Document Type");
                SalesLine_Rec.SETRANGE(SalesLine_Rec."Document No.","No.");
                IF SalesLine_Rec.FINDSET THEN BEGIN
                  REPEAT
                  IF (SalesLine_Rec."Requested qtity" <> 0)  AND (SalesLine_Rec.Quantity <> SalesLine_Rec."Requested qtity") THEN

                     NbrProdModif:= NbrProdModif+1;

                UNTIL SalesLine_Rec.NEXT=0;
                END;
                //END DEL.SAZ
            end;

            trigger OnPreDataItem()
            begin
                Print := Print OR NOT CurrReport.PREVIEW;

                CurrPageFooterHiddenFlg := 0;
                CurrPageHeaderHiddenFlg := 0;
                CurrGroupPageNO := 0;
                InnerGroupPageNO := 1;
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
                    field(NoOfCopies;NoOfCopies)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo;ShowInternalInfo)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if the document shows internal information.';
                    }
                    field(ArchiveDocument;ArchiveDocument)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you print it.';

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                              LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction;LogInteraction)
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                              ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents;DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
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
            ArchiveDocument := SalesSetup."Arch. Orders and Ret. Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

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
        SalesSetup.GET;
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents",CompanyInfo1,CompanyInfo2,CompanyInfo3);

        NewPageGroupNo := 0;
    end;

    var
        Text004: Label 'Order Confirmation %1', Comment='%1 = Document No.';
        Text005: Label 'Page %1';
        GLSetup: Record "98";
        ShipmentMethod: Record "10";
        PaymentTerms: Record "3";
        PrepmtPaymentTerms: Record "3";
        SalesPurchPerson: Record "13";
        CompanyInfo: Record "79";
        CompanyInfo1: Record "79";
        CompanyInfo2: Record "79";
        CompanyInfo3: Record "79";
        SalesSetup: Record "311";
        VATAmountLine: Record "290" temporary;
        PrepmtVATAmountLine: Record "290" temporary;
        PrepmtVATAmountLineDeduct: Record "290" temporary;
        SalesLine: Record "37" temporary;
        DimSetEntry1: Record "480";
        DimSetEntry2: Record "480";
        TempPrepmtDimSetEntry: Record "480" temporary;
        PrepmtInvBuf: Record "461" temporary;
        RespCenter: Record "5714";
        Language: Record "8";
        CurrExchRate: Record "330";
        AsmHeader: Record "900";
        AsmLine: Record "901";
        FormatAddr: Codeunit "365";
        SegManagement: Codeunit "5051";
        ArchiveManagement: Codeunit "5063";
        FormatDocument: Codeunit "368";
        SalesPostPrepmt: Codeunit "442";
        DimMgt: Codeunit "408";
        CustAddr: array [8] of Text[50];
        ShipToAddr: array [8] of Text[50];
        CompanyAddr: array [8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
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
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        OutputNo: Integer;
        NNCTotalLCY: Decimal;
        NNCTotalExclVAT: Decimal;
        NNCVATAmt: Decimal;
        NNCTotalInclVAT: Decimal;
        NNCPmtDiscOnVAT: Decimal;
        NNCTotalInclVAT2: Decimal;
        NNCVATAmt2: Decimal;
        NNCTotalExclVAT2: Decimal;
        NNCSalesLineLineAmt: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        Print: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankCaptionLbl: Label 'Bank';
        AccountNoCaptionLbl: Label 'Account No.';
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        OrderNoCaptionLbl: Label 'Order No.';
        HomePageCaptionCap: Label 'Home Page';
        EmailCaptionLbl: Label 'Email';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        DiscountPercentCaptionLbl: Label 'Discount %';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        DescriptionCaptionLbl: Label 'Description';
        GLAccountNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepaymentVATAmtSpecCapLbl: Label 'Prepayment VAT Amount Specification';
        PrepmtPmtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        PhoneNoCaptionLbl: Label 'Phone No.';
        AmountCaptionLbl: Label 'Amount';
        VATPercentageCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        LineAmtCaptionLbl: Label 'Line Amount';
        TotalCaptionLbl: Label 'Total';
        UnitPriceCaptionLbl: Label 'Unit Price';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        DocumentDateCaptionLbl: Label 'Document Date';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount';
        FooterLabel: array [20] of Text[30];
        FooterTxt: array [20] of Text[120];
        HeaderLabel: array [20] of Text[30];
        HeaderTxt: array [20] of Text[120];
        CustPostGrp: Record "92";
        ML_SalesPerson: Label 'Salesperson';
        ML_Reference: Label 'Reference';
        ML_ApplyToDoc: Label 'Refers to Document';
        ML_ShipCond: Label 'Shipping Conditions';
        ML_ShipAdr: Label 'Shipping Address';
        ML_InvAdr: Label 'Invoice Address';
        ML_PmtTerms: Label 'Payment Terms';
        ML_OrderAdr: Label 'Order Address';
        ML_ShipDate: Label 'Shipping Date';
        ML_Bank: Label 'Bank Information';
        ML_AccNo: Label 'Account';
        Sales_Nu_Type: Integer;
        Sales_Nu_Type_Title: Integer;
        CurrGroupPageNO: Integer;
        InnerGroupPageNO: Integer;
        CurrPageHeaderHiddenFlg: Integer;
        CurrPageFooterHiddenFlg: Integer;
        RegistrationNoCaptionLbl: Label 'Reg.No.';
        CustomerNoCaptionLbl: Label 'Customer No.';
        ML_Continued: Label 'Continued';
        NewPageGroupNo: Integer;
        NewPageLine: Boolean;
        Caption_DocExterne: Label 'External ref.';
        Caption_Adress: Label 'Invoice adress';
        Caption_Ref_Externe: Label 'your ref.';
        Caption_Location: Label 'Location';
        ItemCrossReference: Record "5717";
        ItemCrossReferenceField: Code[20];
        Ref_Caption: Text;
        QteChanged: Text;
        QteChangedText: Label 'item quantity have changed ';
        NbrProdModif: Integer;
        SalesLine_Rec: Record "37";
        TxtQteDem: Label 'Initial Qty (PCE)';
        TxtQteConf: Label 'Confirmed Qty (PCE)';
        TxtContact: Label 'Contact';
        TxtEstDelDate: Label 'Estimated Delivery';
        SalesLine_Description: Text;
        RelatePOCpt: Label 'Related PO';

    [Scope('Internal')]
    procedure InitializeRequest(NoOfCopiesFrom: Integer;ShowInternalInfoFrom: Boolean;ArchiveDocumentFrom: Boolean;LogInteractionFrom: Boolean;PrintFrom: Boolean;DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatAddressFields(var SalesHeader: Record "36")
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center",RespCenter,CompanyInfo,CompanyAddr);
        FormatAddr.SalesHeaderBillTo(CustAddr,SalesHeader);
        ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr,CustAddr,SalesHeader);
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "36")
    begin
        WITH SalesHeader DO BEGIN
          FormatDocument.SetTotalLabels("Currency Code",TotalText,TotalInclVATText,TotalExclVATText);
          FormatDocument.SetSalesPerson(SalesPurchPerson,"Salesperson Code",SalesPersonText);
          FormatDocument.SetPaymentTerms(PaymentTerms,"Payment Terms Code","Language Code");
          FormatDocument.SetPaymentTerms(PrepmtPaymentTerms,"Prepmt. Payment Terms Code","Language Code");
          FormatDocument.SetShipmentMethod(ShipmentMethod,"Shipment Method Code","Language Code");

          ReferenceText := FormatDocument.SetText("Your Reference" <> '',FIELDCAPTION("Your Reference"));
          VATNoText := FormatDocument.SetText("VAT Registration No." <> '',FIELDCAPTION("VAT Registration No."));
        END;
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "204";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
          EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    [Scope('Internal')]
    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('',2,' '));
    end;

    [Scope('Internal')]
    procedure PrepareHeader()
    begin
        CLEAR(HeaderLabel);
        CLEAR(HeaderTxt);

        WITH "Sales Header" DO BEGIN
          FormatAddr.SalesHeaderSellTo(CustAddr,"Sales Header");

          IF SalesPurchPerson.GET("Salesperson Code") THEN BEGIN
            HeaderLabel[2] := ML_SalesPerson;
            HeaderTxt[2] := SalesPurchPerson.Name;
          END;

          IF "Your Reference" <> '' THEN BEGIN
            HeaderLabel[3] := ML_Reference;
            HeaderTxt[3] := "Your Reference";
          END;

          COMPRESSARRAY(HeaderLabel);
          COMPRESSARRAY(HeaderTxt);

          // To filter rounding line
          CustPostGrp.GET("Customer Posting Group");
        END;
    end;

    [Scope('Internal')]
    procedure PrepareFooter()
    begin
        CLEAR(FooterLabel);
        CLEAR(FooterTxt);

        WITH "Sales Header" DO BEGIN
          IF PaymentTerms.GET("Payment Terms Code") THEN BEGIN
            FooterLabel[1] := ML_PmtTerms;
            PaymentTerms.TranslateDescription(PaymentTerms,"Language Code");
            FooterTxt[1] := PaymentTerms.Description;
          END;

          // Application no for credit memos
          IF "Applies-to Doc. No." <> '' THEN BEGIN
            FooterLabel[2] := ML_ApplyToDoc;
            FooterTxt[2] := FORMAT("Applies-to Doc. Type") + ' ' + "Applies-to Doc. No.";
          END;

          // Shipping Conditions
          IF ShipmentMethod.GET("Shipment Method Code") THEN BEGIN
            FooterLabel[3] := ML_ShipCond;
            ShipmentMethod.TranslateDescription(ShipmentMethod,"Language Code");
            FooterTxt[3] := ShipmentMethod.Description;
          END;

          // Shipping Address
          IF "Ship-to Code" <> '' THEN BEGIN
            FooterLabel[4] := ML_ShipAdr;
            FooterTxt[4] := "Ship-to Name" + ' ' + "Ship-to City";
          END;

          // Invoice and Order Address
          IF "Sell-to Customer No." <> "Bill-to Customer No." THEN BEGIN
            FooterLabel[5] := ML_InvAdr;
            FooterTxt[5] := "Bill-to Name" + ', ' + "Bill-to City";
            FooterLabel[6] := ML_OrderAdr;
            FooterTxt[6] := "Sell-to Customer Name" + ', ' + "Sell-to City";
          END;

          // Shipping Date if <> Document Date
          IF ("Shipment Date" <> "Document Date") AND ("Shipment Date" <> 0D) THEN BEGIN
            FooterLabel[7] := ML_ShipDate;
            FooterTxt[7] := FORMAT("Shipment Date",0,4);
          END;

          CurrGroupPageNO += 1;
          InnerGroupPageNO :=1;
          CurrPageHeaderHiddenFlg := 0;
          CurrPageFooterHiddenFlg := 0;
          CompanyInfo.TESTFIELD("Bank Name");
          FooterLabel[8] := ML_Bank;
          FooterTxt[8] := CompanyInfo."Bank Name" + ', ' + ML_AccNo + ' ' + CompanyInfo."Bank Account No.";

          COMPRESSARRAY(FooterLabel);
          COMPRESSARRAY(FooterTxt);
        END;
    end;
}

