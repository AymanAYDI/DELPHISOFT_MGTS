report 50010 "Suggest Purch Price on Wksh."
{
    // NGTS/LOCO/GRC 13.03.09 create report

    Caption = 'Suggest Purchase Price on Wksh.';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem3889; Table7012)
        {
            DataItemTableView = SORTING (Item No.);
            RequestFilterFields = "Item No.", "Currency Code", "Starting Date";

            trigger OnAfterGetRecord()
            begin


                IF Item."No." <> "Item No." THEN BEGIN
                    Item.GET("Item No.");
                    Window.UPDATE(1, "Item No.");
                END;

                ReplacePurchCode := NOT ("Vendor No." = ToPurchCode);

                //IF (ToSalesCode = '') AND (ToSalesType <> ToSalesType::"All Customers") THEN
                //  ERROR(Text002,"Sales Type");

                CLEAR(PurchPriceWksh);

                //PurchPriceWksh.VALIDATE("Sales Type",ToSalesType);

                IF NOT ReplacePurchCode THEN
                    PurchPriceWksh.VALIDATE("Vendor No.", "Vendor No.")
                ELSE
                    PurchPriceWksh.VALIDATE("Vendor No.", ToPurchCode);

                PurchPriceWksh.VALIDATE("Item No.", "Item No.");
                PurchPriceWksh."New Unit Price" := "Direct Unit Cost";
                PurchPriceWksh."Minimum Quantity" := "Minimum Quantity";

                PurchPriceWksh."Qty. optimale" := "Purchase Price"."Qty. optimale";

                IF NOT ReplaceUnitOfMeasure THEN
                    PurchPriceWksh."Unit of Measure Code" := "Unit of Measure Code"
                ELSE BEGIN
                    PurchPriceWksh."Unit of Measure Code" := ToUnitOfMeasure.Code;
                    IF NOT (PurchPriceWksh."Unit of Measure Code" IN ['', Item."Base Unit of Measure"]) THEN
                        IF NOT ItemUnitOfMeasure.GET("Item No.", PurchPriceWksh."Unit of Measure Code") THEN
                            CurrReport.SKIP;
                    PurchPriceWksh."New Unit Price" :=
                      PurchPriceWksh."New Unit Price" *
                      UOMMgt.GetQtyPerUnitOfMeasure(Item, PurchPriceWksh."Unit of Measure Code") /
                      UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code");
                END;
                PurchPriceWksh.VALIDATE("Unit of Measure Code");
                PurchPriceWksh.VALIDATE("Variant Code", "Variant Code");

                IF NOT ReplaceCurrency THEN
                    PurchPriceWksh."Currency Code" := "Currency Code"
                ELSE
                    PurchPriceWksh."Currency Code" := ToCurrency.Code;

                IF NOT ReplaceStartingDate THEN
                    PurchPriceWksh.VALIDATE("Starting Date", "Starting Date")
                ELSE
                    PurchPriceWksh.VALIDATE("Starting Date", ToStartDate);
                IF NOT ReplaceEndingDate THEN
                    PurchPriceWksh.VALIDATE("Ending Date", "Ending Date")
                ELSE
                    PurchPriceWksh.VALIDATE("Ending Date", ToEndDate);

                IF "Currency Code" <> PurchPriceWksh."Currency Code" THEN BEGIN
                    IF "Currency Code" <> '' THEN BEGIN
                        FromCurrency.GET("Currency Code");
                        FromCurrency.TESTFIELD(Code);
                        PurchPriceWksh."New Unit Price" :=
                          CurrExchRate.ExchangeAmtFCYToLCY(
                            WORKDATE, "Currency Code", PurchPriceWksh."New Unit Price",
                            CurrExchRate.ExchangeRate(
                              WORKDATE, "Currency Code"));
                    END;
                    IF PurchPriceWksh."Currency Code" <> '' THEN
                        PurchPriceWksh."New Unit Price" :=
                          CurrExchRate.ExchangeAmtLCYToFCY(
                            WORKDATE, PurchPriceWksh."Currency Code",
                            PurchPriceWksh."New Unit Price", CurrExchRate.ExchangeRate(
                              WORKDATE, PurchPriceWksh."Currency Code"));
                END;

                IF PurchPriceWksh."Currency Code" = '' THEN
                    Currency2.InitRoundingPrecision
                ELSE BEGIN
                    Currency2.GET(PurchPriceWksh."Currency Code");
                    Currency2.TESTFIELD("Unit-Amount Rounding Precision");
                END;
                PurchPriceWksh."New Unit Price" :=
                  ROUND(PurchPriceWksh."New Unit Price", Currency2."Unit-Amount Rounding Precision");

                IF PurchPriceWksh."New Unit Price" > PriceLowerLimit THEN
                    PurchPriceWksh."New Unit Price" := PurchPriceWksh."New Unit Price" * UnitPriceFactor;
                IF RoundingMethod.Code <> '' THEN BEGIN
                    RoundingMethod."Minimum Amount" := PurchPriceWksh."New Unit Price";
                    IF RoundingMethod.FIND('=<') THEN BEGIN
                        PurchPriceWksh."New Unit Price" :=
                          PurchPriceWksh."New Unit Price" + RoundingMethod."Amount Added Before";
                        IF RoundingMethod.Precision > 0 THEN
                            PurchPriceWksh."New Unit Price" :=
                              ROUND(
                                PurchPriceWksh."New Unit Price",
                                RoundingMethod.Precision, COPYSTR('=><', RoundingMethod.Type + 1, 1));
                        PurchPriceWksh."New Unit Price" := PurchPriceWksh."New Unit Price" +
                          RoundingMethod."Amount Added After";
                    END;
                END;

                //SalesPriceWksh."Price Includes VAT" := "Price Includes VAT";
                //SalesPriceWksh."VAT Bus. Posting Gr. (Price)" := "VAT Bus. Posting Gr. (Price)";
                //SalesPriceWksh."Allow Invoice Disc." := "Allow Invoice Disc.";
                //SalesPriceWksh."Allow Line Disc." := "Allow Line Disc.";
                PurchPriceWksh.CalcCurrentPrice(PriceAlreadyExists);

                IF PriceAlreadyExists OR CreateNewPrices THEN BEGIN
                    PurchPriceWksh2 := PurchPriceWksh;
                    IF PurchPriceWksh2.FIND('=') THEN
                        PurchPriceWksh.MODIFY(TRUE)
                    ELSE
                        PurchPriceWksh.INSERT(TRUE);
                END;
            end;

            trigger OnPreDataItem()
            begin
                Window.OPEN(Text001);
            end;
        }
    }

    requestpage
    {
        Caption = 'Purchase Code';

        layout
        {
            area(content)
            {
                field("Purchase Code"; ToPurchCode)
                {
                    Caption = 'Purchase Code';
                    TableRelation = Vendor;
                }
                field("Unit of Measure Code"; ToUnitOfMeasure.Code)
                {
                    Caption = 'Unit of Measure Code';
                    TableRelation = "Unit of Measure";
                }
                field("Currency Code"; ToCurrency.Code)
                {
                    Caption = 'Currency Code';
                    TableRelation = Currency;
                }
                field("Starting Date"; ToStartDate)
                {
                    Caption = 'Starting Date';
                }
                field("Ending Date"; ToEndDate)
                {
                    OptionCaption = 'Ending Date';
                }
                field("Only Prices Above"; PriceLowerLimit)
                {
                    OptionCaption = 'Only Prices Above';
                }
                field("Adjustment Factor"; UnitPriceFactor)
                {
                    OptionCaption = 'Adjustment Factor';
                }
                field("Rounding Method"; RoundingMethod.Code)
                {
                    OptionCaption = 'Rounding Method';
                    TableRelation = "Rounding Method";
                }
                field("Create New Prices"; CreateNewPrices)
                {
                    OptionCaption = 'Create New Prices';
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IF UnitPriceFactor = 0 THEN BEGIN
                UnitPriceFactor := 1;
                ToCustPriceGr.Code := '';
                ToUnitOfMeasure.Code := '';
                ToCurrency.Code := '';
            END;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin

        ToPurchType := ToPurchType::Vendor;
    end;

    trigger OnPreReport()
    begin


        ToVend."No." := ToPurchCode;
        IF ToVend."No." <> '' THEN
            ToVend.FIND
        ELSE BEGIN
            IF NOT ToVend.FIND THEN
                ToVend.INIT;
            ToPurchCode := ToVend."No.";
        END;



        ReplaceUnitOfMeasure := ToUnitOfMeasure.Code <> '';
        ReplaceCurrency := ToCurrency.Code <> '';
        ReplaceStartingDate := ToStartDate <> 0D;
        ReplaceEndingDate := ToEndDate <> 0D;

        IF ReplaceUnitOfMeasure AND (ToUnitOfMeasure.Code <> '') THEN
            ToUnitOfMeasure.FIND;

        RoundingMethod.SETRANGE(Code, RoundingMethod.Code);
    end;

    var
        Text001: Label 'Processing items  #1##########';
        SalesPrice2: Record "7002";
        SalesPriceWksh2: Record "7023";
        SalesPriceWksh: Record "7023";
        ToCust: Record "18";
        ToCustPriceGr: Record "6";
        ToCampaign: Record "5071";
        ToUnitOfMeasure: Record "204";
        ItemUnitOfMeasure: Record "5404";
        ToCurrency: Record "4";
        FromCurrency: Record "4";
        Currency2: Record "4";
        CurrExchRate: Record "330";
        RoundingMethod: Record "42";
        Item: Record "27";
        UOMMgt: Codeunit "5402";
        Window: Dialog;
        PriceAlreadyExists: Boolean;
        CreateNewPrices: Boolean;
        UnitPriceFactor: Decimal;
        PriceLowerLimit: Decimal;
        ToSalesType: Option Customer,"Customer Price Group","All Customers",Campaign;
        ToSalesCode: Code[20];
        ToStartDate: Date;
        ToEndDate: Date;
        ReplaceSalesCode: Boolean;
        ReplaceUnitOfMeasure: Boolean;
        ReplaceCurrency: Boolean;
        ReplaceStartingDate: Boolean;
        ReplaceEndingDate: Boolean;
        Text002: Label 'Purchase Code must be specified when copying from %1 to All Vendors.';
        "+++++++++500000": Integer;
        PurchPrice2: Record "7012";
        PurchPriceWksh2: Record "50038";
        PurchPriceWksh: Record "50038";
        ToVend: Record "23";
        ToPurchCode: Code[20];
        ReplacePurchCode: Boolean;
        ToPurchType: Option Vendor;
        Vendor: Record "23";

    [Scope('Internal')]
    procedure InitializeRequest(NewToPurchType: Option Vendor; NewToPurchCode: Code[20]; NewToStartDate: Date; NewToEndDate: Date; NewToCurrCode: Code[10]; NewToUOMCode: Code[10]; NewCreateNewPrices: Boolean)
    begin
        ToPurchType := NewToPurchType;
        ToPurchCode := NewToPurchCode;
        ToStartDate := NewToStartDate;
        ToEndDate := NewToEndDate;
        ToCurrency.Code := NewToCurrCode;
        ToUnitOfMeasure.Code := NewToUOMCode;
        CreateNewPrices := NewCreateNewPrices;
    end;
}

