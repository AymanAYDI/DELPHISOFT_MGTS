report 50081 "DEL Archived Sales Order" //216
{
    Caption = 'Archived Sales Order';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/ArchivedSalesOrder.rdlc';

    dataset
    {
        dataitem("Sales Header Archive"; "Sales Header Archive")
        {
            DataItemTableView = SORTING("Document Type", "No.", "Doc. No. Occurrence", "Version No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed", "Version No.";
            RequestFilterHeading = 'Archived Sales Order';
            column(Sales_Header_Archive_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_Archive_No_; "No.")
            {
            }
            column(Sales_Header_Archive_Doc__No__Occurrence; "Doc. No. Occurrence")
            {
            }
            column(Sales_Header_Archive_Version_No_; "Version No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2_Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText_; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo__Giro_No__; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfo__Bank_Name_; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(Sales_Header_Archive___Bill_to_Customer_No__; "Sales Header Archive"."Bill-to Customer No.")
                    {
                    }
                    column(FORMAT__Sales_Header_Archive___Document_Date__0_4_; FORMAT("Sales Header Archive"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(Sales_Header_Archive___VAT_Registration_No__; "Sales Header Archive"."VAT Registration No.")
                    {
                    }
                    column(Sales_Header_Archive___Shipment_Date_; FORMAT("Sales Header Archive"."Shipment Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Sales_Header_Archive___No__; "Sales Header Archive"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(Sales_Header_Archive___Your_Reference_; "Sales Header Archive"."Your Reference")
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(Sales_Header_Archive___Prices_Including_VAT_; "Sales Header Archive"."Prices Including VAT")
                    {
                    }
                    column(STRSUBSTNO_Text011__Sales_Header_Archive___Version_No____Sales_Header_Archive___No__of_Archived_Versions__; STRSUBSTNO(Text011, "Sales Header Archive"."Version No.", "Sales Header Archive"."No. of Archived Versions"))
                    {
                    }
                    column(VATBaseDiscountPercent; "Sales Header Archive"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVAT_YesNo; FORMAT("Sales Header Archive"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__Caption; CompanyInfo__VAT_Registration_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Giro_No__Caption; CompanyInfo__Giro_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Name_Caption; CompanyInfo__Bank_Name_CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Bank_Account_No__Caption; CompanyInfo__Bank_Account_No__CaptionLbl)
                    {
                    }
                    column(Sales_Header_Archive___Bill_to_Customer_No__Caption; "Sales Header Archive".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(Sales_Header_Archive___Shipment_Date_Caption; Sales_Header_Archive___Shipment_Date_CaptionLbl)
                    {
                    }
                    column(Order_No_Caption; Order_No_CaptionLbl)
                    {
                    }
                    column(Sales_Header_Archive___Prices_Including_VAT_Caption; "Sales Header Archive".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Header Archive";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control80; DimText)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET() THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK();

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
                            UNTIL DimSetEntry1.NEXT() = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Sales Line Archive"; "Sales Line Archive")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Header Archive";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(SalesLineArch__Line_Amount_; TempSalesLineArchive."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line_Archive__Description; "Sales Line Archive".Description)
                        {
                        }
                        column(RoundLoopBody3Visibility; TempSalesLineArchive.Type = 0)
                        {
                        }
                        column(Sales_Line_Archive___No__; "Sales Line Archive"."No.")
                        {
                        }
                        column(Sales_Line_Archive__Description_Control63; "Sales Line Archive".Description)
                        {
                        }
                        column(Sales_Line_Archive__Quantity; "Sales Line Archive".Quantity)
                        {
                        }
                        column(Sales_Line_Archive___Unit_of_Measure_; "Sales Line Archive"."Unit of Measure")
                        {
                        }
                        column(Sales_Line_Archive___Unit_Price_; "Sales Line Archive"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line_Archive___Line_Discount___; "Sales Line Archive"."Line Discount %")
                        {
                        }
                        column(Sales_Line_Archive___Line_Amount_; "Sales Line Archive"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line_Archive___Allow_Invoice_Disc__; "Sales Line Archive"."Allow Invoice Disc.")
                        {
                        }
                        column(Sales_Line_Archive___VAT_Identifier_; "Sales Line Archive"."VAT Identifier")
                        {
                        }
                        column(SalesLineType; FORMAT("Sales Line Archive".Type))
                        {
                        }
                        column(AllowInvoiceDis_YesNo; FORMAT("Sales Line Archive"."Allow Invoice Disc."))
                        {
                        }
                        column(SalesLineNo; FORMAT("Sales Line Archive"."Line No."))
                        {
                        }
                        column(RoundLoopBody4Visibility; TempSalesLineArchive.Type > 0)
                        {
                        }
                        column(SalesLineArch__Line_Amount__Control84; TempSalesLineArchive."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineArch__Inv__Discount_Amount_; TempSalesLineArchive."Inv. Disc. Amount to Invoice")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineArch__Line_Amount__Control70; TempSalesLineArchive."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesLineArch__Line_Amount__SalesLineArch__Inv__Discount_Amount_; TempSalesLineArchive."Line Amount" - TempSalesLineArchive."Inv. Disc. Amount to Invoice")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(SalesLineArch__Line_Amount__SalesLineArch__Inv__Discount_Amount__Control88; TempSalesLineArchive."Line Amount" - TempSalesLineArchive."Inv. Disc. Amount to Invoice")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineArch__Line_Amount__SalesLineArch__Inv__Discount_Amount____VATAmount; TempSalesLineArchive."Line Amount" - TempSalesLineArchive."Inv. Disc. Amount to Invoice" + VATAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control131; TotalExclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText_Control133; TempVATAmountLine.VATAmountText())
                        {
                        }
                        column(VATAmount_Control134; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control135; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(Sales_Line_Archive___No__Caption; "Sales Line Archive".FIELDCAPTION("No."))
                        {
                        }
                        column(Sales_Line_Archive__Description_Control63Caption; "Sales Line Archive".FIELDCAPTION(Description))
                        {
                        }
                        column(Sales_Line_Archive__QuantityCaption; "Sales Line Archive".FIELDCAPTION(Quantity))
                        {
                        }
                        column(Sales_Line_Archive___Unit_of_Measure_Caption; "Sales Line Archive".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(Unit_PriceCaption; Unit_PriceCaptionLbl)
                        {
                        }
                        column(Sales_Line_Archive___Line_Discount___Caption; Sales_Line_Archive___Line_Discount___CaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Sales_Line_Archive___VAT_Identifier_Caption; "Sales Line Archive".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(Sales_Line_Archive___Allow_Invoice_Disc__Caption; "Sales Line Archive".FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control83; ContinuedCaption_Control83Lbl)
                        {
                        }
                        column(SalesLineArch__Inv__Discount_Amount_Caption; SalesLineArch__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText_Control82; DimText)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
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
                                UNTIL DimSetEntry2.NEXT() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Sales Line Archive"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                TempSalesLineArchive.FIND('-')
                            ELSE
                                TempSalesLineArchive.NEXT();
                            "Sales Line Archive" := TempSalesLineArchive;

                            IF NOT "Sales Header Archive"."Prices Including VAT" AND
                               (TempSalesLineArchive."VAT Calculation Type" = TempSalesLineArchive."VAT Calculation Type"::"Full VAT")
                            THEN
                                TempSalesLineArchive."Line Amount" := 0;

                            IF (TempSalesLineArchive.Type = TempSalesLineArchive.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Sales Line Archive"."No." := '';
                        end;

                        trigger OnPostDataItem()
                        begin
                            TempSalesLineArchive.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := TempSalesLineArchive.FIND('+');
                            WHILE MoreLines AND (TempSalesLineArchive.Description = '') AND (TempSalesLineArchive."Description 2" = '') AND
                                  (TempSalesLineArchive."No." = '') AND (TempSalesLineArchive.Quantity = 0) AND
                                  (TempSalesLineArchive.Amount = 0)
                            DO
                                MoreLines := TempSalesLineArchive.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            TempSalesLineArchive.SETRANGE("Line No.", 0, TempSalesLineArchive."Line No.");
                            SETRANGE(Number, 1, TempSalesLineArchive.COUNT);
                            CurrReport.CREATETOTALS(TempSalesLineArchive."Line Amount", TempSalesLineArchive."Inv. Discount Amount",
                              TempSalesLineArchive."Inv. Disc. Amount to Invoice");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Base_; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Base__Control106; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control107; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control72; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control73; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control74; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control110; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control111; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control100; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control104; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control108; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control114; TempVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control115; TempVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control112; TempVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control116; TempVATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control130; TempVATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control106Caption; VATAmountLine__VAT_Base__Control106CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control107Caption; VATAmountLine__VAT_Amount__Control107CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control73Caption; VATAmountLine__Inv__Disc__Base_Amount__Control73CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control72Caption; VATAmountLine__Line_Amount__Control72CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control74Caption; VATAmountLine__Invoice_Discount_Amount__Control74CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control110Caption; VATAmountLine__VAT_Base__Control110CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control114Caption; VATAmountLine__VAT_Base__Control114CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK();
                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              TempVATAmountLine."Line Amount", TempVATAmountLine."Inv. Disc. Base Amount",
                              TempVATAmountLine."Invoice Discount Amount", TempVATAmountLine."VAT Base", TempVATAmountLine."VAT Amount");
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
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control149; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control150; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control151; TempVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control152; TempVATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control156; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control157; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control159; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control160; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }
                        column(VALVATAmountLCY_Control149Caption; VALVATAmountLCY_Control149CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control150Caption; VALVATBaseLCY_Control150CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control151Caption; VATAmountLine__VAT____Control151CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control152Caption; VATAmountLine__VAT_Identifier__Control152CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control157Caption; VALVATBaseLCY_Control157CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control160Caption; VALVATBaseLCY_Control160CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            TempVATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              TempVATAmountLine.GetBaseLCY(
                                "Sales Header Archive"."Posting Date", "Sales Header Archive"."Currency Code",
                                "Sales Header Archive"."Currency Factor");
                            VALVATAmountLCY :=
                              TempVATAmountLine.GetAmountLCY(
                                "Sales Header Archive"."Posting Date", "Sales Header Archive"."Currency Code",
                                "Sales Header Archive"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header Archive"."Currency Code" = '') OR
                               (TempVATAmountLine.GetTotalVATAmount() = 0)
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, TempVATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header Archive"."Posting Date", "Sales Header Archive"."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        column(ShipmentMethod_Description; ShipmentMethod.Description)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(ShipmentMethod_DescriptionCaption; ShipmentMethod_DescriptionCaptionLbl)
                        {
                        }
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Sales_Header_Archive___Sell_to_Customer_No__; "Sales Header Archive"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr_8_; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddr_7_; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr_6_; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr_5_; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr_4_; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr_3_; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr_2_; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr_1_; ShipToAddr[1])
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }
                        column(Sales_Header_Archive___Sell_to_Customer_No__Caption; "Sales Header Archive".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    TempSalesHeader: Record "Sales Header" temporary;
                    TempSalesLine: Record "Sales Line" temporary;
                begin
                    InitTempLines(TempSalesHeader, TempSalesLine);

                    VATAmount := TempVATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := TempVATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      TempVATAmountLine.GetTotalVATDiscount(TempSalesHeader."Currency Code", TempSalesHeader."Prices Including VAT");
                    TotalAmountInclVAT := TempVATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN BEGIN
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        CODEUNIT.RUN(CODEUNIT::"SalesCount-PrintedArch", "Sales Header Archive");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := LanguageCdu.GetLanguageID("Language Code");

                FormatAddressFields("Sales Header Archive");
                FormatDocumentFields("Sales Header Archive");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                CALCFIELDS("No. of Archived Versions");
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
                    field(NoOfCopiesF; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
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

    trigger OnInitReport()
    begin
        GLSetup.GET();
        CompanyInfo.GET();
        SalesSetup.GET();

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                CompanyInfo.CALCFIELDS(Picture);
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET();
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET();
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    var
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Language: Record Language;
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        RespCenter: Record "Responsibility Center";
        SalesSetup: Record "Sales & Receivables Setup";
        TempSalesLineArchive: Record "Sales Line Archive" temporary;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        LanguageCdu: Codeunit Language;
        Continue: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        ShowShippingAddr: Boolean;
        TotalAmountInclVAT: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        AmountCaptionLbl: Label 'Amount';
        CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.';
        CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        ContinuedCaption_Control83Lbl: Label 'Continued';
        ContinuedCaptionLbl: Label 'Continued';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        Order_No_CaptionLbl: Label 'Order No.';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        Sales_Header_Archive___Shipment_Date_CaptionLbl: Label 'Shipment Date';
        Sales_Line_Archive___Line_Discount___CaptionLbl: Label 'Disc. %';
        SalesLineArch__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        SubtotalCaptionLbl: Label 'Subtotal';
        Text004: Label 'Sales Order Archived %1';
        Text005: Label 'Page %1';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        Text011: Label 'Version %1 of %2';
        Unit_PriceCaptionLbl: Label 'Unit Price';
        VALVATAmountLCY_Control149CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCY_Control150CaptionLbl: Label 'VAT Base';
        VALVATBaseLCY_Control157CaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control160CaptionLbl: Label 'Total';
        VALVATBaseLCYCaptionLbl: Label 'Continued';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__Inv__Disc__Base_Amount__Control73CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control74CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__Line_Amount__Control72CaptionLbl: Label 'Line Amount';
        VATAmountLine__VAT____Control151CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Amount__Control107CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base__Control106CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Base__Control110CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control114CaptionLbl: Label 'Total';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Identifier__Control152CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        CopyText: Text[30];
        SalesPersonText: Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];

    local procedure FormatAddressFields(var SalesHeaderArchive: Record "Sales Header Archive")
    begin
        FormatAddr.GetCompanyAddr(SalesHeaderArchive."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesHeaderArchBillTo(CustAddr, SalesHeaderArchive);
        ShowShippingAddr := FormatAddr.SalesHeaderArchShipTo(ShipToAddr, CustAddr, SalesHeaderArchive);
    end;

    local procedure FormatDocumentFields(SalesHeaderArchive: Record "Sales Header Archive")
    begin
        FormatDocument.SetTotalLabels(SalesHeaderArchive."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesHeaderArchive."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeaderArchive."Payment Terms Code", SalesHeaderArchive."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, SalesHeaderArchive."Prepmt. Payment Terms Code", SalesHeaderArchive."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeaderArchive."Shipment Method Code", SalesHeaderArchive."Language Code");

        ReferenceText := FormatDocument.SetText(SalesHeaderArchive."Your Reference" <> '', SalesHeaderArchive.FIELDCAPTION("Your Reference"));
        VATNoText := FormatDocument.SetText(SalesHeaderArchive."VAT Registration No." <> '', SalesHeaderArchive.FIELDCAPTION("VAT Registration No."));
    end;

    local procedure InitTempLines(var TempSalesHeader: Record "Sales Header" temporary; var TempSalesLine: Record "Sales Line" temporary)
    begin
        TempSalesLineArchive.CopyTempLines("Sales Header Archive", TempSalesLine);

        TempVATAmountLine.DELETEALL();
        TempSalesHeader.TRANSFERFIELDS("Sales Header Archive");
        TempSalesLine."Prepayment Line" := TRUE;  // used as flag in CalcVATAmountLines -> not invoice rounding
        TempSalesLine.CalcVATAmountLines(0, TempSalesHeader, TempSalesLine, TempVATAmountLine);
    end;
}

