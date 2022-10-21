report 50076 "DEL Archived Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ArchivedPurchaseOrder.rdlc';
    Caption = 'Archived Purchase Order';

    dataset
    {
        dataitem("Purchase Header Archive"; "Purchase Header Archive")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Archived Purchase Order';
            column(Purchase_Header_Archive_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_Archive_No_; "No.")
            {
            }
            column(Purchase_Header_Archive_Doc__No__Occurrence; "Doc. No. Occurrence")
            {
            }
            column(Purchase_Header_Archive_Version_No_; "Version No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo1_Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText_; STRSUBSTNO(Text004, CopyText))
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
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
                    column(FORMAT__Purchase_Header_Archive___Document_Date__0_4_; FORMAT("Purchase Header Archive"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(Purchase_Header_Archive___VAT_Registration_No__; "Purchase Header Archive"."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPerson_Name; SalesPurchPerson.Name)
                    {
                    }
                    column(Purchase_Header_Archive___No__; "Purchase Header Archive"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(Purchase_Header_Archive___Your_Reference_; "Purchase Header Archive"."Your Reference")
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(Purchase_Header_Archive___Buy_from_Vendor_No__; "Purchase Header Archive"."Buy-from Vendor No.")
                    {
                    }
                    column(BuyFromAddr_1_; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr_2_; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr_3_; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr_4_; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr_5_; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr_6_; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr_7_; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr_8_; BuyFromAddr[8])
                    {
                    }
                    column(Purchase_Header_Archive___Prices_Including_VAT_; "Purchase Header Archive"."Prices Including VAT")
                    {
                    }
                    column(STRSUBSTNO_Text010__Purchase_Header_Archive___Version_No____Purchase_Header_Archive___No__of_Archived_Versions__; STRSUBSTNO(Text010, "Purchase Header Archive"."Version No.", "Purchase Header Archive"."No. of Archived Versions"))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(Purchase_Header_Archive___VAT_Base_Discount___; "Purchase Header Archive"."VAT Base Discount %")
                    {
                    }
                    column(PricesInclVATtxt; PricesInclVATtxt)
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
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
                    column(Order_No_Caption; Order_No_CaptionLbl)
                    {
                    }
                    column(Purchase_Header_Archive___Buy_from_Vendor_No__Caption; "Purchase Header Archive".FIELDCAPTION("Buy-from Vendor No."))
                    {
                    }
                    column(Purchase_Header_Archive___Prices_Including_VAT_Caption; "Purchase Header Archive".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header Archive";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control72; DimText)
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
                    dataitem("Purchase Line Archive"; "Purchase Line Archive")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No."),
                                       "Doc. No. Occurrence" = FIELD("Doc. No. Occurrence"),
                                       "Version No." = FIELD("Version No.");
                        DataItemLinkReference = "Purchase Header Archive";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Doc. No. Occurrence", "Version No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchLineArch__Line_Amount_; PurchLineArch."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line_Archive__Description; "Purchase Line Archive".Description)
                        {
                        }
                        column(Purchase_Line_Archive___Line_No__; "Purchase Line Archive"."Line No.")
                        {
                        }
                        column(AllowInvDisctxt; AllowInvDisctxt)
                        {
                        }
                        column(Purchase_Line_Archive__Type; PurchaseLineArchiveType)
                        {
                        }
                        column(Purchase_Line_Archive___No__; "Purchase Line Archive"."No.")
                        {
                        }
                        column(Purchase_Line_Archive__Description_Control63; "Purchase Line Archive".Description)
                        {
                        }
                        column(Purchase_Line_Archive__Quantity; "Purchase Line Archive".Quantity)
                        {
                        }
                        column(Purchase_Line_Archive___Unit_of_Measure_; "Purchase Line Archive"."Unit of Measure")
                        {
                        }
                        column(Purchase_Line_Archive___Direct_Unit_Cost_; "Purchase Line Archive"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line_Archive___Line_Discount___; "Purchase Line Archive"."Line Discount %")
                        {
                        }
                        column(Purchase_Line_Archive___Line_Amount_; "Purchase Line Archive"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line_Archive___Allow_Invoice_Disc__; "Purchase Line Archive"."Allow Invoice Disc.")
                        {
                        }
                        column(Purchase_Line_Archive___VAT_Identifier_; "Purchase Line Archive"."VAT Identifier")
                        {
                        }
                        column(PurchLineArch__Line_Amount__Control77; PurchLineArch."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineArch__Inv__Discount_Amount_; -PurchLineArch."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineArch__Line_Amount__Control109; PurchLineArch."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchLineArch__Line_Amount__PurchLineArch__Inv__Discount_Amount_; PurchLineArch."Line Amount" - PurchLineArch."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText())
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLineArch__Line_Amount__PurchLineArch__Inv__Discount_Amount____VATAmount; PurchLineArch."Line Amount" - PurchLineArch."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(PurchLineArch__Line_Amount__PurchLineArch__Inv__Discount_Amount__Control147; PurchLineArch."Line Amount" - PurchLineArch."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText_Control32; VATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText_Control51; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText_Control69; TotalInclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control83; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvoiceDiscountAmount; TotalInvoiceDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line_Archive___No__Caption; "Purchase Line Archive".FIELDCAPTION("No."))
                        {
                        }
                        column(Purchase_Line_Archive__Description_Control63Caption; "Purchase Line Archive".FIELDCAPTION(Description))
                        {
                        }
                        column(Purchase_Line_Archive__QuantityCaption; "Purchase Line Archive".FIELDCAPTION(Quantity))
                        {
                        }
                        column(Purchase_Line_Archive___Unit_of_Measure_Caption; "Purchase Line Archive".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(Direct_Unit_CostCaption; Direct_Unit_CostCaptionLbl)
                        {
                        }
                        column(Purchase_Line_Archive___Line_Discount___Caption; Purchase_Line_Archive___Line_Discount___CaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(Purchase_Line_Archive___Allow_Invoice_Disc__Caption; "Purchase Line Archive".FIELDCAPTION("Allow Invoice Disc."))
                        {
                        }
                        column(Purchase_Line_Archive___VAT_Identifier_Caption; "Purchase Line Archive".FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control76; ContinuedCaption_Control76Lbl)
                        {
                        }
                        column(PurchLineArch__Inv__Discount_Amount_Caption; PurchLineArch__Inv__Discount_Amount_CaptionLbl)
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
                            column(DimText_Control74; DimText)
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", "Purchase Line Archive"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                PurchLineArch.FIND('-')
                            ELSE
                                PurchLineArch.NEXT();
                            "Purchase Line Archive" := PurchLineArch;

                            IF NOT "Purchase Header Archive"."Prices Including VAT" AND
                               (PurchLineArch."VAT Calculation Type" = PurchLineArch."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLineArch."Line Amount" := 0;

                            IF (PurchLineArch.Type = PurchLineArch.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line Archive"."No." := '';
                            AllowInvDisctxt := FORMAT("Purchase Line Archive"."Allow Invoice Disc.");
                            PurchaseLineArchiveType := "Purchase Line Archive".Type.AsInteger();

                            TotalSubTotal += "Purchase Line Archive"."Line Amount";
                            TotalInvoiceDiscountAmount -= "Purchase Line Archive"."Inv. Discount Amount";
                            TotalAmount += "Purchase Line Archive".Amount;
                        end;

                        trigger OnPostDataItem()
                        begin
                            PurchLineArch.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLineArch.FIND('+');

                            WHILE MoreLines AND (PurchLineArch.Description = '') AND (PurchLineArch."Description 2" = '') AND
                                  (PurchLineArch."No." = '') AND (PurchLineArch.Quantity = 0) AND
                                  (PurchLineArch.Amount = 0)
                            DO
                                MoreLines := PurchLineArch.NEXT(-1) <> 0;

                            IF NOT MoreLines THEN
                                CurrReport.BREAK();

                            PurchLineArch.SETRANGE("Line No.", 0, PurchLineArch."Line No.");
                            SETRANGE(Number, 1, PurchLineArch.COUNT);
                            CurrReport.CREATETOTALS(PurchLineArch."Line Amount", PurchLineArch."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Base__Control99; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control100; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control131; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control132; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control133; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control103; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control104; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control56; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control57; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control58; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control107; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control108; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control59; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control60; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control61; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATCounter_Number; Number)
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control99Caption; VATAmountLine__VAT_Base__Control99CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control100Caption; VATAmountLine__VAT_Amount__Control100CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control132Caption; VATAmountLine__Inv__Disc__Base_Amount__Control132CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control131Caption; VATAmountLine__Line_Amount__Control131CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control133Caption; VATAmountLine__Invoice_Discount_Amount__Control133CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control103Caption; VATAmountLine__VAT_Base__Control103CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base__Control107Caption; VATAmountLine__VAT_Base__Control107CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK();
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
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control158; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control159; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control160; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control161; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control162; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control163; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY_Control165; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY_Control166; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }
                        column(VALVATAmountLCY_Control158Caption; VALVATAmountLCY_Control158CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control159Caption; VALVATBaseLCY_Control159CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control160Caption; VATAmountLine__VAT____Control160CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control161Caption; VATAmountLine__VAT_Identifier__Control161CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control163Caption; VALVATBaseLCY_Control163CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control166Caption; VALVATBaseLCY_Control166CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Purchase Header Archive"."Posting Date", "Purchase Header Archive"."Currency Code",
                                "Purchase Header Archive"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Purchase Header Archive"."Posting Date", "Purchase Header Archive"."Currency Code",
                                "Purchase Header Archive"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Purchase Header Archive"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount() = 0)
                            THEN
                                CurrReport.BREAK();

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header Archive"."Posting Date", "Purchase Header Archive"."Currency Code", 1);
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
                        column(Purchase_Header_Archive___Pay_to_Vendor_No__; "Purchase Header Archive"."Pay-to Vendor No.")
                        {
                        }
                        column(VendAddr_8_; VendAddr[8])
                        {
                        }
                        column(VendAddr_7_; VendAddr[7])
                        {
                        }
                        column(VendAddr_6_; VendAddr[6])
                        {
                        }
                        column(VendAddr_5_; VendAddr[5])
                        {
                        }
                        column(VendAddr_4_; VendAddr[4])
                        {
                        }
                        column(VendAddr_3_; VendAddr[3])
                        {
                        }
                        column(VendAddr_2_; VendAddr[2])
                        {
                        }
                        column(VendAddr_1_; VendAddr[1])
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }
                        column(Payment_DetailsCaption; Payment_DetailsCaptionLbl)
                        {
                        }
                        column(Vendor_No_Caption; Vendor_No_CaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF "Purchase Header Archive"."Buy-from Vendor No." = "Purchase Header Archive"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total3; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Purchase_Header_Archive___Sell_to_Customer_No__; "Purchase Header Archive"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr_1_; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr_2_; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr_3_; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr_4_; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr_5_; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr_6_; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr_7_; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr_8_; ShipToAddr[8])
                        {
                        }
                        column(Total3_Number; Number)
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }
                        column(Purchase_Header_Archive___Sell_to_Customer_No__Caption; "Purchase Header Archive".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF ("Purchase Header Archive"."Sell-to Customer No." = '') AND (ShipToAddr[1] = '') THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBuf__G_L_Account_No__; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(PrepmtLineAmount_Control173; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                        }
                        column(PrepmtInvBuf_Description; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtLineAmount_Control177; PrepmtLineAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control182; TotalExclVATText)
                        {
                        }
                        column(PrepmtInvBuf_Amount; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine_VATAmountText; PrepmtVATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control186; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvBuf_Amount___PrepmtVATAmount; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_Control188; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText_Control189; VATAmountLine.VATAmountText())
                        {
                        }
                        column(PrepmtVATAmount_Control190; PrepmtVATAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText_Control192; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtLoop_Number; Number)
                        {
                        }
                        column(PrepmtLineAmount_Control173Caption; PrepmtLineAmount_Control173CaptionLbl)
                        {
                        }
                        column(PrepmtInvBuf_DescriptionCaption; PrepmtInvBuf_DescriptionCaptionLbl)
                        {
                        }
                        column(PrepmtInvBuf__G_L_Account_No__Caption; PrepmtInvBuf__G_L_Account_No__CaptionLbl)
                        {
                        }
                        column(Prepayment_SpecificationCaption; Prepayment_SpecificationCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control176; ContinuedCaption_Control176Lbl)
                        {
                        }
                        column(ContinuedCaption_Control178; ContinuedCaption_Control178Lbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText_Control179; DimText)
                            {
                            }
                            column(DimText_Control181; DimText)
                            {
                            }
                            column(PrepmtDimLoop_Number; Number)
                            {
                            }
                            column(Line_DimensionsCaption_Control180; Line_DimensionsCaption_Control180Lbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT PrepmtDimSetEntry.FINDSET() THEN
                                        CurrReport.BREAK();
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK();

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            PrepmtDimSetEntry."Dimension Code", PrepmtDimSetEntry."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL PrepmtDimSetEntry.NEXT() = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT PrepmtInvBuf.FIND('-') THEN
                                    CurrReport.BREAK();
                            END ELSE
                                IF PrepmtInvBuf.NEXT() = 0 THEN
                                    CurrReport.BREAK();

                            IF ShowInternalInfo THEN
                                PrepmtDimSetEntry.SETRANGE("Dimension Set ID", PrepmtInvBuf."Dimension Set ID");

                            IF "Purchase Header Archive"."Prices Including VAT" THEN
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            ELSE
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmountLine__VAT_Amount_; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base_; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount_; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT___; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control194; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control195; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control196; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT____Control197; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmountLine__VAT_Identifier_; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control210; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control211; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control212; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT____Control213; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control215; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control216; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control217; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header Archive"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATCounter_Number; Number)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Amount__Control194Caption; PrepmtVATAmountLine__VAT_Amount__Control194CaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control195Caption; PrepmtVATAmountLine__VAT_Base__Control195CaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__Line_Amount__Control196Caption; PrepmtVATAmountLine__Line_Amount__Control196CaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT____Control197Caption; PrepmtVATAmountLine__VAT____Control197CaptionLbl)
                        {
                        }
                        column(Prepayment_VAT_Amount_SpecificationCaption; Prepayment_VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Identifier_Caption; PrepmtVATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control209; ContinuedCaption_Control209Lbl)
                        {
                        }
                        column(ContinuedCaption_Control214; ContinuedCaption_Control214Lbl)
                        {
                        }
                        column(PrepmtVATAmountLine__VAT_Base__Control216Caption; PrepmtVATAmountLine__VAT_Base__Control216CaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, PrepmtVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(PrepmtTotal; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PrepmtPaymentTerms_Description; PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepmtTotal_Number; Number)
                        {
                        }
                        column(PrepmtPaymentTerms_DescriptionCaption; PrepmtPaymentTerms_DescriptionCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT PrepmtInvBuf.FIND('-') THEN
                                CurrReport.BREAK();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    TempPurchHeader: Record "Purchase Header" temporary;
                    TempPurchLine: Record "Purchase Line" temporary;
                    PurchLineArchive: Record "Purchase Line Archive";
                begin
                    CLEAR(PurchLineArch);
                    PurchLineArch.DELETEALL();
                    PurchLineArchive.SETRANGE("Document Type", "Purchase Header Archive"."Document Type");
                    PurchLineArchive.SETRANGE("Document No.", "Purchase Header Archive"."No.");
                    PurchLineArchive.SETRANGE("Version No.", "Purchase Header Archive"."Version No.");
                    IF PurchLineArchive.FINDSET() THEN
                        REPEAT
                            PurchLineArch := PurchLineArchive;
                            PurchLineArch.INSERT();
                            TempPurchLine.TRANSFERFIELDS(PurchLineArchive);
                            TempPurchLine.INSERT();
                        UNTIL PurchLineArchive.NEXT() = 0;

                    VATAmountLine.DELETEALL();

                    TempPurchHeader.TRANSFERFIELDS("Purchase Header Archive");
                    TempPurchLine."Prepayment Line" := TRUE;  // used as flag in CalcVATAmountLines -> not invoice rounding
                    TempPurchLine.CalcVATAmountLines(0, TempPurchHeader, TempPurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount(TempPurchHeader."Currency Code", TempPurchHeader."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN
                        CopyText := FormatDocument.GetCOPYText();
                    CurrReport.PAGENO := 1;
                    OutputNo := OutputNo + 1;
                    TotalSubTotal := 0;
                    TotalInvoiceDiscountAmount := 0;
                    TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        CODEUNIT.RUN(CODEUNIT::"Purch.HeaderArch-Printed", "Purchase Header Archive");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                FormatAddressFields("Purchase Header Archive");
                FormatDocumentFields("Purchase Header Archive");
                PricesInclVATtxt := FORMAT("Prices Including VAT");

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
                    field(NoOfCopies; NoOfCopies)
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
        CompanyInfo1.GET();
        CompanyInfo1.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";

        CompanyInfo1: Record "Company Information";
        CurrExchRate: Record "Currency Exchange Rate";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PrepmtDimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        Language: Record Language;
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        PurchLineArch: Record "Purchase Line Archive" temporary;
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        VATAmountLine: Record "VAT Amount Line" temporary;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        Continue: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        PrepmtLineAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalInvoiceDiscountAmount: Decimal;
        TotalSubTotal: Decimal;
        VALVATAmountLCY: Decimal;
        VALVATBaseLCY: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        PurchaseLineArchiveType: Integer;
        AmountCaptionLbl: Label 'Amount';
        CompanyInfo__Bank_Account_No__CaptionLbl: Label 'Account No.';
        CompanyInfo__Bank_Name_CaptionLbl: Label 'Bank';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__Giro_No__CaptionLbl: Label 'Giro No.';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        ContinuedCaption_Control76Lbl: Label 'Continued';
        ContinuedCaption_Control176Lbl: Label 'Continued';
        ContinuedCaption_Control178Lbl: Label 'Continued';
        ContinuedCaption_Control209Lbl: Label 'Continued';
        ContinuedCaption_Control214Lbl: Label 'Continued';
        ContinuedCaptionLbl: Label 'Continued';
        Direct_Unit_CostCaptionLbl: Label 'Direct Unit Cost';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Line_DimensionsCaption_Control180Lbl: Label 'Line Dimensions';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        Order_No_CaptionLbl: Label 'Order No.';
        PageCaptionLbl: Label 'Page';
        Payment_DetailsCaptionLbl: Label 'Payment Details';
        PaymentTerms_DescriptionCaptionLbl: Label 'Payment Terms';
        Prepayment_SpecificationCaptionLbl: Label 'Prepayment Specification';
        Prepayment_VAT_Amount_SpecificationCaptionLbl: Label 'Prepayment VAT Amount Specification';
        PrepmtInvBuf__G_L_Account_No__CaptionLbl: Label 'G/L Account No.';
        PrepmtInvBuf_DescriptionCaptionLbl: Label 'Description';
        PrepmtLineAmount_Control173CaptionLbl: Label 'Amount';
        PrepmtPaymentTerms_DescriptionCaptionLbl: Label 'Prepmt. Payment Terms';
        PrepmtVATAmountLine__Line_Amount__Control196CaptionLbl: Label 'Line Amount';
        PrepmtVATAmountLine__VAT____Control197CaptionLbl: Label 'VAT %';
        PrepmtVATAmountLine__VAT_Amount__Control194CaptionLbl: Label 'VAT Amount';
        PrepmtVATAmountLine__VAT_Base__Control195CaptionLbl: Label 'VAT Base';
        PrepmtVATAmountLine__VAT_Base__Control216CaptionLbl: Label 'Total';
        PrepmtVATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        Purchase_Line_Archive___Line_Discount___CaptionLbl: Label 'Disc. %';
        PurchLineArch__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        Ship_to_AddressCaptionLbl: Label 'Ship-to Address';
        ShipmentMethod_DescriptionCaptionLbl: Label 'Shipment Method';
        SubtotalCaptionLbl: Label 'Subtotal';
        Text004: Label 'Purchase Order Archived %1', Comment = '%1 = Document No.';
        Text005: Label 'Page %1';
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        Text010: Label 'Version %1 of %2 ';
        VALVATAmountLCY_Control158CaptionLbl: Label 'VAT Amount';
        VALVATBaseLCY_Control159CaptionLbl: Label 'VAT Base';
        VALVATBaseLCY_Control163CaptionLbl: Label 'Continued';
        VALVATBaseLCY_Control166CaptionLbl: Label 'Total';
        VALVATBaseLCYCaptionLbl: Label 'Continued';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__Inv__Disc__Base_Amount__Control132CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control133CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__Line_Amount__Control131CaptionLbl: Label 'Line Amount';
        VATAmountLine__VAT____Control160CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Amount__Control100CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base__Control99CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Base__Control103CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control107CaptionLbl: Label 'Total';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Identifier__Control161CaptionLbl: Label 'VAT Identifier';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Vendor_No_CaptionLbl: Label 'Vendor No.';
        AllowInvDisctxt: Text[30];
        CopyText: Text[30];
        PricesInclVATtxt: Text[30];
        PurchaserText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VALExchRate: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        VALSpecLCYHeader: Text[80];
        VATNoText: Text[80];
        DimText: Text[120];

    local procedure FormatAddressFields(var PurchaseHeaderArchive: Record "Purchase Header Archive")
    begin
        FormatAddr.GetCompanyAddr(PurchaseHeaderArchive."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.PurchHeaderBuyFromArch(BuyFromAddr, PurchaseHeaderArchive);
        IF PurchaseHeaderArchive."Buy-from Vendor No." <> PurchaseHeaderArchive."Pay-to Vendor No." THEN
            FormatAddr.PurchHeaderPayToArch(VendAddr, PurchaseHeaderArchive);
        FormatAddr.PurchHeaderShipToArch(ShipToAddr, PurchaseHeaderArchive);
    end;

    local procedure FormatDocumentFields(PurchaseHeaderArchive: Record "Purchase Header Archive")
    begin
        FormatDocument.SetTotalLabels(PurchaseHeaderArchive."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetPurchaser(SalesPurchPerson, PurchaseHeaderArchive."Purchaser Code", PurchaserText);
        FormatDocument.SetPaymentTerms(PaymentTerms, PurchaseHeaderArchive."Payment Terms Code", PurchaseHeaderArchive."Language Code");
        FormatDocument.SetPaymentTerms(PrepmtPaymentTerms, PurchaseHeaderArchive."Prepmt. Payment Terms Code", PurchaseHeaderArchive."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, PurchaseHeaderArchive."Shipment Method Code", PurchaseHeaderArchive."Language Code");
        ReferenceText := FormatDocument.SetText(PurchaseHeaderArchive."Your Reference" <> '', PurchaseHeaderArchive.FIELDCAPTION("Your Reference"));
        VATNoText := FormatDocument.SetText(PurchaseHeaderArchive."VAT Registration No." <> '', PurchaseHeaderArchive.FIELDCAPTION("VAT Registration No."));
    end;
}

