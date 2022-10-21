
page 50034 "DEL Subform Real"
{

    Editable = false;
    PageType = ListPart;
    SourceTable = "DEL Element";

    layout
    {
        area(Content)
        {
            repeater(Controle1)
            {
                Editable = false;
                field(ID; Rec.ID)
                {
                    Visible = false;
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal ID';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                }
                field("Type No."; Rec."Type No.")
                {
                }
                field(Fee_ID; Rec.Fee_ID)
                {
                    Caption = 'Fee ID';
                }
                field("<Fee Description>"; FeeDescription_Te)
                {
                    Caption = 'Fee Description';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    DrillDownPageId = "DEL Position";
                }
                field("<Currency Code>"; Currency_Code)
                {
                    Caption = 'Currency';
                }
                field("<Currency Rate>"; Currency_Rate_Dec)
                {
                    Caption = 'Currency Rate';
                    DecimalPlaces = 2 : 3;
                }
                field("Amount(EUR)"; Rec."Amount(EUR)")
                {
                    Caption = 'Amount (EUR)';
                    DrillDownPageId = "DEL Position";
                }
                field("Date"; Rec.Date)
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SeeButton)
            {
                Caption = 'See Document';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    customerLedgerEntry_Re_Loc: Record "Cust. Ledger Entry";
                    element_Re_Loc: Record "DEL Element";
                    GLEntry_Re_Loc: Record "G/L Entry";
                    postedPurchCrMemoHeader_Re_Loc: Record "Purch. Cr. Memo Hdr.";
                    purchInvHeader_Re_Loc: Record "Purch. Inv. Header";
                    postedSalesCrMemoHeader_Re_Loc: Record "Sales Cr.Memo Header";
                    salesInvHeader_Re_Loc: Record "Sales Invoice Header";
                    vendorLedgerEntry_Re_Loc: Record "Vendor Ledger Entry";
                begin

                    case Rec.Type of
                        Rec.Type::"Purchase Invoice":
                            begin

                                if purchInvHeader_Re_Loc.Get(Rec."Type No.") then begin

                                    Page.Run(Page::"Posted Purchase Invoice", purchInvHeader_Re_Loc);
                                    exit
                                end;

                                Message('Document non trouvé..');

                            end;

                        Rec.Type::"Sales Cr. Memo":
                            begin

                                if postedSalesCrMemoHeader_Re_Loc.Get(Rec."Type No.") then begin

                                    Page.Run(Page::"Posted Sales Credit Memos", postedSalesCrMemoHeader_Re_Loc);
                                    exit
                                end;

                                Message('Document non trouvé..');

                            end;

                        Rec.Type::"Purch. Cr. Memo":
                            begin

                                if postedPurchCrMemoHeader_Re_Loc.Get(Rec."Type No.") then begin

                                    Page.Run(Page::"Posted Purchase Credit Memo", postedPurchCrMemoHeader_Re_Loc);
                                    exit
                                end;

                                Message('Document non trouvé..');

                            end;

                        Rec.Type::"Sales Invoice":
                            begin

                                if salesInvHeader_Re_Loc.Get(Rec."Type No.") then begin

                                    Page.Run(Page::"Posted Sales Invoice", salesInvHeader_Re_Loc);
                                    exit
                                end;

                                Message('Document non trouvé..');

                            end;

                        Rec.Type::Invoice:

                            if Rec."Subject Type" = Rec."Subject Type"::Vendor then begin


                                vendorLedgerEntry_Re_Loc.Reset();
                                vendorLedgerEntry_Re_Loc.SetFilter("Document Type", '%1|%2|%3',
                                  vendorLedgerEntry_Re_Loc."Document Type"::Invoice,
                                  vendorLedgerEntry_Re_Loc."Document Type"::Payment,
                                  vendorLedgerEntry_Re_Loc."Document Type"::"Credit Memo");
                                vendorLedgerEntry_Re_Loc.SetRange("Document No.", Rec."Type No.");
                                vendorLedgerEntry_Re_Loc.SetRange("Vendor No.", Rec."Subject No.");

                                if vendorLedgerEntry_Re_Loc.Find('-') then begin
                                    Page.Run(Page::"Vendor Ledger Entries", vendorLedgerEntry_Re_Loc);
                                    exit
                                end;

                            end else
                                if Rec."Subject Type" = Rec."Subject Type"::Customer then begin

                                    customerLedgerEntry_Re_Loc.Reset();
                                    customerLedgerEntry_Re_Loc.SetFilter("Document Type", '%1|%2|%3',
                                      customerLedgerEntry_Re_Loc."Document Type"::Invoice,
                                      customerLedgerEntry_Re_Loc."Document Type"::Payment,
                                      customerLedgerEntry_Re_Loc."Document Type"::"Credit Memo");
                                    customerLedgerEntry_Re_Loc.SetRange("Document No.", Rec."Type No.");
                                    customerLedgerEntry_Re_Loc.SetRange("Customer No.", Rec."Subject No.");

                                    if customerLedgerEntry_Re_Loc.Find('-') then begin
                                        Page.Run(Page::"Customer Ledger Entries", customerLedgerEntry_Re_Loc);
                                        exit
                                    end;

                                end else
                                    if Rec."Subject Type" = Rec."Subject Type"::"G/L Account" then begin



                                        Deal_Cu.FNC_Get_ACO(element_Re_Loc, Rec.Deal_ID);
                                        if element_Re_Loc.Find('-') then begin

                                            GLEntry_Re_Loc.Reset();
                                            GLEntry_Re_Loc.SetRange("G/L Account No.", Rec."Subject No.");

                                            if GLEntry_Re_Loc."Document Type" = GLEntry_Re_Loc."Document Type"::Invoice then begin
                                                GLEntry_Re_Loc.SetRange("Document Type", GLEntry_Re_Loc."Document Type"::Invoice);
                                                GLEntry_Re_Loc.SetFilter(Amount, '<%1', 0);
                                            end else
                                                if GLEntry_Re_Loc."Document Type" = GLEntry_Re_Loc."Document Type"::Payment then begin
                                                    GLEntry_Re_Loc.SetRange("Document Type", GLEntry_Re_Loc."Document Type"::Payment);
                                                    GLEntry_Re_Loc.SetFilter(Amount, '>%1', 0);
                                                end;

                                            GLEntry_Re_Loc.SetRange("Document No.", Rec."Type No.");
                                            GLEntry_Re_Loc.SetFilter("Global Dimension 1 Code", '%1|%2', '', element_Re_Loc."Type No.");

                                            if GLEntry_Re_Loc.Find('-') then begin
                                                Page.Run(Page::"General Ledger Entries", GLEntry_Re_Loc);
                                                exit
                                            end
                                        end

                                    end else
                                        Message('Document non trouvé..');

                    end

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        position_Re_Loc: Record "DEL Position";
    begin
        FeeDescription_Te := '';

        if Rec.Fee_ID <> '' then
            FeeDescription_Te := Fee_Cu.FNC_Get_Description(Rec.Fee_ID);


        Currency_Code := '';
        Currency_Rate_Dec := 0;

        position_Re_Loc.Reset();
        position_Re_Loc.SetRange(Element_ID, Rec.ID);
        if position_Re_Loc.FindFirst() then begin
            Currency_Code := position_Re_Loc.Currency;
            Currency_Rate_Dec := position_Re_Loc.Rate;
        end

    end;

    var
        Deal_Cu: Codeunit "DEL Deal";
        Fee_Cu: Codeunit "DEL Fee";
        Currency_Code: Code[10];
        Currency_Rate_Dec: Decimal;
        FeeDescription_Te: Text[250];


    procedure FNC_Get_GL_Amount(Element: Record "DEL Element"): Decimal
    var
        element_Re_Loc: Record "DEL Element";
        GLEntry_Re_Loc: Record "G/L Entry";
    begin


        Deal_Cu.FNC_Get_ACO(element_Re_Loc, Element.Deal_ID);
        if element_Re_Loc.FindFirst() then begin
            GLEntry_Re_Loc.Reset();
            GLEntry_Re_Loc.SetRange("G/L Account No.", Element."Subject No.");
            GLEntry_Re_Loc.SetRange("Document Type", GLEntry_Re_Loc."Document Type"::Invoice);
            GLEntry_Re_Loc.SetRange("Document No.", Element."Type No.");
            GLEntry_Re_Loc.SetRange("Global Dimension 1 Code", element_Re_Loc."Type No.");
            if GLEntry_Re_Loc.FindFirst() then
                exit(GLEntry_Re_Loc.Amount);
        end;
    end;


    procedure FNC_Get_Currency_Code(Element: Record "DEL Element"): Code[10]
    var
        customerLedgerEntry_Re_Loc: Record "Cust. Ledger Entry";
        position_Re_Loc: Record "DEL Position";
        vendorLedgerEntry_Re_Loc: Record "Vendor Ledger Entry";
    begin

        vendorLedgerEntry_Re_Loc.Reset();
        vendorLedgerEntry_Re_Loc.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        vendorLedgerEntry_Re_Loc.SetRange("Document No.", Element."Type No.");
        vendorLedgerEntry_Re_Loc.SetRange("Document Type", vendorLedgerEntry_Re_Loc."Document Type"::Invoice);
        if vendorLedgerEntry_Re_Loc.FindFirst() then
            exit(vendorLedgerEntry_Re_Loc."Currency Code");


        customerLedgerEntry_Re_Loc.Reset();
        customerLedgerEntry_Re_Loc.SetCurrentKey("Document No.", "Document Type", "Customer No.");
        customerLedgerEntry_Re_Loc.SetRange("Document No.", Element."Type No.");
        customerLedgerEntry_Re_Loc.SetRange("Document Type", customerLedgerEntry_Re_Loc."Document Type"::Invoice);
        if customerLedgerEntry_Re_Loc.FindFirst() then
            exit(customerLedgerEntry_Re_Loc."Currency Code");

        position_Re_Loc.Reset();
        position_Re_Loc.SetRange(Element_ID, Rec.ID);
        if position_Re_Loc.FindFirst() then
            exit(position_Re_Loc.Currency)
    end;


    procedure FNC_Get_Currency_Rate(Element: Record "DEL Element"): Decimal
    var
        customerLedgerEntry_Re_Loc: Record "Cust. Ledger Entry";
        position_Re_Loc: Record "DEL Position";
        vendorLedgerEntry_Re_Loc: Record "Vendor Ledger Entry";
    begin

        vendorLedgerEntry_Re_Loc.Reset();
        vendorLedgerEntry_Re_Loc.SetCurrentKey("Document No.", "Document Type", "Vendor No.");
        vendorLedgerEntry_Re_Loc.SetRange("Document No.", Element."Type No.");
        vendorLedgerEntry_Re_Loc.SetRange("Document Type", vendorLedgerEntry_Re_Loc."Document Type"::Invoice);
        if vendorLedgerEntry_Re_Loc.FindFirst() then
            exit(vendorLedgerEntry_Re_Loc."Adjusted Currency Factor");


        customerLedgerEntry_Re_Loc.Reset();
        customerLedgerEntry_Re_Loc.SetCurrentKey("Document No.", "Document Type", "Customer No.");
        customerLedgerEntry_Re_Loc.SetRange("Document No.", Element."Type No.");
        customerLedgerEntry_Re_Loc.SetRange("Document Type", customerLedgerEntry_Re_Loc."Document Type"::Invoice);
        if customerLedgerEntry_Re_Loc.FindFirst() then
            exit(customerLedgerEntry_Re_Loc."Adjusted Currency Factor");

        position_Re_Loc.Reset();
        position_Re_Loc.SetRange(Element_ID, Rec.ID);
        if position_Re_Loc.FindFirst() then
            exit(1)
    end;


    procedure FNC_Get_Exchange_Currency_Rate(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal): Decimal
    var
        CurrExchgRate_Re_Loc: Record "Currency Exchange Rate";
    begin
        exit(CurrExchgRate_Re_Loc.ExchangeAmtFCYToFCY(Date, FromCurrencyCode, ToCurrencyCode, Amount))
    end;


    procedure FNC_Get_DS_Currency_Rate(Date: Date; ToCurrencyCode: Code[10]): Decimal
    var
        CurrExchgRate_Re_Loc: Record "Currency Exchange Rate";
    begin
        CurrExchgRate_Re_Loc.SetRange("Currency Code", ToCurrencyCode);
        CurrExchgRate_Re_Loc.SetRange("Starting Date", 0D, Date);
        if CurrExchgRate_Re_Loc.FindLast() then
            exit(CurrExchgRate_Re_Loc."Relational Exch. Rate Amount")
        else
            exit(0)
    end;
}

#pragma implicitwith restore

