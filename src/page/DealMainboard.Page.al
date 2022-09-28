page 50030 "DEL Deal Mainboard"
{

    Caption = 'Deal Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "DEL Deal";

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
                    dealShipment_Re_Loc.SETRANGE(Deal_ID, ID);

                    CLEAR(mypage);
                    mypage.SETTABLEVIEW(dealShipment_Re_Loc);
                    mypage.SETRECORD(dealShipment_Re_Loc);
                    mypage.LOOKUPMODE(TRUE);
                    IF mypage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                        mypage.GETRECORD(dealShipment_Re_Loc);
                        ItemDetailShipmentNo_Co := dealShipment_Re_Loc.ID;

                        IF dealShipment_Re_Loc.GET(ItemDetailShipmentNo_Co) THEN
                            CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, dealShipment_Re_Loc."BR No.")
                        ELSE
                            CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, '');

                    END
                end;

                trigger OnValidate()
                var
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                begin
                    IF dealShipment_Re_Loc.GET(ItemDetailShipmentNo_Co) THEN
                        CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, dealShipment_Re_Loc."BR No.")
                    ELSE
                        CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, '');
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
                    IF myPage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                        myPage.GETRECORD(dealShipment_Re_Loc);
                        PLLogisticShipmentNo_Co := dealShipment_Re_Loc.ID;
                        CurrPage.UPDATE

                    END
                end;

                trigger OnValidate()
                var
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                begin

                    PLLogisticShipmentNoCoOnAfterV;
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
                    IF myPage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                        myPage.GETRECORD(dealShipment_Re_Loc);
                        PLDetailShipmentNo_Co := dealShipment_Re_Loc.ID;
                        CurrPage.UPDATE

                    END
                end;

                trigger OnValidate()
                var
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                begin

                    PLDetailShipmentNoCoOnAfterVal;
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
                        CurrencyExchange_page_Loc: Page "DEL Currency Exchange";
                    begin
                        DealShipList_Fo_Loc.LOOKUPMODE := TRUE;
                        IF DealShipList_Fo_Loc.RUNMODAL = ACTION::LookupOK THEN BEGIN
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
                        CurrencyExchange_Re_Loc.SETFILTER(Deal_ID, '%1 | %2', '', ID);
                        CurrencyExchange_Re_Loc.SETFILTER("Valid From", '<=%1', TODAY);
                        CurrencyExchange_Re_Loc.SETFILTER("Valid To", '>=%1', TODAY);

                        CurrencyExchange_page_Loc.SETTABLEVIEW(CurrencyExchange_Re_Loc);
                        CurrencyExchange_page_Loc.SETRECORD(CurrencyExchange_Re_Loc);
                        CurrencyExchange_page_Loc.RUNMODAL
                    end;
                }
                separator()
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
                        requestID_Co_Loc: Code[20];
                        urm_Re_Loc: Record "DEL Update Request Manager";
                    begin


                        requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                          ID,
                          urm_Re_Loc.Requested_By_Type::CUSTOM,
                          USERID,
                          CURRENTDATETIME
                        );

                        urm_Re_Loc.GET(requestID_Co_Loc);



                        UpdateRequestManager_Cu.FNC_Process_RequestsDeal(urm_Re_Loc, FALSE, FALSE, TRUE, requestID_Co_Loc);
                        urm_Re_Loc.SETRANGE(urm_Re_Loc.ID, requestID_Co_Loc);
                        IF urm_Re_Loc.FINDFIRST THEN
                            urm_Re_Loc.DELETE;
                        // end THM
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

                    trigger OnAction()
                    var
                        requestID_Co_Loc: Code[20];
                        urm_Re_Loc: Record "DEL Update Request Manager";
                    begin

                        requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                          ID,
                          urm_Re_Loc.Requested_By_Type::CUSTOM,
                          USERID,
                          CURRENTDATETIME
                        );

                        urm_Re_Loc.GET(requestID_Co_Loc);


                        UpdateRequestManager_Cu.FNC_Process_RequestsDeal(urm_Re_Loc, FALSE, TRUE, TRUE, requestID_Co_Loc);
                        urm_Re_Loc.SETRANGE(urm_Re_Loc.ID, requestID_Co_Loc);
                        IF urm_Re_Loc.FINDFIRST THEN
                            urm_Re_Loc.DELETE;


                        CurrPage.UPDATE();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        plannedElement_Re_Loc: Record "DEL Element";
        realElement_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        item_Re_Loc: Record Item;
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        element_Re_Loc: Record "DEL Element";
        amount_Dec_Loc: Decimal;
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        dealShipCon_Re_Loc: Record "DEL Deal Shipment Connection";
    begin
        FNC_InitVars();


        CurrPage."Subpage Logistic".PAGE.FNC_Set_Deal_ID(ID);


        IF ItemDetailShipmentNo_Co = '' THEN
            CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, '');


        PLLogistic_Re_Temp.DELETEALL;


        IF PLLogisticShipmentNo_Co = '' THEN BEGIN

            plannedElement_Re_Loc.RESET();
            plannedElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            plannedElement_Re_Loc.SETRANGE(Deal_ID, ID);
            plannedElement_Re_Loc.SETRANGE(Type, plannedElement_Re_Loc.Type::Fee);
            plannedElement_Re_Loc.SETRANGE(Instance, plannedElement_Re_Loc.Instance::planned);
            //on boucle sur toutes les elements de type Fee
            IF plannedElement_Re_Loc.FINDFIRST THEN
                REPEAT

                    PLLogistic_Re_Temp.INIT();

                    PLLogistic_Re_Temp."Planned Element ID" := plannedElement_Re_Loc.ID;
                    PLLogistic_Re_Temp."Planned Element Type No." := plannedElement_Re_Loc.Fee_ID;
                    PLLogistic_Re_Temp."Planned Amount" := Element_Cu.FNC_Get_Amount_From_Positions(plannedElement_Re_Loc.ID);

                    //on cherche les éléments réalisés pour un élément prévu
                    realElement_Re_Loc.RESET();
                    realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                    realElement_Re_Loc.SETRANGE(Deal_ID, ID);
                    realElement_Re_Loc.SETRANGE(Type, realElement_Re_Loc.Type::Invoice); //CHG-DEV-PROVISION filter sur invoice|provision
                    realElement_Re_Loc.SETRANGE(Fee_ID, plannedElement_Re_Loc.Fee_ID);
                    realElement_Re_Loc.SETRANGE(Fee_Connection_ID, plannedElement_Re_Loc.Fee_Connection_ID);

                    //on boucle sur tous les elements de type Invoice
                    IF realElement_Re_Loc.FINDFIRST THEN BEGIN
                        REPEAT

                            IF NOT PLLogistic_Re_Temp.GET(plannedElement_Re_Loc.ID, realElement_Re_Loc.ID) THEN BEGIN

                                PLLogistic_Re_Temp."Real Element ID" := realElement_Re_Loc.ID;
                                //PLLogistic_Re_Temp."Real Element Type No." := realElement_Re_Loc."Type No.";
                                PLLogistic_Re_Temp."Real Amount" += Element_Cu.FNC_Get_Amount_From_Positions(realElement_Re_Loc.ID);

                                //PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                                //IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                            END;

                        UNTIL (realElement_Re_Loc.NEXT() = 0);

                        PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                        IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                    END ELSE BEGIN

                        PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                        IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                    END;

                UNTIL (plannedElement_Re_Loc.NEXT() = 0);

            //spécifique pour une livraison
        END ELSE BEGIN

            plannedElement_Re_Loc.RESET();
            plannedElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            plannedElement_Re_Loc.SETRANGE(Deal_ID, ID);
            plannedElement_Re_Loc.SETRANGE(Type, plannedElement_Re_Loc.Type::Fee);
            plannedElement_Re_Loc.SETRANGE(Instance, plannedElement_Re_Loc.Instance::planned);
            IF plannedElement_Re_Loc.FINDFIRST THEN
                REPEAT

                    PLLogistic_Re_Temp.INIT();
                    amount_Dec_Loc := 0;

                    //planned
                    //-----------------------------------------------------------------------------------
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", DealShipment_Cu.FNC_GetBRNo(PLLogisticShipmentNo_Co));
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Element_ID, plannedElement_Re_Loc.ID);
                            position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");
                            IF position_Re_Loc.FINDFIRST THEN
                                REPEAT
                                    amount_Dec_Loc += position_Re_Loc.Amount * purchRcptLine_Re_Loc.Quantity * position_Re_Loc.Rate;
                                UNTIL (position_Re_Loc.NEXT() = 0);

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

                    //ajout dans le rec temp
                    PLLogistic_Re_Temp."Planned Element ID" := plannedElement_Re_Loc.ID;
                    PLLogistic_Re_Temp."Planned Element Type No." := plannedElement_Re_Loc.Fee_ID;
                    PLLogistic_Re_Temp."Planned Amount" := amount_Dec_Loc;

                    //real
                    //-----------------------------------------------------------------------------------

                    //on cherche les éléments réalisés pour un élément prévu
                    realElement_Re_Loc.RESET();
                    realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                    realElement_Re_Loc.SETRANGE(Deal_ID, ID);
                    realElement_Re_Loc.SETRANGE(Type, realElement_Re_Loc.Type::Invoice); //CHG-DEV-PROVISION filter sur invoice|provision
                    realElement_Re_Loc.SETRANGE(Fee_ID, plannedElement_Re_Loc.Fee_ID);
                    realElement_Re_Loc.SETRANGE(Fee_Connection_ID, plannedElement_Re_Loc.Fee_Connection_ID);
                    //on boucle sur tous les elements de type Fee
                    IF realElement_Re_Loc.FINDFIRST THEN BEGIN
                        REPEAT

                            //filtre sur les positions avec element id correspondant
                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Deal_ID, ID);
                            position_Re_Loc.SETRANGE(Element_ID, realElement_Re_Loc.ID);
                            IF position_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    IF dealShipCon_Re_Loc.GET(ID, PLLogisticShipmentNo_Co, position_Re_Loc."Sub Element_ID") THEN BEGIN
                                        //PLLogistic_Re_Temp."Real Element ID" := realElement_Re_Loc.ID;
                                        PLLogistic_Re_Temp."Real Amount" += position_Re_Loc."Line Amount (EUR)";
                                    END

                                UNTIL (position_Re_Loc.NEXT() = 0);

                        UNTIL (realElement_Re_Loc.NEXT() = 0);

                        PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                        IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                    END ELSE BEGIN

                        PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                        IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                    END;



                    PositionSummary_Re_Temp.DELETEALL;


                    position_Re_Loc.RESET();
                    position_Re_Loc.SETFILTER(Deal_ID, ID);

                    IF position_Re_Loc.FINDFIRST THEN
                        REPEAT
                            //on controle si cet article a déjà été ajouté (si oui, on skip, si non on calcule et ajoute)
                            IF NOT PositionSummary_Re_Temp.GET(position_Re_Loc."Deal Item No.") THEN BEGIN

                                //insertion dans la table temporaire

                                PositionSummary_Re_Temp.INIT();

                                PositionSummary_Re_Temp.VALIDATE("Item No.", position_Re_Loc."Deal Item No.");

                                IF item_Re_Loc.GET(position_Re_Loc."Deal Item No.") THEN
                                    PositionSummary_Re_Temp.Description := item_Re_Loc.Description;

                                //PLANNED

                                PositionSummary_Re_Temp."Planned Sales" :=
                                  Deal_Item_Cu.FNC_Get_Sales_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                                PositionSummary_Re_Temp."Planned Purchases" :=
                                  Deal_Item_Cu.FNC_Get_Purchases_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                                PositionSummary_Re_Temp."Planned Fees" :=
                                  Deal_Item_Cu.FNC_Get_Fees_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                                PositionSummary_Re_Temp."Planned Gross Margin" :=
                                  PositionSummary_Re_Temp."Planned Sales" + PositionSummary_Re_Temp."Planned Purchases";

                                PositionSummary_Re_Temp."Planned Final Margin" :=
                                  PositionSummary_Re_Temp."Planned Gross Margin" + PositionSummary_Re_Temp."Planned Fees";

                                IF PositionSummary_Re_Temp."Planned Sales" <> 0 THEN BEGIN
                                    PositionSummary_Re_Temp."Planned % Of Gross Margin" :=
                                      ((PositionSummary_Re_Temp."Planned Gross Margin" * 100) / PositionSummary_Re_Temp."Planned Sales") / 100;

                                    PositionSummary_Re_Temp."Planned % Of Final Margin" :=
                                      ((PositionSummary_Re_Temp."Planned Final Margin" * 100) / PositionSummary_Re_Temp."Planned Sales") / 100;
                                END;

                                //REAL

                                PositionSummary_Re_Temp."Real Sales" :=
                                  Deal_Item_Cu.FNC_Get_Sales_Amount(
                                   Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                                PositionSummary_Re_Temp."Real Purchases" :=
                                  Deal_Item_Cu.FNC_Get_Purchases_Amount(
                                   Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                                PositionSummary_Re_Temp."Real Fees" :=
                                  Deal_Item_Cu.FNC_Get_Fees_Amount(
                                    Rec.ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                                PositionSummary_Re_Temp."Real Gross Margin" :=
                                  PositionSummary_Re_Temp."Real Sales" + PositionSummary_Re_Temp."Real Purchases";

                                PositionSummary_Re_Temp."Real Final Margin" :=
                                  PositionSummary_Re_Temp."Real Gross Margin" + PositionSummary_Re_Temp."Real Fees";

                                IF PositionSummary_Re_Temp."Real Sales" <> 0 THEN BEGIN
                                    PositionSummary_Re_Temp."Real % Of Gross Margin" :=
                                      ((PositionSummary_Re_Temp."Real Gross Margin" * 100) / PositionSummary_Re_Temp."Real Sales") / 100;

                                    PositionSummary_Re_Temp."Real % Of Final Margin" :=
                                      ((PositionSummary_Re_Temp."Real Final Margin" * 100) / PositionSummary_Re_Temp."Real Sales") / 100;
                                END;

                                IF NOT PositionSummary_Re_Temp.INSERT(FALSE) THEN;

                            END;
                        UNTIL (position_Re_Loc.NEXT() = 0);

                    // Call our Subpage update function
                    CurrPage.PositionDetails.PAGE.SetTempRecord(PositionSummary_Re_Temp);

    end;

    trigger OnInit()
    begin
        ProNegPercFinalMarginCtrlVisib := TRUE;
        ProPercFinalMarginCtrlVisible := TRUE;
        RNegPercFinalMarginCtrlVisible := TRUE;
        RPercFinalMarginCtrlVisible := TRUE;
        PNegPercFinalMarginCtrlVisible := TRUE;
        PPercFinalMarginCtrlVisible := TRUE;
        FNC_InitVars();
    end;

    var
        //TODO
        // Deal_Item_Cu: Codeunit "50024";
        // Element_Cu: Codeunit "50021";
        // Deal_Cu: Codeunit "50020";
        // Position_Cu: Codeunit "50022";
        // DealShipment_Cu: Codeunit "50029";
        // UpdateRequestManager_Cu: Codeunit "50032";
        Comment: Boolean;
        Pro_Sales_Dec: Decimal;
        Pro_Purchases_Dec: Decimal;
        Pro_Fees_Dec: Decimal;
        Pro_Gross_Margin_Dec: Decimal;
        Pro_Final_Margin_Dec: Decimal;
        Pro_Percent_Gross_Margin_Dec: Decimal;
        Pro_Percent_Final_Margin_Dec: Decimal;
        Pro_Neg_Perc_Final_Margin_Dec: Decimal;
        P_Sales_Dec: Decimal;
        P_Purchases_Dec: Decimal;
        P_Fees_Dec: Decimal;
        P_Gross_Margin_Dec: Decimal;
        P_Final_Margin_Dec: Decimal;
        P_Percent_Gross_Margin_Dec: Decimal;
        P_Percent_Final_Margin_Dec: Decimal;
        P_Neg_Perc_Final_Margin_Dec: Decimal;
        R_Sales_Dec: Decimal;
        R_Purchases_Dec: Decimal;
        R_Fees_Dec: Decimal;
        R_Gross_Margin_Dec: Decimal;
        R_Final_Margin_Dec: Decimal;
        R_Percent_Gross_Margin_Dec: Decimal;
        R_Percent_Final_Margin_Dec: Decimal;
        R_Neg_Perc_Final_Margin_Dec: Decimal;
        D_Sales_Dec: Decimal;
        D_Purchases_Dec: Decimal;
        D_Fees_Dec: Decimal;
        D_Gross_Margin_Dec: Decimal;
        D_Final_Margin_Dec: Decimal;
        PositionSummary_Re_Temp: Record "DEL Position Summary" temporary;
        ShipmentList_Te: Text[50];
        ItemDetailShipmentNo_Co: Code[20];
        PLDetailShipmentNo_Co: Code[20];
        PLShipmentNo_Co: Code[20];
        PLLogisticShipmentNo_Co: Code[20];
        PLLogistic_Re_Temp: Record "DEL P&L Logistic" temporary;
        [InDataSet]
        PPercFinalMarginCtrlVisible: Boolean;
        [InDataSet]
        PNegPercFinalMarginCtrlVisible: Boolean;
        [InDataSet]
        RPercFinalMarginCtrlVisible: Boolean;
        [InDataSet]
        RNegPercFinalMarginCtrlVisible: Boolean;
        [InDataSet]
        ProPercFinalMarginCtrlVisible: Boolean;
        [InDataSet]
        ProNegPercFinalMarginCtrlVisib: Boolean;
        Text19054020: Label 'L O G I S T I C S';
        Text19024619: Label 'I T E M S   D E T A I L';
        Text19054932: Label 'P L A N N E D';
        Text19019719: Label 'R E A L';
        Text19036953: Label 'P R O F I T S  &&  L O S S E S  D E T A I L';
        Text19004363: Label 'P R O F I T S  &&  L O S S E S';
        Text19043039: Label 'P R O F I T S  &&  L O S S E S  L O G I S T I C';
        Text19006783: Label 'A C O';
        Text19006410: Label 'V C O';
        Text19002194: Label 'Planned';
        Text19075186: Label '% of Gross Income';
        Text19032023: Label 'Real';
        Text19061674: Label 'Projected';
        Text19042911: Label 'Delta';
        Text19010011: Label 'N G T S';


    procedure FNC_InitVars()
    begin
        D_Sales_Dec := 0;
        D_Purchases_Dec := 0;
        D_Fees_Dec := 0;
        D_Gross_Margin_Dec := 0;
        D_Final_Margin_Dec := 0;

        R_Sales_Dec := 0;
        R_Purchases_Dec := 0;
        R_Fees_Dec := 0;
        R_Gross_Margin_Dec := 0;
        R_Final_Margin_Dec := 0;
        R_Percent_Gross_Margin_Dec := 0;
        R_Percent_Final_Margin_Dec := 0;
        R_Neg_Perc_Final_Margin_Dec := 0;

        P_Sales_Dec := 0;
        P_Purchases_Dec := 0;
        P_Fees_Dec := 0;
        P_Gross_Margin_Dec := 0;
        P_Final_Margin_Dec := 0;
        P_Percent_Gross_Margin_Dec := 0;
        P_Percent_Final_Margin_Dec := 0;
        P_Neg_Perc_Final_Margin_Dec := 0;

        Pro_Sales_Dec := 0;
        Pro_Purchases_Dec := 0;
        Pro_Fees_Dec := 0;
        Pro_Gross_Margin_Dec := 0;
        Pro_Final_Margin_Dec := 0;
        Pro_Percent_Gross_Margin_Dec := 0;
        Pro_Percent_Final_Margin_Dec := 0;
        Pro_Neg_Perc_Final_Margin_Dec := 0;
    end;

    local procedure PLShipmentNoCoOnAfterValidate()
    begin
        CurrPage.UPDATE
    end;

    local procedure PLLogisticShipmentNoCoOnAfterV()
    begin
        CurrPage.UPDATE
    end;

    local procedure PLDetailShipmentNoCoOnAfterVal()
    begin
        CurrPage.UPDATE
    end;

    local procedure Control1103070011OnDeactivate()
    begin
        PAGE.RUN(PAGE::"Currency Exchange")
    end;
}

