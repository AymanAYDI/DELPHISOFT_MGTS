//TODO //Report 

// report 206 "Sales - Invoice"
// {
//     // 
//     // ------------------------------------------------------------------------------------------
//     // Sign    : Maria Hr. Hristova = mhh
//     // Version : MGTS10.00.005,MGTS10.026,MGTS10.029
//     // 
//     // ------------------------------------------------------------------------------------------
//     // No.    Version          Date        Sign    Description
//     // ------------------------------------------------------------------------------------------
//     // 001    MGTS10.00.005    04.02.20    mhh     List of changes:
//     //                                              Changed trigger: Sales Invoice Header - OnAfterGetRecord()
//     // 
//     // 002     MGTS10.026       17.02.21    mhh     List of changes:
//     //                                              Changed report layout
//     // 
//     // 003     MGTS10.029       25.06.21    mhh     List of changes:
//     //                                              Changed trigger: Sales Invoice Header - OnAfterGetRecord()
//     // 
//     // 004     MGTS10.030       21.07.21 : Add C\AL, add fields in report layout
//     // 
//     // 004     MGTS10.032       30.07.21  : Add fields in report layout : "Amount Including VAT, %VAT
//     // 
//     // 005     MGTS10.033       12.11.2021 : Add C\AL
//     // 
//     // 006     MGTS10.036       22.03.22 : Add padding on column HS Code in report layout.
//     // ------------------------------------------------------------------------------------------
//     DefaultLayout = RDLC;
//     RDLCLayout = './SalesInvoice.rdlc';

//     Caption = 'Sales - Invoice';
//     EnableHyperlinks = true;
//     Permissions = TableData "Sales Shipment Buffer" = rimd;
//     PreviewMode = PrintLayout;

//     dataset
//     {
//         dataitem(DataItem5581; Table112)
//         {
//             DataItemTableView = SORTING(No.);
//             RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
//             RequestFilterHeading = 'Posted Sales Invoice';
//             column(MentionUnderTotal_SalesInvoiceHeader; "Sales Invoice Header"."Mention Under Total")
//             {
//             }
//             column(AmountMentionUnderTotal_SalesInvoiceHeader; "Sales Invoice Header"."Amount Mention Under Total")
//             {
//             }
//             column(No_SalesInvHdr; "No.")
//             {
//             }
//             column(EMailCaption; EMailCaptionLbl)
//             {
//             }
//             column(InvDiscountAmountCaption; InvDiscountAmountCaptionLbl)
//             {
//             }
//             column(VATCaption; VATCaptionLbl)
//             {
//             }
//             column(VATBaseCaption; VATBaseCaptionLbl)
//             {
//             }
//             column(VATAmountCaption; VATAmountCaptionLbl)
//             {
//             }
//             column(VATIdentifierCaption; VATIdentifierCaptionLbl)
//             {
//             }
//             column(TotalCaption; TotalCaptionLbl)
//             {
//             }
//             column(PaymentTermsCaption; PaymentTermsCaptionLbl)
//             {
//             }
//             column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
//             {
//             }
//             column(DocumentDateCaption; DocumentDateCaptionLbl)
//             {
//             }
//             column(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
//             {
//             }
//             column("TextRéf"; Caption_ref)
//             {
//             }
//             column(HeaderRefExterne; "Sales Invoice Header"."Your Reference")
//             {
//             }
//             column(FactNum; Text11500)
//             {
//             }
//             column(BankName; CompanyInfo."Bank Name")
//             {
//             }
//             column(BankCompte; 'Compte no :  ' + CompanyInfo."Bank Account No.")
//             {
//             }
//             column(BankIban; 'Iban: ' + CompanyInfo.IBAN)
//             {
//             }
//             column(BankSwift; 'Swift: ' + CompanyInfo."SWIFT Code")
//             {
//             }
//             column(BankPenalite; CompanyInfo."Info pénalités")
//             {
//             }
//             column(Fisc1; CompanyInfo."Info fiscales 1")
//             {
//             }
//             column(Fisc2; CompanyInfo."Info fiscales 2")
//             {
//             }
//             column(HSCode_TXT; HSCode_TXT)
//             {
//             }
//             column(CompanyIBANEuro; STRSUBSTNO(IBANCpt, CompanyInfo.IBAN))
//             {
//             }
//             column(CompanyIBANUSD; STRSUBSTNO(IBANUSDCpt, CompanyInfo."IBAN USD"))
//             {
//             }
//             column(SalesShipmenNoCptLbl; FIELDCAPTION("Sales Invoice Header"."Shipment No."))
//             {
//             }
//             column(ShowVAT; ShowVAT)
//             {
//             }
//             dataitem(CopyLoop; Table2000000026)
//             {
//                 DataItemTableView = SORTING(Number);
//                 dataitem(PageLoop; Table2000000026)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         WHERE(Number = CONST(1));
//                     column(TextGNoIdIntracom; TextGNoIdIntracom)
//                     {
//                     }
//                     column(CompanyInfo2Picture; CompanyInfo2.Picture)
//                     {
//                     }
//                     column(CompanyInfo1Picture; CompanyInfo1.Picture)
//                     {
//                     }
//                     column(CompanyInfo3Picture; CompanyInfo3.Picture)
//                     {
//                     }
//                     column(DocumentCaption; DocumentCaption())
//                     {
//                     }
//                     column(CopyText; CopyText)
//                     {
//                     }
//                     column(CustAddr1; CustAddr[1])
//                     {
//                     }
//                     column(CompanyAddr1; CompanyAddr[1])
//                     {
//                     }
//                     column(CustAddr2; CustAddr[2])
//                     {
//                     }
//                     column(CompanyAddr2; CompanyAddr[2])
//                     {
//                     }
//                     column(CustAddr3; CustAddr[3])
//                     {
//                     }
//                     column(CompanyAddr3; CompanyAddr[3])
//                     {
//                     }
//                     column(CustAddr4; CustAddr[4])
//                     {
//                     }
//                     column(CompanyAddr4; CompanyAddr[4])
//                     {
//                     }
//                     column(CustAddr5; CustAddr[5])
//                     {
//                     }
//                     column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
//                     {
//                     }
//                     column(CustAddr6; CustAddr[6])
//                     {
//                     }
//                     column(ShipToAddr1; ShipToAddr[1])
//                     {
//                     }
//                     column(ShipToAddr2; ShipToAddr[2])
//                     {
//                     }
//                     column(ShipToAddr3; ShipToAddr[3])
//                     {
//                     }
//                     column(ShipToAddr4; ShipToAddr[4])
//                     {
//                     }
//                     column(ShipToAddr5; ShipToAddr[5])
//                     {
//                     }
//                     column(ShipToAddr6; ShipToAddr[6])
//                     {
//                     }
//                     column(NTO_RepFiscal; NTO_ReprésentantFiscal)
//                     {
//                     }
//                     column(NTO_Expediteur; NTO_expéditeur)
//                     {
//                     }
//                     column(NTO_Destinataire; NTO_Destinataire)
//                     {
//                     }
//                     column(NTO_TxtDest; NTO_TxtLieuDest)
//                     {
//                     }
//                     column(DomiciliationTXT; DomiciliationTXT)
//                     {
//                     }
//                     column(NTO_FiscCtct1; NTO_FiscCtct[1])
//                     {
//                     }
//                     column(NTO_FiscCtct2; NTO_FiscCtct[2])
//                     {
//                     }
//                     column(NTO_FiscCtct3; NTO_FiscCtct[3])
//                     {
//                     }
//                     column(NTO_FiscCtct4; NTO_FiscCtct[4])
//                     {
//                     }
//                     column(NTO_FiscCtct5; NTO_FiscCtct[5])
//                     {
//                     }
//                     column(NTO_FiscCtct6; NTO_FiscCtct[6])
//                     {
//                     }
//                     column(NTO_FiscCtct7; NTO_FiscCtct[7])
//                     {
//                     }
//                     column(AdresseSecondaire1; AdresseSecondaire[1])
//                     {
//                     }
//                     column(AdresseSecondaire2; AdresseSecondaire[2])
//                     {
//                     }
//                     column(AdresseSecondaire3; AdresseSecondaire[3])
//                     {
//                     }
//                     column(AdresseSecondaire4; AdresseSecondaire[4])
//                     {
//                     }
//                     column(AdresseSecondaire5; AdresseSecondaire[5])
//                     {
//                     }
//                     column(CompanyInfoHomePage; CompanyInfo."Home Page")
//                     {
//                     }
//                     column(CompanyInfoEMail; CompanyInfo."E-Mail")
//                     {
//                     }
//                     column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
//                     {
//                     }
//                     column(PaymentTermsDescription; PaymentTerms.Description)
//                     {
//                     }
//                     column(ShipmentMethodDescription; ShipmentMethod.Description)
//                     {
//                     }
//                     column(BillToCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
//                     {
//                     }
//                     column(PostingDate_SalesInvHdr; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Day,2>.<Month,2>.<Year4>'))
//                     {
//                     }
//                     column(VATNoText; VATNoText)
//                     {
//                     }
//                     column(VATRegNo_SalesInvHeader; "Sales Invoice Header"."VAT Registration No.")
//                     {
//                     }
//                     column(DueDate_SalesInvHeader; FORMAT("Sales Invoice Header"."Due Date", 0, '<Day,2>.<Month,2>.<Year4>'))
//                     {
//                     }
//                     column(SalesPersonText; SalesPersonText)
//                     {
//                     }
//                     column(SalesPurchPersonName; SalesPurchPerson.Name)
//                     {
//                     }
//                     column(ReferenceText; ReferenceText)
//                     {
//                     }
//                     column(YourReference_SalesInvHdr; "Sales Invoice Header"."Your Reference")
//                     {
//                     }
//                     column(OrderNoText; OrderNoText)
//                     {
//                     }
//                     column(OrderNo_SalesInvHeader; "Sales Invoice Header"."Order No.")
//                     {
//                     }
//                     column(CustAddr7; CustAddr[7])
//                     {
//                     }
//                     column(CustAddr8; CustAddr[8])
//                     {
//                     }
//                     column(CompanyAddr5; CompanyAddr[5])
//                     {
//                     }
//                     column(CompanyAddr6; CompanyAddr[6])
//                     {
//                     }
//                     column(DocDate_SalesInvoiceHdr; FORMAT("Sales Invoice Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     column(PricesInclVATYesNo; FORMAT("Sales Invoice Header"."Prices Including VAT"))
//                     {
//                     }
//                     column(PageCaption; STRSUBSTNO(Text005, ''))
//                     {
//                     }
//                     column(CompanyInfoRegNo; CompanyInfo.GetRegistrationNumber)
//                     {
//                     }
//                     column(PhoneNoCaption; PhoneNoCaptionLbl)
//                     {
//                     }
//                     column(HomePageCaption; HomePageCaptionLbl)
//                     {
//                     }
//                     column(VATRegNoCaption; VATRegNoCaptionLbl)
//                     {
//                     }
//                     column(GiroNoCaption; GiroNoCaptionLbl)
//                     {
//                     }
//                     column(BankNameCaption; BankNameCaptionLbl)
//                     {
//                     }
//                     column(BankAccountNoCaption; BankAccountNoCaptionLbl)
//                     {
//                     }
//                     column(DueDateCaption; DueDateCaptionLbl)
//                     {
//                     }
//                     column(InvoiceNoCaption; InvoiceNoCaptionLbl)
//                     {
//                     }
//                     column(PostingDateCaption; PostingDateCaptionLbl)
//                     {
//                     }
//                     column(RegNoCaption; CompanyInfo.GetRegistrationNumberLbl)
//                     {
//                     }
//                     column(PricesInclVAT_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Prices Including VAT"))
//                     {
//                     }
//                     column(FooterLabel1; FooterLabel[1])
//                     {
//                     }
//                     column(FooterLabel2; FooterLabel[2])
//                     {
//                     }
//                     column(FooterLabel3; FooterLabel[3])
//                     {
//                     }
//                     column(FooterLabel4; FooterLabel[4])
//                     {
//                     }
//                     column(FooterLabel5; FooterLabel[5])
//                     {
//                     }
//                     column(FooterLabel6; FooterLabel[6])
//                     {
//                     }
//                     column(FooterLabel7; FooterLabel[7])
//                     {
//                     }
//                     column(FooterLabel8; FooterLabel[8])
//                     {
//                     }
//                     column(FooterTxt1; FooterTxt[1])
//                     {
//                     }
//                     column(FooterTxt2; FooterTxt[2])
//                     {
//                     }
//                     column(FooterTxt3; FooterTxt[3])
//                     {
//                     }
//                     column(FooterTxt4; FooterTxt[4])
//                     {
//                     }
//                     column(FooterTxt5; FooterTxt[5])
//                     {
//                     }
//                     column(FooterTxt6; FooterTxt[6])
//                     {
//                     }
//                     column(FooterTxt7; FooterTxt[7])
//                     {
//                     }
//                     column(FooterTxt8; FooterTxt[8])
//                     {
//                     }
//                     column(HeaderLabel1; HeaderLabel[1])
//                     {
//                     }
//                     column(HeaderLabel2; HeaderLabel[2])
//                     {
//                     }
//                     column(HeaderLabel3; HeaderLabel[3])
//                     {
//                     }
//                     column(HeaderLabel4; HeaderLabel[4])
//                     {
//                     }
//                     column(HeaderTxt1; HeaderTxt[1])
//                     {
//                     }
//                     column(HeaderTxt2; HeaderTxt[2])
//                     {
//                     }
//                     column(HeaderTxt3; HeaderTxt[3])
//                     {
//                     }
//                     column(HeaderTxt4; HeaderTxt[4])
//                     {
//                     }
//                     column(CustomerNoCaption; ML_CustomerNo)
//                     {
//                     }
//                     column(SellCustNo; "Sales Invoice Header"."Sell-to Customer No.")
//                     {
//                     }
//                     column(IsAtyse; IsAtyse)
//                     {
//                     }
//                     column(CompInfoVATReg; CompInfoVATReg)
//                     {
//                     }
//                     column(ShipmentNo_SalesInvHdr; "Sales Invoice Header"."Shipment No.")
//                     {
//                     }
//                     dataitem(DimensionLoop1; Table2000000026)
//                     {
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = SORTING(Number)
//                                             WHERE(Number = FILTER(1 ..));
//                         column(DimText; DimText)
//                         {
//                         }
//                         column(Number_Integer; DimensionLoop1.Number)
//                         {
//                         }
//                         column(DimensionsCaption; DimensionsCaptionLbl)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             IF Number = 1 THEN BEGIN
//                                 IF NOT DimSetEntry1.FINDSET THEN
//                                     CurrReport.BREAK();
//                             END ELSE
//                                 IF NOT Continue THEN
//                                     CurrReport.BREAK();

//                             CLEAR(DimText);
//                             Continue := FALSE;
//                             REPEAT
//                                 OldDimText := DimText;
//                                 IF DimText = '' THEN
//                                     DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
//                                 ELSE
//                                     DimText :=
//                                       STRSUBSTNO(
//                                         '%1, %2 %3', DimText,
//                                         DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
//                                 IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
//                                     DimText := OldDimText;
//                                     Continue := TRUE;
//                                     EXIT;
//                                 END;
//                             UNTIL DimSetEntry1.NEXT = 0;
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             IF NOT ShowInternalInfo THEN
//                                 CurrReport.BREAK();
//                         end;
//                     }
//                     dataitem(DataItem1570; Table113)
//                     {
//                         DataItemLink = Document No.=FIELD(No.);
//                         DataItemLinkReference = "Sales Invoice Header";
//                         DataItemTableView = SORTING(Document No., Line No.);
//                         column(ShowVATOption; ShowVAT)
//                         {
//                         }
//                         column(LineAmt_SalesInvoiceLine; "Line Amount")
//                         {
//                             AutoFormatExpression = GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(Description_SalesInvLine; Description)
//                         {
//                         }
//                         column(No_SalesInvoiceLine; "No.")
//                         {
//                         }
//                         column(Quantity_SalesInvoiceLine; Quantity)
//                         {
//                         }
//                         column(UOM_SalesInvoiceLine; "Unit of Measure")
//                         {
//                         }
//                         column(UnitPrice_SalesInvLine; "Unit Price")
//                         {
//                             AutoFormatExpression = GetCurrencyCode;
//                             AutoFormatType = 2;
//                         }
//                         column(LineDisc_SalesInvoiceLine; "Line Discount %")
//                         {
//                         }
//                         column(VAT_SalesInvLine; "VAT %")
//                         {
//                         }
//                         column(HS_Code; HS_Code)
//                         {
//                         }
//                         column(PostedShipmentDate; FORMAT(PostedShipmentDate))
//                         {
//                         }
//                         column(SalesLineType; FORMAT("Sales Invoice Line".Type))
//                         {
//                         }
//                         column(InvDiscountAmount; -"Inv. Discount Amount")
//                         {
//                             AutoFormatExpression = GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(TotalSubTotal; TotalSubTotal)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalInvoiceDiscountAmt; TotalInvoiceDiscountAmt)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalText; TotalText)
//                         {
//                         }
//                         column(RefExterne; "Sales Invoice Line"."Cross-Reference No.")
//                         {
//                         }
//                         column(Amount_SalesInvoiceLine; Amount)
//                         {
//                             AutoFormatExpression = GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(TotalAmount; TotalAmount)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(AmountIncludingVATAmount; "Amount Including VAT" - Amount)
//                         {
//                             AutoFormatExpression = GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
//                         {
//                             AutoFormatExpression = GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
//                         {
//                         }
//                         column(TotalExclVATText; TotalExclVATText)
//                         {
//                         }
//                         column(TotalInclVATText; TotalInclVATText)
//                         {
//                         }
//                         column(TotalAmountInclVAT; TotalAmountInclVAT)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(TotalAmountVAT; TotalAmountVAT)
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(TotalPaymentDiscountOnVAT; TotalPaymentDiscountOnVAT)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(LineNo_SalesInvoiceLine; "Line No.")
//                         {
//                         }
//                         column(MontantFooter; MontantFooter)
//                         {
//                         }
//                         column(UnitPriceCaption; UnitPriceCaptionLbl)
//                         {
//                         }
//                         column(DiscountCaption; DiscountCaptionLbl)
//                         {
//                         }
//                         column(AmountCaption; AmountCaptionLbl)
//                         {
//                         }
//                         column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
//                         {
//                         }
//                         column(SubtotalCaption; SubtotalCaptionLbl)
//                         {
//                         }
//                         column(PaymentDiscVATCaption; PaymentDiscVATCaptionLbl)
//                         {
//                         }
//                         column(Description_SalesInvLineCaption; FIELDCAPTION(Description))
//                         {
//                         }
//                         column(No_SalesInvoiceLineCaption; FIELDCAPTION("No."))
//                         {
//                         }
//                         column(Quantity_SalesInvoiceLineCaption; FIELDCAPTION(Quantity))
//                         {
//                         }
//                         column(UOM_SalesInvoiceLineCaption; FIELDCAPTION("Unit of Measure"))
//                         {
//                         }
//                         column(VAT_SalesInvLineCaption; FIELDCAPTION("VAT %"))
//                         {
//                         }
//                         column(SubtotalNet_SalesInvoiceLine; "Subtotal net")
//                         {
//                         }
//                         column(NewPageGroupNo; NewPageGroupNo)
//                         {
//                         }
//                         column(NewPageLine; NewPageLine)
//                         {
//                         }
//                         column(IsLineWithTotals; LineNoWithTotal = "Line No.")
//                         {
//                         }
//                         dataitem("Sales Shipment Buffer"; Table2000000026)
//                         {
//                             DataItemTableView = SORTING(Number);
//                             column(SalesShpBufferPostingDate; FORMAT(SalesShipmentBuffer."Posting Date"))
//                             {
//                             }
//                             column(SalesShpBufferQuantity; SalesShipmentBuffer.Quantity)
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(ShipmentCaption; ShipmentCaptionLbl)
//                             {
//                             }

//                             trigger OnAfterGetRecord()
//                             begin
//                                 IF Number = 1 THEN
//                                     SalesShipmentBuffer.FIND('-')
//                                 ELSE
//                                     SalesShipmentBuffer.NEXT;
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                                 SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");

//                                 SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
//                             end;
//                         }
//                         dataitem(DimensionLoop2; Table2000000026)
//                         {
//                             DataItemTableView = SORTING(Number)
//                                                 WHERE(Number = FILTER(1 ..));
//                             column(DimText_DimensionLoop2; DimText)
//                             {
//                             }
//                             column(LineDimensionsCaption; LineDimensionsCaptionLbl)
//                             {
//                             }

//                             trigger OnAfterGetRecord()
//                             begin
//                                 IF Number = 1 THEN BEGIN
//                                     IF NOT DimSetEntry2.FINDSET THEN
//                                         CurrReport.BREAK();
//                                 END ELSE
//                                     IF NOT Continue THEN
//                                         CurrReport.BREAK();

//                                 CLEAR(DimText);
//                                 Continue := FALSE;
//                                 REPEAT
//                                     OldDimText := DimText;
//                                     IF DimText = '' THEN
//                                         DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
//                                     ELSE
//                                         DimText :=
//                                           STRSUBSTNO(
//                                             '%1, %2 %3', DimText,
//                                             DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
//                                     IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
//                                         DimText := OldDimText;
//                                         Continue := TRUE;
//                                         EXIT;
//                                     END;
//                                 UNTIL DimSetEntry2.NEXT = 0;
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 IF NOT ShowInternalInfo THEN
//                                     CurrReport.BREAK();

//                                 DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
//                             end;
//                         }
//                         dataitem(AsmLoop; Table2000000026)
//                         {
//                             column(TempPostedAsmLineUOMCode; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(TempPostedAsmLineVariantCode; BlanksForIndent() + TempPostedAsmLine."Variant Code")
//                             {
//                                 DecimalPlaces = 0 : 5;
//                             }
//                             column(TempPostedAsmLineDesc; BlanksForIndent() + TempPostedAsmLine.Description)
//                             {
//                             }
//                             column(TempPostedAsmLineNo; BlanksForIndent() + TempPostedAsmLine."No.")
//                             {
//                             }

//                             trigger OnAfterGetRecord()
//                             var
//                                 ItemTranslation: Record "30";
//                             begin
//                                 IF Number = 1 THEN
//                                     TempPostedAsmLine.FINDSET
//                                 ELSE
//                                     TempPostedAsmLine.NEXT;

//                                 IF ItemTranslation.GET(TempPostedAsmLine."No.",
//                                      TempPostedAsmLine."Variant Code",
//                                      "Sales Invoice Header"."Language Code")
//                                 THEN
//                                     TempPostedAsmLine.Description := ItemTranslation.Description;
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 CLEAR(TempPostedAsmLine);
//                                 IF NOT DisplayAssemblyInformation THEN
//                                     CurrReport.BREAK();
//                                 CollectAsmInformation();
//                                 CLEAR(TempPostedAsmLine);
//                                 SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
//                             end;
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             PostedShipmentDate := 0D;
//                             IF Quantity <> 0 THEN
//                                 PostedShipmentDate := FindPostedShipmentDate();

//                             IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
//                                 "No." := '';

//                             VATAmountLine.INIT;
//                             VATAmountLine."VAT Identifier" := "VAT Identifier";
//                             VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
//                             VATAmountLine."Tax Group Code" := "Tax Group Code";
//                             VATAmountLine."VAT %" := "VAT %";
//                             VATAmountLine."VAT Base" := Amount;
//                             VATAmountLine."Amount Including VAT" := "Amount Including VAT";
//                             VATAmountLine."Line Amount" := "Line Amount";
//                             IF "Allow Invoice Disc." THEN
//                                 VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
//                             VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
//                             VATAmountLine."VAT Clause Code" := "VAT Clause Code";
//                             VATAmountLine.InsertLine;

//                             TotalSubTotal += "Line Amount";
//                             TotalInvoiceDiscountAmt -= "Inv. Discount Amount";
//                             TotalAmount += Amount;
//                             TotalAmountVAT += "Amount Including VAT" - Amount;
//                             TotalAmountInclVAT += "Amount Including VAT";
//                             TotalPaymentDiscountOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
//                             MontantFooter := MontantFooter + "Sales Invoice Line".Amount;
//                             HS_Code := '';
//                             IF "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item THEN
//                                 IF Item.GET("Sales Invoice Line"."No.") THEN
//                                     HS_Code := Item."Code nomenclature douaniere";
//                             NewPageLine := Type = Type::"New Page";
//                             IF NewPageLine THEN
//                                 NewPageGroupNo += 1;
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             VATAmountLine.DELETEALL;
//                             SalesShipmentBuffer.RESET;
//                             SalesShipmentBuffer.DELETEALL;
//                             FirstValueEntryNo := 0;
//                             MoreLines := FIND('+');
//                             WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
//                                 MoreLines := NEXT(-1) <> 0;
//                             IF NOT MoreLines THEN
//                                 CurrReport.BREAK();
//                             LineNoWithTotal := "Line No.";
//                             SETRANGE("Line No.", 0, "Line No.");
//                             CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");

//                             NewPageLine := FALSE;
//                         end;
//                     }
//                     dataitem(VATCounter; Table2000000026)
//                     {
//                         DataItemTableView = SORTING(Number);
//                         column(VATAmountLineVATBase; VATAmountLine."VAT Base")
//                         {
//                             AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmountLineVATAmount; VATAmountLine."VAT Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmountLineLineAmount; VATAmountLine."Line Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmtLineInvDiscountAmt; VATAmountLine."Invoice Discount Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmountLineVAT; VATAmountLine."VAT %")
//                         {
//                             DecimalPlaces = 0 : 5;
//                         }
//                         column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
//                         {
//                         }
//                         column(VATAmntSpecificCaption; VATAmntSpecificCaptionLbl)
//                         {
//                         }
//                         column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
//                         {
//                         }
//                         column(LineAmountCaption; LineAmountCaptionLbl)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             VATAmountLine.GetLine(Number);
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             SETRANGE(Number, 1, VATAmountLine.COUNT);
//                             CurrReport.CREATETOTALS(
//                               VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
//                               VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
//                         end;
//                     }
//                     dataitem(VATClauseEntryCounter; Table2000000026)
//                     {
//                         DataItemTableView = SORTING(Number);
//                         column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
//                         {
//                         }
//                         column(VATClauseCode; VATAmountLine."VAT Clause Code")
//                         {
//                         }
//                         column(VATClauseDescription; VATClause.Description)
//                         {
//                         }
//                         column(VATClauseDescription2; VATClause."Description 2")
//                         {
//                         }
//                         column(VATClauseAmount; VATAmountLine."VAT Amount")
//                         {
//                             AutoFormatExpression = "Sales Invoice Header"."Currency Code";
//                             AutoFormatType = 1;
//                         }
//                         column(VATClausesCaption; VATClausesCap)
//                         {
//                         }
//                         column(VATClauseVATIdentifierCaption; VATIdentifierCaptionLbl)
//                         {
//                         }
//                         column(VATClauseVATAmtCaption; VATAmountCaptionLbl)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             VATAmountLine.GetLine(Number);
//                             IF NOT VATClause.GET(VATAmountLine."VAT Clause Code") THEN
//                                 CurrReport.SKIP();
//                             VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             CLEAR(VATClause);
//                             SETRANGE(Number, 1, VATAmountLine.COUNT);
//                             CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
//                         end;
//                     }
//                     dataitem(VatCounterLCY; Table2000000026)
//                     {
//                         DataItemTableView = SORTING(Number);
//                         column(VALSpecLCYHeader; VALSpecLCYHeader)
//                         {
//                         }
//                         column(VALExchRate; VALExchRate)
//                         {
//                         }
//                         column(VALVATBaseLCY; VALVATBaseLCY)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VALVATAmountLCY; VALVATAmountLCY)
//                         {
//                             AutoFormatType = 1;
//                         }
//                         column(VATAmountLineVAT_VatCounterLCY; VATAmountLine."VAT %")
//                         {
//                             DecimalPlaces = 0 : 5;
//                         }
//                         column(VATAmtLineVATIdentifier_VatCounterLCY; VATAmountLine."VAT Identifier")
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             VATAmountLine.GetLine(Number);
//                             VALVATBaseLCY :=
//                               VATAmountLine.GetBaseLCY(
//                                 "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
//                                 "Sales Invoice Header"."Currency Factor");
//                             VALVATAmountLCY :=
//                               VATAmountLine.GetAmountLCY(
//                                 "Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code",
//                                 "Sales Invoice Header"."Currency Factor");
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             IF (NOT GLSetup."Print VAT specification in LCY") OR
//                                ("Sales Invoice Header"."Currency Code" = '')
//                             THEN
//                                 CurrReport.BREAK();

//                             SETRANGE(Number, 1, VATAmountLine.COUNT);
//                             CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

//                             IF GLSetup."LCY Code" = '' THEN
//                                 VALSpecLCYHeader := Text007 + Text008
//                             ELSE
//                                 VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

//                             CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
//                             CalculatedExchRate := ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
//                             VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
//                         end;
//                     }
//                     dataitem(PaymentReportingArgument; Table1062)
//                     {
//                         DataItemTableView = SORTING(Key);
//                         UseTemporary = true;
//                         column(PaymentServiceLogo; Logo)
//                         {
//                         }
//                         column(PaymentServiceURLText; "URL Caption")
//                         {
//                         }
//                         column(PaymentServiceURL; GetTargetURL)
//                         {
//                         }

//                         trigger OnPreDataItem()
//                         var
//                             PaymentServiceSetup: Record "1060";
//                         begin
//                             PaymentServiceSetup.CreateReportingArgs(PaymentReportingArgument, "Sales Invoice Header");
//                             IF ISEMPTY THEN
//                                 CurrReport.BREAK();
//                         end;
//                     }
//                     dataitem(Total; Table2000000026)
//                     {
//                         DataItemTableView = SORTING(Number)
//                                             WHERE(Number = CONST(1));
//                     }
//                     dataitem(Total2; Table2000000026)
//                     {
//                         DataItemTableView = SORTING(Number)
//                                             WHERE(Number = CONST(1));
//                         column(SellToCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
//                         {
//                         }
//                         column(SellToCustNo_SalesInvHdrCaption; "Sales Invoice Header".FIELDCAPTION("Sell-to Customer No."))
//                         {
//                         }

//                         trigger OnPreDataItem()
//                         begin
//                             IF NOT ShowShippingAddr THEN
//                                 CurrReport.BREAK();
//                         end;
//                     }
//                     dataitem(LineFee; Table2000000026)
//                     {
//                         DataItemTableView = SORTING(Number)
//                                             ORDER(Ascending)
//                                             WHERE(Number = FILTER(1 ..));
//                         column(LineFeeCaptionLbl; TempLineFeeNoteOnReportHist.ReportText)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             IF NOT DisplayAdditionalFeeNote THEN
//                                 CurrReport.BREAK();

//                             IF Number = 1 THEN BEGIN
//                                 IF NOT TempLineFeeNoteOnReportHist.FINDSET THEN
//                                     CurrReport.BREAK()
//                             END ELSE
//                                 IF TempLineFeeNoteOnReportHist.NEXT = 0 THEN
//                                     CurrReport.BREAK();
//                         end;
//                     }
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     IF Number > 1 THEN BEGIN
//                         CopyText := FormatDocument.GetCOPYText;
//                         OutputNo += 1;
//                     END;
//                     CurrReport.PAGENO := 1;

//                     TotalSubTotal := 0;
//                     TotalInvoiceDiscountAmt := 0;
//                     TotalAmount := 0;
//                     TotalAmountVAT := 0;
//                     TotalAmountInclVAT := 0;
//                     TotalPaymentDiscountOnVAT := 0;
//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     IF NOT CurrReport.PREVIEW THEN
//                         CODEUNIT.RUN(CODEUNIT::"Sales Inv.-Printed", "Sales Invoice Header");
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
//                     IF NoOfLoops <= 0 THEN
//                         NoOfLoops := 1;
//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);
//                     OutputNo := 1;
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 //>>DBE
//                 CLEAR(TextGNoIdIntracom);
//                 //<<DBE
//                 CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

//                 PrepareHeader();
//                 PrepareFooter();

//                 FormatAddressFields("Sales Invoice Header");
//                 FormatDocumentFields("Sales Invoice Header");

//                 IF NOT Cust.GET("Bill-to Customer No.") THEN
//                     CLEAR(Cust);

//                 DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

//                 GetLineFeeNoteOnReportHist("No.");

//                 IF LogInteraction THEN
//                     IF NOT CurrReport.PREVIEW THEN BEGIN
//                         IF "Bill-to Contact No." <> '' THEN
//                             SegManagement.LogDocument(
//                               SegManagement.SalesInvoiceInterDocType, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
//                               "Campaign No.", "Posting Description", '')
//                         ELSE
//                             SegManagement.LogDocument(
//                               SegManagement.SalesInvoiceInterDocType, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
//                               "Campaign No.", "Posting Description", '');
//                     END;

//                 Cust.GET("Bill-to Customer No.");
//                 //>>DBE
//                 //CustAddr[8] :='N° id. intracom. ' + Cust."VAT Registration No.";
//                 TextGNoIdIntracom := 'N° id. intracom. ' + Cust."VAT Registration No.";
//                 //<<DBE


//                 //ngts begin
//                 IF Contact.GET("Sales Invoice Header"."Sell-to Contact No.") THEN BEGIN
//                     ContactAltAddresse.SETRANGE(ContactAltAddresse."Contact No.", "Sales Invoice Header"."Sell-to Contact No.");
//                     IF ContactAltAddresse.FIND('-') THEN BEGIN
//                         codeAdresse := ContactAltAddresse.Code;
//                         FormatAddr.ContactAddrAlt(AdresseSecondaire, Contact, codeAdresse, TODAY);
//                         IF AdresseSecondaire[1] <> '' THEN
//                             DomiciliationTXT := 'Domiciliation :';
//                     END;
//                 END;
//                 //ngts end

//                 COMPRESSARRAY(CustAddr);
//                 //LOG-YOM/28.01.15
//                 //CustAddr[7] :='N° id. intracom. ' + Cust."VAT Registration No.";
//                 //LOG-YOM/28.01.15
//                 // NTO-
//                 NTO_ShowSpecHeader := FALSE;

//                 //MGTS10.029; 003; mhh; begin
//                 //begin deletion:
//                 IF "Sales Invoice Header"."Fiscal Repr." <> '' THEN BEGIN
//                     IF NTO_Ctct.GET("Sales Invoice Header"."Fiscal Repr.") THEN BEGIN
//                         //end //deletion}
//                         /*
//                         IF "Sales Invoice Header"."Bill-to Customer No." <> '' THEN BEGIN
//                           BillToCust.RESET;
//                           BillToCust.SETRANGE("No.", "Bill-to Customer No.");
//                           IF BillToCust.FINDFIRST THEN;

//                           IF NTO_Ctct.GET( BillToCust."Fiscal Repr." ) THEN BEGIN
//                         */
//                         //MGTS10.029; 003; mhh; end

//                         FormatAddr.NTO_SalesFiscCtct(NTO_FiscCtct, NTO_Ctct);

//                         NTO_ShowSpecHeader := TRUE;
//                         NTO_NoIntracomm := Cust."No TVA intracomm. NGTS";
//                         NTO_expéditeur := NTO_TxtExped;

//                         NTO_ReprésentantFiscal := NTO_TxtReprFisc;
//                         NTO_Destinataire := NTO_TxtDest;
//                         NTO_ReprFIscTVA := NTO_Ctct."VAT Registration No.";
//                         NTO_FiscCtct[6] := 'N° id. intracom. ' + NTO_Ctct."VAT Registration No.";
//                         //NOH1 start
//                         IF NTO_Ctct."N° de TVA" <> '' THEN BEGIN

//                             //MGTS10.00.005; 001; mhh; begin
//                             IF Cust."Change VAT Registration Place" THEN BEGIN
//                                 CompInfoVATReg := 'N° de TVA: ' + NTO_Ctct."N° de TVA";
//                                 NTO_FiscCtct[7] := '';
//                             END ELSE
//                                 //MGTS10.00.005; 001; mhh; end

//                                 NTO_FiscCtct[7] := 'N° de TVA: ' + NTO_Ctct."N° de TVA";
//                         END;
//                         //NOH1 end
//                         COMPRESSARRAY(NTO_FiscCtct)
//                     END

//                     //single
//                 END

//                 ELSE
//                     CompInfoVATReg := 'N° de TVA: ' + CompanyInfo."VAT Registration No.";

//                 //>>MGTS10.033
//                 IF (Cust."Country/Region Code" = 'DE') AND ("Sales Invoice Header"."Fiscal Repr." = '') THEN BEGIN
//                     CLEAR(NTO_FiscCtct);
//                     IF Cust."No TVA intracomm. NGTS" <> '' THEN
//                         NTO_FiscCtct[1] := 'N° id. intracom. ' + Cust."No TVA intracomm. NGTS"
//                     ELSE
//                         NTO_FiscCtct[1] := 'N° de TVA: ' + CompanyInfo."VAT Registration No.";

//                     NTO_NoIntracomm := '';
//                     NTO_expéditeur := '';
//                     NTO_ReprésentantFiscal := '';
//                     NTO_Destinataire := '';
//                     NTO_ReprFIscTVA := '';
//                     CompInfoVATReg := '';
//                 END;
//                 //>>MGTS10.033

//                 // NTO+
//                 //DEL.SAZ 19.07.19
//                 IF "Sales Invoice Header"."Sell-to Customer No." = 'ATYSE ESPAGNE' THEN
//                     IsAtyse := TRUE
//                 ELSE
//                     IsAtyse := FALSE;

//                 //End Del.SAZ

//                 //>> MGTS10.032
//                 Customer.GET("Sell-to Customer No.");
//                 ShowVAT := Customer."Show VAT In Invoice";
//                 //<<MGTS10.032

//             end;

//             trigger OnPreDataItem()
//             begin

//                 CompInfoVATReg := '';
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'No. of Copies';
//                         ToolTip = 'Specifies how many copies of the document to print.';
//                     }
//                     field(ShowInternalInfo; ShowInternalInfo)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Show Internal Information';
//                         ToolTip = 'Specifies if the document shows internal information.';
//                     }
//                     field(LogInteraction; LogInteraction)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Log Interaction';
//                         Enabled = LogInteractionEnable;
//                         ToolTip = 'Specifies that interactions with the contact are logged.';
//                     }
//                     field(DisplayAsmInformation; DisplayAssemblyInformation)
//                     {
//                         Caption = 'Show Assembly Components';
//                     }
//                     field(DisplayAdditionalFeeNote; DisplayAdditionalFeeNote)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Show Additional Fee Note';
//                         ToolTip = 'Specifies that any notes about additional fees are included on the document.';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }

//         trigger OnInit()
//         begin
//             LogInteractionEnable := TRUE;
//         end;

//         trigger OnOpenPage()
//         begin
//             InitLogInteraction();
//             LogInteractionEnable := LogInteraction;
//         end;
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         GLSetup.GET;
//         SalesSetup.GET;
//         CompanyInfo.GET;
//         CompanyInfo.VerifyAndSetPaymentInfo;
//         FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
//     end;

//     trigger OnPreReport()
//     begin
//         IF NOT CurrReport.USEREQUESTPAGE THEN
//             InitLogInteraction();
//     end;

//     var
//         PaymentTerms: Record "3";
//         Language: Record "8";
//         ShipmentMethod: Record "10";
//         SalesPurchPerson: Record "13";
//         BillToCust: Record "18";
//         Cust: Record "18";
//         Customer: Record "18";
//         Item: Record "27";
//         CompanyInfo: Record "79";
//         CompanyInfo1: Record "79";
//         CompanyInfo2: Record "79";
//         CompanyInfo3: Record "79";
//         CustPostGrp: Record "92";
//         GLSetup: Record "98";
//         VATAmountLine: Record "290" temporary;
//         SalesSetup: Record "311";
//         CurrExchRate: Record "330";
//         DimSetEntry1: Record "480";
//         DimSetEntry2: Record "480";
//         VATClause: Record "560";
//         TempPostedAsmLine: Record "911" temporary;
//         TempLineFeeNoteOnReportHist: Record "1053" temporary;
//         Contact: Record "5050";
//         NTO_Ctct: Record "5050";
//         ContactAltAddresse: Record "5051";
//         RespCenter: Record "5714";
//         SalesShipmentBuffer: Record "7190" temporary;
//         FormatAddr: Codeunit "365";
//         FormatDocument: Codeunit "368";
//         SegManagement: Codeunit "5051";
//         Continue: Boolean;
//         DisplayAdditionalFeeNote: Boolean;
//         DisplayAssemblyInformation: Boolean;
//         IsAtyse: Boolean;
//         LogInteraction: Boolean;
//         [InDataSet]
//         LogInteractionEnable: Boolean;
//         MoreLines: Boolean;
//         NewPageLine: Boolean;
//         NTO_ShowSpecHeader: Boolean;
//         ShowInternalInfo: Boolean;
//         ShowShippingAddr: Boolean;
//         ShowVAT: Boolean;
//         codeAdresse: Code[20];
//         HS_Code: Code[20];
//         NTO_NoIntracomm: Code[30];
//         NTO_ReprFIscTVA: Code[30];
//         PostedShipmentDate: Date;
//         CalculatedExchRate: Decimal;
//         MontantFooter: Decimal;
//         TotalAmount: Decimal;
//         TotalAmountInclVAT: Decimal;
//         TotalAmountVAT: Decimal;
//         TotalInvoiceDiscountAmt: Decimal;
//         TotalPaymentDiscountOnVAT: Decimal;
//         TotalSubTotal: Decimal;
//         VALVATAmountLCY: Decimal;
//         VALVATBaseLCY: Decimal;
//         CurrGroupPageNO: Integer;
//         CurrPageFooterHiddenFlg: Integer;
//         FirstValueEntryNo: Integer;
//         LineNoWithTotal: Integer;
//         NewPageGroupNo: Integer;
//         NextEntryNo: Integer;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         OutputNo: Integer;
//         AmountCaptionLbl: Label 'Amount';
//         BankAccountNoCaptionLbl: Label 'Account No.';
//         BankNameCaptionLbl: Label 'Bank';
//         Caption_ref: Label 'Y/ref';
//         DimensionsCaptionLbl: Label 'Header Dimensions';
//         DiscountCaptionLbl: Label 'Discount %';
//         DocumentDateCaptionLbl: Label 'Date';
//         DueDateCaptionLbl: Label 'Due Date';
//         EMailCaptionLbl: Label 'E-Mail';
//         GiroNoCaptionLbl: Label 'Giro No.';
//         HomePageCaptionLbl: Label 'Home Page';
//         HSCode_TXT: Label '* Ce code est mentionné à titre purement indicatif et ne saurait engager la responsabilité de MGTS';
//         IBANCpt: Label 'IBAN (pour paiement en Euro): %1';
//         IBANUSDCpt: Label 'IBAN (pour paiement en USD): %1';
//         InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
//         InvDiscountAmountCaptionLbl: Label 'Invoice Discount Amount';
//         InvoiceNoCaptionLbl: Label 'Invoice No.';
//         LineAmountCaptionLbl: Label 'Line Amount';
//         LineDimensionsCaptionLbl: Label 'Line Dimensions';
//         ML_AccNo: Label 'Account';
//         ML_ApplyToDoc: Label 'Refers to Document';
//         ML_Bank: Label 'Bank Information';
//         ML_Continued: Label 'Continued';
//         ML_CustomerNo: Label 'Customer No.';
//         ML_InvAdr: Label 'Invoice Address';
//         ML_OrderAdr: Label 'Order Address';
//         ML_OrderNo: Label 'Order No.';
//         ML_PmtTerms: Label 'Payment Terms';
//         ML_Reference: Label 'Reference';
//         ML_SalesPerson: Label 'Salesperson';
//         ML_ShipAdr: Label 'Shipping Address';
//         ML_ShipCond: Label 'Shipping Conditions';
//         ML_ShipDate: Label 'Shipping Date';
//         NTO_TxtDest: Label 'Facturation à :';
//         NTO_TxtExped: Label 'Expéditeur:';
//         NTO_TxtLieuDest: Label 'Lieu de destination:';
//         NTO_TxtReprFisc: Label 'Représenté fiscalement par:';
//         NTO_TxtReprFiscEspagne: Label 'Etablissement permanent';
//         PaymentDiscVATCaptionLbl: Label 'Payment Discount on VAT';
//         PaymentTermsCaptionLbl: Label 'Payment Terms';
//         PhoneNoCaptionLbl: Label 'Phone No.';
//         PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
//         PostingDateCaptionLbl: Label 'Posting Date';
//         ShipmentCaptionLbl: Label 'Shipment';
//         ShipmentMethodCaptionLbl: Label 'Shipment Method';
//         ShipmentMethodCodeLbl: Label 'Sales incoterm';
//         ShipToAddressCaptionLbl: Label 'Ship-to Address';
//         SubtotalCaptionLbl: Label 'Subtotal';
//         Text005: Label 'Page %1';
//         Text007: Label 'VAT Amount Specification in ';
//         Text008: Label 'Local Currency';
//         Text009: Label 'Exchange rate: %1/%2';
//         Text11500: Label 'Invoice';
//         Text11501: Label 'Prepayment Invoice';
//         TotalCaptionLbl: Label 'Total';
//         UnitPriceCaptionLbl: Label 'Unit Price';
//         VATAmntSpecificCaptionLbl: Label 'VAT Amount Specification';
//         VATAmountCaptionLbl: Label 'VAT Amount';
//         VATBaseCaptionLbl: Label 'VAT Base';
//         VATCaptionLbl: Label 'VAT %';
//         VATClausesCap: Label 'VAT Clause';
//         VATIdentifierCaptionLbl: Label 'VAT Identifier';
//         VATRegNoCaptionLbl: Label 'VAT Registration No.';
//         CompInfoVATReg: Text;
//         TextGNoIdIntracom: Text;
//         CopyText: Text[30];
//         DomiciliationTXT: Text[30];
//         FooterLabel: array[20] of Text[30];
//         HeaderLabel: array[20] of Text[30];
//         NTO_Destinataire: Text[30];
//         "NTO_expéditeur": Text[30];
//         NTO_LieuDestination: Text[30];
//         "NTO_ReprésentantFiscal": Text[30];
//         SalesPersonText: Text[30];
//         CompanyAddr: array[8] of Text[50];
//         CustAddr: array[8] of Text[50];
//         NTO_FiscCtct: array[8] of Text[50];
//         ShipToAddr: array[8] of Text[50];
//         TotalExclVATText: Text[50];
//         TotalInclVATText: Text[50];
//         TotalText: Text[50];
//         VALExchRate: Text[50];
//         OldDimText: Text[75];
//         AdresseSecondaire: array[8] of Text[80];
//         OrderNoText: Text[80];
//         ReferenceText: Text[80];
//         VALSpecLCYHeader: Text[80];
//         VATNoText: Text[80];
//         DimText: Text[120];
//         FooterTxt: array[20] of Text[120];
//         HeaderTxt: array[20] of Text[120];

//     [Scope('Internal')]
//     procedure InitLogInteraction()
//     begin
//         LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
//     end;

//     local procedure FindPostedShipmentDate(): Date
//     var
//         SalesShipmentHeader: Record "110";
//         SalesShipmentBuffer2: Record "7190" temporary;
//     begin
//         NextEntryNo := 1;
//         IF "Sales Invoice Line"."Shipment No." <> '' THEN
//             IF SalesShipmentHeader.GET("Sales Invoice Line"."Shipment No.") THEN
//                 EXIT(SalesShipmentHeader."Posting Date");

//         IF "Sales Invoice Header"."Order No." = '' THEN
//             EXIT("Sales Invoice Header"."Posting Date");

//         CASE "Sales Invoice Line".Type OF
//             "Sales Invoice Line".Type::Item:
//                 GenerateBufferFromValueEntry("Sales Invoice Line");
//             "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource,
//           "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset":
//                 GenerateBufferFromShipment("Sales Invoice Line");
//             "Sales Invoice Line".Type::" ":
//                 EXIT(0D);
//         END;

//         SalesShipmentBuffer.RESET;
//         SalesShipmentBuffer.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//         SalesShipmentBuffer.SETRANGE("Line No.", "Sales Invoice Line"."Line No.");
//         IF SalesShipmentBuffer.FIND('-') THEN BEGIN
//             SalesShipmentBuffer2 := SalesShipmentBuffer;
//             IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
//                 SalesShipmentBuffer.GET(
//                   SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
//                 SalesShipmentBuffer.DELETE;
//                 EXIT(SalesShipmentBuffer2."Posting Date");
//             END;
//             SalesShipmentBuffer.CALCSUMS(Quantity);
//             IF SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity THEN BEGIN
//                 SalesShipmentBuffer.DELETEALL;
//                 EXIT("Sales Invoice Header"."Posting Date");
//             END;
//         END ELSE
//             EXIT("Sales Invoice Header"."Posting Date");
//     end;

//     local procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "113")
//     var
//         ItemLedgerEntry: Record "32";
//         ValueEntry: Record "5802";
//         Quantity: Decimal;
//         TotalQuantity: Decimal;
//     begin
//         TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
//         ValueEntry.SETCURRENTKEY("Document No.");
//         ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
//         ValueEntry.SETRANGE("Posting Date", "Sales Invoice Header"."Posting Date");
//         ValueEntry.SETRANGE("Item Charge No.", '');
//         ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
//         IF ValueEntry.FIND('-') THEN
//             REPEAT
//                 IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
//                     IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
//                         Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
//                     ELSE
//                         Quantity := ValueEntry."Invoiced Quantity";
//                     AddBufferEntry(
//                       SalesInvoiceLine2,
//                       -Quantity,
//                       ItemLedgerEntry."Posting Date");
//                     TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
//                 END;
//                 FirstValueEntryNo := ValueEntry."Entry No." + 1;
//             UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
//     end;

//     local procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "113")
//     var
//         SalesShipmentHeader: Record "110";
//         SalesShipmentLine: Record "111";
//         SalesInvoiceHeader: Record "112";
//         SalesInvoiceLine2: Record "113";
//         Quantity: Decimal;
//         TotalQuantity: Decimal;
//     begin
//         TotalQuantity := 0;
//         SalesInvoiceHeader.SETCURRENTKEY("Order No.");
//         SalesInvoiceHeader.SETFILTER("No.", '..%1', "Sales Invoice Header"."No.");
//         SalesInvoiceHeader.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
//         IF SalesInvoiceHeader.FIND('-') THEN
//             REPEAT
//                 SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
//                 SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
//                 SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
//                 SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
//                 SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//                 IF SalesInvoiceLine2.FIND('-') THEN
//                     REPEAT
//                         TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
//                     UNTIL SalesInvoiceLine2.NEXT = 0;
//             UNTIL SalesInvoiceHeader.NEXT = 0;

//         SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
//         SalesShipmentLine.SETRANGE("Order No.", "Sales Invoice Header"."Order No.");
//         SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
//         SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
//         SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
//         SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

//         IF SalesShipmentLine.FIND('-') THEN
//             REPEAT
//                 IF "Sales Invoice Header"."Get Shipment Used" THEN
//                     CorrectShipment(SalesShipmentLine);
//                 IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
//                 ELSE BEGIN
//                     IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
//                         SalesShipmentLine.Quantity := TotalQuantity;
//                     Quantity :=
//                       SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

//                     TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
//                     SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

//                     IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN
//                         AddBufferEntry(
//                           SalesInvoiceLine,
//                           Quantity,
//                           SalesShipmentHeader."Posting Date");
//                 END;
//             UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
//     end;

//     local procedure CorrectShipment(var SalesShipmentLine: Record "111")
//     var
//         SalesInvoiceLine: Record "113";
//     begin
//         SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
//         SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
//         SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
//         IF SalesInvoiceLine.FIND('-') THEN
//             REPEAT
//                 SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
//             UNTIL SalesInvoiceLine.NEXT = 0;
//     end;

//     local procedure AddBufferEntry(SalesInvoiceLine: Record "113"; QtyOnShipment: Decimal; PostingDate: Date)
//     begin
//         SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
//         SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
//         SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
//         IF SalesShipmentBuffer.FIND('-') THEN BEGIN
//             SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
//             SalesShipmentBuffer.MODIFY;
//             EXIT;
//         END;

//         "Document No." := SalesInvoiceLine."Document No.";
//         "Line No." := SalesInvoiceLine."Line No.";
//         "Entry No." := NextEntryNo;
//         Type := SalesInvoiceLine.Type;
//         "No." := SalesInvoiceLine."No.";
//         Quantity := QtyOnShipment;
//         "Posting Date" := PostingDate;
//         INSERT;
//         NextEntryNo := NextEntryNo + 1
//     end;

//     local procedure DocumentCaption(): Text[250]
//     begin
//         IF "Sales Invoice Header"."Prepayment Invoice" THEN
//             EXIT(Text11501);
//         EXIT(Text11500);
//     end;

//     [Scope('Internal')]
//     procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
//     begin
//         NoOfCopies := NewNoOfCopies;
//         ShowInternalInfo := NewShowInternalInfo;
//         LogInteraction := NewLogInteraction;
//         DisplayAssemblyInformation := DisplayAsmInfo;
//     end;

//     local procedure FormatDocumentFields(SalesInvoiceHeader: Record "112")
//     begin
//         FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
//         FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
//         FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
//         FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

//         OrderNoText := FormatDocument.SetText("Order No." <> '', FIELDCAPTION("Order No."));
//         ReferenceText := FormatDocument.SetText("Your Reference" <> '', FIELDCAPTION("Your Reference"));
//         VATNoText := FormatDocument.SetText("VAT Registration No." <> '', FIELDCAPTION("VAT Registration No."));
//     end;

//     local procedure FormatAddressFields(SalesInvoiceHeader: Record "112")
//     begin
//         FormatAddr.GetCompanyAddr(SalesInvoiceHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
//         FormatAddr.SalesInvBillTo(CustAddr, SalesInvoiceHeader);
//         ShowShippingAddr := FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, SalesInvoiceHeader);
//     end;

//     local procedure CollectAsmInformation()
//     var
//         ItemLedgerEntry: Record "32";
//         SalesShipmentLine: Record "111";
//         PostedAsmHeader: Record "910";
//         PostedAsmLine: Record "911";
//         ValueEntry: Record "5802";
//     begin
//         TempPostedAsmLine.DELETEALL;
//         IF "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item THEN
//             EXIT;
//         SETCURRENTKEY("Document No.");
//         SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//         SETRANGE("Document Type", "Document Type"::"Sales Invoice");
//         SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
//         SETRANGE(Adjustment, FALSE);
//         IF NOT FINDSET THEN
//             EXIT;
//         REPEAT
//             IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN
//                 IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
//                     SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
//                     IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
//                         PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
//                         IF PostedAsmLine.FINDSET THEN
//                             REPEAT
//                                 TreatAsmLineBuffer(PostedAsmLine);
//                             UNTIL PostedAsmLine.NEXT = 0;
//                     END;
//                 END;
//         UNTIL ValueEntry.NEXT = 0;
//     end;

//     local procedure TreatAsmLineBuffer(PostedAsmLine: Record "911")
//     begin
//         CLEAR(TempPostedAsmLine);
//         TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
//         TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
//         TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
//         TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
//         TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
//         IF TempPostedAsmLine.FINDFIRST THEN BEGIN
//             TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
//             TempPostedAsmLine.MODIFY;
//         END ELSE BEGIN
//             CLEAR(TempPostedAsmLine);
//             TempPostedAsmLine := PostedAsmLine;
//             TempPostedAsmLine.INSERT;
//         END;
//     end;

//     local procedure GetUOMText(UOMCode: Code[10]): Text[10]
//     var
//         UnitOfMeasure: Record "204";
//     begin
//         IF NOT UnitOfMeasure.GET(UOMCode) THEN
//             EXIT(UOMCode);
//         EXIT(UnitOfMeasure.Description);
//     end;

//     [Scope('Internal')]
//     procedure BlanksForIndent(): Text[10]
//     begin
//         EXIT(PADSTR('', 2, ' '));
//     end;

//     [Scope('Internal')]
//     procedure PrepareHeader()
//     begin
//         CLEAR(HeaderLabel);
//         CLEAR(HeaderTxt);

//         FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");

//         IF "Order No." <> '' THEN BEGIN
//             HeaderLabel[1] := ML_OrderNo;
//             HeaderTxt[1] := "Order No.";
//         END;

//         IF SalesPurchPerson.GET("Salesperson Code") THEN BEGIN
//             HeaderLabel[2] := ML_SalesPerson;
//             HeaderTxt[2] := SalesPurchPerson.Name;
//         END;

//         IF "Your Reference" <> '' THEN BEGIN
//             HeaderLabel[3] := ML_Reference;
//             //HeaderTxt[3] := "Your Reference";
//             HeaderTxt[3] := "Sales Invoice Header"."External Document No.";
//         END;

//         //>MGTS10.03
//         IF ("Shipment Method Code" <> '') THEN BEGIN
//             HeaderLabel[4] := ShipmentMethodCodeLbl;
//             HeaderTxt[4] := "Sales Invoice Header"."Shipment Method Code";
//         END;
//         //<<MGTS10.03

//         COMPRESSARRAY(HeaderLabel);

//         COMPRESSARRAY(HeaderTxt);

//         CustPostGrp.GET("Customer Posting Group");
//     end;

//     local procedure PrepareFooter()
//     var
//         PmtMethod: Record "3";
//         ShipMethod: Record "10";
//     begin
//         CLEAR(FooterLabel);
//         CLEAR(FooterTxt);

//         IF PmtMethod.GET("Payment Terms Code") THEN BEGIN
//             FooterLabel[1] := ML_PmtTerms;
//             PmtMethod.TranslateDescription(PmtMethod, "Language Code");
//             FooterTxt[1] := PmtMethod.Description;
//         END;

//         IF "Applies-to Doc. No." <> '' THEN BEGIN
//             FooterLabel[2] := ML_ApplyToDoc;
//             FooterTxt[2] := FORMAT("Applies-to Doc. Type") + ' ' + "Applies-to Doc. No.";
//         END;

//         IF ShipMethod.GET("Shipment Method Code") THEN BEGIN
//             FooterLabel[3] := ML_ShipCond;
//             ShipMethod.TranslateDescription(ShipMethod, "Language Code");
//             FooterTxt[3] := ShipMethod.Description;
//         END;

//         IF "Ship-to Code" <> '' THEN BEGIN
//             FooterLabel[4] := ML_ShipAdr;
//             FooterTxt[4] := "Ship-to Name" + ' ' + "Ship-to City";
//         END;

//         IF "Sell-to Customer No." <> "Bill-to Customer No." THEN BEGIN
//             FooterLabel[5] := ML_InvAdr;
//             FooterTxt[5] := "Bill-to Name" + ', ' + "Bill-to City";
//             FooterLabel[6] := ML_OrderAdr;
//             FooterTxt[6] := "Sell-to Customer Name" + ', ' + "Sell-to City";
//         END;

//         IF ("Shipment Date" <> "Document Date") AND ("Shipment Date" <> 0D) THEN BEGIN
//             FooterLabel[7] := ML_ShipDate;
//             FooterTxt[7] := FORMAT("Shipment Date", 0, 4);
//         END;

//         CurrGroupPageNO += 1;
//         CurrPageFooterHiddenFlg := 0;

//         CompanyInfo.TESTFIELD("Bank Name");
//         FooterLabel[8] := ML_Bank;
//         FooterTxt[8] := CompanyInfo."Bank Name" + ', ' + ML_AccNo + ' ' + CompanyInfo."Bank Account No.";

//         COMPRESSARRAY(FooterLabel);
//         COMPRESSARRAY(FooterTxt);
//     end;

//     local procedure GetLineFeeNoteOnReportHist(SalesInvoiceHeaderNo: Code[20])
//     var
//         Customer: Record "18";
//         CustLedgerEntry: Record "21";
//         LineFeeNoteOnReportHist: Record "1053";
//     begin
//         TempLineFeeNoteOnReportHist.DELETEALL;
//         CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
//         CustLedgerEntry.SETRANGE("Document No.", SalesInvoiceHeaderNo);
//         IF NOT CustLedgerEntry.FINDFIRST THEN
//             EXIT;

//         IF NOT Customer.GET(CustLedgerEntry."Customer No.") THEN
//             EXIT;

//         LineFeeNoteOnReportHist.SETRANGE("Cust. Ledger Entry No", CustLedgerEntry."Entry No.");
//         LineFeeNoteOnReportHist.SETRANGE("Language Code", Customer."Language Code");
//         IF LineFeeNoteOnReportHist.FINDSET THEN BEGIN
//             REPEAT
//                 TempLineFeeNoteOnReportHist.INIT;
//                 TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
//                 TempLineFeeNoteOnReportHist.INSERT;
//             UNTIL LineFeeNoteOnReportHist.NEXT = 0;
//         END ELSE BEGIN
//             LineFeeNoteOnReportHist.SETRANGE("Language Code", Language.GetUserLanguage);
//             IF LineFeeNoteOnReportHist.FINDSET THEN
//                 REPEAT
//                     TempLineFeeNoteOnReportHist.INIT;
//                     TempLineFeeNoteOnReportHist.COPY(LineFeeNoteOnReportHist);
//                     TempLineFeeNoteOnReportHist.INSERT;
//                 UNTIL LineFeeNoteOnReportHist.NEXT = 0;
//         END;
//     end;
// }

