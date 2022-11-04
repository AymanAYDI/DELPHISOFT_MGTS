report 50071 "DEL Sales - Shipment"  //208
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/SalesShipment.rdlc';

    Caption = 'Sales - Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
            column(No_SalesShptHeader; "No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfoFAX; CompanyInfo."Fax No.")
                    {
                    }
                    column(CaptionFax; CompanyInfo.FIELDCAPTION(CompanyInfo."Fax No."))
                    {
                    }
                    column(SalesShptCopyText; STRSUBSTNO(Text002, CopyText))
                    {
                    }
                    column(CaptionAffaire; CaptionAffaire)
                    {
                    }
                    column(Affaire; "Sales Shipment Line"."Shortcut Dimension 1 Code")
                    {
                    }
                    column(ShipToAddr1; ShipToAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(ShipToAddr2; ShipToAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(ShipToAddr3; ShipToAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(ShipToAddr4; ShipToAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(ShipToAddr5; ShipToAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(ShipToAddr6; ShipToAddr[6])
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(SelltoCustNo_SalesShptHeader; "Sales Shipment Header"."Sell-to Customer No.")
                    {
                    }
                    column(DocDate_SalesShptHeader; FORMAT("Sales Shipment Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                    {
                    }
                    column(ShipToAddr7; ShipToAddr[7])
                    {
                    }
                    column(ShipToAddr8; ShipToAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(ItemTrackingAppendixCaption; ItemTrackingAppendixCaptionLbl)
                    {
                    }
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
                    {
                    }
                    column(DocumentDateCaption; DocumentDateCaptionLbl)
                    {
                    }
                    column(SelltoCustNo_SalesShptHeaderCaption; "Sales Shipment Header".FIELDCAPTION("Sell-to Customer No."))
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
                    column(CompanyInfoRegNo; CompanyInfo."Registration No.")
                    {
                    }
                    column(CompanyInfoRegNoCaption; CompanyInfoRegNoCaptionLbl)
                    {
                    }
                    column(CustomerNoCaption; CustomerNoCaptionLbl)
                    {
                    }
                    column(BilAdr1; BilAdr[1])
                    {
                    }
                    column(BilAdr2; BilAdr[2])
                    {
                    }
                    column(BilAdr3; BilAdr[3])
                    {
                    }
                    column(BilAdr4; BilAdr[4])
                    {
                    }
                    column(BilAdr5; BilAdr[5])
                    {
                    }
                    column(BilAdr21; BilAdr2[1])
                    {
                    }
                    column(BilAdr22; BilAdr2[2])
                    {
                    }
                    column(OrderNo; "Sales Shipment Header"."Order No.")
                    {
                    }
                    column(ExternalDocumentNo; "Sales Shipment Header"."External Document No.")
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
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
                                    DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1; %2 - %3', DimText,
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
                    dataitem("Sales Shipment Line"; "Sales Shipment Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Shipment Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(Description_SalesShptLine; Description)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(ShowCorrectionLines; ShowCorrectionLines)
                        {
                        }
                        column(Type_SalesShptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(AsmHeaderExists; AsmHeaderExists)
                        {
                        }
                        column(DocumentNo_SalesShptLine; "Document No.")
                        {
                        }
                        column(LinNo; LinNo)
                        {
                        }
                        column(Qty_SalesShptLine; Quantity)
                        {
                        }
                        column(UOM_SalesShptLine; "Unit of Measure")
                        {
                        }
                        column(No_SalesShptLine; "No.")
                        {
                        }
                        column(LineNo_SalesShptLine; "Line No.")
                        {
                        }
                        column(UnitPrice_SalesShptLine; "Unit Price")
                        {
                        }
                        column(Description_SalesShptLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(Qty_SalesShptLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesShptLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(No_SalesShptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(UnitPrice_SalesShptLineCaption; FIELDCAPTION("Unit Price"))
                        {
                        }
                        column(NewPageGroupNo; NewPageGroupNo)
                        {
                        }
                        column(NewPageLine; NewPageLine)
                        {
                        }
                        column(GrossWeight; "Gross Weight")
                        {
                        }
                        column(NetWeight; "Net Weight")
                        {
                        }
                        column(Volcbmcartontransport; Item_Rec."DEL Vol cbm carton transport")
                        {
                        }
                        column(Volcbm; Item_Rec.GetVolCBM(TRUE))
                        {
                        }
                        column(CrossReference; "Item Reference No.")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
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
                                        DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1; %2 - %3', DimText,
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
                            end;
                        }
                        dataitem(DisplayAsmInfo; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(PostedAsmLineItemNo; BlanksForIndent() + PostedAsmLine."No.")
                            {
                            }
                            column(PostedAsmLineDescription; BlanksForIndent() + PostedAsmLine.Description)
                            {
                            }
                            column(PostedAsmLineQuantity; PostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(PostedAsmLineUOMCode; GetUnitOfMeasureDescr(PostedAsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                IF Number = 1 THEN
                                    PostedAsmLine.FINDSET()
                                ELSE
                                    PostedAsmLine.NEXT();

                                IF ItemTranslation.GET(PostedAsmLine."No.",
                                     PostedAsmLine."Variant Code",
                                     "Sales Shipment Header"."Language Code")
                                THEN
                                    PostedAsmLine.Description := ItemTranslation.Description;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK();
                                IF NOT AsmHeaderExists THEN
                                    CurrReport.BREAK();

                                PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                                SETRANGE(Number, 1, PostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            LinNo := "Line No.";
                            IF NOT ShowCorrectionLines AND Correction THEN
                                CurrReport.SKIP();
                            //DEL.SAZ
                            IF (("Sales Shipment Line".Type = "Sales Shipment Line".Type::Item) OR ("Sales Shipment Line".Type = "Sales Shipment Line".Type::"G/L Account"))
                              AND ("Sales Shipment Line".Quantity = 0) THEN
                                CurrReport.SKIP();

                            IF Item_Rec.GET("Sales Shipment Line"."No.") THEN;
                            //EDN DELsaz
                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                            IF DisplayAssemblyInformation THEN
                                AsmHeaderExists := AsmToShipmentExists(PostedAsmHeader);

                            NewPageLine := Type = Type::"New Page";
                            IF NewPageLine THEN
                                NewPageGroupNo += 1;
                        end;

                        trigger OnPostDataItem()
                        begin
                            IF ShowLotSN THEN BEGIN
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(TRUE);
                                TrackingSpecCount :=
                                  ItemTrackingDocMgt.RetrieveDocumentItemTracking(temp_TrackingSpecBuffer,
                                    "Sales Shipment Header"."No.", DATABASE::"Sales Shipment Header", 0);
                                ItemTrackingDocMgt.SetRetrieveAsmItemTracking(FALSE);
                            END;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");

                            NewPageLine := FALSE;
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

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowCustAddr THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(ItemTrackingLine; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(TrackingSpecBufferNo; temp_TrackingSpecBuffer."Item No.")
                        {
                        }
                        column(TrackingSpecBufferDesc; temp_TrackingSpecBuffer.Description)
                        {
                        }
                        column(TrackingSpecBufferLotNo; temp_TrackingSpecBuffer."Lot No.")
                        {
                        }
                        column(TrackingSpecBufferSerNo; temp_TrackingSpecBuffer."Serial No.")
                        {
                        }
                        column(TrackingSpecBufferQty; temp_TrackingSpecBuffer."Quantity (Base)")
                        {
                        }
                        column(ShowTotal; ShowTotal)
                        {
                        }
                        column(ShowGroup; ShowGroup)
                        {
                        }
                        column(QuantityCaption; QuantityCaptionLbl)
                        {
                        }
                        column(SerialNoCaption; SerialNoCaptionLbl)
                        {
                        }
                        column(LotNoCaption; LotNoCaptionLbl)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(NoCaption; NoCaptionLbl)
                        {
                        }
                        dataitem(TotalItemTracking; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = CONST(1));
                            column(Quantity1; TotalQty)
                            {
                            }
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                temp_TrackingSpecBuffer.FINDSET()
                            ELSE
                                temp_TrackingSpecBuffer.NEXT();

                            IF NOT ShowCorrectionLines AND temp_TrackingSpecBuffer.Correction THEN
                                CurrReport.SKIP();
                            IF temp_TrackingSpecBuffer.Correction THEN
                                temp_TrackingSpecBuffer."Quantity (Base)" := -temp_TrackingSpecBuffer."Quantity (Base)";

                            ShowTotal := FALSE;
                            IF ItemTrackingAppendix.IsStartNewGroup(temp_TrackingSpecBuffer) THEN
                                ShowTotal := TRUE;

                            ShowGroup := FALSE;
                            IF (temp_TrackingSpecBuffer."Source Ref. No." <> OldRefNo) OR
                               (temp_TrackingSpecBuffer."Item No." <> OldNo)
                            THEN BEGIN
                                OldRefNo := temp_TrackingSpecBuffer."Source Ref. No.";
                                OldNo := temp_TrackingSpecBuffer."Item No.";
                                TotalQty := 0;
                            END ELSE
                                ShowGroup := TRUE;
                            TotalQty += temp_TrackingSpecBuffer."Quantity (Base)";
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF TrackingSpecCount = 0 THEN
                                CurrReport.BREAK();
                            CurrReport.NEWPAGE();
                            SETRANGE(Number, 1, TrackingSpecCount);
                            temp_TrackingSpecBuffer.SETCURRENTKEY("Source ID", "Source Type", "Source Subtype", "Source Batch Name",
                              "Source Prod. Order Line", "Source Ref. No.");
                        end;
                    }

                    trigger OnPreDataItem()
                    begin
                        // Item Tracking:
                        IF ShowLotSN THEN BEGIN
                            TrackingSpecCount := 0;
                            OldRefNo := 0;
                            ShowGroup := FALSE;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                    TotalQty := 0;           // Item Tracking
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        CODEUNIT.RUN(CODEUNIT::"Sales Shpt.-Printed", "Sales Shipment Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := 1 + ABS(NoOfCopies);
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                PrepareHeader();
                PrepareFooter();

                FormatAddressFields("Sales Shipment Header");
                FormatDocumentFields("Sales Shipment Header");

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');
                ShiptoAddress_Rec.SETRANGE(Code, "Sales Shipment Header"."Ship-to Code");
                IF ShiptoAddress_Rec.FINDFIRST() THEN BEGIN
                    BilAdr[1] := ShiptoAddress_Rec.Name;
                    BilAdr[2] := ShiptoAddress_Rec."Name 2";
                    BilAdr[3] := ShiptoAddress_Rec.Address;
                    BilAdr[4] := ShiptoAddress_Rec."Address 2";
                    BilAdr[5] := ShiptoAddress_Rec."Country/Region Code" + ' ' + ShiptoAddress_Rec.City;
                END;
                COMPRESSARRAY(BilAdr);
                BilAdr2[1] := "Sales Shipment Header"."Bill-to Name";
                BilAdr2[2] := "Sales Shipment Header"."Bill-to Contact";

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
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field("Show Correction Lines"; ShowCorrectionLines)
                    {
                        Caption = 'Show Correction Lines';
                    }
                    field(ShowLotSN; ShowLotSN)
                    {
                        Caption = 'Show Serial/Lot Number Appendix';
                    }
                    field(DisplayAsmInfo; DisplayAssemblyInformation)
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
            InitLogInteraction();
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInfo.GET();
        SalesSetup.GET();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction();
        AsmHeaderExists := FALSE;
    end;

    var
        Language: Record Language;
        SalesPurchPerson: Record "Salesperson/Purchaser";
        Item_Rec: Record Item;
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        ShiptoAddress_Rec: Record "Ship-to Address";
        SalesSetup: Record "Sales & Receivables Setup";
        temp_TrackingSpecBuffer: Record "Tracking Specification" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        RespCenter: Record "Responsibility Center";
        ItemTrackingAppendix: Report "Item Tracking Appendix";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        AsmHeaderExists: Boolean;
        Continue: Boolean;
        DisplayAssemblyInformation: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        NewPageLine: Boolean;
        ShowCorrectionLines: Boolean;
        ShowCustAddr: Boolean;
        ShowGroup: Boolean;
        ShowInternalInfo: Boolean;
        ShowLotSN: Boolean;
        ShowTotal: Boolean;
        OldNo: Code[20];
        TotalQty: Decimal;
        InnerGroupNo: Integer;
        LinNo: Integer;
        NewPageGroupNo: Integer;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OldRefNo: Integer;
        OutputNo: Integer;
        TotalPageNo: Integer;
        TrackingSpecCount: Integer;
        CaptionAffaire: Label 'ACO (affaire)';
        CompanyInfoRegNoCaptionLbl: Label 'Reg. No.';
        CustomerNoCaptionLbl: Label 'Customer No.';
        DescriptionCaptionLbl: Label 'Description';
        DocumentDateCaptionLbl: Label 'Document Date';
        EmailCaptionLbl: Label 'Email';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        HomePageCaptionLbl: Label 'Home Page';
        ItemTrackingAppendixCaptionLbl: Label 'Item Tracking - Appendix';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        LotNoCaptionLbl: Label 'Lot No.';
        ML_ApplyToDoc: Label 'Refers to Document';
        ML_InvAdr: Label 'Invoice Address';
        ML_OrderAdr: Label 'Order Address';
        ML_PmtTerms: Label 'Payment Terms';
        ML_Reference: Label 'Reference';
        ML_SalesPerson: Label 'Salesperson';
        ML_ShipAdr: Label 'Shipping Address';
        ML_ShipCond: Label 'Shipping Conditions';
        ML_ShipDate: Label 'Shipping Date';
        NoCaptionLbl: Label 'No.';
        PhoneNoCaptionLbl: Label 'Phone No.';
        QuantityCaptionLbl: Label 'Quantity';
        SerialNoCaptionLbl: Label 'Serial No.';
        Text002: Label 'Sales - Shipment %1', Comment = '%1 = Document No.';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        BilAdr: array[5] of Text;
        BilAdr2: array[5] of Text;
        SalesPersonText: Text[20];
        CopyText: Text[30];
        FooterLabel: array[20] of Text[30];
        HeaderLabel: array[20] of Text[30];
        CompanyAddr: array[8] of Text[50];
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        DimText: Text[120];
        FooterTxt: array[20] of Text[120];
        HeaderTxt: array[20] of Text[120];


    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(5) <> '';
    end;


    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean; NewShowLotSN: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
        ShowLotSN := NewShowLotSN;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    local procedure FormatAddressFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatAddr.GetCompanyAddr(SalesShipmentHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesShptShipTo(ShipToAddr, SalesShipmentHeader);
        ShowCustAddr := FormatAddr.SalesShptBillTo(CustAddr, ShipToAddr, SalesShipmentHeader);
    end;

    local procedure FormatDocumentFields(SalesShipmentHeader: Record "Sales Shipment Header")
    begin
        FormatDocument.SetSalesPerson(SalesPurchPerson, SalesShipmentHeader."Salesperson Code", SalesPersonText);
        ReferenceText := FormatDocument.SetText(SalesShipmentHeader."Your Reference" <> '', SalesShipmentHeader.FIELDCAPTION("Your Reference"));
    end;

    local procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;


    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;


    procedure PrepareHeader()
    begin
        CLEAR(HeaderLabel);
        CLEAR(HeaderTxt);

        FormatAddr.SalesShptShipTo(CustAddr, "Sales Shipment Header");

        IF SalesPurchPerson.GET("Sales Shipment Header"."Salesperson Code") THEN BEGIN
            HeaderLabel[2] := ML_SalesPerson;
            HeaderTxt[2] := SalesPurchPerson.Name;
        END;

        IF "Sales Shipment Header"."Your Reference" <> '' THEN BEGIN
            HeaderLabel[3] := ML_Reference;
            HeaderTxt[3] := "Sales Shipment Header"."Your Reference";
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

        IF PmtMethod.GET("Sales Shipment Header"."Payment Terms Code") THEN BEGIN
            FooterLabel[1] := ML_PmtTerms;
            PmtMethod.TranslateDescription(PmtMethod, "Sales Shipment Header"."Language Code");
            FooterTxt[1] := PmtMethod.Description;
        END;

        // Application no for credit memos
        IF "Sales Shipment Header"."Applies-to Doc. No." <> '' THEN BEGIN
            FooterLabel[2] := ML_ApplyToDoc;
            FooterTxt[2] := FORMAT("Sales Shipment Header"."Applies-to Doc. Type") + ' ' + "Sales Shipment Header"."Applies-to Doc. No.";
        END;

        // Shipping Conditions
        IF ShipMethod.GET("Sales Shipment Header"."Shipment Method Code") THEN BEGIN
            FooterLabel[3] := ML_ShipCond;
            ShipMethod.TranslateDescription(ShipMethod, "Sales Shipment Header"."Language Code");
            FooterTxt[3] := ShipMethod.Description;
        END;

        // Shipping Address
        IF "Sales Shipment Header"."Ship-to Code" <> '' THEN BEGIN
            FooterLabel[4] := ML_ShipAdr;
            FooterTxt[4] := "Sales Shipment Header"."Ship-to Name" + ' ' + "Sales Shipment Header"."Ship-to City";
        END;

        // Invoice and Order Address
        IF "Sales Shipment Header"."Sell-to Customer No." <> "Sales Shipment Header"."Bill-to Customer No." THEN BEGIN
            FooterLabel[5] := ML_InvAdr;
            FooterTxt[5] := "Sales Shipment Header"."Bill-to Name" + ', ' + "Sales Shipment Header"."Bill-to City";
            FooterLabel[6] := ML_OrderAdr;
            FooterTxt[6] := "Sales Shipment Header"."Sell-to Customer Name" + ', ' + "Sales Shipment Header"."Sell-to City";
        END;

        // Shipping Date if <> Document Date
        IF ("Sales Shipment Header"."Shipment Date" <> "Sales Shipment Header"."Document Date") AND ("Sales Shipment Header"."Shipment Date" <> 0D) THEN BEGIN
            FooterLabel[7] := ML_ShipDate;
            FooterTxt[7] := FORMAT("Sales Shipment Header"."Shipment Date", 0, 4);
        END;

        TotalPageNo += 1;
        InnerGroupNo := 1;

        COMPRESSARRAY(FooterLabel);
        COMPRESSARRAY(FooterTxt);
    end;
}

