codeunit 50024 "DEL Deal Item"
{


    trigger OnRun()
    begin
    end;

    var

        Deal_Cu: Codeunit "DEL Deal";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";

        Type_Op: Option Cost,Price;

        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';

    procedure FNC_Add(Deal_ID_Co_Par: Code[20]; Item_No_Co_Par: Code[20])
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin


        IF NOT dealItem_Re_Loc.GET(Deal_ID_Co_Par, Item_No_Co_Par) THEN
            FNC_Insert(Deal_ID_Co_Par, Item_No_Co_Par)

    end;


    procedure FNC_Insert(Deal_ID_Co_Par: Code[20]; Item_No_Co_Par: Code[20])
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
        item_Re_Loc: Record Item;
    begin
        IF item_Re_Loc.GET(Item_No_Co_Par) THEN BEGIN

            FNC_checkForZero(item_Re_Loc);



            dealItem_Re_Loc.INIT();
            dealItem_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
            dealItem_Re_Loc.VALIDATE("Item No.", item_Re_Loc."No.");

            dealItem_Re_Loc.VALIDATE("Net Weight", item_Re_Loc."DEL Weight net");
            dealItem_Re_Loc.VALIDATE("Gross Weight", item_Re_Loc."DEL Weight brut");

            dealItem_Re_Loc.VALIDATE("Volume CMB", item_Re_Loc.GetVolCBM(TRUE));

            dealItem_Re_Loc.VALIDATE("Volume CMB carton transport", item_Re_Loc."DEL Vol cbm carton transport");
            dealItem_Re_Loc.VALIDATE(PCB, item_Re_Loc."DEL PCB");
            dealItem_Re_Loc.VALIDATE("Droit de douane reduit", item_Re_Loc."DEL Droit de douane reduit");

            IF NOT dealItem_Re_Loc.INSERT() THEN
                ERROR(ERROR_TXT, 'Co50024', 'FNC_Insert()', 'Insertion impossible dans la table Deal Item')

        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Insert()', STRSUBSTNO('Item >%1< inexistant !', Item_No_Co_Par));

    end;


    procedure FNC_Update_Unit_Cost(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; UnitCost_De_Par: Decimal; CurrencyCost_Co_Par: Code[10])
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin

        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN


            dealItem_Re_Loc.VALIDATE("Unit Cost", UnitCost_De_Par);
            dealItem_Re_Loc.VALIDATE("Currency Cost", CurrencyCost_Co_Par);
            IF NOT dealItem_Re_Loc.MODIFY() THEN
                ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Cost()', 'Update Cost impossible dans la table Deal Item')


        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Cost()',
              STRSUBSTNO('Item >%1< introuvable dans la table Deal Item pour l''affaire %2 !', ItemNo_Co_Par, Deal_ID_Co_Par));

    end;

    procedure FNC_Update_Unit_Price(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; UnitPrice_De_Par: Decimal; CurrencyPrice_Co_Par: Code[10])
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin


        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN


            dealItem_Re_Loc.VALIDATE("Unit Price", UnitPrice_De_Par);
            dealItem_Re_Loc.VALIDATE("Currency Price", CurrencyPrice_Co_Par);
            IF NOT dealItem_Re_Loc.MODIFY() THEN
                ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Price()', 'Update Price impossible dans la table Deal Item')


        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Unit_Price()',
              STRSUBSTNO('Item >%1< introuvable dans la table Deal Item pour l''affaire %2 !', ItemNo_Co_Par, Deal_ID_Co_Par));

    end;


    procedure FNC_Update_Net_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Net Weight" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Net_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Update_Gross_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Gross Weight" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Gross_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Update_Volume_CMB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Volume CMB" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Volume_CMB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Update_Volume_CMB_Carton(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc."Volume CMB carton transport" := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_Volume_CMB_Carton()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Update_PCB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; NewValue_Dec_Par: Decimal)
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN BEGIN
            dealItem_Re_Loc.PCB := NewValue_Dec_Par;
            dealItem_Re_Loc.MODIFY();
        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Update_PCB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Sales_Amount(Deal_ID_Co_Par: Code[20]; ShipmentNo_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option Planned,Real) Amount_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
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

                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT

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


            END ELSE BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Planned);

                IF position_Re_Loc.FINDFIRST() THEN
                    REPEAT
                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF element_Re_Loc.Type = element_Re_Loc.Type::VCO THEN
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

                IF position_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF ((element_Re_Loc.Type = element_Re_Loc.Type::"Sales Invoice")
                          OR (element_Re_Loc.Type = element_Re_Loc.Type::"Sales Cr. Memo")) THEN
                            IF ShipmentNo_Co_Par = '' THEN
                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)

                            ELSE

                                IF dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc.Element_ID) THEN
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);

                    UNTIL (position_Re_Loc.NEXT() = 0);

            END;

    end;


    procedure FNC_Get_Purchases_Amount(Deal_ID_Co_Par: Code[20]; ShipmentNo_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option Planned,Real) Amount_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
    begin


        Amount_Dec_Ret := 0;


        IF Instance_Op_Par = Instance_Op_Par::Planned THEN BEGIN


            IF dealShipment_Re_Loc.GET(ShipmentNo_Co_Par) THEN BEGIN

                IF BR_Header_Re_Loc.GET(dealShipment_Re_Loc."BR No.") THEN BEGIN

                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", BR_Header_Re_Loc."No.");
                    purchRcptLine_Re_Loc.SETRANGE("No.", "Item_No._Co_Par");

                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT

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


            END ELSE BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Planned);

                IF position_Re_Loc.FINDFIRST() THEN
                    REPEAT
                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF element_Re_Loc.Type = element_Re_Loc.Type::ACO THEN
                            Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)

                    UNTIL (position_Re_Loc.NEXT() = 0);

            END

        END ELSE
            IF Instance_Op_Par = Instance_Op_Par::Real THEN BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par::Real);

                IF position_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF ((element_Re_Loc.Type = element_Re_Loc.Type::"Purchase Invoice")
                          OR (element_Re_Loc.Type = element_Re_Loc.Type::"Purch. Cr. Memo")) THEN
                            IF ShipmentNo_Co_Par = '' THEN
                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)

                            ELSE

                                IF dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc.Element_ID) THEN
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);

                    UNTIL (position_Re_Loc.NEXT() = 0);

            END;

    end;


    procedure FNC_Get_Fees_Amount(Deal_ID_Co_Par: Code[20]; ShipmentNo_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option Planned,Real) Amount_Dec_Ret: Decimal
    var
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
    begin


        Amount_Dec_Ret := 0;


        IF Instance_Op_Par = Instance_Op_Par::Planned THEN BEGIN


            IF dealShipment_Re_Loc.GET(ShipmentNo_Co_Par) THEN BEGIN

                IF BR_Header_Re_Loc.GET(dealShipment_Re_Loc."BR No.") THEN BEGIN

                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", BR_Header_Re_Loc."No.");
                    purchRcptLine_Re_Loc.SETRANGE("No.", "Item_No._Co_Par");

                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                            position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");

                            IF position_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                                    IF element_Re_Loc.Type = element_Re_Loc.Type::Fee THEN
                                        Amount_Dec_Ret += position_Re_Loc.Amount * purchRcptLine_Re_Loc.Quantity * position_Re_Loc.Rate;

                                UNTIL (position_Re_Loc.NEXT() = 0)


                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

                END


            END ELSE BEGIN

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
                position_Re_Loc.SETRANGE(Instance, Instance_Op_Par);

                IF position_Re_Loc.FINDFIRST() THEN
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

                IF position_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, position_Re_Loc.Element_ID);
                        IF element_Re_Loc.Type = element_Re_Loc.Type::Invoice THEN
                            IF ShipmentNo_Co_Par = '' THEN
                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                            ELSE

                                IF (dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc.Element_ID)) AND (
                                   dealShipmentConnection_Re_Loc.GET(Deal_ID_Co_Par, ShipmentNo_Co_Par, position_Re_Loc."Sub Element_ID")) THEN
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);

                    UNTIL (position_Re_Loc.NEXT() = 0);

            END;

    end;


    procedure FNC_Get_Amount(Deal_ID_Co_Par: Code[20]; "Item_No._Co_Par": Code[20]; Instance_Op_Par: Option) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "DEL Position";
    begin
        /*RETOURNE LE MONTANT TOTAL D'UN ARTICLE (ACHAT, VENTE ET FRAIS)*/

        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        position_Re_Loc.SETRANGE("Deal Item No.", "Item_No._Co_Par");
        position_Re_Loc.SETRANGE(Instance, Instance_Op_Par);

        Amount_Dec_Ret := 0;
        IF position_Re_Loc.FINDFIRST() THEN
            REPEAT
                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);
            UNTIL (position_Re_Loc.NEXT() = 0)

    end;


    procedure FNC_Get_Unit_Price(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Amount_Dec_Ret := dealItem_Re_Loc."Unit Price"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Unit_Price()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Unit_Cost(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Amount_Dec_Ret := dealItem_Re_Loc."Unit Cost"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Unit_Cost()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Currency_Price(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Currency_Co_Ret: Code[10]
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Currency_Co_Ret := dealItem_Re_Loc."Currency Price"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Currency_Price()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Currency_Cost(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Currency_Co_Ret: Code[10]
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Currency_Co_Ret := dealItem_Re_Loc."Currency Cost"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Currency_Cost()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Net_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Net Weight"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Net_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Gross_Weight(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Gross Weight"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Gross_Weight()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Volume_CMB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Volume CMB"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Volume_CMB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Volume_CMB_Carton(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Volume CMB carton transport"
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Volume_CMB_Carton()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_PCB(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc.PCB
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_PCB()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Droit_Douanne(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) Value_Co_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
    begin
        IF dealItem_Re_Loc.GET(Deal_ID_Co_Par, ItemNo_Co_Par) THEN
            Value_Co_Ret := dealItem_Re_Loc."Droit de douane reduit" / 100
        ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Get_Droit_Douanne()',
              STRSUBSTNO('Item >%1< introuvable pour l''affaire >%2< dans la table Deal Item !', ItemNo_Co_Par, Deal_ID_Co_Par))
    end;


    procedure FNC_Get_Campaign_Code(Deal_ID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]) CampaignCode_Co_Ret: Code[20]
    var
        element_Re_Loc: Record "DEL Element";
        salesLine_Re_Loc: Record "Sales Line";
    begin
        CampaignCode_Co_Ret := '';

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT
                salesLine_Re_Loc.RESET();
                salesLine_Re_Loc.SETRANGE("Document Type", salesLine_Re_Loc."Document Type"::Order);
                salesLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                salesLine_Re_Loc.SETRANGE("No.", ItemNo_Co_Par);
                IF salesLine_Re_Loc.FINDFIRST() THEN BEGIN
                    CampaignCode_Co_Ret := salesLine_Re_Loc."DEL Campaign Code";
                    EXIT(CampaignCode_Co_Ret);
                END

            UNTIL element_Re_Loc.NEXT() = 0;
    end;


    procedure FNC_checkForZero(Item_Re_Par: Record Item)
    var
        message_Te_Loc: Text[250];
    begin
        message_Te_Loc := '';

        IF Item_Re_Par."DEL Weight net" = 0 THEN message_Te_Loc += 'Weight net';
        IF Item_Re_Par."DEL Weight brut" = 0 THEN message_Te_Loc += ', Weight brut';

        IF Item_Re_Par.GetVolCBM(TRUE) = 0 THEN message_Te_Loc += ', Vol cbm';
        IF Item_Re_Par."DEL Vol cbm carton transport" = 0 THEN message_Te_Loc += ', Vol cbm carton transport';
        IF Item_Re_Par."DEL PCB" = 0 THEN message_Te_Loc += ', PCB';

        IF message_Te_Loc <> '' THEN BEGIN
            message_Te_Loc += ' de l''article ' + FORMAT(Item_Re_Par."No.") + ' à 0 sur la fiche article !';
            ERROR(message_Te_Loc);
        END;
    end;


    procedure FNC_Manual_Update(ItemNo_Co_Par: Code[20])
    var
        DealItem_Re_Loc: Record "DEL Deal Item";
        Item_Re_Loc: Record Item;
    begin

        IF Item_Re_Loc.GET(ItemNo_Co_Par) THEN BEGIN


            DealItem_Re_Loc.RESET();
            DealItem_Re_Loc.SETFILTER("Item No.", Item_Re_Loc."No.");

            DealItem_Re_Loc.SETFILTER(DealItem_Re_Loc.Status, '%1|%2|%3', DealItem_Re_Loc.Status::"In order", DealItem_Re_Loc.Status::"In progress", DealItem_Re_Loc.Status::Invoiced);

            IF DealItem_Re_Loc.FINDFIRST() THEN
                REPEAT

                    FNC_Update_Net_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL Weight net");
                    FNC_Update_Gross_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL Weight brut");

                    FNC_Update_Volume_CMB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc.GetVolCBM(TRUE));

                    FNC_Update_Volume_CMB_Carton(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL Vol cbm carton transport");
                    FNC_Update_PCB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL PCB");


                    Deal_Cu.FNC_Reinit_Deal(DealItem_Re_Loc.Deal_ID, TRUE, FALSE);


                UNTIL (DealItem_Re_Loc.NEXT() = 0);

            MESSAGE('Mise à jour effectuée !');

        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Manual_Update()',
              STRSUBSTNO('Article >%1< introuvable dans la table Item !', ItemNo_Co_Par))

    end;


    procedure FNC_UpdateWithACOLine(From_Te_Par: Text[30]; ACOLine_Re_Par: Record "Purchase Line"; xACOLine_Re_Par: Record "Purchase Line")
    var
        element_Re_Loc: Record "DEL Element";
        UpdateRequest_Re: Record "DEL Update Request Manager";
        ACO_Line_Re_Loc: Record "Purchase Line";
        Type_Op_Loc: Option Cost,Price;
    begin

        IF ACOLine_Re_Par.Quantity > 0 THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Type, "Type No.");
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
            element_Re_Loc.SETRANGE("Type No.", ACOLine_Re_Par."Document No.");
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST() THEN BEGIN

                ACO_Line_Re_Loc.RESET();
                ACO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);

                IF ACO_Line_Re_Loc.FINDFIRST() THEN
                    REPEAT


                        FNC_Add(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."No.");


                        IF FNC_NeedsToBeUpdated(
                          element_Re_Loc.Deal_ID,
                          ACO_Line_Re_Loc."No.",
                          Type_Op_Loc::Cost,
                          ACO_Line_Re_Loc."Direct Unit Cost",
                          ACO_Line_Re_Loc."Currency Code") THEN BEGIN


                            FNC_Update_Unit_Cost(
                              element_Re_Loc.Deal_ID,
                              ACO_Line_Re_Loc."No.",
                              ACO_Line_Re_Loc."Direct Unit Cost",
                              ACO_Line_Re_Loc."Currency Code"
                            );

                            UpdateRequest_Re.RESET();
                            UpdateRequest_Re.SETCURRENTKEY(Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.");
                            UpdateRequest_Re.SETRANGE(Request_For_Deal_ID, element_Re_Loc.Deal_ID);
                            UpdateRequest_Re.SETRANGE(Requested_By_Type, UpdateRequest_Re.Requested_By_Type::"Deal Item");

                            UpdateRequest_Re.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
                            UpdateRequest_Re.SETRANGE("To be ignored", FALSE);
                            IF NOT UpdateRequest_Re.FINDFIRST() THEN
                                UpdateRequestManager_Cu.FNC_Add_Request(
                                  element_Re_Loc.Deal_ID,
                                  UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                  '',
                                  CURRENTDATETIME
                                );

                        END ELSE
                            IF ACOLine_Re_Par.Quantity <> xACOLine_Re_Par.Quantity THEN BEGIN


                                UpdateRequest_Re.RESET();
                                UpdateRequest_Re.SETCURRENTKEY(Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.");
                                UpdateRequest_Re.SETRANGE(Request_For_Deal_ID, element_Re_Loc.Deal_ID);
                                UpdateRequest_Re.SETRANGE(Requested_By_Type, UpdateRequest_Re.Requested_By_Type::"Deal Item");

                                UpdateRequest_Re.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
                                UpdateRequest_Re.SETRANGE("To be ignored", FALSE);
                                IF NOT UpdateRequest_Re.FINDFIRST() THEN
                                    UpdateRequestManager_Cu.FNC_Add_Request(
                                      element_Re_Loc.Deal_ID,
                                      UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                      '',
                                      CURRENTDATETIME
                                    );


                            END;

                    UNTIL (ACO_Line_Re_Loc.NEXT() = 0);

                //on met à jour toutes les affaires qui viennent d'etre marquées dans la boucle
                //le dernier paramètre est à true pour dire qu'on traite la liste silencieusement
                UpdateRequestManager_Cu.FNC_ProcessRequestsByType(UpdateRequest_Re.Requested_By_Type::"Deal Item", '', TRUE);

            END;

        END;
    end;


    procedure FNC_UpdateWithVCOLine(From_Te_Par: Text[30]; VCOLine_Re_Par: Record "Sales Line"; xVCOLine_Re_Par: Record "Sales Line")
    var
        elem_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        UpdateRequest_Re: Record "DEL Update Request Manager";
        VCO_Line_Re_Loc: Record "Sales Line";
        Type_Op_Loc: Option Cost,Price;
    begin
        //Cette fonction est appelée lorsque des modifications sont effectuées sur les lignes VCO au niveau du prix de vente
        //-> si p.e. on change la quantité, alors le prix de vente est validé et cette fonction est appelée
        //-> si p.e. on change la devise du document, chaque ligne voit son prix de vente validé et cette fonction est appelée aussi..

        //si la quantité est plus grande que zéro on envisage une mise à jour sinon ca sert à rien
        IF ((VCOLine_Re_Par.Quantity > 0) AND (VCOLine_Re_Par."Special Order Purchase No." <> '')) THEN BEGIN

            //si une affaire existe pour cette VCO
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Type, "Type No.");
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE("Type No.", VCOLine_Re_Par."Document No.");
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST() THEN BEGIN

                //on traite directement toutes les lignes sur la VCO
                VCO_Line_Re_Loc.RESET();
                VCO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                //si il y a des lignes sur la VCO
                IF VCO_Line_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        //Sur une VCO, chaque ligne peut concerner une ACO différente
                        //sur les lignes VCO on a le numéro ACO et on veut connaitre l'affaire liée à cette ACO
                        elem_Re_Loc.RESET();
                        elem_Re_Loc.SETCURRENTKEY(Type, "Type No.");
                        elem_Re_Loc.SETRANGE(Type, elem_Re_Loc.Type::ACO);
                        elem_Re_Loc.SETRANGE("Type No.", VCO_Line_Re_Loc."Special Order Purchase No.");
                        IF elem_Re_Loc.FINDFIRST() THEN BEGIN

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
                                IF NOT UpdateRequest_Re.FINDFIRST() THEN
                                    UpdateRequestManager_Cu.FNC_Add_Request(
                                      elem_Re_Loc.Deal_ID,
                                      UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                      '', //VCOLine_Re_Par."No.",
                                      CURRENTDATETIME
                                    );
                                //MESSAGE('ajout request opur deal %1', element_Re_Loc.Deal_ID);

                                //si la nouvelle quantité est différente de la quantitée précédente
                            END ELSE
                                IF VCOLine_Re_Par.Quantity <> xVCOLine_Re_Par.Quantity THEN BEGIN

                                    //on ajoute une update request seulement si on a pas déjà une request pour le meme cas
                                    //car ca sert à rien de faire 10x la meme mise à jour de l'affaire
                                    UpdateRequest_Re.RESET();
                                    UpdateRequest_Re.SETCURRENTKEY(Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.");
                                    UpdateRequest_Re.SETRANGE(Request_For_Deal_ID, elem_Re_Loc.Deal_ID);
                                    UpdateRequest_Re.SETRANGE(Requested_By_Type, UpdateRequest_Re.Requested_By_Type::"Deal Item");
                                    UpdateRequest_Re.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
                                    UpdateRequest_Re.SETRANGE("To be ignored", FALSE);
                                    IF NOT UpdateRequest_Re.FINDFIRST() THEN
                                        UpdateRequestManager_Cu.FNC_Add_Request(
                                          elem_Re_Loc.Deal_ID,
                                          UpdateRequest_Re.Requested_By_Type::"Deal Item",
                                          '',
                                          CURRENTDATETIME
                                        );

                                END;

                        END;

                    UNTIL (VCO_Line_Re_Loc.NEXT() = 0);

                //on met à jour toutes les affaires qui viennent d'etre marquées dans la boucle
                //le dernier paramètre est à true pour dire qu'on traite la liste silencieusement
                UpdateRequestManager_Cu.FNC_ProcessRequestsByType(UpdateRequest_Re.Requested_By_Type::"Deal Item", '', TRUE);

            END;

        END;
    end;


    procedure FNC_NeedsToBeUpdated(DealID_Co_Par: Code[20]; ItemNo_Co_Par: Code[20]; Type_Op: Option Cost,Price; Amount_Dec_Par: Decimal; Currency_Co_Par: Code[10]) needsUpdate_Bo_Ret: Boolean
    begin

        IF Type_Op = Type_Op::Cost THEN
            needsUpdate_Bo_Ret :=
              (Amount_Dec_Par = FNC_Get_Unit_Cost(DealID_Co_Par, ItemNo_Co_Par))
              AND
              (Currency_Co_Par = FNC_Get_Currency_Cost(DealID_Co_Par, ItemNo_Co_Par)
            )
        ELSE
            IF Type_Op = Type_Op::Price THEN
                needsUpdate_Bo_Ret :=
                  (Amount_Dec_Par = FNC_Get_Unit_Price(DealID_Co_Par, ItemNo_Co_Par))
                  AND
                  (Currency_Co_Par = FNC_Get_Currency_Price(DealID_Co_Par, ItemNo_Co_Par)
                );

        EXIT(NOT needsUpdate_Bo_Ret);

    end;


    procedure FNC_Manual_Update2(ItemNo_Co_Par: Code[20])
    var
        DealItem_Re_Loc: Record "DEL Deal Item";
        Item_Re_Loc: Record Item;
    begin
        //utilser pour mise à jour par lot
        /*Mise à jour des champs "Net Weight", "Gross Weight", "Volume CMB", "Volume CMB Carton" et "PCB"*/

        //on cherche l'article
        IF Item_Re_Loc.GET(ItemNo_Co_Par) THEN BEGIN

            //on cherche les deal items correspondant à cet article
            DealItem_Re_Loc.RESET();
            DealItem_Re_Loc.SETFILTER("Item No.", Item_Re_Loc."No.");
            DealItem_Re_Loc.SETFILTER(DealItem_Re_Loc.Status, '%1|%2|%3', DealItem_Re_Loc.Status::"In order", DealItem_Re_Loc.Status::"In progress", DealItem_Re_Loc.Status::Invoiced);
            IF DealItem_Re_Loc.FINDFIRST() THEN
                REPEAT

                    FNC_Update_Net_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL Weight net");
                    FNC_Update_Gross_Weight(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL Weight brut");
                    //FNC_Update_Volume_CMB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."Vol cbm");
                    FNC_Update_Volume_CMB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc.GetVolCBM(TRUE));
                    FNC_Update_Volume_CMB_Carton(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL Vol cbm carton transport");
                    FNC_Update_PCB(DealItem_Re_Loc.Deal_ID, DealItem_Re_Loc."Item No.", Item_Re_Loc."DEL PCB");

                    Deal_Cu.FNC_Reinit_Deal(DealItem_Re_Loc.Deal_ID, TRUE, TRUE);
                UNTIL (DealItem_Re_Loc.NEXT() = 0);



        END ELSE
            ERROR(ERROR_TXT, 'Co50024', 'FNC_Manual_Update()',
              STRSUBSTNO('Article >%1< introuvable dans la table Item !', ItemNo_Co_Par))

    end;
}

