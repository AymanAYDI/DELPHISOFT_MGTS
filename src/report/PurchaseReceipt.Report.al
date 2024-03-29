report 50082 "DEL Purchase - Receipt" //408
{
    Caption = 'Purchase - Receipt';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/PurchaseReceipt.rdlc';

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Purchase Receipt';
            column(No_PurchRcptHeader; "No.")
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(DescCaption; DescCaptionLbl)
            {
            }
            column(QtyCaption; QtyCaptionLbl)
            {
            }
            column(UOMCaption; UOMCaptionLbl)
            {
            }
            column(PaytoVenNoCaption; Caption_client)
            {
            }
            column(EmailCaption; EmailCaptionLbl)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CurrentReportPageNo; STRSUBSTNO(Text003, ''))
                    {
                    }
                    column(PurchRcptCopyText1; STRSUBSTNO(Text11500, CopyText))
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
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(DocDate_PurchRcptHeader; FORMAT("Purch. Rcpt. Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(No1_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_PurchRcptHeader; "Purch. Rcpt. Header"."Your Reference")
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
                    column(PhoneNoCaption; PhoneNoCaptionLbl)
                    {
                    }
                    column(FaxNoCaption; FaxNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionLbl)
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankNameCaption; BankNameCaptionLbl)
                    {
                    }
                    column(AccNoCaption; AccNoCaptionLbl)
                    {
                    }
                    column(ShipmentNoCaption; ShipmentNoCaptionLbl)
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
                    column(PayToVendNo_PurchRcptHeader; "Purch. Rcpt. Header"."Pay-to Vendor No.")
                    {
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
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
                    dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Purch. Rcpt. Header";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(Type_PurchRcptLine; FORMAT(Type, 0, 2))
                        {
                        }
                        column(Desc_PurchRcptLine; Description)
                        {
                            IncludeCaption = false;
                        }
                        column(Qty_PurchRcptLine; Quantity)
                        {
                            IncludeCaption = false;
                        }
                        column(UOM_PurchRcptLine; "Unit of Measure")
                        {
                            IncludeCaption = false;
                        }
                        column(No_PurchRcptLine; "No.")
                        {
                        }
                        column(DocNo_PurchRcptLine; "Document No.")
                        {
                        }
                        column(LineNo_PurchRcptLine; "Line No.")
                        {
                            IncludeCaption = false;
                        }
                        column(PageNo2; CurrReport.PAGENO())
                        {
                        }
                        column(No_PurchRcptLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(Number_IntegerLine; DimensionLoop2.Number)
                            {
                            }
                            column(DimText1; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
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

                        trigger OnAfterGetRecord()
                        begin
                            IF (NOT ShowCorrectionLines) AND Correction THEN
                                CurrReport.SKIP();

                            DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK();
                            SETRANGE("Line No.", 0, "Line No.");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(BuyfromVenNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
                        {
                        }
                        column(BuyfromVenNo_PurchRcptHeaderCaption; "Purch. Rcpt. Header".FIELDCAPTION("Buy-from Vendor No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF "Purch. Rcpt. Header"."Buy-from Vendor No." = "Purch. Rcpt. Header"."Pay-to Vendor No." THEN
                                CurrReport.BREAK();
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PaytoVenNo_PurchRcptHeader; Caption_client)
                        {
                        }
                        column(VendAddr1; VendAddr[1])
                        {
                        }
                        column(VendAddr2; VendAddr[2])
                        {
                        }
                        column(VendAddr3; VendAddr[3])
                        {
                        }
                        column(VendAddr4; VendAddr[4])
                        {
                        }
                        column(VendAddr5; VendAddr[5])
                        {
                        }
                        column(VendAddr6; VendAddr[6])
                        {
                        }
                        column(VendAddr7; VendAddr[7])
                        {
                        }
                        column(VendAddr8; VendAddr[8])
                        {
                        }
                        column(PaytoAddrCaption; PaytoAddrCaptionLbl)
                        {
                        }
                        column(PaytoVenNo_PurchRcptHeaderCaption; Caption_client)
                        {
                        }
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text001;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        RcptCountPrinted.RUN("Purch. Rcpt. Header");
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
                CurrReport.LANGUAGE := LanguageCdu.GetLanguageID("Language Code");

                LCO_Element.SETRANGE("Type No.", "Purch. Rcpt. Header"."Order No.");
                LCO_Element.SETRANGE(Type, LCO_Element.Type::ACO);

                IF LCO_Element.FIND('-') THEN BEGIN
                    LCO_Deal_ID := LCO_Element.Deal_ID;
                    LCO_P_Order_No := LCO_Element."Type No.";
                END;

                LCO_DealShipment.SETRANGE(LCO_DealShipment.Deal_ID, LCO_Deal_ID);
                IF LCO_DealShipment.FIND('-') THEN BEGIN
                    LCO_Shipment := LCO_DealShipment.ID
                END;


                PrepareHeader();
                PrepareFooter();

                CompanyInfo.GET();


                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

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
                FormatAddr.PurchRcptShipTo(ShipToAddr, "Purch. Rcpt. Header");

                FormatAddr.PurchRcptPayTo(VendAddr, "Purch. Rcpt. Header");

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        SegManagement.LogDocument(
                          15, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');
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
                    field(ShowCorrectionLines; ShowCorrectionLines)
                    {
                        Caption = 'Show Correction Lines';
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
            LogInteraction := SegManagement.FindInteractTmplCode(15) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        LCO_DealShipment: Record "DEL Deal Shipment";
        LCO_Element: Record "DEL Element";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language: Record Language;
        RespCenter: Record "Responsibility Center";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        FormatAddr: Codeunit "Format Address";

        LanguageCdu: Codeunit Language;

        RcptCountPrinted: Codeunit "Purch.Rcpt.-Printed";
        SegManagement: Codeunit SegManagement;
        Continue: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        MoreLines: Boolean;
        ShowCorrectionLines: Boolean;
        ShowInternalInfo: Boolean;
        LCO_Deal_ID: Code[10];
        LCO_P_Order_No: Code[10];
        LCO_Shipment: Code[20];
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        OutputNo: Integer;
        AccNoCaptionLbl: Label 'Account No.';
        BankNameCaptionLbl: Label 'Bank';
        Caption_client: Label 'Customer No.';
        DescCaptionLbl: Label 'Description';
        DocDateCaptionLbl: Label 'Date';
        EmailCaptionLbl: Label 'E-Mail';
        FaxNoCaptionLbl: Label 'Fax No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        HomePageCaptionLbl: Label 'Home Page';
        LineDimCaptionLbl: Label 'Line Dimensions';
        ML_AFFNo: Label 'N° Affaire / Shipment';
        ML_InvAdr: Label 'Invoice Address';
        ML_OrderAdr: Label 'Order Address';
        ML_PmtTerms: Label 'Payment Terms';
        ML_POrder: Label 'N° ACO';
        ML_PurchPerson: Label 'Purchaser';
        ML_Reference: Label 'Reference';
        ML_ShipAdr: Label 'Shipping Address';
        ML_ShipCond: Label 'Shipping Conditions';
        ML_ShipDate: Label 'Shipping Date';
        PageCaptionLbl: Label 'Page';
        PaytoAddrCaptionLbl: Label 'Pay-to Address';
        PhoneNoCaptionLbl: Label 'Phone No.';
        QtyCaptionLbl: Label 'Quantity';
        ShipmentNoCaptionLbl: Label 'Shipment No.';

        Text000: Label 'Purchaser';
        Text001: Label 'COPY';
        Text003: Label 'Page %1';
        Text11500: Label 'Receipt %1';
        UOMCaptionLbl: Label 'Unit Of Measure';
        VATRegNoCaptionLbl: Label 'VAT Reg. No.';
        CopyText: Text[30];
        FooterLabel: array[20] of Text[30];
        HeaderLabel: array[20] of Text[30];
        PurchaserText: Text[30];
        CompanyAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        VendAddr: array[8] of Text[50];
        OldDimText: Text[75];
        ReferenceText: Text[80];
        DimText: Text[120];
        FooterTxt: array[20] of Text[120];
        HeaderTxt: array[20] of Text[120];

    procedure PrepareHeader()
    begin
        CLEAR(HeaderLabel);
        CLEAR(HeaderTxt);

        FormatAddr.PurchRcptShipTo(VendAddr, "Purch. Rcpt. Header");

        IF SalesPurchPerson.GET("Purch. Rcpt. Header"."Purchaser Code") THEN BEGIN
            HeaderLabel[3] := ML_PurchPerson;
            HeaderTxt[3] := SalesPurchPerson.Name;
        END;

        IF "Purch. Rcpt. Header"."Your Reference" <> '' THEN BEGIN
            HeaderLabel[4] := ML_Reference;
            HeaderTxt[4] := "Purch. Rcpt. Header"."Your Reference";
        END;

        HeaderLabel[5] := ML_POrder;
        HeaderTxt[5] := "Purch. Rcpt. Header"."Order No.";

        HeaderLabel[6] := ML_AFFNo;
        HeaderTxt[6] := LCO_Deal_ID + ' / ' + LCO_Shipment;


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

        IF PmtMethod.GET("Purch. Rcpt. Header"."Payment Terms Code") THEN BEGIN
            FooterLabel[1] := ML_PmtTerms;
            PmtMethod.TranslateDescription(PmtMethod, "Purch. Rcpt. Header"."Language Code");
            FooterTxt[1] := PmtMethod.Description;
        END;

        // Shipping Conditions
        IF ShipMethod.GET("Purch. Rcpt. Header"."Shipment Method Code") THEN BEGIN
            FooterLabel[2] := ML_ShipCond;
            ShipMethod.TranslateDescription(ShipMethod, "Purch. Rcpt. Header"."Language Code");
            FooterTxt[2] := ShipMethod.Description;
        END;

        // Shipping Address
        IF "Purch. Rcpt. Header"."Ship-to Code" <> '' THEN BEGIN
            FooterLabel[3] := ML_ShipAdr;
            FooterTxt[3] := "Purch. Rcpt. Header"."Ship-to Name" + ' ' + "Purch. Rcpt. Header"."Ship-to City";
        END;

        // Invoice and Order Address
        IF "Purch. Rcpt. Header"."Buy-from Vendor No." <> "Purch. Rcpt. Header"."Pay-to Vendor No." THEN BEGIN
            FooterLabel[4] := ML_InvAdr;
            FooterTxt[4] := "Purch. Rcpt. Header"."Pay-to Name" + ', ' + "Purch. Rcpt. Header"."Pay-to City";
            FooterLabel[5] := ML_OrderAdr;
            FooterTxt[5] := "Purch. Rcpt. Header"."Buy-from Vendor Name" + ', ' + "Purch. Rcpt. Header"."Buy-from City";
        END;

        // Shipping Date if <> Document Date
        IF NOT ("Purch. Rcpt. Header"."Expected Receipt Date" IN ["Purch. Rcpt. Header"."Document Date", 0D]) THEN BEGIN
            FooterLabel[6] := ML_ShipDate;
            FooterTxt[6] := FORMAT("Purch. Rcpt. Header"."Expected Receipt Date", 0, 4);
        END;

        FooterLabel[6] := ML_ShipDate;
        FooterTxt[6] := FORMAT("Purch. Rcpt. Header"."Expected Receipt Date", 0, 4);

        // Remove the useless value of FooterLabel[8] and FooterTxt[8]
        // which make the wrong format of the section, set a ' ' value to shipping date if
        // it's null to make sure the format is correct in RTC.
        IF FORMAT("Purch. Rcpt. Header"."Expected Receipt Date", 0, 4) = '' THEN BEGIN
            FooterTxt[6] := ' ';
        END;

        FooterLabel[8] := '';
        FooterTxt[8] := '';

        COMPRESSARRAY(FooterLabel);
        COMPRESSARRAY(FooterTxt);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        ShowCorrectionLines := NewShowCorrectionLines;
    end;
}

