page 50033 "Subform Planned"
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
                field(Deal_ID; Deal_ID)
                {
                    Caption = 'Deal ID';
                    Visible = false;
                }
                field(Type; Type)
                {
                    Caption = 'Type';
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
                Enabled = SeeButtonEnable;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    purchHeader_Re_Loc: Record "38";
                    purchHeaderArch_Re_Loc: Record "5109";
                    salesHeader_Re_Loc: Record "36";
                    salesHeaderArch_Re_Loc: Record "5107";
                begin
                    //MESSAGE(pageAT(Type));

                    CASE Type OF
                        Type::ACO:
                            BEGIN
                                //on cherche si une version courante existe
                                IF purchHeader_Re_Loc.GET(purchHeader_Re_Loc."Document Type"::Order, "Type No.") THEN BEGIN
                                    //MESSAGE('ok');
                                    PAGE.RUN(PAGE::"Purchase Order", purchHeader_Re_Loc);
                                    EXIT
                                END;

                                //on cherche si une version archivée existe
                                purchHeaderArch_Re_Loc.RESET();
                                purchHeaderArch_Re_Loc.SETRANGE("Document Type", purchHeader_Re_Loc."Document Type"::Order);
                                purchHeaderArch_Re_Loc.SETFILTER("No.", "Type No.");
                                //on cherche la dernière occurence dans sa dernière version
                                IF purchHeaderArch_Re_Loc.FIND('+') THEN BEGIN
                                    //MESSAGE('archive');
                                    PAGE.RUN(PAGE::"Purchase Order Archive", purchHeaderArch_Re_Loc);
                                    EXIT
                                END;

                                MESSAGE('Document non trouvé..');

                            END;
                        Type::VCO:
                            BEGIN
                                //on cherche si une version courante existe
                                IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, "Type No.") THEN BEGIN
                                    //MESSAGE('ok');
                                    PAGE.RUN(PAGE::"Sales Order", salesHeader_Re_Loc);
                                    EXIT
                                END;

                                //on cherche si une version archivée existe
                                salesHeaderArch_Re_Loc.RESET();
                                salesHeaderArch_Re_Loc.SETRANGE("Document Type", salesHeader_Re_Loc."Document Type"::Order);
                                salesHeaderArch_Re_Loc.SETFILTER("No.", "Type No.");
                                //on cherche la dernière occurence dans sa dernière version
                                IF salesHeaderArch_Re_Loc.FIND('+') THEN BEGIN
                                    //MESSAGE('archive');
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
        currency_Exchange_Re_Loc: Record "50028";
        position_Re_Loc: Record "50022";
    begin
        FeeDescription_Te := '';
        IF Fee_ID <> '' THEN
            FeeDescription_Te := Fee_Cu.FNC_Get_Description(Fee_ID);

        //18.06.09 obsolet since we work with flowfields
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

        END;

        IF Type = Type::Fee THEN
            SeeButtonEnable := FALSE
        ELSE
            SeeButtonEnable := TRUE

    end;

    trigger OnInit()
    begin
        SeeButtonEnable := TRUE;
    end;

    var
        Fee_Cu: Codeunit "50023";
        FeeDescription_Te: Text[50];
        Element_Cu: Codeunit "50021";
        Amount_Dec: Decimal;
        Raw_Amount_Dec: Decimal;
        Currency_Code: Code[10];
        Currency_Rate_Dec: Decimal;
        [InDataSet]
        SeeButtonEnable: Boolean;
}

