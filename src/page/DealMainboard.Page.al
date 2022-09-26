page 50030 "Deal Mainboard"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 23.03.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            23.03.09   Affichage du % vente sur marge final en négatif selon DEV12
    // CHG02                            06.04.09   adapté l'appel de fonction de création de l'affaire
    // CHG03                            26.09.11   adapted deal update function with "updatePlanned" parameter
    // THM                              24.10.2013  change ShipmentList_Te length 30 to 50

    Caption = 'Deal Card';
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Table50020;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(ID; ID)
                {
                    Importance = Promoted;
                }
                field(Status; Status)
                {
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    Editable = false;
                }
            }
            part(ACO; 50031)
            {
                Caption = 'ACO';
                SubPageLink = Deal_ID = FIELD (ID),
                              Type = CONST (ACO),
                              Instance = FILTER (planned);
            }
            part(VCO; 50032)
            {
                Caption = 'VCO';
                SubPageLink = Deal_ID = FIELD (ID),
                              Type = CONST (VCO),
                              Instance = CONST (planned);
            }
            part("Subpage Logistic"; 50037)
            {
                Caption = 'Logistique';
                SubPageLink = Deal_ID = FIELD (ID);
            }
            field(ItemDetailShipmentNo_Co; ItemDetailShipmentNo_Co)
            {
                Caption = 'Shipment';
                TableRelation = "Deal Shipment".ID;

                trigger OnLookup(var Text: Text): Boolean
                var
                    dealShipment_Re_Loc: Record "50030";
                    mypage: Page "50040";
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
                    dealShipment_Re_Loc: Record "50030";
                begin
                    IF dealShipment_Re_Loc.GET(ItemDetailShipmentNo_Co) THEN
                        CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, dealShipment_Re_Loc."BR No.")
                    ELSE
                        CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, '');
                end;
            }
            part(ShipmentSubpage; 50041)
            {
                Caption = 'Détail Articles';
            }
            part("Prévu"; 50033)
            {
                Caption = 'Prévu';
                SubPageLink = Deal_ID = FIELD (ID),
                              Instance = CONST (planned);
            }
            part("Réalisé"; 50034)
            {
                Caption = 'Réalisé';
                SubPageLink = Deal_ID = FIELD (ID),
                              Instance = CONST (real),
                              Type = FILTER (<> BR);
            }
            field(PLLogisticShipmentNo_Co; PLLogisticShipmentNo_Co)
            {
                Caption = 'Shipment';
                TableRelation = "Deal Shipment".ID;

                trigger OnLookup(var Text: Text): Boolean
                var
                    dealShipment_Re_Loc: Record "50030";
                    myPage: Page "50040";
                begin
                    dealShipment_Re_Loc.RESET();
                    dealShipment_Re_Loc.SETRANGE(Deal_ID, ID);

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
                    dealShipment_Re_Loc: Record "50030";
                begin
                    //dealShipment_Re_Loc.GET(ItemDetailShipmentNo_Co);
                    //Currpage.ShipmentSubpage.page.UpdateFilters(dealShipment_Re_Loc."BR No.");
                    PLLogisticShipmentNoCoOnAfterV;
                end;
            }
            part(PLLogistic; 50045)
            {
                Caption = 'P&&L Logistique';
                Editable = false;
            }
            field(PLDetailShipmentNo_Co; PLDetailShipmentNo_Co)
            {
                Caption = 'Shipment';
                TableRelation = "Deal Shipment".ID;

                trigger OnLookup(var Text: Text): Boolean
                var
                    dealShipment_Re_Loc: Record "50030";
                    myPage: Page "50040";
                begin
                    dealShipment_Re_Loc.RESET();
                    dealShipment_Re_Loc.SETRANGE(Deal_ID, ID);

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
                    dealShipment_Re_Loc: Record "50030";
                begin
                    //dealShipment_Re_Loc.GET(ItemDetailShipmentNo_Co);
                    //Currpage.ShipmentSubpage.page.UpdateFilters(dealShipment_Re_Loc."BR No.");
                    PLDetailShipmentNoCoOnAfterVal;
                end;
            }
            part(PositionDetails; 50035)
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
                        DealShip_Re_Loc: Record "50030";
                        DealShipList_Fo_Loc: Page "50040";
                        CurrencyExchange_page_Loc: Page "50039";
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
                        CurrencyExchange_Re_Loc: Record "50028";
                        CurrencyExchange_page_Loc: Page "50039";
                    begin
                        //obsolet 05.08.08
                        //page.RUNMODAL(page::"Currency Exchange");

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
                        urm_Re_Loc: Record "50039";
                    begin
                        //START CHG02
                        //Deal_Cu.FNC_Reinit_Deal(ID,FALSE,FALSE);
                        //STOP CHG02

                        requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                          ID,
                          urm_Re_Loc.Requested_By_Type::CUSTOM,
                          USERID,
                          CURRENTDATETIME
                        );

                        urm_Re_Loc.GET(requestID_Co_Loc);

                        //begin THM optimisation
                        //UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,FALSE,TRUE);

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
                        urm_Re_Loc: Record "50039";
                    begin

                        requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                          ID,
                          urm_Re_Loc.Requested_By_Type::CUSTOM,
                          USERID,
                          CURRENTDATETIME
                        );

                        urm_Re_Loc.GET(requestID_Co_Loc);

                        //begin THM optimisation

                        //UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,TRUE,TRUE);

                        UpdateRequestManager_Cu.FNC_Process_RequestsDeal(urm_Re_Loc, FALSE, TRUE, TRUE, requestID_Co_Loc);
                        urm_Re_Loc.SETRANGE(urm_Re_Loc.ID, requestID_Co_Loc);
                        IF urm_Re_Loc.FINDFIRST THEN
                            urm_Re_Loc.DELETE;
                        // end THM

                        CurrPage.UPDATE();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        plannedElement_Re_Loc: Record "50021";
        realElement_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
        item_Re_Loc: Record "27";
        dealShipment_Re_Loc: Record "50030";
        BR_Header_Re_Loc: Record "120";
        purchRcptLine_Re_Loc: Record "121";
        element_Re_Loc: Record "50021";
        amount_Dec_Loc: Decimal;
        dealShipmentConnection_Re_Loc: Record "50032";
        elementConnection_Re_Loc: Record "50027";
        dealShipCon_Re_Loc: Record "50032";
    begin
        FNC_InitVars();

        //------------------------------------------
        /*ONGLET LOGISTIQUE*/
        //------------------------------------------
        CurrPage."Subpage Logistic".PAGE.FNC_Set_Deal_ID(ID);

        //------------------------------------------
        /*ONGLET ITEMS DETAIL*/
        //------------------------------------------
        IF ItemDetailShipmentNo_Co = '' THEN
            CurrPage.ShipmentSubpage.PAGE.FNC_SetFilters(ID, '');

        //------------------------------------------
        /*ONGLET P&L*/
        //------------------------------------------

        /*
        P = Planned
        R = Real
        D = Delta
        */

        //PLANNED
        /*
          P_Sales_Dec     := Deal_Cu.FNC_Get_VCO_Amount(ID, PLShipmentNo_Co);
          P_Purchases_Dec := Deal_Cu.FNC_Get_ACO_Amount(ID, PLShipmentNo_Co);
          P_Fees_Dec      := Deal_Cu.FNC_Get_Fee_Amount(ID, PLShipmentNo_Co);
        
          P_Gross_Margin_Dec := P_Sales_Dec + P_Purchases_Dec;
          P_Final_Margin_Dec := P_Gross_Margin_Dec + P_Fees_Dec;
        
          IF P_Sales_Dec <> 0 THEN BEGIN
            P_Percent_Gross_Margin_Dec := ((P_Gross_Margin_Dec * 100) / P_Sales_Dec) / 100;
        
            //START CHG01
            //si la marge est positive, on affiche l'indicateur (barre pourcentage) et on cache le label
            IF (((P_Final_Margin_Dec * 100) / P_Sales_Dec) / 100 > 0) THEN BEGIN
              P_Percent_Final_Margin_Dec := ((P_Final_Margin_Dec * 100) / P_Sales_Dec) / 100;
              PPercFinalMarginCtrlVisible := TRUE;
              PNegPercFinalMarginCtrlVisible := FALSE;
            //sinon on masque l'indicateur (car il ne peut pas afficher de % négatifs) et on affiche le label avec le pourcentage négatif
            END ELSE BEGIN
              P_Neg_Perc_Final_Margin_Dec := ((P_Final_Margin_Dec * 100) / P_Sales_Dec);
              PPercFinalMarginCtrlVisible := FALSE;
              PNegPercFinalMarginCtrlVisible := TRUE;
            END;
            //STOP CHG01
        
            //MESSAGE(pageAT(((P_Final_Margin_Dec * 100) / P_Sales_Dec) / 100));
          END;
        
        //REAL
          R_Sales_Dec     := Deal_Cu.FNC_Get_SalesInvoice_Amount(ID, PLShipmentNo_Co)
                             + Deal_Cu.FNC_Get_SalesCrMemo_Amount(ID, PLShipmentNo_Co);
          R_Purchases_Dec := Deal_Cu.FNC_Get_PurchInvoice_Amount(ID, PLShipmentNo_Co)
                             + Deal_Cu.FNC_Get_PurchCrMemo_Amount(ID, PLShipmentNo_Co);
          R_Fees_Dec      := Deal_Cu.FNC_Get_Invoice_Amount(ID, PLShipmentNo_Co);
        
          R_Gross_Margin_Dec := R_Sales_Dec + R_Purchases_Dec;
          R_Final_Margin_Dec := R_Gross_Margin_Dec + R_Fees_Dec;
        
          IF R_Sales_Dec <> 0 THEN BEGIN
            R_Percent_Gross_Margin_Dec := ((R_Gross_Margin_Dec * 100) / R_Sales_Dec) / 100;
        
            //START CHG01
            //si la marge est positive, on affiche l'indicateur (barre pourcentage) et on cache le label
            IF (((R_Final_Margin_Dec * 100) / R_Sales_Dec) / 100 > 0) THEN BEGIN
              R_Percent_Final_Margin_Dec := ((R_Final_Margin_Dec * 100) / R_Sales_Dec) / 100;
              RPercFinalMarginCtrlVisible := TRUE;
              RNegPercFinalMarginCtrlVisible := FALSE;
            //sinon on masque l'indicateur (car il ne peut pas afficher de % négatifs) et on affiche le label avec le pourcentage négatif
            END ELSE BEGIN
              R_Neg_Perc_Final_Margin_Dec := ((R_Final_Margin_Dec * 100) / R_Sales_Dec);
              RPercFinalMarginCtrlVisible := FALSE;
              RNegPercFinalMarginCtrlVisible := TRUE;
            END;
            //STOP CHG01
        
          END ELSE BEGIN
            RPercFinalMarginCtrlVisible := TRUE;
            RNegPercFinalMarginCtrlVisible := FALSE;
          END;
        
        //PROJECTED
          Pro_Sales_Dec     := Deal_Cu.FNC_Get_ProSales_Amount(ID, PLShipmentNo_Co);
          Pro_Purchases_Dec := Deal_Cu.FNC_Get_ProPurch_Amount(ID, PLShipmentNo_Co);
          Pro_Fees_Dec      := Deal_Cu.FNC_Get_ProLog_Amount(ID, PLShipmentNo_Co);
        
          Pro_Gross_Margin_Dec := Pro_Sales_Dec + Pro_Purchases_Dec;
          Pro_Final_Margin_Dec := Pro_Gross_Margin_Dec + Pro_Fees_Dec;
        
          IF Pro_Sales_Dec <> 0 THEN BEGIN
            Pro_Percent_Gross_Margin_Dec := ((Pro_Gross_Margin_Dec * 100) / Pro_Sales_Dec) / 100;
            //Pro_Percent_Final_Margin_Dec := ((Pro_Final_Margin_Dec * 100) / Pro_Sales_Dec) / 100;
        
            //START CHG01
            //si la marge est positive, on affiche l'indicateur (barre pourcentage) et on cache le label
            IF (((Pro_Final_Margin_Dec * 100) / Pro_Sales_Dec) / 100 > 0) THEN BEGIN
              Pro_Percent_Final_Margin_Dec := ((Pro_Final_Margin_Dec * 100) / Pro_Sales_Dec) / 100;
              ProPercFinalMarginCtrlVisible := TRUE;
              ProNegPercFinalMarginCtrlVisib := FALSE;
            //sinon on masque l'indicateur (car il ne peut pas afficher de % négatifs) et on affiche le label avec le pourcentage négatif
            END ELSE BEGIN
              Pro_Neg_Perc_Final_Margin_Dec := ((Pro_Final_Margin_Dec * 100) / Pro_Sales_Dec);
              ProPercFinalMarginCtrlVisible := FALSE;
              ProNegPercFinalMarginCtrlVisib := TRUE;
            END;
            //STOP CHG01
        
          END;
        
        
        //DELTA
          D_Sales_Dec        := R_Sales_Dec        - P_Sales_Dec;
          D_Purchases_Dec    := R_Purchases_Dec    - P_Purchases_Dec;
          D_Fees_Dec         := R_Fees_Dec         - P_Fees_Dec;
          D_Gross_Margin_Dec := R_Gross_Margin_Dec - P_Gross_Margin_Dec;
          D_Final_Margin_Dec := R_Final_Margin_Dec - P_Final_Margin_Dec;
        */
        //------------------------------------------
        /*ONGLET P&L Logistic*/
        //------------------------------------------
        // don't forget to check 1000x that PLLogistic_Re_Temp is REALY set Temporary
        // before you start to test your solution :o)
        PLLogistic_Re_Temp.DELETEALL;
        //CLEARALL;

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


                    /*
                    //on regarde si il y a des invoice pour cette livraison
                    dealShipmentConnection_Re_Loc.RESET();
                    dealShipmentConnection_Re_Loc.SETRANGE(Deal_ID, ID);
                    dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, PLShipmentNo_Co);
                    IF dealShipmentConnection_Re_Loc.Findfirst THEN BEGIN
                      REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, dealShipmentConnection_Re_Loc.Element_ID);

                        //on regarde sur quel(s) Element(s) l'invoice a été dispatché
                        IF element_Re_Loc.Type = element_Re_Loc.Type::Invoice THEN BEGIN

                          elementConnection_Re_Loc.RESET();
                          elementConnection_Re_Loc.SETRANGE(Deal_ID, ID);
                          elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                          elementConnection_Re_Loc.SETRANGE("Apply To", plannedElement_Re_Loc.ID);
                          IF elementConnection_Re_Loc.Findfirst THEN BEGIN
                            REPEAT
                              //on regarde si l'élément sur lequel a été dispatché une invoice apparatient à la livraison en cours
                              //IF dealShipCon_Re_Loc.GET(ID, PLShipmentNo_Co, elementConnection_Re_Loc."Apply To") THEN BEGIN

                                //filtre sur les positions avec element id et sub element id correspondant
                                position_Re_Loc.RESET();
                                position_Re_Loc.SETRANGE(Deal_ID, ID);
                                position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                                position_Re_Loc.SETRANGE("Sub Element_ID", elementConnection_Re_Loc."Apply To");
                                IF position_Re_Loc.Findfirst THEN
                                  REPEAT

                                    //PLLogistic_Re_Temp."Real Element ID" := realElement_Re_Loc.ID;
                                    PLLogistic_Re_Temp."Real Amount" += position_Re_Loc."Line Amount (EUR)";

                                  UNTIL(position_Re_Loc.NEXT() = 0);
                              //END
                            UNTIL(elementConnection_Re_Loc.NEXT() = 0);
                          END;

                        END ELSE BEGIN

                          PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                          IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                        END;

                      UNTIL(dealShipmentConnection_Re_Loc.NEXT() = 0);
                    END;
                    //-----------------------------------------------------------------------------------
                       */

                    /*
                    //on cherche les éléments réalisés pour un élément prévu
                    realElement_Re_Loc.RESET();
                    realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                    realElement_Re_Loc.SETRANGE(Deal_ID, ID);
                    realElement_Re_Loc.SETRANGE(Type, realElement_Re_Loc.Type::Invoice); //CHG-DEV-PROVISION filter sur invoice|provision
                    realElement_Re_Loc.SETRANGE(Fee_ID, plannedElement_Re_Loc.Fee_ID);
                    realElement_Re_Loc.SETRANGE(Fee_Connection_ID, plannedElement_Re_Loc.Fee_Connection_ID);
                    //on boucle sur tous les elements de type Fee
                    IF realElement_Re_Loc.Findfirst THEN BEGIN
                      REPEAT

                        IF NOT PLLogistic_Re_Temp.GET(plannedElement_Re_Loc.ID, realElement_Re_Loc.ID) THEN BEGIN

                          //si realElement est enregistré pour cette livraison
                          IF dealShipmentConnection_Re_Loc.GET(ID, PLLogisticShipmentNo_Co, realElement_Re_Loc.ID) THEN BEGIN

                            PLLogistic_Re_Temp."Real Element ID" := realElement_Re_Loc.ID;
                            PLLogistic_Re_Temp."Real Amount" += Element_Cu.FNC_Get_Amount_From_Positions(realElement_Re_Loc.ID);

                          END;

                       END;

                      UNTIL(realElement_Re_Loc.NEXT()=0);

                      PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                      IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                    END ELSE BEGIN

                      PLLogistic_Re_Temp.Delta := PLLogistic_Re_Temp."Real Amount" - PLLogistic_Re_Temp."Planned Amount";
                      IF NOT PLLogistic_Re_Temp.INSERT(FALSE) THEN;

                    END;
                    */

                UNTIL (plannedElement_Re_Loc.NEXT() = 0);

        END;

        // Call our Subpage update function
        CurrPage.PLLogistic.PAGE.SetTempRecord(PLLogistic_Re_Temp);


        //------------------------------------------
        /*ONGLET P&L Details*/
        //------------------------------------------

        // don't forget to check 1000x that PositionSummary_Re_Temp is REALY set Temporary
        // before you start to test your solution :o)
        PositionSummary_Re_Temp.DELETEALL;
        //CLEARALL;

        position_Re_Loc.RESET();
        position_Re_Loc.SETFILTER(Deal_ID, ID);
        //on boucle sur toutes les positions, comme ca on est sur d'avoir tous les articles
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
                        ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                    PositionSummary_Re_Temp."Planned Purchases" :=
                      Deal_Item_Cu.FNC_Get_Purchases_Amount(
                        ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

                    PositionSummary_Re_Temp."Planned Fees" :=
                      Deal_Item_Cu.FNC_Get_Fees_Amount(
                        ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Planned);

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
                        ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                    PositionSummary_Re_Temp."Real Purchases" :=
                      Deal_Item_Cu.FNC_Get_Purchases_Amount(
                        ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

                    PositionSummary_Re_Temp."Real Fees" :=
                      Deal_Item_Cu.FNC_Get_Fees_Amount(
                        ID, PLDetailShipmentNo_Co, position_Re_Loc."Deal Item No.", position_Re_Loc.Instance::Real);

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
        Deal_Item_Cu: Codeunit "50024";
        Element_Cu: Codeunit "50021";
        Deal_Cu: Codeunit "50020";
        Position_Cu: Codeunit "50022";
        DealShipment_Cu: Codeunit "50029";
        UpdateRequestManager_Cu: Codeunit "50032";
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
        PositionSummary_Re_Temp: Record "50029" temporary;
        ShipmentList_Te: Text[50];
        ItemDetailShipmentNo_Co: Code[20];
        PLDetailShipmentNo_Co: Code[20];
        PLShipmentNo_Co: Code[20];
        PLLogisticShipmentNo_Co: Code[20];
        PLLogistic_Re_Temp: Record "50036" temporary;
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

    [Scope('Internal')]
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

