page 50034 "DEL Subform Real"
{

    Editable = false;
    PageType = ListPart;
    SourceTable = "DEL Element";

    layout
    {
        area(content)
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
                    DrillDownPageID = "DEL Position";
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
                    DrillDownPageID = "DEL Position";
                }
                field("Date"; Rec.Date)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SeeButton)
            {
                Caption = 'See Document';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    purchInvHeader_Re_Loc: Record "Purch. Inv. Header";
                    salesInvHeader_Re_Loc: Record "Sales Invoice Header";
                    vendorLedgerEntry_Re_Loc: Record "Vendor Ledger Entry";
                    customerLedgerEntry_Re_Loc: Record "Cust. Ledger Entry";
                    GLEntry_Re_Loc: Record "G/L Entry";
                    entryNo_Int_Loc: Integer;
                    element_Re_Loc: Record "DEL Element";
                    postedPurchCrMemoHeader_Re_Loc: Record "Purch. Cr. Memo Hdr.";
                    postedSalesCrMemoHeader_Re_Loc: Record "Sales Cr.Memo Header";
                begin

                    CASE Rec.Type OF
                        Rec.Type::"Purchase Invoice":
                            BEGIN

                                IF purchInvHeader_Re_Loc.GET(Rec."Type No.") THEN BEGIN

                                    PAGE.RUN(PAGE::"Posted Purchase Invoice", purchInvHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Rec.Type::"Sales Cr. Memo":
                            BEGIN

                                IF postedSalesCrMemoHeader_Re_Loc.GET(Rec."Type No.") THEN BEGIN

                                    PAGE.RUN(PAGE::"Posted Sales Credit Memos", postedSalesCrMemoHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Rec.Type::"Purch. Cr. Memo":
                            BEGIN

                                IF postedPurchCrMemoHeader_Re_Loc.GET(Rec."Type No.") THEN BEGIN

                                    PAGE.RUN(PAGE::"Posted Purchase Credit Memo", postedPurchCrMemoHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Rec.Type::"Sales Invoice":
                            BEGIN

                                IF salesInvHeader_Re_Loc.GET(Rec."Type No.") THEN BEGIN

                                    PAGE.RUN(PAGE::"Posted Sales Invoice", salesInvHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Rec.Type::Invoice:

                            IF Rec."Subject Type" = Rec."Subject Type"::Vendor THEN BEGIN


                                vendorLedgerEntry_Re_Loc.RESET();
                                vendorLedgerEntry_Re_Loc.SETFILTER("Document Type", '%1|%2|%3',
                                  vendorLedgerEntry_Re_Loc."Document Type"::Invoice,
                                  vendorLedgerEntry_Re_Loc."Document Type"::Payment,
                                  vendorLedgerEntry_Re_Loc."Document Type"::"Credit Memo");
                                vendorLedgerEntry_Re_Loc.SETRANGE("Document No.", Rec."Type No.");
                                vendorLedgerEntry_Re_Loc.SETRANGE("Vendor No.", Rec."Subject No.");

                                IF vendorLedgerEntry_Re_Loc.FIND('-') THEN BEGIN
                                    PAGE.RUN(PAGE::"Vendor Ledger Entries", vendorLedgerEntry_Re_Loc);
                                    EXIT
                                END;

                            END ELSE
                                IF Rec."Subject Type" = Rec."Subject Type"::Customer THEN BEGIN

                                    customerLedgerEntry_Re_Loc.RESET();
                                    customerLedgerEntry_Re_Loc.SETFILTER("Document Type", '%1|%2|%3',
                                      customerLedgerEntry_Re_Loc."Document Type"::Invoice,
                                      customerLedgerEntry_Re_Loc."Document Type"::Payment,
                                      customerLedgerEntry_Re_Loc."Document Type"::"Credit Memo");
                                    customerLedgerEntry_Re_Loc.SETRANGE("Document No.", Rec."Type No.");
                                    customerLedgerEntry_Re_Loc.SETRANGE("Customer No.", Rec."Subject No.");

                                    IF customerLedgerEntry_Re_Loc.FIND('-') THEN BEGIN
                                        PAGE.RUN(PAGE::"Customer Ledger Entries", customerLedgerEntry_Re_Loc);
                                        EXIT
                                    END;

                                END ELSE
                                    IF Rec."Subject Type" = Rec."Subject Type"::"G/L Account" THEN BEGIN



                                        //TODO Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID);
                                        IF element_Re_Loc.FIND('-') THEN BEGIN

                                            GLEntry_Re_Loc.RESET();
                                            GLEntry_Re_Loc.SETRANGE("G/L Account No.", Rec."Subject No.");

                                            IF GLEntry_Re_Loc."Document Type" = GLEntry_Re_Loc."Document Type"::Invoice THEN BEGIN
                                                GLEntry_Re_Loc.SETRANGE("Document Type", GLEntry_Re_Loc."Document Type"::Invoice);
                                                GLEntry_Re_Loc.SETFILTER(Amount, '<%1', 0);
                                            END ELSE
                                                IF GLEntry_Re_Loc."Document Type" = GLEntry_Re_Loc."Document Type"::Payment THEN BEGIN
                                                    GLEntry_Re_Loc.SETRANGE("Document Type", GLEntry_Re_Loc."Document Type"::Payment);
                                                    GLEntry_Re_Loc.SETFILTER(Amount, '>%1', 0);
                                                END;

                                            GLEntry_Re_Loc.SETRANGE("Document No.", Rec."Type No.");
                                            GLEntry_Re_Loc.SETFILTER("Global Dimension 1 Code", '%1|%2', '', element_Re_Loc."Type No.");

                                            IF GLEntry_Re_Loc.FIND('-') THEN BEGIN
                                                PAGE.RUN(PAGE::"General Ledger Entries", GLEntry_Re_Loc);
                                                EXIT
                                            END
                                        END

                                    END ELSE
                                        MESSAGE('Document non trouvé..');

                    END

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        position_Re_Loc: Record "DEL Position";
        currency_Exchange_Re_Loc: Record "DEL Currency Exchange";
    begin
        FeeDescription_Te := '';

        IF Rec.Fee_ID <> '' THEN
            //TODOFeeDescription_Te := Fee_Cu.FNC_Get_Description(Rec.Fee_ID);


        Currency_Code := '';
        Currency_Rate_Dec := 0;

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, Rec.ID);
        IF position_Re_Loc.FINDFIRST() THEN BEGIN
            Currency_Code := position_Re_Loc.Currency;
            Currency_Rate_Dec := position_Re_Loc.Rate;
        END

    end;

    var
        // TODO Fee_Cu: Codeunit "50023";
        // Element_Cu: Codeunit "50021";
        FeeDescription_Te: Text[250];
        Raw_Amount_Dec: Decimal;
        Currency_Code: Code[10];
        Currency_Rate_Dec: Decimal;
        Amount_Dec: Decimal;
    //TODO  Deal_Cu: Codeunit 50020;


    procedure FNC_Get_GL_Amount(Element: Record "DEL Element"): Decimal
    var
        element_Re_Loc: Record "DEL Element";
        GLEntry_Re_Loc: Record "G/L Entry";
    begin


        //TODO Deal_Cu.FNC_Get_ACO(element_Re_Loc, Element.Deal_ID);
        IF element_Re_Loc.FINDFIRST() THEN BEGIN
            GLEntry_Re_Loc.RESET();
            GLEntry_Re_Loc.SETRANGE("G/L Account No.", Element."Subject No.");
            GLEntry_Re_Loc.SETRANGE("Document Type", GLEntry_Re_Loc."Document Type"::Invoice);
            GLEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
            GLEntry_Re_Loc.SETRANGE("Global Dimension 1 Code", element_Re_Loc."Type No.");
            IF GLEntry_Re_Loc.FINDFIRST() THEN
                EXIT(GLEntry_Re_Loc.Amount);
        END;
    end;


    procedure FNC_Get_Currency_Code(Element: Record "DEL Element"): Code[10]
    var
        vendorLedgerEntry_Re_Loc: Record "Vendor Ledger Entry";
        customerLedgerEntry_Re_Loc: Record "Cust. Ledger Entry";
        GLEntry_Re_Loc: Record "G/L Entry";
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
    begin

        vendorLedgerEntry_Re_Loc.RESET();
        vendorLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document Type", vendorLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF vendorLedgerEntry_Re_Loc.FINDFIRST() THEN
            EXIT(vendorLedgerEntry_Re_Loc."Currency Code");


        customerLedgerEntry_Re_Loc.RESET();
        customerLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document Type", customerLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF customerLedgerEntry_Re_Loc.FINDFIRST() THEN
            EXIT(customerLedgerEntry_Re_Loc."Currency Code");

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, Rec.ID);
        IF position_Re_Loc.FINDFIRST() THEN
            EXIT(position_Re_Loc.Currency)
    end;


    procedure FNC_Get_Currency_Rate(Element: Record "DEL Element"): Decimal
    var
        vendorLedgerEntry_Re_Loc: Record "Vendor Ledger Entry";
        customerLedgerEntry_Re_Loc: Record "Cust. Ledger Entry";
        GLEntry_Re_Loc: Record "G/L Entry";
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
    begin

        vendorLedgerEntry_Re_Loc.RESET();
        vendorLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document Type", vendorLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF vendorLedgerEntry_Re_Loc.FINDFIRST() THEN
            EXIT(vendorLedgerEntry_Re_Loc."Adjusted Currency Factor");


        customerLedgerEntry_Re_Loc.RESET();
        customerLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document Type", customerLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF customerLedgerEntry_Re_Loc.FINDFIRST() THEN
            EXIT(customerLedgerEntry_Re_Loc."Adjusted Currency Factor");

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, Rec.ID);
        IF position_Re_Loc.FINDFIRST() THEN
            EXIT(1)
    end;


    procedure FNC_Get_Exchange_Currency_Rate(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal): Decimal
    var
        CurrExchgRate_Re_Loc: Record "Currency Exchange Rate";
    begin
        EXIT(CurrExchgRate_Re_Loc.ExchangeAmtFCYToFCY(Date, FromCurrencyCode, ToCurrencyCode, Amount))
    end;


    procedure FNC_Get_DS_Currency_Rate(Date: Date; ToCurrencyCode: Code[10]): Decimal
    var
        CurrExchgRate_Re_Loc: Record "Currency Exchange Rate";
    begin
        CurrExchgRate_Re_Loc.SETRANGE("Currency Code", ToCurrencyCode);
        CurrExchgRate_Re_Loc.SETRANGE("Starting Date", 0D, Date);
        IF CurrExchgRate_Re_Loc.FINDLAST THEN
            EXIT(CurrExchgRate_Re_Loc."Relational Exch. Rate Amount")
        ELSE
            EXIT(0)
    end;
}

