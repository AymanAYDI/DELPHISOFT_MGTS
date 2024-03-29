page 50030 "DEL Deal Mainboard"
{

    Caption = 'Deal Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "DEL Deal";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ID; Rec.ID)
                {
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = false;
                }
            }
            part(ACO; "DEL Subform ACO")
            {
                Caption = 'ACO';
                SubPageLink = Deal_ID = FIELD(ID),
                              Type = CONST(ACO),
                              Instance = FILTER(planned);
            }
            part(VCO; "DEL Subform VCO")
            {
                Caption = 'VCO';
                SubPageLink = Deal_ID = FIELD(ID),
                              Type = CONST(VCO),
                              Instance = CONST(planned);
            }
            part("Subpage Logistic"; "DEL Subform Logistic")
            {
                Caption = 'Logistique';
                SubPageLink = Deal_ID = FIELD(ID);
            }
            field(ItemDetailShipmentNo_Co; ItemDetailShipmentNo_Co)
            {
                Caption = 'Shipment';
                TableRelation = "DEL Deal Shipment".ID;

                trigger OnLookup(var Text: Text): Boolean
                var
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                    mypage: Page "DEL Deal Ship. Sele.";
                begin
                    dealShipment_Re_Loc.RESET();
                    dealShipment_Re_Loc.SETRANGE(Deal_ID, Rec.ID);

                    CLEAR(mypage);
                    mypage.SETTABLEVIEW(dealShipment_Re_Loc);
                    mypage.SETRECORD(dealShipment_Re_Loc);
                    mypage.LOOKUPMODE(TRUE);
                    IF mypage.RUNMODAL() = ACTION::LookupOK THEN BEGIN

                        mypage.GETRECORD(dealShipment_Re_Loc);
                        ItemDetailShipmentNo_Co := dealShipment_Re_Loc.ID;

                        IF dealShipment_Re_Loc.GET(ItemDetailShipmentNo_Co) THEN
                            CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(Rec.ID, dealShipment_Re_Loc."BR No.")
                        ELSE
                            CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(Rec.ID, '');

                    END
                end;

                trigger OnValidate()
                var
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                begin
                    IF dealShipment_Re_Loc.GET(ItemDetailShipmentNo_Co) THEN
                        CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(Rec.ID, dealShipment_Re_Loc."BR No.")
                    ELSE
                        CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(Rec.ID, '');
                end;
            }
            part(ShipmentSubpage; "Deal Posted Purch. Rcpt. Sub.")
            {
                Caption = 'Détail Articles';
            }
            part("Prévu"; "DEL Subform Planned")
            {
                Caption = 'Prévu';
                SubPageLink = Deal_ID = FIELD(ID),
                              Instance = CONST(planned);
            }
            part("Réalisé"; "DEL Subform Real")
            {
                Caption = 'Réalisé';
                SubPageLink = Deal_ID = FIELD(ID),
                              Instance = CONST(real),
                              Type = FILTER(<> BR);
            }
            field(PLLogisticShipmentNo_Co; PLLogisticShipmentNo_Co)
            {
                Caption = 'Shipment';
                TableRelation = "DEL Deal Shipment".ID;

                trigger OnLookup(var Text: Text): Boolean
                var
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                    myPage: Page "DEL Deal Ship. Sele.";
                begin
                    dealShipment_Re_Loc.RESET();
                    dealShipment_Re_Loc.SETRANGE(Deal_ID, Rec.ID);

                    CLEAR(myPage);
                    myPage.SETTABLEVIEW(dealShipment_Re_Loc);
                    myPage.SETRECORD(dealShipment_Re_Loc);
                    myPage.LOOKUPMODE(TRUE);
                    IF myPage.RUNMODAL() = ACTION::LookupOK THEN BEGIN

                        myPage.GETRECORD(dealShipment_Re_Loc);
                        PLLogisticShipmentNo_Co := dealShipment_Re_Loc.ID;
                        CurrPage.UPDATE()

                    END
                end;

                trigger OnValidate()
                begin

                    PLLogisticShipmentNoCoOnAfterV();
                end;
            }
            part(PLLogistic; "DEL Subform P&L Logistic")
            {
                Caption = 'P&&L Logistique';
                Editable = false;
            }
            field(PLDetailShipmentNo_Co; PLDetailShipmentNo_Co)
            {
                Caption = 'Shipment';
                TableRelation = "DEL Deal Shipment".ID;

                trigger OnLookup(var Text: Text): Boolean
                var
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                    myPage: Page "DEL Deal Ship. Sele.";
                begin
                    dealShipment_Re_Loc.RESET();
                    dealShipment_Re_Loc.SETRANGE(Deal_ID, Rec.ID);

                    CLEAR(myPage);
                    myPage.SETTABLEVIEW(dealShipment_Re_Loc);
                    myPage.SETRECORD(dealShipment_Re_Loc);
                    myPage.LOOKUPMODE(TRUE);
                    IF myPage.RUNMODAL() = ACTION::LookupOK THEN BEGIN

                        myPage.GETRECORD(dealShipment_Re_Loc);
                        PLDetailShipmentNo_Co := dealShipment_Re_Loc.ID;
                        CurrPage.UPDATE()

                    END
                end;

                trigger OnValidate()
                begin

                    PLDetailShipmentNoCoOnAfterVal();
                end;
            }
            part(PositionDetails; "DEL Subform P&L Details")
            {
                Caption = 'P&&L Détail';
                Editable = false;
                Enabled = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Deal)
            {
                Caption = 'Deal';
                Visible = true;
                action(List)
                {
                    Caption = 'List';
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        DealShip_Re_Loc: Record "DEL Deal Shipment";
                        DealShipList_Fo_Loc: Page "DEL Deal Ship. Sele.";
                    begin
                        DealShipList_Fo_Loc.LOOKUPMODE := TRUE;
                        IF DealShipList_Fo_Loc.RUNMODAL() = ACTION::LookupOK THEN BEGIN
                            DealShipList_Fo_Loc.GETRECORD(DealShip_Re_Loc);
                            Rec.GET(DealShip_Re_Loc.Deal_ID);
                        END;
                    end;
                }
                action("Exchange Rates")
                {
                    Caption = 'Exchange Rates';
                    Image = InsertCurrency;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CurrencyExchange_Re_Loc: Record "DEL Currency Exchange";
                        CurrencyExchange_page_Loc: Page "DEL Currency Exchange";
                    begin


                        CLEAR(CurrencyExchange_page_Loc);

                        CurrencyExchange_Re_Loc.RESET();
                        CurrencyExchange_Re_Loc.SETFILTER(Deal_ID, '%1 | %2', '', Rec.ID);
                        CurrencyExchange_Re_Loc.SETFILTER("Valid From", '<=%1', TODAY);
                        CurrencyExchange_Re_Loc.SETFILTER("Valid To", '>=%1', TODAY);

                        CurrencyExchange_page_Loc.SETTABLEVIEW(CurrencyExchange_Re_Loc);
                        CurrencyExchange_page_Loc.SETRECORD(CurrencyExchange_Re_Loc);
                        CurrencyExchange_page_Loc.RUNMODAL()
                    end;
                }
                separator(SPR)
                {
                }
                action(Reinit)
                {
                    Caption = 'Reinit';
                    Image = Recalculate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        urm_Re_Loc: Record "DEL Update Request Manager";
                        requestID_Co_Loc: Code[20];
                    begin


                        requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                          Rec.ID,
                          urm_Re_Loc.Requested_By_Type::CUSTOM.AsInteger(),
                          USERID,
                          CURRENTDATETIME
                        );
                        urm_Re_Loc.GET(requestID_Co_Loc);
                        UpdateRequestManager_Cu.FNC_Process_RequestsDeal(urm_Re_Loc, FALSE, FALSE, TRUE, requestID_Co_Loc);
                        urm_Re_Loc.SETRANGE(urm_Re_Loc.ID, requestID_Co_Loc);
                        IF urm_Re_Loc.FINDFIRST() THEN
                            urm_Re_Loc.DELETE();
                        CurrPage.UPDATE();
                    end;
                }
                action("Recalculer (y compris le prévu)")
                {
                    Caption = 'Recalculer (y compris le prévu)';
                    Image = Forecast;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        urm_Re_Loc: Record "DEL Update Request Manager";
                        requestID_Co_Loc: Code[20];
                    begin

                        requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                          Rec.ID,
                          urm_Re_Loc.Requested_By_Type::CUSTOM.AsInteger(),
                          USERID,
                          CURRENTDATETIME
                        );

                        urm_Re_Loc.GET(requestID_Co_Loc);
                        UpdateRequestManager_Cu.FNC_Process_RequestsDeal(urm_Re_Loc, FALSE, TRUE, TRUE, requestID_Co_Loc);
                        urm_Re_Loc.SETRANGE(urm_Re_Loc.ID, requestID_Co_Loc);
                        IF urm_Re_Loc.FINDFIRST() THEN
                            urm_Re_Loc.DELETE();
                        CurrPage.UPDATE();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        dealShipCon_Re_Loc: Record "DEL Deal Shipment Connection";
        plannedElement_Re_Loc: Record "DEL Element";
        realElement_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        item_Re_Loc: Record Item;
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        amount_Dec_Loc: Decimal;
    begin
        FNC_InitVars();


        CurrPage."Subpage Logistic".PAGE.FNC_Set_Deal_ID(Rec.ID);


        IF ItemDetailShipmentNo_Co = '' THEN
            CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(Rec.ID, '');

        TempPLLogistic_Re.DELETEALL();
        IF PLLogisticShipmentNo_Co = '' THEN BEGIN

            plannedElement_Re_Loc.RESET();
            plannedElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            plannedElement_Re_Loc.SETRANGE(Deal_ID, Rec.ID);
            plannedElement_Re_Loc.SETRANGE(Type, plannedElement_Re_Loc.Type::Fee);
            plannedElement_Re_Loc.SETRANGE(Instance, plannedElement_Re_Loc.Instance::planned);

            IF plannedElement_Re_Loc.FINDFIRST() THEN
                REPEAT

                    TempPLLogistic_Re.INIT();

                    TempPLLogistic_Re."Planned Element ID" := plannedElement_Re_Loc.ID;
                    TempPLLogistic_Re."Planned Element Type No." := plannedElement_Re_Loc.Fee_ID;
                    TempPLLogistic_Re."Planned Amount" := Element_Cu.FNC_Get_Amount_From_Positions(plannedElement_Re_Loc.ID);

                    realElement_Re_Loc.RESET();
                    realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                    realElement_Re_Loc.SETRANGE(Deal_ID, Rec.ID);
                    realElement_Re_Loc.SETRANGE(Type, realElement_Re_Loc.Type::Invoice);
                    realElement_Re_Loc.SETRANGE(Fee_ID, plannedElement_Re_Loc.Fee_ID);
                    realElement_Re_Loc.SETRANGE(Fee_Connection_ID, plannedElement_Re_Loc.Fee_Connection_ID);


                    IF realElement_Re_Loc.FINDFIRST() THEN BEGIN
                        REPEAT

                            IF NOT TempPLLogistic_Re.GET(plannedElement_Re_Loc.ID, realElement_Re_Loc.ID) THEN BEGIN

                                TempPLLogistic_Re."Real Element ID" := realElement_Re_Loc.ID;

                                TempPLLogistic_Re."Real Amount" += Element_Cu.FNC_Get_Amount_From_Positions(realElement_Re_Loc.ID);
                            END;

                        UNTIL (realElement_Re_Loc.NEXT() = 0);

                        TempPLLogistic_Re.Delta := TempPLLogistic_Re."Real Amount" - TempPLLogistic_Re."Planned Amount";
                        IF NOT TempPLLogistic_Re.INSERT(FALSE) THEN;

                    END ELSE BEGIN

                        TempPLLogistic_Re.Delta := TempPLLogistic_Re."Real Amount" - TempPLLogistic_Re."Planned Amount";
                        IF NOT TempPLLogistic_Re.INSERT(FALSE) THEN;

                    END;

                UNTIL (plannedElement_Re_Loc.NEXT() = 0);


        END ELSE BEGIN

            plannedElement_Re_Loc.RESET();
            plannedElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            plannedElement_Re_Loc.SETRANGE(Deal_ID, Rec.ID);
            plannedElement_Re_Loc.SETRANGE(Type, plannedElement_Re_Loc.Type::Fee);
            plannedElement_Re_Loc.SETRANGE(Instance, plannedElement_Re_Loc.Instance::planned);
            IF plannedElement_Re_Loc.FINDFIRST() THEN
                REPEAT

                    TempPLLogistic_Re.INIT();
                    amount_Dec_Loc := 0;
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", DealShipment_Cu.FNC_GetBRNo(PLLogisticShipmentNo_Co));
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Element_ID, plannedElement_Re_Loc.ID);
                            position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");
                            IF position_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    amount_Dec_Loc += position_Re_Loc.Amount * purchRcptLine_Re_Loc.Quantity * position_Re_Loc.Rate;
                                UNTIL (position_Re_Loc.NEXT() = 0);

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);


                    TempPLLogistic_Re."Planned Element ID" := plannedElement_Re_Loc.ID;
                    TempPLLogistic_Re."Planned Element Type No." := plannedElement_Re_Loc.Fee_ID;
                    TempPLLogistic_Re."Planned Amount" := amount_Dec_Loc;


                    realElement_Re_Loc.RESET();
                    realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                    realElement_Re_Loc.SETRANGE(Deal_ID, Rec.ID);
                    realElement_Re_Loc.SETRANGE(Type, realElement_Re_Loc.Type::Invoice);
                    realElement_Re_Loc.SETRANGE(Fee_ID, plannedElement_Re_Loc.Fee_ID);
                    realElement_Re_Loc.SETRANGE(Fee_Connection_ID, plannedElement_Re_Loc.Fee_Connection_ID);

                    IF realElement_Re_Loc.FINDFIRST() THEN BEGIN
                        REPEAT


                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Deal_ID, Rec.ID);
                            position_Re_Loc.SETRANGE(Element_ID, realElement_Re_Loc.ID);
                            IF position_Re_Loc.FINDFIRST() THEN
                                REPEAT

                                    IF dealShipCon_Re_Loc.GET(Rec.ID, PLLogisticShipmentNo_Co, position_Re_Loc."Sub Element_ID") THEN
                                        TempPLLogistic_Re."Real Amount" += position_Re_Loc."Line Amount (EUR)";

                                UNTIL (position_Re_Loc.NEXT() = 0);

                        UNTIL (realElement_Re_Loc.NEXT() = 0);

                        TempPLLogistic_Re.Delta := TempPLLogistic_Re."Real Amount" - TempPLLogistic_Re."Planned Amount";
                        IF NOT TempPLLogistic_Re.INSERT(FALSE) THEN;

                    END ELSE BEGIN

                        TempPLLogistic_Re.Delta := TempPLLogistic_Re."Real Amount" - TempPLLogistic_Re."Planned Amount";
                        IF NOT TempPLLogistic_Re.INSERT(FALSE) THEN;

                    END;



                    Temp_PositionSummary_Re.DELETEALL();


                    position_Re_Loc.RESET();
                    position_Re_Loc.SETFILTER(Deal_ID, Rec.ID);

                    IF position_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            IF NOT Temp_PositionSummary_Re.GET(position_Re_Loc."Deal Item No.") THEN BEGIN



                                Temp_PositionSummary_Re.INIT();

                                Temp_PositionSummary_Re.VALIDATE("Item No.", position_Re_Loc."Deal Item No.");

                                IF item_Re_Loc.GET(position_Re_Loc."Deal Item No.") THEN
                                    Temp_PositionSummary_Re.Description := item_Re_Loc.Description;

                                Temp_PositionSummary_Re."Planned Sales" :=
                                  Deal_Item_Cu.FNC_Get_Sales_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                                Temp_PositionSummary_Re."Planned Purchases" :=
                                  Deal_Item_Cu.FNC_Get_Purchases_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                                Temp_PositionSummary_Re."Planned Fees" :=
                                  Deal_Item_Cu.FNC_Get_Fees_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                                Temp_PositionSummary_Re."Planned Gross Margin" :=
                                  Temp_PositionSummary_Re."Planned Sales" + Temp_PositionSummary_Re."Planned Purchases";

                                Temp_PositionSummary_Re."Planned Final Margin" :=
                                  Temp_PositionSummary_Re."Planned Gross Margin" + Temp_PositionSummary_Re."Planned Fees";

                                IF Temp_PositionSummary_Re."Planned Sales" <> 0 THEN BEGIN
                                    Temp_PositionSummary_Re."Planned % Of Gross Margin" :=
                                      ((Temp_PositionSummary_Re."Planned Gross Margin" * 100) / Temp_PositionSummary_Re."Planned Sales") / 100;

                                    Temp_PositionSummary_Re."Planned % Of Final Margin" :=
                                      ((Temp_PositionSummary_Re."Planned Final Margin" * 100) / Temp_PositionSummary_Re."Planned Sales") / 100;
                                END;


                                Temp_PositionSummary_Re."Real Sales" :=
                                  Deal_Item_Cu.FNC_Get_Sales_Amount(
                                   Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                                Temp_PositionSummary_Re."Real Purchases" :=
                                  Deal_Item_Cu.FNC_Get_Purchases_Amount(
                                   Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                                Temp_PositionSummary_Re."Real Fees" :=
                                  Deal_Item_Cu.FNC_Get_Fees_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                                Temp_PositionSummary_Re."Real Gross Margin" :=
                                  Temp_PositionSummary_Re."Real Sales" + Temp_PositionSummary_Re."Real Purchases";

                                Temp_PositionSummary_Re."Real Final Margin" :=
                                  Temp_PositionSummary_Re."Real Gross Margin" + Temp_PositionSummary_Re."Real Fees";

                                IF Temp_PositionSummary_Re."Real Sales" <> 0 THEN BEGIN
                                    Temp_PositionSummary_Re."Real % Of Gross Margin" :=
                                      ((Temp_PositionSummary_Re."Real Gross Margin" * 100) / Temp_PositionSummary_Re."Real Sales") / 100;

                                    Temp_PositionSummary_Re."Real % Of Final Margin" :=
                                      ((Temp_PositionSummary_Re."Real Final Margin" * 100) / Temp_PositionSummary_Re."Real Sales") / 100;
                                END;

                                IF NOT Temp_PositionSummary_Re.INSERT(FALSE) THEN;

                            END;
                        UNTIL (position_Re_Loc.NEXT() = 0);


                    CurrPage.PositionDetails.PAGE.SetTempRecord(Temp_PositionSummary_Re);
                until (plannedElement_Re_Loc.Next() = 0);

        end;
    end;

    trigger OnInit()
    begin

        FNC_InitVars();
    end;

    var

        TempPLLogistic_Re: Record "DEL P&L Logistic" temporary;
        Temp_PositionSummary_Re: Record "DEL Position Summary" temporary;
        Deal_Item_Cu: Codeunit "DEL Deal Item";
        DealShipment_Cu: Codeunit "DEL Deal Shipment";
        Element_Cu: Codeunit "DEL Element";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        ItemDetailShipmentNo_Co: Code[20];
        PLDetailShipmentNo_Co: Code[20];
        PLLogisticShipmentNo_Co: Code[20];


    procedure FNC_InitVars()
    begin

    end;

    local procedure PLShipmentNoCoOnAfterValidate()
    begin
        CurrPage.UPDATE()
    end;

    local procedure PLLogisticShipmentNoCoOnAfterV()
    begin
        CurrPage.UPDATE()
    end;

    local procedure PLDetailShipmentNoCoOnAfterVal()
    begin
        CurrPage.UPDATE()
    end;

    local procedure Control1103070011OnDeactivate()
    begin
        PAGE.RUN(PAGE::"DEL Currency Exchange")
    end;
}

