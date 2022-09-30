codeunit 50020 Deal
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 09.09.08                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01  RC4                       09.09.08   Created Doc
    // CHG02                            15.09.08   Changed deal status attribution rule
    // CHG03                            15.09.08   Correction du calcul des montants ACO et VCO par livraison
    // CHG04                            06.04.09   Added FNC_Reinit_Silently_Method which cause a reinit with not message nor warnings
    //                                             Adapted FNC_Reinit_Deal to handle silent update
    //                                             Adapted FNC_Init_Deal to handle silent update
    //                                             Correction de l'implémentation du paramètre "Update_Planned_Bo_Par"
    // CHG05                            20.04.09   Added FNC_Set_LastUpdate_DateTime
    // STG01                            28.05.09   Reinitialization possible if real elements are not Purchase Invoice or Sales Invoice
    // CHG06                            07.09.09   Gestion de la période
    // CHG07                            11.03.10   Définition du nouveau champ Deal."ACO Docuement Date"
    // CHG08                            26.09.11   adapted deal update function with "updatePlanned" parameter
    // THM        THM150118             15.01.18   add vendor No
    // 
    // Mgts10.00.01.00 | 11.01.2020 | Order API Management : Add C\AL : FNC_Init_Deal


    trigger OnRun()
    begin
    end;

    var
        Element_Cu: Codeunit "50021";
        Position_Cu: Codeunit "50022";
        Fee_Cu: Codeunit "50023";
        NoSeriesMgt_Cu: Codeunit "396";
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';
        Setup: Record "50000";
        DealShipment_Cu: Codeunit "50029";
        DealItem_Cu: Codeunit "50024";
        Currency_Exchange_Re: Record "50028";

    [Scope('Internal')]
    procedure FNC_New_Deal(ACO_No_Co_Par: Code[20]) deal_ID_Co_Ret: Code[20]
    var
        purchaseHeader_Re_Loc: Record "38";
        purchaseHeaderArchive_Re_Loc: Record "5109";
    begin
        /*__Creates a Deal and attaches this.ACO on it__*/

        IF purchaseHeader_Re_Loc.GET(purchaseHeader_Re_Loc."Document Type"::Order, ACO_No_Co_Par) THEN BEGIN

            deal_ID_Co_Ret :=
              FNC_Insert_Deal(
                'AFF' + COPYSTR(ACO_No_Co_Par, STRPOS(ACO_No_Co_Par, '-')),
                purchaseHeader_Re_Loc."Purchaser Code",
                //CHG07
                purchaseHeader_Re_Loc."Document Date"
              );

            /*_Links this.ACO to the knewly created Deal_*/
            FNC_Attach_ACO(deal_ID_Co_Ret, ACO_No_Co_Par);

        END ELSE BEGIN
            purchaseHeaderArchive_Re_Loc.SETRANGE("Document Type", purchaseHeaderArchive_Re_Loc."Document Type"::Order);
            purchaseHeaderArchive_Re_Loc.SETRANGE("No.", ACO_No_Co_Par);
            IF purchaseHeaderArchive_Re_Loc.FINDLAST THEN BEGIN
                deal_ID_Co_Ret :=
                  FNC_Insert_Deal(
                    'AFF' + COPYSTR(ACO_No_Co_Par, STRPOS(ACO_No_Co_Par, '-')),
                    purchaseHeaderArchive_Re_Loc."Purchaser Code",
                    //CHG07
                    purchaseHeaderArchive_Re_Loc."Document Date"
                  );

                /*_Links this.ACO to the knewly created Deal_*/
                FNC_Attach_ACO(deal_ID_Co_Ret, ACO_No_Co_Par);
            END;
        END;

    end;

    [Scope('Internal')]
    procedure FNC_Init_Deal(Deal_ID_Co_Par: Code[20]; Update_Planned_Bo_Par: Boolean; Update_Silently_Bo_Par: Boolean)
    var
        intProgressI: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        success_Bo_Loc: Boolean;
        "-MGTS10.00-": Integer;
        APIOrdersTrackRecordsMgt: Codeunit "50044";
    begin
        /*__Initialises a Deal by adding Elements and their Positions__*/

        /*_Adds Planned Elements if required_*/
        Element_Cu.FNC_Add_Planned_Elements(Deal_ID_Co_Par, Update_Planned_Bo_Par);

        /*_Adds Real Elements if required_*/
        Element_Cu.FNC_Add_Real_Elements(Deal_ID_Co_Par);

        /*_Adds Positions for Planned and Real Elements_*/
        Position_Cu.FNC_Add_Positions(Deal_ID_Co_Par, Update_Planned_Bo_Par, Update_Silently_Bo_Par);

        //>>Mgts10.00
        APIOrdersTrackRecordsMgt.UpdateOrderAPIRecordTracking(Deal_ID_Co_Par);
        //<<Mgts10.00

    end;

    [Scope('Internal')]
    procedure FNC_Reinit_Deal(Deal_ID_Co_Par: Code[20]; Update_Planned_Par: Boolean; Update_Silently_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
        deal_Item_Re_Loc: Record "50023";
        elementConnection_Re_Loc: Record "50027";
        ACO_Re_Loc: Record "38";
        VCO_Re_Loc: Record "36";
        update_planned: Boolean;
        dealShipment_Re_Loc: Record "50030";
    begin
        /*__
        
          Le paramètre update_planned_Par défini si il faut forcer la mise à jour du prévu ou non
        
        __*/

        //START CHG04
        IF Update_Planned_Par THEN BEGIN

            //le paramètre a été défini comme vrai, on update donc le prévu sans tester quoi que ca soit
            update_planned := TRUE;

        END ELSE BEGIN

            //le paramètre a été défini comme faux, il faut donc controler si il faut recalculer le prévu ou pas
            update_planned := FALSE;

            //on recalcule le prévu seulement si on ne trouve pas d'éléments réels facture achat/vente pour l'affaire en cours
            element_Re_Loc.RESET();
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Instance, position_Re_Loc.Instance::Real);
            //START STG01
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice", element_Re_Loc.Type::"Sales Invoice");
            //STOP STG01
            IF NOT element_Re_Loc.FINDFIRST THEN
                update_planned := TRUE;

        END;
        //STOP CHG04

        IF update_planned THEN BEGIN
            /*_Deletes Planned Positions, Element Connections and Elements for this.Deal_*/

            //MESSAGE('update planned');

            position_Re_Loc.RESET();
            position_Re_Loc.SETCURRENTKEY(Deal_ID);
            position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            position_Re_Loc.SETRANGE(Instance, position_Re_Loc.Instance::Planned);
            position_Re_Loc.DELETEALL();

            elementConnection_Re_Loc.RESET();
            elementConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            elementConnection_Re_Loc.SETRANGE(Instance, elementConnection_Re_Loc.Instance::planned);
            elementConnection_Re_Loc.DELETEALL();

            element_Re_Loc.RESET();
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Instance, position_Re_Loc.Instance::Planned);
            element_Re_Loc.DELETEALL();

            /*_Initialises this.Deal and updates Planned Elements_*/
            FNC_Init_Deal(Deal_ID_Co_Par, TRUE, Update_Silently_Par);

            /*_Updates this.Deal purchaser code_*/
            FNC_UpdatePurchaserCode(Deal_ID_Co_Par);

        END ELSE BEGIN

            /*_Initialises this.Deal without updating Planned Elements because some of them already have been archived_*/
            FNC_Init_Deal(Deal_ID_Co_Par, FALSE, Update_Silently_Par);

        END;

        /*_Updates this.Deal status_*/
        FNC_UpdateStatus(Deal_ID_Co_Par);

        //START CHG05
        /*_Sets the last update field to current date and time_*/
        FNC_Set_LastUpdate_DateTime(Deal_ID_Co_Par);
        //STOP CHG05

        //START CHG06
        /*_Sets the period field of elements according to a deal shipment sales invoice's posting date_*/
        FNC_UpdatePeriod(Deal_ID_Co_Par);
        //STOP CHG06

        IF NOT Update_Silently_Par THEN
            MESSAGE('Affaire %1 mise à jour avec succès !', Deal_ID_Co_Par);

    end;

    [Scope('Internal')]
    procedure FNC_Reinit_Silently_Deal(Deal_ID_Co_Par: Code[20]; UpdatePlanned_Bo_Par: Boolean)
    begin
        FNC_Reinit_Deal(Deal_ID_Co_Par, UpdatePlanned_Bo_Par, TRUE);
    end;

    [Scope('Internal')]
    procedure FNC_Delete(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        ACOConnection_Re_Loc: Record "50026";
        dealItem_Re_Loc: Record "50023";
        deal_Re_Loc: Record "50020";
        currencyExchange_Re_Loc: Record "50028";
        dealShipment_Re_Loc: Record "50030";
        dealShipmentSelection_Re_Loc: Record "50031";
        logistic_Re_Loc: Record "50034";
        sps_Re_Loc: Record "50042";
    begin
        /*__Supprime complétement et définitivement une affaire__*/

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT
                Element_Cu.FNC_Delete_Element(element_Re_Loc.ID)
            UNTIL (element_Re_Loc.NEXT() = 0);

        ACOConnection_Re_Loc.RESET();
        ACOConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        ACOConnection_Re_Loc.DELETEALL();

        dealItem_Re_Loc.RESET();
        dealItem_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        dealItem_Re_Loc.DELETEALL();

        currencyExchange_Re_Loc.RESET();
        currencyExchange_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        currencyExchange_Re_Loc.DELETEALL();

        dealShipment_Re_Loc.RESET();
        dealShipment_Re_Loc.SETCURRENTKEY(Deal_ID);
        dealShipment_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        dealShipment_Re_Loc.DELETEALL();

        dealShipmentSelection_Re_Loc.RESET();
        dealShipmentSelection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        dealShipmentSelection_Re_Loc.DELETEALL();

        sps_Re_Loc.RESET();
        sps_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        sps_Re_Loc.DELETEALL();

        logistic_Re_Loc.RESET();
        logistic_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        logistic_Re_Loc.DELETEALL();

        deal_Re_Loc.RESET();
        deal_Re_Loc.SETRANGE(ID, Deal_ID_Co_Par);
        deal_Re_Loc.DELETEALL();

    end;

    [Scope('Internal')]
    procedure FNC_Insert_Deal(Deal_ID_Co_Par: Code[20]; PurchaserCode_Co_Par: Code[10]; ACODocumentDate_Da_Par: Date) deal_ID_Co_Ret: Code[20]
    var
        deal_Re_Loc: Record "50020";
    begin
        /*__Inserts a row in the Deal table and returns its ID__*/

        IF NOT deal_Re_Loc.GET(Deal_ID_Co_Par) THEN BEGIN

            deal_ID_Co_Ret := Deal_ID_Co_Par;

            deal_Re_Loc.INIT();
            deal_Re_Loc.ID := deal_ID_Co_Ret;
            deal_Re_Loc.Status := deal_Re_Loc.Status::"In order";
            deal_Re_Loc.Date := TODAY;
            deal_Re_Loc.VALIDATE("Purchaser Code", PurchaserCode_Co_Par);
            //CHG07
            deal_Re_Loc."ACO Document Date" := ACODocumentDate_Da_Par;

            IF NOT deal_Re_Loc.INSERT() THEN
                ERROR(ERROR_TXT, 'Co 50020', 'FNC_Insert_New_Deal()', 'Insert() impossible dans la table Deal');

        END ELSE
            ERROR(ERROR_TXT, 'Co 50020', 'FNC_Insert_New_Deal()', 'Cette affaire est déjà existante !');

    end;

    [Scope('Internal')]
    procedure FNC_Set_Deal(var Deal_Re_Par: Record "50020"; Deal_ID_Co_Par: Code[20])
    begin
        /*__Sets by instance Deal_Re_Par according to Deal_ID_Co_Par, and raises an error could not__*/

        IF NOT Deal_Re_Par.GET(Deal_ID_Co_Par) THEN
            ERROR(ERROR_TXT, 'Co 50020', 'FNC_Set_Deal()', FORMAT('GET() impossible avec Deal.ID >' + Deal_ID_Co_Par + '<'));

    end;

    [Scope('Internal')]
    procedure FNC_Get_ACO(var element_Re_Par: Record "50021"; dealID_Co_Par: Code[20])
    begin
        //filtre un record element (passé par REF) sur le premier élément ACO d'une affaire

        /*_On cherche l'ACO liée à l'affaire_*/
        element_Re_Par.RESET();
        element_Re_Par.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Par.SETRANGE(Deal_ID, dealID_Co_Par);
        element_Re_Par.SETRANGE(Type, element_Re_Par.Type::ACO);
        element_Re_Par.SETRANGE(Instance, element_Re_Par.Instance::planned);

    end;

    [Scope('Internal')]
    procedure FNC_UpdateStatus(Deal_ID_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "50020";
        element_Re_Loc: Record "50021";
        isInvoiced_Bo_Loc: Boolean;
        purchHeader_Re_Loc: Record "38";
        salesHeader_Re_Loc: Record "36";
    begin
        /*__Sets this.Deal status__*/

        FNC_Set_Deal(deal_Re_Loc, Deal_ID_Co_Par);

        /*_Only when this.Deal is not yet Closed_*/
        IF ((deal_Re_Loc.Status <> deal_Re_Loc.Status::Closed) AND (deal_Re_Loc.Status <> deal_Re_Loc.Status::Canceled)) THEN BEGIN

            /*_By default, status is "In Order"_*/
            deal_Re_Loc.Status := deal_Re_Loc.Status::"In order";

            /*_If at least one of the Elements for this.Deal is a BR -> "In progress"_*/
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::BR);
            IF element_Re_Loc.FINDFIRST THEN
                deal_Re_Loc.Status := deal_Re_Loc.Status::"In progress";


            //If there are ACOs or VCOs that are not yet archived, it means this.Deal has not yet been fully invoiced
            isInvoiced_Bo_Loc := TRUE;

            //Checks not archived ACOs
            //element_Re_Loc.RESET();
            //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);

            FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    IF purchHeader_Re_Loc.GET(purchHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN
                        isInvoiced_Bo_Loc := FALSE;
                UNTIL (element_Re_Loc.NEXT() = 0);

            //Checks not archived VCOs
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN
                        isInvoiced_Bo_Loc := FALSE;
                UNTIL (element_Re_Loc.NEXT() = 0);

            /*
            //new invoice status definition
            //-> if there is at least 1 sales invoice for a deal, then the status is "Invoiced"

            isInvoiced_Bo_Loc := TRUE;

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Invoice");
            IF NOT element_Re_Loc.FINDFIRST THEN
              isInvoiced_Bo_Loc := FALSE;
            */

            IF isInvoiced_Bo_Loc THEN
                deal_Re_Loc.Status := deal_Re_Loc.Status::Invoiced;

            /*_Saving state_*/
            deal_Re_Loc.MODIFY();

        END

    end;

    [Scope('Internal')]
    procedure FNC_UpdatePurchaserCode(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        purchaseHeader_Re_Loc: Record "38";
        deal_Re_Loc: Record "50020";
    begin
        //récupérer le num de l'aco pour ce deal
        FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
        IF element_Re_Loc.FINDFIRST THEN BEGIN
            //récupérer le code vendeur sur l'aco
            IF purchaseHeader_Re_Loc.GET(
              purchaseHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN BEGIN
                //mettre à jour sur la table deal
                IF deal_Re_Loc.GET(Deal_ID_Co_Par) THEN BEGIN
                    deal_Re_Loc.VALIDATE("Purchaser Code", purchaseHeader_Re_Loc."Purchaser Code");
                    deal_Re_Loc.MODIFY();
                END
            END
        END
    end;

    [Scope('Internal')]
    procedure FNC_Set_LastUpdate_DateTime(Deal_ID_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "50020";
    begin
        FNC_Set_Deal(deal_Re_Loc, Deal_ID_Co_Par);
        deal_Re_Loc."Last Update" := CURRENTDATETIME;
        deal_Re_Loc.MODIFY();
    end;

    [Scope('Internal')]
    procedure FNC_UpdatePeriod(Deal_ID_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "50020";
        dealShipment_Re_Loc: Record "50030";
        dsc_Re_Loc: Record "50032";
        element_Re_Loc: Record "50021";
        period_Da_Loc: Date;
    begin
        /*__
        //lister les livraisons
          //pour chaque livraison, on cherche la période
            //si période <> 0D
              //mise à jour de la période des éléments appartenant à la livraison
        __*/

        FNC_Set_Deal(deal_Re_Loc, Deal_ID_Co_Par);

        /*_Only when this.Deal is not yet Closed or Canceled_*/
        IF ((deal_Re_Loc.Status <> deal_Re_Loc.Status::Closed) AND (deal_Re_Loc.Status <> deal_Re_Loc.Status::Canceled)) THEN BEGIN

            //pour toutes les livraisons d'une affaire
            dealShipment_Re_Loc.RESET();
            dealShipment_Re_Loc.SETCURRENTKEY(Deal_ID);
            dealShipment_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            IF dealShipment_Re_Loc.FINDFIRST THEN BEGIN
                REPEAT

                    //pour chaque livraison, on cherche la période
                    period_Da_Loc := DealShipment_Cu.FNC_GetSalesInvoicePeriod(dealShipment_Re_Loc.ID);

                    //si la période existe
                    IF period_Da_Loc <> 0D THEN BEGIN

                        //mise à jour de la période des éléments appartenant à la livraison
                        dsc_Re_Loc.RESET();
                        dsc_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                        dsc_Re_Loc.SETRANGE(Shipment_ID, dealShipment_Re_Loc.ID);
                        IF dsc_Re_Loc.FINDFIRST THEN BEGIN
                            REPEAT

                                //on récupère l'élément
                                IF element_Re_Loc.GET(dsc_Re_Loc.Element_ID) THEN BEGIN

                                    //si la valeur a changé
                                    IF element_Re_Loc.Period <> period_Da_Loc THEN BEGIN
                                        element_Re_Loc.Period := period_Da_Loc;
                                        element_Re_Loc.MODIFY();
                                    END;

                                END;

                            UNTIL (dsc_Re_Loc.NEXT() = 0);
                        END;

                    END;

                UNTIL (dealShipment_Re_Loc.NEXT() = 0);
            END;

        END

    end;

    [Scope('Internal')]
    procedure FNC_Attach_ACO(Deal_ID_Co_Par: Code[20]; ACO_ID_Co_Par: Code[20])
    var
        ACO_Connection_Re_Loc: Record "50026";
        PurchaseHeader: Record "38";
    begin
        /*__Inserts a row in the ACO Connection table, linking a this.Deal and this.ACO__*/
        ACO_Connection_Re_Loc.INIT();
        ACO_Connection_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
        ACO_Connection_Re_Loc.VALIDATE("ACO No.", ACO_ID_Co_Par);
        //DEL.SAZ ce code n'etais pas ajouté au prod ajouter par saz le 07.03.19
        //THM150118
        IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, ACO_ID_Co_Par) THEN
            ACO_Connection_Re_Loc."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
        //THM150118 END;
        IF NOT ACO_Connection_Re_Loc.INSERT() THEN
            ERROR(ERROR_TXT, 'Co 50020', 'FNC_Attach_ACO', 'Insert() impossible dans la table ''ACO Connection''');

    end;

    [Scope('Internal')]
    procedure FNC_Get_ACO_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        BR_Header_Re_Loc: Record "120";
        dealShipment_Re_Loc: Record "50030";
        dsc_Re_Loc: Record "50032";
        purchRcptLine_Re_Loc: Record "121";
        dealItem_Re_Loc: Record "50023";
        position_Re_Loc: Record "50022";
        BRNo_Co_Ret: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            //element_Re_Loc.RESET();
            //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);

            FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            IF element_Re_Loc.FINDFIRST THEN
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //message('new impl');
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::dispatched);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    //on vérifie l'appartenance de l'élément à la livraison
                    IF dsc_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, element_Re_Loc.ID) THEN
                        Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);


            /*
            message('old impl');
            //Comme il n'y a pas de prévu par livraison, on se base sur les quantités des BR et les couts prévus
            BRNo_Co_Ret := DealShipment_Cu.FNC_GetBRNo(DealShipment_No_Co_Par);

            purchRcptLine_Re_Loc.RESET();
            purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Ret);
            purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
            purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
            IF purchRcptLine_Re_Loc.FINDFIRST THEN
              REPEAT
                qty_Dec_Loc    := purchRcptLine_Re_Loc.Quantity;
                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(Deal_ID_Co_Par, curr_Co_Loc, 'EUR');
                Amount_Dec_Ret -= qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
              UNTIL(purchRcptLine_Re_Loc.NEXT()=0);
            */

        END;

    end;

    [Scope('Internal')]
    procedure FNC_Get_VCO_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        BR_Header_Re_Loc: Record "120";
        dealShipment_Re_Loc: Record "50030";
        dsc_Re_Loc: Record "50032";
        purchRcptLine_Re_Loc: Record "121";
        dealItem_Re_Loc: Record "50023";
        position_Re_Loc: Record "50022";
        BRNo_Co_Ret: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0)

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //message('new impl');
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::dispatched);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    //on vérifie l'appartenance de l'élément à la livraison
                    IF dsc_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, element_Re_Loc.ID) THEN
                        Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

            /*
            MESSAGE('old impl');
            BRNo_Co_Ret := DealShipment_Cu.FNC_GetBRNo(DealShipment_No_Co_Par);

            purchRcptLine_Re_Loc.RESET();
            purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Ret);
            purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
            purchRcptLine_Re_Loc.SETFILTER(Quantity, '>0');
            IF purchRcptLine_Re_Loc.FINDFIRST THEN
              REPEAT
                qty_Dec_Loc    := purchRcptLine_Re_Loc.Quantity;
                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(Deal_ID_Co_Par, curr_Co_Loc, 'EUR');
                Amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
              UNTIL(purchRcptLine_Re_Loc.NEXT()=0);
            */

        END;

    end;

    [Scope('Internal')]
    procedure FNC_Get_Fee_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
        dsc_Re_Loc: Record "50032";
        purchRcptLine_Re_Loc: Record "121";
        BR_Header_Re_Loc: Record "120";
        dealShipment_Re_Loc: Record "50030";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //MESSAGE('new impl');
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::dispatched);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    //on vérifie l'appartenance de l'élément à la livraison
                    IF dsc_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, element_Re_Loc.ID) THEN
                        Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

            /*
            Calcule les frais prévu pour une livraison. Il s'agit d'un calcul approximatif car il n'existe pas de liaison
            entre les livraisons et les frais prévu. Le calcul se base sur les quantités réceptionnées et le montant du frais
            prévu par article. Le code qui suit est lourd au niveau des performances. Si des problèmes de rapidité apparaissent
            il faudra penser à le désactiver.
            */
            /*
            MESSAGE('old impl');
            IF dealShipment_Re_Loc.GET(DealShipment_No_Co_Par) THEN BEGIN

              IF BR_Header_Re_Loc.GET(dealShipment_Re_Loc."BR No.") THEN BEGIN

                purchRcptLine_Re_Loc.RESET();
                purchRcptLine_Re_Loc.SETRANGE("Document No.", BR_Header_Re_Loc."No.");
                IF purchRcptLine_Re_Loc.FINDFIRST THEN
                  REPEAT

                    element_Re_Loc.RESET();
                    element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
                    element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                    element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
                    element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
                    IF element_Re_Loc.FINDFIRST THEN
                      REPEAT

                        position_Re_Loc.RESET();
                        position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                        position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");
                        IF position_Re_Loc.FINDFIRST THEN
                          REPEAT
                            Amount_Dec_Ret += position_Re_Loc.Amount * purchRcptLine_Re_Loc.Quantity * position_Re_Loc.Rate;
                          UNTIL(position_Re_Loc.NEXT() = 0)

                      UNTIL(element_Re_Loc.NEXT() = 0)

                  UNTIL(purchRcptLine_Re_Loc.NEXT()=0)

              END

            END
            */

        END

    end;

    [Scope('Internal')]
    procedure FNC_Get_PurchInvoice_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "50021";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0)

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //Si il y a une Purchase invoice Invoice
            element_ID_Co_Loc := DealShipment_Cu.FNC_GetPurchInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_PurchCrMemo_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "50021";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purch. Cr. Memo");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0)

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //Si il y a une Purchase invoice Invoice
            element_ID_Co_Loc := DealShipment_Cu.FNC_GetPurchCrMemoElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_SalesInvoice_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "50021";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Invoice");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0);

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //Si il y a une Sales Invoice
            element_ID_Co_Loc := DealShipment_Cu.FNC_GetSalesInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_SalesCrMemo_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "50021";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Cr. Memo");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0);

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //Si il y a une Sales Invoice
            element_ID_Co_Loc := DealShipment_Cu.FNC_GetSalesCrMemoElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_Invoice_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        elementConnection_Re_Loc: Record "50027";
        dealShipCon_Re_Loc: Record "50032";
        position_Re_Loc: Record "50022";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Invoice);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //on regarde si il y a des invoice pour cette livraison
            dealShipmentConnection_Re_Loc.RESET();
            dealShipmentConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipment_No_Co_Par);
            IF dealShipmentConnection_Re_Loc.FINDFIRST THEN
                REPEAT

                    Element_Cu.FNC_Set_Element(element_Re_Loc, dealShipmentConnection_Re_Loc.Element_ID);

                    //on regarde sur quel(s) Element(s) l'invoice a été dispatché
                    IF element_Re_Loc.Type = element_Re_Loc.Type::Invoice THEN BEGIN

                        //si splitt index vaut 0, alors c'est la vieille méthode de dispatching, faut controler les connections éléments
                        IF element_Re_Loc."Splitt Index" = 0 THEN BEGIN

                            elementConnection_Re_Loc.RESET();
                            elementConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                            elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                            IF elementConnection_Re_Loc.FINDFIRST THEN
                                REPEAT
                                    //on regarde si l'élément sur lequel a été dispatché une invoice apparatient à la livraison en cours
                                    IF dealShipCon_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, elementConnection_Re_Loc."Apply To") THEN BEGIN

                                        //filtre sur les positions avec element id et sub element id correspondant
                                        position_Re_Loc.RESET();
                                        position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                        position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                                        position_Re_Loc.SETRANGE("Sub Element_ID", elementConnection_Re_Loc."Apply To");
                                        IF position_Re_Loc.FINDFIRST THEN
                                            REPEAT
                                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                                            UNTIL (position_Re_Loc.NEXT() = 0);

                                    END
                                UNTIL (elementConnection_Re_Loc.NEXT() = 0);
                            //sinon, c'est la nouvelle méthode, à ce moment là on a pas besoin de controler parce que le montant a déjà été splitté
                            //correctement lors de la création des positions
                        END ELSE BEGIN

                            //filtre sur les positions avec element id correspondant
                            position_Re_Loc.RESET();
                            //position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                            position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                            IF position_Re_Loc.FINDFIRST THEN
                                REPEAT
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                                UNTIL (position_Re_Loc.NEXT() = 0);

                        END;

                    END;

                UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_ProSales_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        elementConnection_Re_Loc: Record "50027";
        targetElement_Re_Loc: Record "50021";
        element_ID_Co_Loc: Code[20];
        planned_Amount_Dec_Loc: Decimal;
        real_Amount_Dec_Loc: Decimal;
        BRNo_Co_Ret: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        purchRcptLine_Re_Loc: Record "121";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    planned_Amount_Dec_Loc := 0;
                    real_Amount_Dec_Loc := 0;

                    //le montant de la VCO
                    planned_Amount_Dec_Loc := Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                    //on cherche les connections qui s'appliquent à la VCO pour ce deal
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE("Apply To", element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN
                        REPEAT
                            Element_Cu.FNC_Set_Element(targetElement_Re_Loc, elementConnection_Re_Loc.Element_ID);
                            IF (
                              (targetElement_Re_Loc.Type = targetElement_Re_Loc.Type::"Sales Invoice")
                              OR
                              (targetElement_Re_Loc.Type = targetElement_Re_Loc.Type::"Sales Cr. Memo")
                              ) THEN
                                real_Amount_Dec_Loc += Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
                        UNTIL (elementConnection_Re_Loc.NEXT() = 0);

                    //si on a trouvé des montants réels, on les assigne, sinon on prend le montant de la VCO
                    IF real_Amount_Dec_Loc <> 0 THEN
                        Amount_Dec_Ret += real_Amount_Dec_Loc
                    ELSE
                        Amount_Dec_Ret += planned_Amount_Dec_Loc;

                UNTIL (element_Re_Loc.NEXT() = 0)

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //Comme il n'y a pas de prévu par livraison, on se base sur les quantités des BR et les couts prévus
            BRNo_Co_Ret := DealShipment_Cu.FNC_GetBRNo(DealShipment_No_Co_Par);

            purchRcptLine_Re_Loc.RESET();
            purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Ret);
            purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
            purchRcptLine_Re_Loc.SETFILTER(Quantity, '>0');
            IF purchRcptLine_Re_Loc.FINDFIRST THEN
                REPEAT
                    qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                    amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(Deal_ID_Co_Par, curr_Co_Loc, 'EUR');
                    Amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

            //Si il y a une Sales Invoice
            element_ID_Co_Loc := DealShipment_Cu.FNC_GetSalesInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_ProPurch_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        elementConnection_Re_Loc: Record "50027";
        targetElement_Re_Loc: Record "50021";
        element_ID_Co_Loc: Code[20];
        planned_Amount_Dec_Loc: Decimal;
        real_Amount_Dec_Loc: Decimal;
        BRNo_Co_Loc: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        purchRcptLine_Re_Loc: Record "121";
    begin
        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            //element_Re_Loc.RESET();
            //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);

            FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    planned_Amount_Dec_Loc := 0;
                    real_Amount_Dec_Loc := 0;

                    //le montant de la ACO
                    planned_Amount_Dec_Loc := Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                    //on cherche les connections qui s'appliquent à la ACO pour ce deal
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE("Apply To", element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN
                        REPEAT
                            Element_Cu.FNC_Set_Element(targetElement_Re_Loc, elementConnection_Re_Loc.Element_ID);
                            IF targetElement_Re_Loc.Type = targetElement_Re_Loc.Type::"Purchase Invoice" THEN
                                real_Amount_Dec_Loc += Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
                        UNTIL (elementConnection_Re_Loc.NEXT() = 0);

                    //si on a trouvé des montants réels, on les assigne, sinon on prend le montant de la ACO
                    IF real_Amount_Dec_Loc <> 0 THEN
                        Amount_Dec_Ret += real_Amount_Dec_Loc
                    ELSE
                        Amount_Dec_Ret += planned_Amount_Dec_Loc;

                UNTIL (element_Re_Loc.NEXT() = 0)

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //Comme il n'y a pas de prévu par livraison, on se base sur les quantités des BR et les couts prévus
            BRNo_Co_Loc := DealShipment_Cu.FNC_GetBRNo(DealShipment_No_Co_Par);

            purchRcptLine_Re_Loc.RESET();
            purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Loc);
            purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
            purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
            IF purchRcptLine_Re_Loc.FINDFIRST THEN
                REPEAT
                    qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                    amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(Deal_ID_Co_Par, curr_Co_Loc, 'EUR');
                    Amount_Dec_Ret -= qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

            //Si il y a une Purchase Invoice
            element_ID_Co_Loc := DealShipment_Cu.FNC_GetPurchInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Get_ProLog_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        invoiceElement_Re_Loc: Record "50021";
        planned_Amount_Dec_Loc: Decimal;
        real_Amount_Dec_Loc: Decimal;
        dealShipment_Re_Loc: Record "50030";
        BR_Header_Re_Loc: Record "120";
        purchRcptLine_Re_Loc: Record "121";
        position_Re_Loc: Record "50022";
        BRNo_Co_Loc: Code[20];
    begin
        //CHG-PROVISION
        /*
        Depuis que les provisions existent, on change la règle de calcul du projeté pour les frais
        on passe de
        montant projeté = montant réalisé s'il existe, sinon montant frais
        à
        montant projeté = montant réalisé + montant provisionné (les deux se complètent et doivent former le montant prévu)
        */

        Amount_Dec_Ret := 0;

        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETFILTER(Type, '%1|%2', element_Re_Loc.Type::Invoice, element_Re_Loc.Type::Provision);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    element_Re_Loc.CALCFIELDS("Amount(EUR)");

                    //pour les provisions, on ne compte pas les extournes
                    IF element_Re_Loc."Amount(EUR)" < 0 THEN
                        Amount_Dec_Ret += element_Re_Loc."Amount(EUR)";

                UNTIL (element_Re_Loc.NEXT() = 0)

            //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN

            //pour la livraison spécifique
            dealShipmentConnection_Re_Loc.RESET();
            dealShipmentConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipment_No_Co_Par);
            IF dealShipmentConnection_Re_Loc.FINDFIRST THEN
                REPEAT

                    //on cherche les éléments facture ou provision
                    Element_Cu.FNC_Set_Element(element_Re_Loc, dealShipmentConnection_Re_Loc.Element_ID);
                    IF ((element_Re_Loc.Type = element_Re_Loc.Type::Invoice) OR (element_Re_Loc.Type = element_Re_Loc.Type::Provision)) THEN BEGIN

                        element_Re_Loc.CALCFIELDS("Amount(EUR)");

                        //pour les provisions, on ne compte pas les extournes
                        IF element_Re_Loc."Amount(EUR)" < 0 THEN
                            Amount_Dec_Ret += element_Re_Loc."Amount(EUR)";

                    END;

                UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);

        END;

        /*
        // si le shipment No. est vide, alors on veut le total global
        IF DealShipment_No_Co_Par = '' THEN BEGIN
        
          element_Re_Loc.RESET();
          element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
          element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
          element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
          element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::Planned);
          IF element_Re_Loc.FINDFIRST THEN
            REPEAT
        
              planned_Amount_Dec_Loc := 0;
              real_Amount_Dec_Loc := 0;
        
              //le montant du Fee
              planned_Amount_Dec_Loc := Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
        
              //on cherche les éléments de type invoice qui ont le meme Fee et Fee_Connection dans l'affaire
              invoiceElement_Re_Loc.RESET();
              invoiceElement_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
              invoiceElement_Re_Loc.SETRANGE(Type, invoiceElement_Re_Loc.Type::Invoice);
              invoiceElement_Re_Loc.SETRANGE(Fee_ID, element_Re_Loc.Fee_ID);
              invoiceElement_Re_Loc.SETRANGE(Fee_Connection_ID, element_Re_Loc.Fee_Connection_ID);
              IF invoiceElement_Re_Loc.FINDFIRST THEN
                REPEAT
                  real_Amount_Dec_Loc += Element_Cu.FNC_Get_Amount_From_Positions(invoiceElement_Re_Loc.ID);
                UNTIL(invoiceElement_Re_Loc.NEXT() = 0);
              //si on a trouvé des montants réels, on les assigne, sinon on prend le montant du frais
              IF real_Amount_Dec_Loc <> 0 THEN
                Amount_Dec_Ret += real_Amount_Dec_Loc
              ELSE
                Amount_Dec_Ret += planned_Amount_Dec_Loc;
        
            UNTIL(element_Re_Loc.NEXT() = 0)
        
        //sinon c'est qu'on veut le total pour la livraison spécifiée
        END ELSE BEGIN
        
          BRNo_Co_Loc := DealShipment_Cu.FNC_GetBRNo(DealShipment_No_Co_Par);
        
            IF BR_Header_Re_Loc.GET(BRNo_Co_Loc) THEN BEGIN
        
              purchRcptLine_Re_Loc.RESET();
              purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Loc);
              purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
              purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
              IF purchRcptLine_Re_Loc.FINDFIRST THEN
        
                REPEAT
        
                  element_Re_Loc.RESET();
                  element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
                  element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                  element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
                  element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::Planned);
                  IF element_Re_Loc.FINDFIRST THEN
        
                    REPEAT
        
                      planned_Amount_Dec_Loc := 0;
                      real_Amount_Dec_Loc := 0;
        
                      position_Re_Loc.RESET();
                      position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                      position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");
                      IF position_Re_Loc.FINDFIRST THEN
                        REPEAT
                          planned_Amount_Dec_Loc += position_Re_Loc.Amount * purchRcptLine_Re_Loc.Quantity * position_Re_Loc.Rate;
                        UNTIL(position_Re_Loc.NEXT() = 0);
        
                      //on regarde si il y a un ou plusieurs elements de type invoice qui a/ont le meme FEE ou FEC
                      invoiceElement_Re_Loc.RESET();
                      invoiceElement_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                      invoiceElement_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Invoice);
                      invoiceElement_Re_Loc.SETRANGE(Fee_ID, element_Re_Loc.Fee_ID);
                      invoiceElement_Re_Loc.SETRANGE(Fee_Connection_ID, element_Re_Loc.Fee_Connection_ID);
                      IF invoiceElement_Re_Loc.FINDFIRST THEN
                        REPEAT
                          real_Amount_Dec_Loc += Element_Cu.FNC_Get_Amount_From_Positions(invoiceElement_Re_Loc.ID);
                        UNTIL(invoiceElement_Re_Loc.NEXT()=0);
        
                       //si on a trouvé des montants réels, on les assigne, sinon on prend le montant de la ACO
                       IF real_Amount_Dec_Loc <> 0 THEN
                         Amount_Dec_Ret += real_Amount_Dec_Loc
                       ELSE
                         Amount_Dec_Ret += planned_Amount_Dec_Loc;
        
                    UNTIL(element_Re_Loc.NEXT() = 0)
        
                UNTIL(purchRcptLine_Re_Loc.NEXT()=0)
        
            END
        
        END;
        */

    end;

    [Scope('Internal')]
    procedure FNC_GetMonthFirstWorkDay(date_Par: Date) date: Date
    begin
        /*
        RETOURNE LE PREMIER JOUR DU MOIS DE LA DATE PASSE PAR PARAMETRE QUI N EST PAS UN SAMEDI OU UN DIMANCHE
        USAGE :
          first := FNC_GetMonthFirstWorkDay(TODAY);
        */

        //premier jour du mois, CM = Current Month
        date := CALCDATE('<-CM>', date_Par);

        //Si on tombe sur un samedi ou un dimanche
        IF ((FORMAT(date, 0, '<Weekday>') = '6') OR (FORMAT(date, 0, '<Weekday>') = '7')) THEN
            REPEAT
                //avancer d'un jour
                date := CALCDATE('<+1D>', date);

                //jusqu'a ce qu'on tombe sur un lundi
            UNTIL (FORMAT(date, 0, '<Weekday>') = '1');

        EXIT(date);

    end;

    [Scope('Internal')]
    procedure FNC_GetMonthLastWorkDay(date_Par: Date) date: Date
    begin
        /*
        RETOURNE LE DERNIER JOUR DU MOIS DE LA DATE PASSE PAR PARAMETRE QUI N EST PAS UN SAMEDI OU UN DIMANCHE
        USAGE :
          last := FNC_GetMonthLastWorkDay(TODAY);
        */

        //dernier jour du mois, CM = Current Month
        date := CALCDATE('<CM>', date_Par);

        //Si on tombe sur un samedi ou un dimanche
        IF ((FORMAT(date, 0, '<Weekday>') = '6') OR (FORMAT(date, 0, '<Weekday>') = '7')) THEN
            REPEAT
                //reculer d'un jour
                date := CALCDATE('<-1D>', date);

                //jusqu'à ce qu'on tombe sur un vendredi
            UNTIL (FORMAT(date, 0, '<Weekday>') = '5');

        EXIT(date);

    end;
}

