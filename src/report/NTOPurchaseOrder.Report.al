report 50004 "DEL NTO - Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/NTOPurchaseOrder.rdlc';

    Caption = 'Order';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            column(Purchase_Header_amount; "Purchase Header".Amount)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(PriceCaption; PriceCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Vendor_RefCaption; Vendor_RefCaptionLbl)
            {
            }
            column(Purchase_Line___No__Caption; "Purchase Line".FIELDCAPTION("No."))
            {
            }
            column(Purchase_Line__Description_Control63Caption; "Purchase Line".FIELDCAPTION(Description))
            {
            }
            column(FooterTxt_8_; FooterTxt[8])
            {
            }
            column(FooterTxt_7_; FooterTxt[7])
            {
            }
            column(FooterTxt_6_; FooterTxt[6])
            {
            }
            column(FooterLabel_6_; FooterLabel[6])
            {
            }
            column(FooterLabel_8_; FooterLabel[8])
            {
            }
            column(FooterLabel_7_; FooterLabel[7])
            {
            }
            column(FooterTxt_5_; FooterTxt[5])
            {
            }
            column(FooterLabel_5_; FooterLabel[5])
            {
            }
            column(FooterTxt_4_; FooterTxt[4])
            {
            }
            column(FooterLabel_4_; FooterLabel[4])
            {
            }
            column(FooterTxt_3_; FooterTxt[3])
            {
            }
            column(FooterLabel_3_; FooterLabel[3])
            {
            }
            column(FooterTxt_2_; FooterTxt[2])
            {
            }
            column(FooterLabel_2_; FooterLabel[2])
            {
            }
            column(FooterTxt_1_; FooterTxt[1])
            {
            }
            column(FooterLabel_1_; FooterLabel[1])
            {
            }
            column(FooterTxt_9_; FooterTxt[9])
            {
            }
            column(FooterLabel_9_; FooterLabel[9])
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
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
                    column(Purchase_Header___Pay_to_Vendor_No__; "Purchase Header"."Pay-to Vendor No.")
                    {
                    }
                    column(Purchase_Header___Document_Date_; "Purchase Header"."Document Date")
                    {
                    }
                    column(HeaderTxt_1_; HeaderTxt[1])
                    {
                    }
                    column(HeaderLabel_1_; HeaderLabel[1])
                    {
                    }
                    column(HeaderTxt_2_; HeaderTxt[2])
                    {
                    }
                    column(HeaderLabel_2_; HeaderLabel[2])
                    {
                    }
                    column(HeaderTxt_3_; HeaderTxt[3])
                    {
                    }
                    column(HeaderLabel_3_; HeaderLabel[3])
                    {
                    }
                    column(HeaderLabel_4_; HeaderLabel[4])
                    {
                    }
                    column(HeaderTxt_4_; HeaderTxt[4])
                    {
                    }
                    column(CopyText; CopyText)
                    {
                    }
                    column(STRSUBSTNO_Text004__Purchase_Header___No___; STRSUBSTNO(Text004, "Purchase Header"."No."))
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyAddr_5_; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr_6_; CompanyAddr[6])
                    {
                    }
                    column(CompanyAddr_3_; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_4_; CompanyAddr[4])
                    {
                    }
                    column(CompanyAddr_2_; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1_; CompanyAddr[1])
                    {
                    }
                    column(STRSUBSTNO_Text005_FORMAT_CurrReport_PAGENO__; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO())))
                    {
                    }
                    column(CopyText_Control1000006; CopyText)
                    {
                    }
                    column(STRSUBSTNO_Text004__Purchase_Header___No____Control1000007; STRSUBSTNO(Text004, "Purchase Header"."No."))
                    {
                    }
                    column(CompanyAddr_4__Control1000000010; CompanyAddr[4])
                    {
                    }
                    column(CompanyInfo__Phone_No___Control1000000011; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyAddr_3__Control1000000012; CompanyAddr[3])
                    {
                    }
                    column(CompanyAddr_2__Control1000000013; CompanyAddr[2])
                    {
                    }
                    column(CompanyAddr_1__Control1000000014; CompanyAddr[1])
                    {
                    }
                    column(BuyFromAddr_1__Control1000000015; BuyFromAddr[1])
                    {
                    }
                    column(Purchase_Header___Document_Date__Control1000000016; "Purchase Header"."Document Date")
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
                    column(DateCaption; DateCaptionLbl)
                    {
                    }
                    column(Customer_No_Caption; Customer_No_CaptionLbl)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimText_Control72; DimText)
                        {
                        }
                        column(Header_DimensionsCaption; Header_DimensionsCaptionLbl)
                        {
                        }
                        column(DimensionLoop1_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT DocDim1.FIND('-') THEN
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
                                      '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DocDim1."Dimension Code", DocDim1."Dimension Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL (DocDim1.NEXT() = 0);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.BREAK();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PurchLine__Line_Amount_; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line___No__; "Purchase Line"."No.")
                        {
                        }
                        column(Purchase_Line__Description_Control63; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Quantity; "Purchase Line".Quantity)
                        {
                            Description = 'Qty';
                        }
                        column(Purchase_Line___Unit_of_Measure_; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(Purchase_Line___Direct_Unit_Cost_; "Purchase Line"."Direct Unit Cost")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Purchase_Line___Line_Amount_; "Purchase Line"."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ref_fourn; ref_fourn)
                        {
                        }
                        column(PurchLine__Line_Amount__Control77; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Inv__Discount_Amount_; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__Control109; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
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
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount____VATAmount; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount__Control147; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
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
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control83; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(ContinuedCaption_Control76; ContinuedCaption_Control76Lbl)
                        {
                        }
                        column(PurchLine__Inv__Discount_Amount_Caption; PurchLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText_Control74; DimText)
                            {
                            }
                            column(Line_DimensionsCaption; Line_DimensionsCaptionLbl)
                            {
                            }
                            column(DimensionLoop2_Number; Number)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DocDim2.FIND('-') THEN
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
                                          '%1 %2', DocDim1."Dimension Code", DocDim1."Dimension Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DocDim1."Dimension Code", DocDim1."Dimension Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL (DocDim1.NEXT() = 0);
                            end;

                            trigger OnPreDataItem()
                            var
                                PurchLine: Record "Purchase Line";
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK();


                                //TODO : à vérifier .. #Abir
                                // DocDim1.SETRANGE("Dimension Set ID", DATABASE::"Purchase Line");
                                // DocDim2.SETRANGE("Document Type", "Purchase Line"."Document Type");
                                // DocDim2.SETRANGE("Document No.", "Purchase Line"."Document No.");
                                // DocDim2.SETRANGE("Line No.", "Purchase Line"."Line No.");
                                // PurchLine."Dimension Set ID" :=
                                //  DimMgt.GetDimensionSetID(DocDim1);
                                DimMgt.ShowDimensionSet(PurchLine."Dimension Set ID", StrSubstNo('%1 %2 %3', PurchLine."Document Type",
                               PurchLine."Document No.", PurchLine."Line No."));
                            end;


                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                PurchLine.FIND('-')
                            ELSE
                                PurchLine.NEXT();
                            "Purchase Line" := PurchLine;

                            IF NOT "Purchase Header"."Prices Including VAT" AND
                               (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                PurchLine."Line Amount" := 0;

                            IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                "Purchase Line"."No." := '';
                            IF "Purchase Line".Type = "Purchase Line".Type::Item THEN BEGIN
                                Item_temp.GET("Purchase Line"."No.");
                                ref_fourn := Item_temp."Vendor Item No.";
                            END
                            ELSE
                                ref_fourn := '';
                        end;

                        trigger OnPostDataItem()
                        begin

                            PurchLine.DELETEALL();
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.FIND('+');
                            WHILE MoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                                  (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                                  (PurchLine.Amount = 0) DO
                                MoreLines := PurchLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                            SETRANGE(Number, 1, PurchLine.COUNT);
                            CurrReport.CREATETOTALS(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Base__Control99; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control100; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control131; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control132; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control133; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control103; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control104; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control56; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control57; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control58; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Base__Control107; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount__Control108; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount__Control59; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control60; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control61; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
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
                        column(VATCounter_Number; Number)
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
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(Total_Number; Number)
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(PurchLine);
                    CLEAR(PurchPost);
                    PurchLine.DELETEALL();
                    VATAmountLine.DELETEALL();
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    IF Number > 1 THEN
                        CopyText := Text003;
                    CurrReport.PAGENO := 1;
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
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                PurchHeader: Record "Purchase Header";
            begin

                CurrReport.LANGUAGE := LanguageCdu.GetLanguageID("Language Code");

                CompanyInfo.GET();
                PrepareHeader();
                PrepareFooter();
                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                //TODO: à vérifier #Abir 
                // DocDim1.SETRANGE("Table ID", DATABASE::"Purchase Header");
                // DocDim1.SETRANGE("Document Type", "Purchase Header"."Document Type");
                // DocDim1.SETRANGE("Document No.", "Purchase Header"."No.");
                DimMgt.ShowDimensionSet(PurchHeader."Dimension Set ID", StrSubstNo('%1 %2 %3', PurchHeader."Document Type",
                PurchHeader."No."));



                IF "Purchaser Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT();
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
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;

                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                IF ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") THEN
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT()
                ELSE
                    PaymentTerms.GET("Payment Terms Code");
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT()
                ELSE
                    ShipmentMethod.GET("Shipment Method Code");

                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StorePurchDocument("Purchase Header", LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        SegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;
                "Purchase Header".CALCFIELDS("Purchase Header".Amount);
            end;
        }
    }

    requestpage
    {

        layout
        {
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
    end;

    var
        CompanyInfo: Record "Company Information";
        // DocDim1: Record 357; //Document Dimension
        // DocDim2: Record 357;
        //   TODO : dimensions have been removed ! ! 
        DocDim1: Record "Dimension Set Entry"; //480 
        DocDim2: Record "General Ledger Setup";
        GLSetup: Record "General Ledger Setup";
        Item_temp: Record Item;
        Language: Record Language;
        PaymentTerms: Record "Payment Terms";
        PurchLine: Record "Purchase Line" temporary;

        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        VATAmountLine: Record "VAT Amount Line" temporary;
        ArchiveManagement: Codeunit ArchiveManagement;
        LanguageCdu: Codeunit Language;

        DimMgt: Codeunit DimensionManagement; //408
        FormatAddr: Codeunit "Format Address";
        PurchPost: Codeunit "Purch.-Post";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        SegManagement: Codeunit SegManagement;
        ArchiveDocument: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        MoreLines: Boolean;
        ShowInternalInfo: Boolean;
        TotalAmountInclVAT: Decimal;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        AmountCaptionLbl: Label 'Amount';
        CompanyInfo__Fax_No__CaptionLbl: Label 'Fax No.';
        CompanyInfo__Phone_No__CaptionLbl: Label 'Phone No.';
        CompanyInfo__VAT_Registration_No__CaptionLbl: Label 'VAT Reg. No.';
        ContinuedCaption_Control76Lbl: Label 'Continued';
        ContinuedCaptionLbl: Label 'Continued';
        Customer_No_CaptionLbl: Label 'Customer No.';
        DateCaptionLbl: Label 'Date';
        Header_DimensionsCaptionLbl: Label 'Header Dimensions';
        Line_DimensionsCaptionLbl: Label 'Line Dimensions';
        ML_Date_Receipt: Label 'Shipment Date';
        ML_Forwarder: Label 'Forwarder';
        ML_InvAdr: Label 'Invoice Address';
        ML_Location_code: Label 'Destination';
        ML_Method: Label 'Ship per';
        ML_OrderAdr: Label 'Order Address';
        ML_PmtTerms: Label 'Payment Terms';
        ML_PurchPerson: Label 'Purchaser';
        ML_Reference: Label 'Reference';
        ML_ShipCond: Label 'Incoterm';
        ML_ShipDate: Label 'Shipping Date';
        PriceCaptionLbl: Label 'Price';
        PurchLine__Inv__Discount_Amount_CaptionLbl: Label 'Inv. Discount Amount';
        QtyCaptionLbl: Label 'Qty';
        SubtotalCaptionLbl: Label 'Subtotal';
        Text000: Label 'Purchaser';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'PURCHASE ORDER N° %1';
        Text005: Label 'Page %1';
        Text006: Label 'Total %1 Excl. VAT';
        VAT_Amount_SpecificationCaptionLbl: Label 'VAT Amount Specification';
        VATAmountLine__Inv__Disc__Base_Amount__Control132CaptionLbl: Label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control133CaptionLbl: Label 'Invoice Discount Amount';
        VATAmountLine__Line_Amount__Control131CaptionLbl: Label 'Line Amount';
        VATAmountLine__VAT___CaptionLbl: Label 'VAT %';
        VATAmountLine__VAT_Amount__Control100CaptionLbl: Label 'VAT Amount';
        VATAmountLine__VAT_Base__Control99CaptionLbl: Label 'VAT Base';
        VATAmountLine__VAT_Base__Control103CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Base__Control107CaptionLbl: Label 'Total';
        VATAmountLine__VAT_Base_CaptionLbl: Label 'Continued';
        VATAmountLine__VAT_Identifier_CaptionLbl: Label 'VAT Identifier';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        Vendor_RefCaptionLbl: Label 'Vendor Ref';
        CopyText: Text[30];
        FooterLabel: array[20] of Text[30];
        HeaderLabel: array[20] of Text[30];
        PurchaserText: Text[30];
        ref_fourn: Text[30];
        ReferenceText: Text[30];
        VATNoText: Text[30];
        BuyFromAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        TotalText: Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        DimText: Text[120];
        FooterTxt: array[20] of Text[120];
        HeaderTxt: array[20] of Text[120];

    procedure PrepareHeader()
    begin

        FormatAddr.PurchHeaderBuyFrom(VendAddr, "Purchase Header");

        IF SalesPurchPerson.GET("Purchase Header"."Purchaser Code") THEN BEGIN
            HeaderLabel[2] := ML_PurchPerson;
            HeaderTxt[2] := SalesPurchPerson.Name;
        END;

        IF "Purchase Header"."Your Reference" <> '' THEN BEGIN
            HeaderLabel[3] := ML_Reference;
            HeaderTxt[3] := "Purchase Header"."Your Reference";
        END;

        COMPRESSARRAY(HeaderLabel);
        COMPRESSARRAY(HeaderTxt);

        CompanyInfo.CALCFIELDS(Picture);
    end;

    procedure PrepareFooter()
    var
        transitaire_Re_Loc: Record "DEL Forwarding agent 2";
        PmtMethod: Record "Payment Terms";
        ShipMethod: Record "Shipment Method";
    begin
        CLEAR(FooterLabel);
        CLEAR(FooterTxt);

        IF PmtMethod.GET("Purchase Header"."Payment Terms Code") THEN BEGIN
            FooterLabel[1] := ML_PmtTerms;
            FooterTxt[1] := PmtMethod.Description;
        END;

        IF ShipMethod.GET("Purchase Header"."Shipment Method Code") THEN BEGIN
            FooterLabel[2] := ML_ShipCond;
            FooterTxt[2] := ShipMethod.Description;
        END;

        IF "Purchase Header"."DEL Forwarding Agent Code" <> '' THEN BEGIN
            IF transitaire_Re_Loc.GET("Purchase Header"."DEL Forwarding Agent Code") THEN BEGIN
                FooterLabel[3] := ML_Forwarder;
                FooterTxt[3] := transitaire_Re_Loc.Description;
            END;
        END;
        IF "Purchase Header"."Location Code" <> '' THEN BEGIN
            FooterLabel[4] := ML_Location_code;
            FooterTxt[4] := "Purchase Header"."Location Code";
        END;
        IF FORMAT("Purchase Header"."DEL Ship Per") <> '' THEN BEGIN
            FooterLabel[5] := ML_Method;
            FooterTxt[5] := FORMAT("Purchase Header"."DEL Ship Per");
        END;

        IF FORMAT("Purchase Header"."Requested Receipt Date") <> '' THEN BEGIN
            FooterLabel[6] := ML_Date_Receipt;
            FooterTxt[6] := FORMAT("Purchase Header"."Requested Receipt Date");
        END;

        IF "Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No." THEN BEGIN
            FooterLabel[7] := ML_InvAdr;
            FooterTxt[7] := "Purchase Header"."Pay-to Name" + ', ' + "Purchase Header"."Pay-to City";
            FooterLabel[8] := ML_OrderAdr;
            FooterTxt[8] := "Purchase Header"."Buy-from Vendor Name" + ', ' + "Purchase Header"."Buy-from City";
        END;


        IF NOT ("Purchase Header"."Expected Receipt Date" IN ["Purchase Header"."Document Date", 0D]) THEN BEGIN
            FooterLabel[9] := ML_ShipDate;
            FooterTxt[9] := FORMAT("Purchase Header"."Expected Receipt Date", 0, 4);
        END;

        COMPRESSARRAY(FooterLabel);
        COMPRESSARRAY(FooterTxt);
    end;
}

