page 50033 "DEL Subform Planned"
{


    Editable = false;
    PageType = ListPart;
    SourceTable = "DEL Element";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal ID';
                    Visible = false;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
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
                Enabled = SeeButtonEnable;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    purchHeader_Re_Loc: Record "Purchase Header";
                    purchHeaderArch_Re_Loc: Record "Purchase Header Archive";
                    salesHeader_Re_Loc: Record "Sales Header";
                    salesHeaderArch_Re_Loc: Record "Sales Header Archive";
                begin


                    CASE Rec.Type OF
                        Rec.Type::ACO:
                            BEGIN

                                IF purchHeader_Re_Loc.GET(purchHeader_Re_Loc."Document Type"::Order, Rec."Type No.") THEN BEGIN

                                    PAGE.RUN(PAGE::"Purchase Order", purchHeader_Re_Loc);
                                    EXIT
                                END;

                                purchHeaderArch_Re_Loc.RESET();
                                purchHeaderArch_Re_Loc.SETRANGE("Document Type", purchHeader_Re_Loc."Document Type"::Order);
                                purchHeaderArch_Re_Loc.SETFILTER("No.", Rec."Type No.");

                                IF purchHeaderArch_Re_Loc.FIND('+') THEN BEGIN

                                    PAGE.RUN(PAGE::"Purchase Order Archive", purchHeaderArch_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;
                        Rec.Type::VCO:
                            BEGIN

                                IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, Rec."Type No.") THEN BEGIN

                                    PAGE.RUN(PAGE::"Sales Order", salesHeader_Re_Loc);
                                    EXIT
                                END;


                                salesHeaderArch_Re_Loc.RESET();
                                salesHeaderArch_Re_Loc.SETRANGE("Document Type", salesHeader_Re_Loc."Document Type"::Order);
                                salesHeaderArch_Re_Loc.SETFILTER("No.", Rec."Type No.");

                                IF salesHeaderArch_Re_Loc.FIND('+') THEN BEGIN

                                    PAGE.RUN(PAGE::"Sales Order Archive", salesHeaderArch_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;

                    END
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        currency_Exchange_Re_Loc: Record "DEL Currency Exchange";
        position_Re_Loc: Record "DEL Position";
    begin
        FeeDescription_Te := '';
        IF Rec.Fee_ID <> '' THEN
            //TODO  FeeDescription_Te := Fee_Cu.FNC_Get_Description(Fee_ID);


            Currency_Code := '';
        Currency_Rate_Dec := 0;

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, Rec.ID);
        IF position_Re_Loc.FINDFIRST() THEN BEGIN

            Currency_Code := position_Re_Loc.Currency;
            Currency_Rate_Dec := position_Re_Loc.Rate;

        END;

        IF Rec.Type = Rec.Type::Fee THEN
            SeeButtonEnable := FALSE
        ELSE
            SeeButtonEnable := TRUE

    end;

    trigger OnInit()
    begin
        SeeButtonEnable := TRUE;
    end;

    var
        //TODO Fee_Cu: Codeunit 50023;
        FeeDescription_Te: Text[50];
        //TODO Element_Cu: Codeunit 50021;
        Amount_Dec: Decimal;
        Raw_Amount_Dec: Decimal;
        Currency_Code: Code[10];
        Currency_Rate_Dec: Decimal;
        [InDataSet]
        SeeButtonEnable: Boolean;
}

