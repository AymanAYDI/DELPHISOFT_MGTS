page 50034 "Subform Real"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 20.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            20.04.09   Update field Date
    // THM                              30.07.13   add field  ID

    Editable = false;
    PageType = ListPart;
    SourceTable = Table50021;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field(ID; ID)
                {
                    Visible = false;
                }
                field(Deal_ID; Deal_ID)
                {
                    Caption = 'Deal ID';
                    Visible = false;
                }
                field(Type; Type)
                {
                }
                field("Type No."; "Type No.")
                {
                }
                field(Fee_ID; Fee_ID)
                {
                    Caption = 'Fee ID';
                }
                field("<Fee Description>"; FeeDescription_Te)
                {
                    Caption = 'Fee Description';
                }
                field(Amount; Amount)
                {
                    Caption = 'Amount';
                    DrillDownPageID = Position;
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
                field("Amount(EUR)"; "Amount(EUR)")
                {
                    Caption = 'Amount (EUR)';
                    DrillDownPageID = Position;
                }
                field(Date; Date)
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
                    purchInvHeader_Re_Loc: Record "122";
                    salesInvHeader_Re_Loc: Record "112";
                    vendorLedgerEntry_Re_Loc: Record "25";
                    customerLedgerEntry_Re_Loc: Record "21";
                    GLEntry_Re_Loc: Record "17";
                    entryNo_Int_Loc: Integer;
                    element_Re_Loc: Record "50021";
                    postedPurchCrMemoHeader_Re_Loc: Record "124";
                    postedSalesCrMemoHeader_Re_Loc: Record "114";
                begin

                    CASE Type OF
                        Type::"Purchase Invoice":
                            BEGIN
                                //on cherche si une version courante existe
                                IF purchInvHeader_Re_Loc.GET("Type No.") THEN BEGIN
                                    //MESSAGE('ok');
                                    PAGE.RUN(PAGE::"Posted Purchase Invoice", purchInvHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Type::"Sales Cr. Memo":
                            BEGIN
                                //on cherche si une version courante existe
                                IF postedSalesCrMemoHeader_Re_Loc.GET("Type No.") THEN BEGIN
                                    //MESSAGE('ok');
                                    PAGE.RUN(PAGE::"Posted Sales Credit Memos", postedSalesCrMemoHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Type::"Purch. Cr. Memo":
                            BEGIN
                                //on cherche si une version courante existe
                                IF postedPurchCrMemoHeader_Re_Loc.GET("Type No.") THEN BEGIN
                                    //MESSAGE('ok');
                                    PAGE.RUN(PAGE::"Posted Purchase Credit Memo", postedPurchCrMemoHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Type::"Sales Invoice":
                            BEGIN
                                //on cherche si une version courante existe
                                IF salesInvHeader_Re_Loc.GET("Type No.") THEN BEGIN
                                    //MESSAGE('ok');
                                    PAGE.RUN(PAGE::"Posted Sales Invoice", salesInvHeader_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                        Type::Invoice:
                            BEGIN
                                IF "Subject Type" = "Subject Type"::Vendor THEN BEGIN

                                    //on cherche si une version courante existe
                                    vendorLedgerEntry_Re_Loc.RESET();
                                    vendorLedgerEntry_Re_Loc.SETFILTER("Document Type", '%1|%2|%3',
                                      vendorLedgerEntry_Re_Loc."Document Type"::Invoice,
                                      vendorLedgerEntry_Re_Loc."Document Type"::Payment,
                                      vendorLedgerEntry_Re_Loc."Document Type"::"Credit Memo");
                                    vendorLedgerEntry_Re_Loc.SETRANGE("Document No.", "Type No.");
                                    vendorLedgerEntry_Re_Loc.SETRANGE("Vendor No.", "Subject No.");

                                    IF vendorLedgerEntry_Re_Loc.FIND('-') THEN BEGIN
                                        PAGE.RUN(PAGE::"Vendor Ledger Entries", vendorLedgerEntry_Re_Loc);
                                        EXIT
                                    END;

                                END ELSE
                                    IF "Subject Type" = "Subject Type"::Customer THEN BEGIN

                                        //on cherche si une version courante existe
                                        customerLedgerEntry_Re_Loc.RESET();
                                        customerLedgerEntry_Re_Loc.SETFILTER("Document Type", '%1|%2|%3',
                                          customerLedgerEntry_Re_Loc."Document Type"::Invoice,
                                          customerLedgerEntry_Re_Loc."Document Type"::Payment,
                                          customerLedgerEntry_Re_Loc."Document Type"::"Credit Memo");
                                        customerLedgerEntry_Re_Loc.SETRANGE("Document No.", "Type No.");
                                        customerLedgerEntry_Re_Loc.SETRANGE("Customer No.", "Subject No.");

                                        IF customerLedgerEntry_Re_Loc.FIND('-') THEN BEGIN
                                            PAGE.RUN(PAGE::"Customer Ledger Entries", customerLedgerEntry_Re_Loc);
                                            EXIT
                                        END;

                                    END ELSE
                                        IF "Subject Type" = "Subject Type"::"G/L Account" THEN BEGIN

                                            /*_On cherche l'ACO liée à l'affaire_*/
                                            //element_Re_Loc.RESET();
                                            //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID);
                                            //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);

                                            Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID);
                                            IF element_Re_Loc.FIND('-') THEN BEGIN

                                                GLEntry_Re_Loc.RESET();
                                                GLEntry_Re_Loc.SETRANGE("G/L Account No.", "Subject No.");

                                                IF GLEntry_Re_Loc."Document Type" = GLEntry_Re_Loc."Document Type"::Invoice THEN BEGIN
                                                    GLEntry_Re_Loc.SETRANGE("Document Type", GLEntry_Re_Loc."Document Type"::Invoice);
                                                    GLEntry_Re_Loc.SETFILTER(Amount, '<%1', 0);
                                                END ELSE
                                                    IF GLEntry_Re_Loc."Document Type" = GLEntry_Re_Loc."Document Type"::Payment THEN BEGIN
                                                        GLEntry_Re_Loc.SETRANGE("Document Type", GLEntry_Re_Loc."Document Type"::Payment);
                                                        GLEntry_Re_Loc.SETFILTER(Amount, '>%1', 0);
                                                    END;

                                                GLEntry_Re_Loc.SETRANGE("Document No.", "Type No.");
                                                GLEntry_Re_Loc.SETFILTER("Global Dimension 1 Code", '%1|%2', '', element_Re_Loc."Type No.");

                                                IF GLEntry_Re_Loc.FIND('-') THEN BEGIN
                                                    PAGE.RUN(PAGE::"General Ledger Entries", GLEntry_Re_Loc);
                                                    EXIT
                                                END
                                            END

                                        END ELSE
                                            MESSAGE('Document non trouvé..');

                            END;

                    END

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        position_Re_Loc: Record "50022";
        currency_Exchange_Re_Loc: Record "50028";
    begin
        FeeDescription_Te := '';

        IF Fee_ID <> '' THEN
            FeeDescription_Te := Fee_Cu.FNC_Get_Description(Fee_ID);

        //18.06.09 Obsolet since we work with flowfields
        /*
        Amount_Dec := 0;
        Amount_Dec := Element_Cu.FNC_Get_Amount_From_Positions(ID);
        
        Raw_Amount_Dec := 0;
        Raw_Amount_Dec := Element_Cu.FNC_Get_Raw_Amount_From_Pos(ID);
        */

        Currency_Code := '';
        Currency_Rate_Dec := 0;

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, ID);
        IF position_Re_Loc.FINDFIRST THEN BEGIN
            Currency_Code := position_Re_Loc.Currency;
            Currency_Rate_Dec := position_Re_Loc.Rate;
        END

    end;

    var
        Fee_Cu: Codeunit "50023";
        Element_Cu: Codeunit "50021";
        FeeDescription_Te: Text[250];
        Raw_Amount_Dec: Decimal;
        Currency_Code: Code[10];
        Currency_Rate_Dec: Decimal;
        Amount_Dec: Decimal;
        Deal_Cu: Codeunit "50020";

    [Scope('Internal')]
    procedure FNC_Get_GL_Amount(Element: Record "50021"): Decimal
    var
        element_Re_Loc: Record "50021";
        GLEntry_Re_Loc: Record "17";
    begin
        //element_Re_Loc.RESET();
        //element_Re_Loc.SETRANGE(Deal_ID, Element.Deal_ID);
        //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);

        Deal_Cu.FNC_Get_ACO(element_Re_Loc, Element.Deal_ID);
        IF element_Re_Loc.FINDFIRST THEN BEGIN
            GLEntry_Re_Loc.RESET();
            GLEntry_Re_Loc.SETRANGE("G/L Account No.", Element."Subject No.");
            GLEntry_Re_Loc.SETRANGE("Document Type", GLEntry_Re_Loc."Document Type"::Invoice);
            GLEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
            GLEntry_Re_Loc.SETRANGE("Global Dimension 1 Code", element_Re_Loc."Type No.");
            IF GLEntry_Re_Loc.FINDFIRST THEN
                EXIT(GLEntry_Re_Loc.Amount);
        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_Currency_Code(Element: Record "50021"): Code[10]
    var
        vendorLedgerEntry_Re_Loc: Record "25";
        customerLedgerEntry_Re_Loc: Record "21";
        GLEntry_Re_Loc: Record "17";
        element_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
    begin
        //on cherche si une version courante existe
        vendorLedgerEntry_Re_Loc.RESET();
        vendorLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document Type", vendorLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF vendorLedgerEntry_Re_Loc.FINDFIRST THEN
            EXIT(vendorLedgerEntry_Re_Loc."Currency Code");

        //on cherche si une version courante existe
        customerLedgerEntry_Re_Loc.RESET();
        customerLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document Type", customerLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF customerLedgerEntry_Re_Loc.FINDFIRST THEN
            EXIT(customerLedgerEntry_Re_Loc."Currency Code");

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, ID);
        IF position_Re_Loc.FINDFIRST THEN
            EXIT(position_Re_Loc.Currency)
    end;

    [Scope('Internal')]
    procedure FNC_Get_Currency_Rate(Element: Record "50021"): Decimal
    var
        vendorLedgerEntry_Re_Loc: Record "25";
        customerLedgerEntry_Re_Loc: Record "21";
        GLEntry_Re_Loc: Record "17";
        element_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
    begin
        //on cherche si une version courante existe
        vendorLedgerEntry_Re_Loc.RESET();
        vendorLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Vendor No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        vendorLedgerEntry_Re_Loc.SETRANGE("Document Type", vendorLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF vendorLedgerEntry_Re_Loc.FINDFIRST THEN
            EXIT(vendorLedgerEntry_Re_Loc."Adjusted Currency Factor");

        //on cherche si une version courante existe
        customerLedgerEntry_Re_Loc.RESET();
        customerLedgerEntry_Re_Loc.SETCURRENTKEY("Document No.", "Document Type", "Customer No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document No.", Element."Type No.");
        customerLedgerEntry_Re_Loc.SETRANGE("Document Type", customerLedgerEntry_Re_Loc."Document Type"::Invoice);
        IF customerLedgerEntry_Re_Loc.FINDFIRST THEN
            EXIT(customerLedgerEntry_Re_Loc."Adjusted Currency Factor");

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, ID);
        IF position_Re_Loc.FINDFIRST THEN
            EXIT(1)
    end;

    [Scope('Internal')]
    procedure FNC_Get_Exchange_Currency_Rate(Date: Date; FromCurrencyCode: Code[10]; ToCurrencyCode: Code[10]; Amount: Decimal): Decimal
    var
        CurrExchgRate_Re_Loc: Record "330";
    begin
        EXIT(CurrExchgRate_Re_Loc.ExchangeAmtFCYToFCY(Date, FromCurrencyCode, ToCurrencyCode, Amount))
    end;

    [Scope('Internal')]
    procedure FNC_Get_DS_Currency_Rate(Date: Date; ToCurrencyCode: Code[10]): Decimal
    var
        CurrExchgRate_Re_Loc: Record "330";
    begin
        CurrExchgRate_Re_Loc.SETRANGE("Currency Code", ToCurrencyCode);
        CurrExchgRate_Re_Loc.SETRANGE("Starting Date", 0D, Date);
        IF CurrExchgRate_Re_Loc.FINDLAST THEN
            EXIT(CurrExchgRate_Re_Loc."Relational Exch. Rate Amount")
        ELSE
            EXIT(0)
    end;
}

