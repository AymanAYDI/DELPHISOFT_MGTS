codeunit 50024 "Deal Item"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 09.09.08                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01  RC4                       09.09.08   Created Doc
    // CHG02                            06.04.09   Adapted various update methods to handle silent update
    // STG01                            02.07.09   Comment check price / cost (according FLB tests on 01.07.09)
    // THM250817                        25.08.17   add Function
    // THM161117                        16.11.17   Add filtre status
    // 
    // Mgts10.00.05.00      04.01.2022 : Replace "Vol cbm" GetVolCBM


    trigger OnRun()
    begin
    end;

    var
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';
        Position_Cu: Codeunit "50022";
        Element_Cu: Codeunit "50021";
        Deal_Cu: Codeunit "50020";
        Type_Op: Option Cost,Price;
        UpdateRequestManager_Cu: Codeunit "50032";

    [Scope('Internal')]
    procedure FNC_Add(Deal_ID_Co_Par: Code[20]; Item_No_Co_Par: Code[20])
    var
        dealItem_Re_Loc: Record "50023";
        item_Re_Loc: Record "27";
    begin
        /*Ajoute seulement si pas déjà présent dans la table*/

        IF NOT dealItem_Re_Loc.GET(Deal_ID_Co_Par, Item_No_Co_Par) THEN
            FNC_Insert(Deal_ID_Co_Par, Item_No_Co_Par)

    end;

    [Scope('Internal')]
    procedure FNC_Insert(Deal_ID_Co_Par: Code[20]; Item_No_Co_Par: Code[20])
    var
        dealItem_Re_Loc: Record "50023";
        item_Re_Loc: Record "27";
    begin
        /*Insère un Deal Item sans le Unit Cost ni le Unit Price*/

        IF item_Re_Loc.GET(Item_No_Co_Par) THEN BEGIN

            FNC_checkForZero(item_Re_Loc);

            //les valeurs à 0 dans item_Re_Loc devraient être signalées !!!

            dealItem_Re_Loc.INIT();
            dealItem_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
            dealItem_Re_Loc.VALIDATE("Item No.", item_Re_Loc."No.");

            dealItem_Re_Loc.VALIDATE("Net Weight", item_Re_Loc."Weight net");
            dealItem_Re_Loc.VALIDATE("Gross Weight", item_Re_Loc."Weight brut");
            //>>Mgts10.00.05.00
            //dealItem_Re_Loc.VALIDATE("Volume CMB", item_Re_Loc."Vol cbm");
            dealItem_Re_Loc.VALIDATE("Volume CMB", item_Re_Loc.GetVolCBM(TRUE));
            //<<Mgts10.00.05.00
            dealItem_Re_Loc.VALIDATE("Volume CMB carton transport", item_Re_Loc."Vol cbm carton transport");
            dealItem_Re_Loc.VALIDATE(PCB, item_Re_Loc.PCB);
            dealItem_Re_Loc.VALIDATE("Droit de douane reduit", item_Re_Loc."Droit de douane reduit");

            IF NOT dealItem_Re_Loc.INSERT() THEN
                ERROR(ERROR_TXT, 'Co50024', 'FNC_Insert()', 'Insertion impossible dans la table Deal Item')

        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Insert()', STRSUBSTNO('Item >%1< inexistant !', Item_No_Co_Par));

    end;

    [Scope('Internal')]
    procedure FNC_Update_Unit_Cost(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; UnitCost_De_Par: Decimal; CurrencyCost_Co_Par: Code[10])
    var
        dealItem_Re_Loc: Record "50023";
    begin
        /*
        Met à jour Unit Cost
        //STG01 Update seulement si le Unit Cost n'a jamais été défini !
        */

        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN

            //START STG01 IF dealItem_Re_Loc."Unit Cost" = 0 THEN BEGIN
            dealItem_Re_Loc.VALIDATE("Unit Cost", UnitCost_De_Par);
            dealItem_Re_Loc.VALIDATE("Currency Cost", CurrencyCost_Co_Par);
            IF NOT dealItem_Re_Loc.MODIFY() THEN
                ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Cost()', 'Update Cost impossible dans la table Deal Item')
            //STOP STG01 END

        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Cost()',
              STRSUBSTNO('Item >%1< introuvable dans la table Deal Item pour l''affaire %2 !', ItemNo_Co_Par, Deal_ID_Co_Par));

    end;

    [Scope('Internal')]
    procedure FNC_Update_Unit_Price(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; UnitPrice_De_Par: Decimal; CurrencyPrice_Co_Par: Code[10])
    var
        dealItem_Re_Loc: Record "50023";
    begin
        /*
        Met à jour Unit Price
        //STG01 Update seulement si le Unit Price n'a jamais été défini !
        */

        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN

            //START STG01 IF dealItem_Re_Loc."Unit Price" = 0 THEN BEGIN
            dealItem_Re_Loc.VALIDATE("Unit Price", UnitPrice_De_Par);
            dealItem_Re_Loc.VALIDATE("Currency Price", CurrencyPrice_Co_Par);
            IF NOT dealItem_Re_Loc.MODIFY() THEN
                ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Price()', 'Update Price impossible dans la table Deal Item')
            //STOP STG01 END

        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Price()',
              STRSUBSTNO('Item >%1< introuvable dans la table Deal Item pour l''affaire %2 !', ItemNo_Co_Par, Deal_ID_Co_Par));

    end;

    [Scope('Internal')]
    procedure FNC_Update_Net_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Net Weight" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Net_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Update_Gross_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Gross Weight" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Gross_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Update_Volume_CMB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Volume CMB" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Volume_CMB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Update_Volume_CMB_Carton(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Volume CMB carton transport" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Volume_CMB_Carton()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Update_PCB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc.PCB := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_PCB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Sales_Amount(Deal_ID_Co_Par: Code[20]; ShipmentNo_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option Planned,Real) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "50022";
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        BR_Header_Re_Loc: Record "120";
        dealShipment_Re_Loc: Record "50030";
        purchRcptLine_Re_Loc: Record "121";
        dealItem_Re_Loc: Record "50023";
    begin
        /*RETOURNE LE MONTANT DES VENTES POUR UN ARTICLE EN PRENANT EN COMPTE LE NUMERO DE LIVRAISON SI IL EST SPECIFIE*/

        Amount_Dec_Ret := 0;

        //Planned
        IF Instance_Op_Par = Instance_Op_Par::Planned THEN BEGIN

            //With Shipment No
            IF dealShipment_Re_Loc.GET(ShipmentNo_Co_Par) THEN BEGIN

                IF BR_Header_Re_Loc.GET(dealShipment_Re_Loc."BR No.") THEN BEGIN

                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", BR_Header_Re_Loc."No.");
                    purchRcptLine_Re_Loc.SETRANGE("No.", "Item_No._Co_Par");

                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT
                            //le montant de la ligne n'existe pas sur les BR, il faut donc aller chercher le cout
                            //de l'article dans la table Deal Item
                            IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.") THEN
                                Amount_Dec_Ret += purchRcptLine_Re_Loc.Quantity * dealItem_Re_Loc."Unit Price"
                            ELSE
                                ERROR(ERROR_TXT, 'Co_50024', 'FNC_Get_Sales_Amount()',
                                  STRSUBSTNO(
                                  'Get_Amount impossible pour Element de type >%1< car le Deal Item >%2< n''existe pas !',
                                  element_Re_Loc.Type,
                                  purchRcptLine_Re_Loc."No."));
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

                END

                //Without Shipment No
            END ELSE BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Planned);

                IF position_Re_Loc.FINDFIRST THEN BEGIN
                    REPEAT
                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF element_Re_Loc.Type = element_Re_Loc.Type::VCO THEN
                            Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)

                    UNTIL (position_Re_Loc.NEXT() = 0);

                END;

            END

            //Real
        END ELSE
            IF Instance_Op_Par = Instance_Op_Par::Real THEN BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Real);

                IF position_Re_Loc.FINDFIRST THEN BEGIN

                    REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF ((element_Re_Loc.Type = element_Re_Loc.Type::"Sales Invoice")
                          OR (element_Re_Loc.Type = element_Re_Loc.Type::"Sales Cr. Memo")) THEN BEGIN

                            //Without Shipment No
                            IF ShipmentNo_Co_Par = '' THEN
                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                            //Without Shipment No
                            ELSE BEGIN
                                //on controle si l'élément fait partie de la livraison sélectionnée
                                IF dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc.Element_ID) THEN
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);
                            END;

                        END;

                    UNTIL (position_Re_Loc.NEXT() = 0);

                END;

            END;

    end;

    [Scope('Internal')]
    procedure FNC_Get_Purchases_Amount(Deal_ID_Co_Par: Code[20]; ShipmentNo_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option Planned,Real) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "50022";
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        BR_Header_Re_Loc: Record "120";
        dealShipment_Re_Loc: Record "50030";
        purchRcptLine_Re_Loc: Record "121";
        dealItem_Re_Loc: Record "50023";
    begin
        /*RETOURNE LE MONTANT DES VENTES POUR UN ARTICLE EN PRENANT EN COMPTE LE NUMERO DE LIVRAISON SI IL EST SPECIFIE*/

        Amount_Dec_Ret := 0;

        //Planned
        IF Instance_Op_Par = Instance_Op_Par::Planned THEN BEGIN

            //With Shipment No
            IF dealShipment_Re_Loc.GET(ShipmentNo_Co_Par) THEN BEGIN

                IF BR_Header_Re_Loc.GET(dealShipment_Re_Loc."BR No.") THEN BEGIN

                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", BR_Header_Re_Loc."No.");
                    purchRcptLine_Re_Loc.SETRANGE("No.", "Item_No._Co_Par");

                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT
                            //le montant de la ligne n'existe pas sur les BR, il faut donc aller chercher le cout
                            //de l'article dans la table Deal Item
                            IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.") THEN
                                Amount_Dec_Ret += purchRcptLine_Re_Loc.Quantity * dealItem_Re_Loc."Unit Cost"
                            ELSE
                                ERROR(ERROR_TXT, 'Co_50024', 'FNC_Get_Purchases_Amount()',
                                  STRSUBSTNO(
                                  'Get_Amount impossible pour Element de type >%1< car le Deal Item >%2< n''existe pas !',
                                  element_Re_Loc.Type,
                                  purchRcptLine_Re_Loc."No."));
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

                END

                //Without Shipment No
            END ELSE BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Planned);

                IF position_Re_Loc.FINDFIRST THEN BEGIN
                    REPEAT
                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF element_Re_Loc.Type = element_Re_Loc.Type::ACO THEN
                            Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)

                    UNTIL (position_Re_Loc.NEXT() = 0);

                END;

            END

            //Real
        END ELSE
            IF Instance_Op_Par = Instance_Op_Par::Real THEN BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Real);

                IF position_Re_Loc.FINDFIRST THEN BEGIN

                    REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF ((element_Re_Loc.Type = element_Re_Loc.Type::"Purchase Invoice")
                          OR (element_Re_Loc.Type = element_Re_Loc.Type::"Purch. Cr. Memo")) THEN BEGIN

                            //Without Shipment No
                            IF ShipmentNo_Co_Par = '' THEN
                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                            //Without Shipment No
                            ELSE BEGIN
                                //on controle si l'élément fait partie de la livraison sélectionnée
                                IF dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc.Element_ID) THEN
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);
                            END;

                        END;

                    UNTIL (position_Re_Loc.NEXT() = 0);

                END;

            END;

    end;

    [Scope('Internal')]
    procedure FNC_Get_Fees_Amount(Deal_ID_Co_Par: Code[20]; ShipmentNo_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option Planned,Real) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "50022";
        element_Re_Loc: Record "50021";
        dealShipmentConnection_Re_Loc: Record "50032";
        BR_Header_Re_Loc: Record "120";
        dealShipment_Re_Loc: Record "50030";
        purchRcptLine_Re_Loc: Record "121";
        dealItem_Re_Loc: Record "50023";
    begin
        /*RETOURNE LE MONTANT DES ACHATS POUR UN ARTICLE*/

        Amount_Dec_Ret := 0;

        //Planned
        IF Instance_Op_Par = Instance_Op_Par::Planned THEN BEGIN

            //With Shipment No
            IF dealShipment_Re_Loc.GET(ShipmentNo_Co_Par) THEN BEGIN

                IF BR_Header_Re_Loc.GET(dealShipment_Re_Loc."BR No.") THEN BEGIN

                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", BR_Header_Re_Loc."No.");
                    purchRcptLine_Re_Loc.SETRANGE("No.", "Item_No._Co_Par");

                    IF purchRcptLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                            position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");

                            IF position_Re_Loc.FINDFIRST THEN
                                REPEAT
                                    Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                                    IF element_Re_Loc.Type = element_Re_Loc.Type::Fee THEN
                                        Amount_Dec_Ret += position_Re_Loc.Amount * purchRcptLine_Re_Loc.Quantity * position_Re_Loc.Rate;

                                UNTIL (position_Re_Loc.NEXT() = 0)


                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

                END

                //Without Shipment No
            END ELSE BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par);

                IF position_Re_Loc.FINDFIRST THEN
                    REPEAT
                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF element_Re_Loc.Type = element_Re_Loc.Type::Fee THEN
                            Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                    UNTIL (position_Re_Loc.NEXT() = 0);

            END

            //Real
        END ELSE
            IF Instance_Op_Par = Instance_Op_Par::Real THEN BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Real);

                IF position_Re_Loc.FINDFIRST THEN
                    REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF element_Re_Loc.Type = element_Re_Loc.Type::Invoice THEN BEGIN  //CHG-DEV-PROVISION si type = Invoice|Provision

                            IF ShipmentNo_Co_Par = '' THEN BEGIN
                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);
                            END ELSE BEGIN
                                //on controle si l'élément et le subelement fait partie de la livraison sélectionnée
                                IF (dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc.Element_ID)) AND (
                                   dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc."Sub Element_ID")) THEN
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);
                            END;

                        END;

                    UNTIL (position_Re_Loc.NEXT() = 0);

            END;

    end;

    [Scope('Internal')]
    procedure FNC_Get_Amount(Deal_ID_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "50022";
    begin
        /*RETOURNE LE MONTANT TOTAL D'UN ARTICLE (ACHAT, VENTE ET FRAIS)*/

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
        position_Re_Loc.SETRANGE(Instance, Instance_Op_Par);

        Amount_Dec_Ret := 0;
        IF position_Re_Loc.FINDFIRST THEN
            REPEAT
                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);
            UNTIL (position_Re_Loc.NEXT() = 0)

    end;

    [Scope('Internal')]
    procedure FNC_Get_Unit_Price(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Amount_Dec_Ret := dealItem_Re_Loc."Unit Price"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Unit_Price()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Unit_Cost(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Amount_Dec_Ret := dealItem_Re_Loc."Unit Cost"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Unit_Cost()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Currency_Price(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Currency_Co_Ret: Code[10]
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Currency_Co_Ret := dealItem_Re_Loc."Currency Price"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Currency_Price()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Currency_Cost(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Currency_Co_Ret: Code[10]
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Currency_Co_Ret := dealItem_Re_Loc."Currency Cost"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Currency_Cost()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Net_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Net Weight"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Net_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Gross_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Gross Weight"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Gross_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Volume_CMB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Volume CMB"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Volume_CMB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Volume_CMB_Carton(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Volume CMB carton transport"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Volume_CMB_Carton()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_PCB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc.PCB
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_PCB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Droit_Douanne(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "50023";
        value_Dec_Loc: Decimal;
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            Value_Co_Ret := dealItem_Re_Loc."Droit de douane reduit" / 100;
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Droit_Douanne()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;

    [Scope('Internal')]
    procedure FNC_Get_Campaign_Code(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) CampaignCode_Co_Ret: Code[20]
    var
        element_Re_Loc: Record "50021";
        salesLine_Re_Loc: Record "37";
    begin
        CampaignCode_Co_Ret := '';

        //chercher l'articles dans la/les VCO(s) de l'affaire
        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT
                salesLine_Re_Loc.RESET();
                salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::Order);
                salesLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                salesLine_Re_Loc.SETRANGE("No.", ItemNo_Co_Par);
                IF salesLine_Re_Loc.FINDFIRST THEN BEGIN
                    CampaignCode_Co_Ret := salesLine_Re_Loc."Campaign Code";
                    EXIT(CampaignCode_Co_Ret);
                END

            UNTIL element_Re_Loc.NEXT() = 0;
    end;

    [Scope('Internal')]
    procedure FNC_checkForZero(Item_Re_Par: Record "27")
    var
        message_Te_Loc: Text[250];
    begin
        message_Te_Loc := '';

        IF Item_Re_Par."Weight net" = 0 THEN message_Te_Loc += 'Weight net';
        IF Item_Re_Par."Weight brut" = 0 THEN message_Te_Loc += ', Weight brut';
        //>>Mgts10.00.05.00
        //IF Item_Re_Par."Vol cbm"                 = 0  THEN message_Te_Loc += ', Vol cbm';
        IF Item_Re_Par.GetVolCBM(TRUE) = 0 THEN message_Te_Loc += ', Vol cbm';
        IF Item_Re_Par."Vol cbm carton transport" = 0 THEN message_Te_Loc += ', Vol cbm carton transport';
        IF Item_Re_Par.PCB = 0 THEN message_Te_Loc += ', PCB';
        //if item_Re_par."Container No."                 = 0  then message_Te_Loc += ', Container No.';
        //IF Item_Re_Par."Droit de douane reduit"        = 0  THEN message_Te_Loc += ', Droit de douane reduit';

        IF message_Te_Loc <> '' THEN BEGIN
            message_Te_Loc += ' de l''article ' + FORMAT(Item_Re_Par."No.") + ' à 0 sur la fiche article !';
            ERROR(message_Te_Loc);
        END;
    end;

    [Scope('Internal')]
    procedure FNC_Manual_Update(ItemNo_Co_Par: Code[20])
    var
        Item_Re_Loc: Record "27";
        DealItem_Re_Loc: Record "50023";
    begin
        /*Mise à jour des champs "Net Weight", "Gross Weight", "Volume CMB", "Volume CMB Carton" et "PCB"*/

        //on cherche l'article
        IF Item_Re_Loc.GET(ItemNo_Co_Par) THEN BEGIN

            //on cherche les deal items correspondant à cet article
            DealItem_Re_Loc.RESET();
            DealItem_Re_Loc.SETFILTER("Item No.", Item_Re_Loc."No.");
            //THM161117
            DealItem_Re_Loc.SETFILTER(DealItem_Re_Loc.Status, '%1|%2|%3', DealItem_Re_Loc.Status::"In order", DealItem_Re_Loc.Status::"In progress", DealItem_Re_Loc.Status::Invoiced);
            //END THM161117
            IF DealItem_Re_Loc.FINDFIRST THEN BEGIN
                REPEAT

                    FNC_Update_Net_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Weight net");
                    FNC_Update_Gross_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Weight brut");
                    //>>Mgts10.00.05.00
                    //FNC_Update_Volume_CMB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Vol cbm");
                    FNC_Update_Volume_CMB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc.GetVolCBM(TRUE));
                    //<<Mgts10.00.05.00
                    FNC_Update_Volume_CMB_Carton(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Vol cbm carton transport");
                    FNC_Update_PCB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc.PCB);

                    //START CHG02
                    Deal_Cu.FNC_Reinit_Deal(DealItem_Re_Loc.Deal_ID, TRUE, FALSE);
                    //STOP CHG02

                UNTIL (DealItem_Re_Loc.NEXT() = 0);

            END;

            MESSAGE('Mise à jour effectuée !');

        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Manual_Update()',
              STRSUBSTNO('Article >%1< introuvable dans la table Item !', ItemNo_Co_Par))

    end;

    [Scope('Internal')]
    procedure FNC_UpdateWithACOLine(From_Te_Par: Text[30]; ACOLine_Re_Par: Record "39"; xACOLine_Re_Par: Record "39")
    var
        element_Re_Loc: Record "50021";
        Type_Op_Loc: Option Cost,Price;
        updateNeeded_Bo_Loc: Boolean;
        ACO_Line_Re_Loc: Record "39";
        UpdateRequest_Re: Record "50039";
    begin
        //Cette fonction est appelée lorsque des modifications sont effectuées sur les lignes ACO au niveau du prix d'achat
        //-> si p.e. on change la quantité, alors le prix d'achat est validé et cette fonction est appelé
        //-> si p.e. on change la devise du document, chaque ligne voit son prix d'achat validé et cette fonction est appelée aussi..

        //si la quantité est plus grande que zéro on envisage une mise à jour sinon ca sert à rien
        IF ACOLine_Re_Par.Quantity > 0 THEN BEGIN

            //MESSAGE('entering');

            //si une affaire existe pour cette ACO
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Type, "Type No.");
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
            element_Re_Loc.SETRANGE("Type No.", ACOLine_Re_Par."Document No.");
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN BEGIN

                //on traite directement toutes les lignes sur l'ACO
                ACO_Line_Re_Loc.RESET();
                ACO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                //si il y a des lignes sur l'ACO
                IF ACO_Line_Re_Loc.FINDFIRST THEN
                    REPEAT

                        //La fonction ajoute seulement si l'item n'a jamais été enregistré !
                        FNC_Add(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.");

                        //détecte si une mise à jour est nécessaire au niveau des deal item (prix et devise)
                        IF FNC_NeedsToBeUpdated(
                          element_Re_Loc.Deal_ID,
                          ACO_Line_Re_Loc."No.",
                          Type_Op_Loc::Cost,
                          ACO_Line_Re_Loc."Direct Unit Cost",
                          ACO_Line_Re_Loc."Currency Code") THEN BEGIN

                            //La fonction met à jour Unit Cost
                            FNC_Update_Unit_Cost(
                              element_Re_Loc.Deal_ID,
                              ACO_Line_Re_Loc."No.",
                              ACO_Line_Re_Loc."Direct Unit Cost",
                              ACO_Line_Re_Loc."Currency Code"
                            );

                            //on ajoute une update request seulement si on a pas déjà une request pour le meme cas
                            //car ca sert à rien de faire 10x la meme mise à jour de l'affaire
                            UpdateRequest_Re.RESET();
                            UpdateRequest_Re.SETCURRENTKEY(Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.");
                            UpdateRequest_Re.SETRANGE(Request_For_Deal_ID, element_Re_Loc.Deal_ID);
                            UpdateRequest_Re.SETRANGE(Requested_By_Type, UpdateRequest_Re.Requested_By_Type::"Deal Item");
                            //UpdateRequest_Re.SETRANGE("Requested_By_Type No.", ACOLine_Re_Par."No.");
                            UpdateRequest_Re.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
                            UpdateRequest_Re.SETRANGE("To be ignored", FALSE);
                            IF NOT UpdateRequest_Re.FINDFIRST THEN BEGIN

                                UpdateRequestManager_Cu.FNC_Add_Request(
                                  element_Re_Loc.Deal_ID,
                                  UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                  '', //ACOLine_Re_Par."No.",
                                  CURRENTDATETIME
                                );

                                //MESSAGE('ajout request opur deal %1', element_Re_Loc.Deal_ID);

                            END;

                            //si la nouvelle quantité est différente de la quantitée précédente
                        END ELSE
                            IF ACOLine_Re_Par.Quantity <> xACOLine_Re_Par.Quantity THEN BEGIN

                                //MESSAGE('*%1 - %2', ACOLine_Re_Par.Quantity, xACOLine_Re_Par.Quantity);
                                //on ajoute une update request seulement si on a pas déjà une request pour le meme cas
                                //car ca sert à rien de faire 10x la meme mise à jour de l'affaire
                                UpdateRequest_Re.RESET();
                                UpdateRequest_Re.SETCURRENTKEY(Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.");
                                UpdateRequest_Re.SETRANGE(Request_For_Deal_ID, element_Re_Loc.Deal_ID);
                                UpdateRequest_Re.SETRANGE(Requested_By_Type, UpdateRequest_Re.Requested_By_Type::"Deal Item");
                                //UpdateRequest_Re.SETRANGE("Requested_By_Type No.", ACOLine_Re_Par."No.");
                                UpdateRequest_Re.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
                                UpdateRequest_Re.SETRANGE("To be ignored", FALSE);
                                IF NOT UpdateRequest_Re.FINDFIRST THEN BEGIN

                                    UpdateRequestManager_Cu.FNC_Add_Request(
                                      element_Re_Loc.Deal_ID,
                                      UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                      '', //ACOLine_Re_Par."No.",
                                      CURRENTDATETIME
                                    );

                                    //MESSAGE('ajout request opur deal %1', element_Re_Loc.Deal_ID);

                                END;

                            END;

                    UNTIL (ACO_Line_Re_Loc.NEXT = 0);

                //on met à jour toutes les affaires qui viennent d'etre marquées dans la boucle
                //le dernier paramètre est à true pour dire qu'on traite la liste silencieusement
                UpdateRequestManager_Cu.FNC_ProcessRequestsByType(UpdateRequest_Re.Requested_By_Type::"Deal Item", '', TRUE);

            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_UpdateWithVCOLine(From_Te_Par: Text[30]; VCOLine_Re_Par: Record "37"; xVCOLine_Re_Par: Record "37")
    var
        element_Re_Loc: Record "50021";
        Type_Op_Loc: Option Cost,Price;
        updateNeeded_Bo_Loc: Boolean;
        VCO_Line_Re_Loc: Record "37";
        UpdateRequest_Re: Record "50039";
        elem_Re_Loc: Record "50021";
    begin
        //Cette fonction est appelée lorsque des modifications sont effectuées sur les lignes VCO au niveau du prix de vente
        //-> si p.e. on change la quantité, alors le prix de vente est validé et cette fonction est appelée
        //-> si p.e. on change la devise du document, chaque ligne voit son prix de vente validé et cette fonction est appelée aussi..

        //si la quantité est plus grande que zéro on envisage une mise à jour sinon ca sert à rien
        IF ((VCOLine_Re_Par.Quantity > 0) AND (VCOLine_Re_Par."Special Order Purchase No." <> '')) THEN BEGIN

            //MESSAGE('entering');

            //si une affaire existe pour cette VCO
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Type, "Type No.");
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE("Type No.", VCOLine_Re_Par."Document No.");
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN BEGIN

                //on traite directement toutes les lignes sur la VCO
                VCO_Line_Re_Loc.RESET();
                VCO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                //si il y a des lignes sur la VCO
                IF VCO_Line_Re_Loc.FINDFIRST THEN
                    REPEAT

                        //Sur une VCO, chaque ligne peut concerner une ACO différente
                        //sur les lignes VCO on a le numéro ACO et on veut connaitre l'affaire liée à cette ACO
                        elem_Re_Loc.RESET();
                        elem_Re_Loc.SETCURRENTKEY(Type, "Type No.");
                        elem_Re_Loc.SETRANGE(Type, elem_Re_Loc.Type::ACO);
                        elem_Re_Loc.SETRANGE("Type No.", VCO_Line_Re_Loc."Special Order Purchase No.");
                        IF elem_Re_Loc.FINDFIRST THEN BEGIN

                            //La fonction ajoute seulement si l'item n'a jamais été enregistré !
                            FNC_Add(elem_Re_Loc.Deal_ID, VCO_Line_Re_Loc."No.");

                            //détecte si une mise à jour est nécessaire au niveau des deal item (prix et devise)
                            IF FNC_NeedsToBeUpdated(
                            elem_Re_Loc.Deal_ID,
                            VCO_Line_Re_Loc."No.",
                            Type_Op_Loc::Price,
                            VCO_Line_Re_Loc."Unit Price",
                            VCO_Line_Re_Loc."Currency Code") THEN BEGIN

                                //La fonction met à jour Unit Price
                                FNC_Update_Unit_Price(
                                  elem_Re_Loc.Deal_ID,
                                  VCO_Line_Re_Loc."No.",
                                  VCO_Line_Re_Loc."Unit Price",
                                  VCO_Line_Re_Loc."Currency Code"
                                );

                                //on ajoute une update request seulement si on a pas déjà une request pour le meme cas
                                //car ca sert à rien de faire 10x la meme mise à jour de l'affaire
                                UpdateRequest_Re.RESET();
                                UpdateRequest_Re.SETCURRENTKEY(Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.");
                                UpdateRequest_Re.SETRANGE(Request_For_Deal_ID, elem_Re_Loc.Deal_ID);
                                UpdateRequest_Re.SETRANGE(Requested_By_Type, UpdateRequest_Re.Requested_By_Type::"Deal Item");
                                //UpdateRequest_Re.SETRANGE("Requested_By_Type No.", VCOLine_Re_Par."No.");
                                UpdateRequest_Re.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
                                UpdateRequest_Re.SETRANGE("To be ignored", FALSE);
                                IF NOT UpdateRequest_Re.FINDFIRST THEN BEGIN

                                    UpdateRequestManager_Cu.FNC_Add_Request(
                                      elem_Re_Loc.Deal_ID,
                                      UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                      '', //VCOLine_Re_Par."No.",
                                      CURRENTDATETIME
                                    );

                                    //MESSAGE('ajout request opur deal %1', element_Re_Loc.Deal_ID);

                                END;

                                //si la nouvelle quantité est différente de la quantitée précédente
                            END ELSE
                                IF VCOLine_Re_Par.Quantity <> xVCOLine_Re_Par.Quantity THEN BEGIN

                                    //on ajoute une update request seulement si on a pas déjà une request pour le meme cas
                                    //car ca sert à rien de faire 10x la meme mise à jour de l'affaire
                                    UpdateRequest_Re.RESET();
                                    UpdateRequest_Re.SETCURRENTKEY(Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.");
                                    UpdateRequest_Re.SETRANGE(Request_For_Deal_ID, elem_Re_Loc.Deal_ID);
                                    UpdateRequest_Re.SETRANGE(Requested_By_Type, UpdateRequest_Re.Requested_By_Type::"Deal Item");
                                    //UpdateRequest_Re.SETRANGE("Requested_By_Type No.", VCOLine_Re_Par."No.");
                                    UpdateRequest_Re.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
                                    UpdateRequest_Re.SETRANGE("To be ignored", FALSE);
                                    IF NOT UpdateRequest_Re.FINDFIRST THEN BEGIN

                                        UpdateRequestManager_Cu.FNC_Add_Request(
                                          elem_Re_Loc.Deal_ID,
                                          UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                          '', //VCOLine_Re_Par."No.",
                                          CURRENTDATETIME
                                        );

                                        //MESSAGE('ajout request opur deal %1', element_Re_Loc.Deal_ID);

                                    END;

                                END;

                        END;

                    UNTIL (VCO_Line_Re_Loc.NEXT = 0);

                //on met à jour toutes les affaires qui viennent d'etre marquées dans la boucle
                //le dernier paramètre est à true pour dire qu'on traite la liste silencieusement
                UpdateRequestManager_Cu.FNC_ProcessRequestsByType(UpdateRequest_Re.Requested_By_Type::"Deal Item", '', TRUE);

            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_NeedsToBeUpdated(DealID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; Type_Op: Option Cost,Price; Amount_Dec_Par: Decimal; Currency_Co_Par: Code[10]) needsUpdate_Bo_Ret: Boolean
    begin
        /*
        compare un enregistrement dealItem pour savoir si il faut le mettre à jour ou pas
        usage : MESSAGE('%1', DealItem_Cu.FNC_NeedsToBeUpdated('AFF-00005', '10707',Type_Op::Price ,7.06,'EUR'));
        */

        IF Type_Op = Type_Op::Cost THEN BEGIN

            needsUpdate_Bo_Ret :=
              (Amount_Dec_Par = FNC_Get_Unit_Cost(DealID_Co_Par, ItemNo_Co_Par))
              AND
              (Currency_Co_Par = FNC_Get_Currency_Cost(DealID_Co_Par, ItemNo_Co_Par)
            );

        END ELSE
            IF Type_Op = Type_Op::Price THEN BEGIN

                needsUpdate_Bo_Ret :=
                  (Amount_Dec_Par = FNC_Get_Unit_Price(DealID_Co_Par, ItemNo_Co_Par))
                  AND
                  (Currency_Co_Par = FNC_Get_Currency_Price(DealID_Co_Par, ItemNo_Co_Par)
                );

            END;

        EXIT(NOT needsUpdate_Bo_Ret);

    end;

    [Scope('Internal')]
    procedure FNC_Manual_Update2(ItemNo_Co_Par: Code[20])
    var
        Item_Re_Loc: Record "27";
        DealItem_Re_Loc: Record "50023";
    begin
        //THM250817  START
        //utilser pour mise à jour par lot
        /*Mise à jour des champs "Net Weight", "Gross Weight", "Volume CMB", "Volume CMB Carton" et "PCB"*/

        //on cherche l'article
        IF Item_Re_Loc.GET(ItemNo_Co_Par) THEN BEGIN

            //on cherche les deal items correspondant à cet article
            DealItem_Re_Loc.RESET();
            DealItem_Re_Loc.SETFILTER("Item No.", Item_Re_Loc."No.");
            //THM161117
            DealItem_Re_Loc.SETFILTER(DealItem_Re_Loc.Status, '%1|%2|%3', DealItem_Re_Loc.Status::"In order", DealItem_Re_Loc.Status::"In progress", DealItem_Re_Loc.Status::Invoiced);
            //END THM161117
            IF DealItem_Re_Loc.FINDFIRST THEN BEGIN
                REPEAT

                    FNC_Update_Net_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Weight net");
                    FNC_Update_Gross_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Weight brut");
                    //>>Mgts10.00.05.00
                    //FNC_Update_Volume_CMB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Vol cbm");
                    FNC_Update_Volume_CMB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc.GetVolCBM(TRUE));
                    //<<Mgts10.00.05.00
                    FNC_Update_Volume_CMB_Carton(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Vol cbm carton transport");
                    FNC_Update_PCB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc.PCB);

                    //START CHG02
                    Deal_Cu.FNC_Reinit_Deal(DealItem_Re_Loc.Deal_ID, TRUE, TRUE);
                    //STOP CHG02

                UNTIL (DealItem_Re_Loc.NEXT() = 0);

            END;



        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Manual_Update()',
              STRSUBSTNO('Article >%1< introuvable dans la table Item !', ItemNo_Co_Par))

        //END THM250817

    end;
}

