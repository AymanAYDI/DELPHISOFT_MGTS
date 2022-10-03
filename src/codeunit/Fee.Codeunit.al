codeunit 50023 "DEL Fee"
{

    var
        Setup: Record "DEL General Setup";
        DealShipment_Cu: Codeunit "Deal Shipment";
        Element_Cu: Codeunit "DEL Element";
        ElementConnection_Cu: Codeunit "DEL Element Connection";
        Fee_Cu: Codeunit "DEL Fee";
        Position_Cu: Codeunit "DEL Position";
        Dispatcher_Cu: Codeunit Dispatcher;
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';


    procedure FNC_Add(element_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        element_Re_Temp: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        fee_Connection_Re_Loc: Record "DEL Fee Connection";
        ACO_Re_Loc: Record "Purchase Header";
        VCO_Re_Loc: Record "Sales Header";
        isToSkip: Boolean;
    begin
        /*AJOUTE TOUS LES FEE D'UN ELEMENT*/

        FNC_Add_Deal_Specific(element_ID_Co_Par);
        FNC_Add_General(element_ID_Co_Par);

    end;


    procedure FNC_Add_Deal_Specific(Element_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        element_Re_Temp: Record "DEL Element";
        fee_Re_Loc: Record "DEL Fee";
        fee_Connection_Re_Loc: Record "DEL Fee Connection";
        ACO_Re_Loc: Record "Purchase Header";
        VCO_Re_Loc: Record "Sales Header";
    begin
        /*AJOUTE TOUS LES FEE CONNECTION QUI ONT UN Deal.ID SPECIFIE*/

        // récupère l'Element voulu en fonction de son ID
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        fee_Connection_Re_Loc.RESET();

        CASE element_Re_Loc."Subject Type" OF
            element_Re_Loc."Subject Type"::Vendor:
                fee_Connection_Re_Loc.SETRANGE(Type, fee_Connection_Re_Loc.Type::Vendor);
            element_Re_Loc."Subject Type"::Customer:
                fee_Connection_Re_Loc.SETRANGE(Type, fee_Connection_Re_Loc.Type::Customer);
        END;
        fee_Connection_Re_Loc.SETRANGE("No.", element_Re_Loc."Subject No.");
        fee_Connection_Re_Loc.SETRANGE("Deal ID", element_Re_Loc.Deal_ID);
        //fee_connection_re_loc.setrange(inactive, false);

        /*AJOUTE TOUS LES FEE DE LA TABLE FEE CONNECTION POUR UN DEAL SPECIFIQUE*/
        IF fee_Connection_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT
                IF fee_Re_Loc.GET(fee_Connection_Re_Loc."Fee ID") THEN BEGIN

                    IF NOT fee_Re_Loc."Used For Import" THEN
                        Element_Cu.FNC_Insert_Element(
                          element_Re_Loc.Deal_ID,
                          element_Re_Loc.Instance::planned,
                          element_Re_Loc.Type::Fee,
                          '',
                          Element_ID_Co_Par,
                          element_Re_Loc."Subject Type"::" ",
                          '',
                          fee_Re_Loc.ID,
                          fee_Connection_Re_Loc.ID,
                          TODAY,
                          0,
                          '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
                          0D,
                          0 //splitt index
                        );

                END ELSE
                    ERROR('ERREUR\Source : Co 50023\Fonction : FNC_Add()\Raison : Fee >%1< introuvable', fee_Connection_Re_Loc."Deal ID")
            UNTIL (fee_Connection_Re_Loc.NEXT() = 0);
        END;

    end;


    procedure FNC_Add_General(Element_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        element_Re_Temp: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        fee_Connection_Re_Loc: Record "DEL Fee Connection";
        ACO_Re_Loc: Record "Purchase Header";
        VCO_Re_Loc: Record "Sales Header";
        isToSkip: Boolean;
    begin
        /*AJOUTE TOUS LES FEE CONNECTION QUI ONT PAS UN Deal.ID SPECIFIE*/

        // récupère l'Element voulu en fonction de son ID
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        fee_Connection_Re_Loc.RESET();

        CASE element_Re_Loc."Subject Type" OF
            element_Re_Loc."Subject Type"::Vendor:
                fee_Connection_Re_Loc.SETRANGE(Type, fee_Connection_Re_Loc.Type::Vendor);
            element_Re_Loc."Subject Type"::Customer:
                fee_Connection_Re_Loc.SETRANGE(Type, fee_Connection_Re_Loc.Type::Customer);
        END;
        fee_Connection_Re_Loc.SETRANGE("No.", element_Re_Loc."Subject No.");
        fee_Connection_Re_Loc.SETFILTER("Deal ID", '%1', '');
        //fee_connection_re_loc.setrange(inactive, false);


        /*AJOUTE TOUS LES FEE DE LA TABLE FEE CONNECTION GENERAUX (Deal.ID vide)*/
        IF fee_Connection_Re_Loc.FINDFIRST() THEN
            REPEAT
                // ON CHERCHE LES ELEMENTS CONCERNES PAR CE FEE
                isToSkip := FALSE;

                element_Re_Temp.RESET();
                element_Re_Temp.SETCURRENTKEY(Deal_ID, Type, Instance);
                element_Re_Temp.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                element_Re_Temp.SETRANGE(Type, element_Re_Temp.Type::Fee);
                element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
                element_Re_Temp.SETRANGE(Fee_ID, fee_Connection_Re_Loc."Fee ID");
                IF element_Re_Temp.FINDFIRST() THEN
                    REPEAT
                        //ON REGARDE DANS Fee Connection
                        //SI CE Fee EST DEJA APPLIQUE AU MEME Element (Ca veut dire qu'un Fee specifique est déjà attaché)
                        IF elementConnection_Re_Loc.GET(element_Re_Loc.Deal_ID, element_Re_Temp.ID, element_Re_Loc.ID) THEN
                            isToSkip := TRUE;
                    UNTIL (element_Re_Temp.NEXT() = 0);

                IF (fee_Re_Loc.GET(fee_Connection_Re_Loc."Fee ID")) AND (NOT isToSkip) THEN BEGIN
                    IF NOT fee_Re_Loc."Used For Import" THEN
                        Element_Cu.FNC_Insert_Element(
                          element_Re_Loc.Deal_ID,
                          element_Re_Loc.Instance::planned,
                          element_Re_Loc.Type::Fee,
                          '',
                          Element_ID_Co_Par,
                          element_Re_Loc."Subject Type"::" ",
                          '',
                          fee_Re_Loc.ID,
                          fee_Connection_Re_Loc.ID,
                          TODAY,
                          0,
                          '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
                          0D,
                          0 //splitt index
                        )
                END
            UNTIL (fee_Connection_Re_Loc.NEXT() = 0);

    end;


    procedure FNC_Set(var fee_Re_Par: Record 50024; fee_ID_Co_Par: Code[20])
    begin
        // défini l'instance du premier paramètre sur le record correspondant au Fee.ID passé en 2ème paramètre
        // j'ai l'ID du Fee et je veux faire pointer ma variable sur le record qui correspond à cet ID
        IF NOT fee_Re_Par.GET(fee_ID_Co_Par) THEN
            ERROR('ERREUR\Source : Co 50023\Fonction : FNC_Set()\Raison : GET() impossible avec Fee.ID >%1<', fee_ID_Co_Par);
    end;


    procedure FNC_Dispatch(Element_ID_Co_Loc: Code[20])
    var
        applyElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        glEntry_Re_Loc: Record "G/L Entry";
        addPositions_Bo_Loc: Boolean;
        isInvoice_Bo_Loc: Boolean;
        amountToDispatch_Dec_Loc: Decimal;
        sum_Dec_Loc: Decimal;
        value_Ar_Loc: array[300] of Decimal;
        arrayIndex: Integer;
        textArray: Text[255];
    begin
        /*DISPATCH UN ELEMENT (Fee ou Invoice) SUR D'AUTRES ELEMENTS*/

        /*
        Exemple:
        On a un frais ou une facture (Element) de 2000.- à ventiler (dispatcher, répartir) sur 3 livraisons (aussi des Element)
        On ventile selon la méthode du "prorata value".
        Valeur livraison 1 : 150
        Valeur livraison 2 : 350
        Valeur livraison 3 : 500
        --
        Valeur totale : 1000
        
        step 1  : on calcul la somme de la valeur de la livraison en fonction du paramètre choisi (valeur, poid, volume, etc..)
        step 2  : array.sum, = 150 + 350 + 500 = 1000
        step 3a : on calcul le pourcentage représenté par chaque ligne du tableau
        step 3b : la somme du frais à dispatcher est multipliée par le pourcentage
        step 4  : on dispatch sur les positions d'un élément
        
        array val.  step 1   step 3a  step 3b    step 4
        -------------------------------------------------
        array[1]    150      0.15     300      |-- 150
        array[2]    350      0.35     700 -----|
        array[3]    500      0.5      1000     |-- 350
        array[4]    -        -        -        |
        array[5]    -        -        -        |-- 200
        array[6]    -        -        -
        array[7]    -        -        -
        array[8]    -        -        -
        array[9]    -        -        -
        array[10]   -        -        -
        */

        isInvoice_Bo_Loc := FALSE;

        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Loc);

        /*_Si le montant du frais à dispatcher vaut 0, alors on le dispatch pas_*/
        IF Element_Cu.FNC_Get_Amount_FCY(element_Re_Loc.ID) <> 0 THEN BEGIN

            //Selon le type de l'Element, on récupère le Fee associé
            CASE element_Re_Loc.Type OF
                element_Re_Loc.Type::Fee:
                    BEGIN
                        Fee_Cu.FNC_Set(fee_Re_Loc, element_Re_Loc.Fee_ID);
                    END;
                element_Re_Loc.Type::Invoice:
                    BEGIN
                        Fee_Cu.FNC_Set(fee_Re_Loc, element_Re_Loc.Fee_ID);
                        isInvoice_Bo_Loc := TRUE;
                    END;
                ELSE BEGIN
                    ERROR(ERROR_TXT, 'Co50023', 'FNC_Dispatch',
                      STRSUBSTNO('On ne dispatch pas un élément de type >%1<', element_Re_Loc.Type));
                END;
            END;

            //CHG04
            //la variable value_Ar_Loc est un tableau !

            //step 1
            //On dispatch selon les règles de Ventilation Element
            //pour un frais (fee ou invoice) on cherche les éléments impliqués sans tenir compte de l'affaire
            //de l'éléments (paramètre false dans les fonctions de recherche). De cette manière, on pourra
            //calculer la proportion du montant à répartir sur les éléments.
            CASE fee_Re_Loc."Ventilation Element" OF
                fee_Re_Loc."Ventilation Element"::Value:
                    Dispatcher_Cu.FNC_Element_Value(value_Ar_Loc, element_Re_Loc.ID, FALSE);
                fee_Re_Loc."Ventilation Element"::"CBM Volume":
                    Dispatcher_Cu.FNC_Element_Volume(value_Ar_Loc, element_Re_Loc.ID, FALSE);
                fee_Re_Loc."Ventilation Element"::"Reception Number":
                    Dispatcher_Cu.FNC_Element_SommeCout(value_Ar_Loc, element_Re_Loc.ID, FALSE);
                fee_Re_Loc."Ventilation Element"::"Colis Amount":
                    Dispatcher_Cu.FNC_Element_Colis(value_Ar_Loc, element_Re_Loc.ID, FALSE);
                fee_Re_Loc."Ventilation Element"::"Gross Weight":
                    Dispatcher_Cu.FNC_Element_Gross_Weight(value_Ar_Loc, element_Re_Loc.ID, FALSE);
                fee_Re_Loc."Ventilation Element"::"Volume CBM Transported":
                    Dispatcher_Cu.FNC_Element_VolumeTransport(value_Ar_Loc, element_Re_Loc.ID, FALSE);
                fee_Re_Loc."Ventilation Element"::Quantity:
                    Dispatcher_Cu.FNC_Element_Quantity(value_Ar_Loc, element_Re_Loc.ID, FALSE);
            END;

            //step 2
            //TOTAL DES VALEURS DE L'ARRAY
            sum_Dec_Loc := Dispatcher_Cu.FNC_Array_Sum(value_Ar_Loc);

            IF sum_Dec_Loc = 0 THEN BEGIN
                //MESSAGE('%1', fee_Re_Loc."Ventilation Element");
                ERROR(ERROR_TXT, 'Co50023', 'FNC_Dispatch()', 'Array total à 0 !');

            END;

            amountToDispatch_Dec_Loc := Element_Cu.FNC_Get_Amount_FCY(element_Re_Loc.ID);

            //calcule la proportion du montant d'un frais par rapport à la règle de répartition
            //pour les frais qui sont splittés sur plusieurs livraisons
            IF isInvoice_Bo_Loc THEN BEGIN
                IF element_Re_Loc."Splitt Index" <> 0 THEN BEGIN
                    amountToDispatch_Dec_Loc := ((value_Ar_Loc[element_Re_Loc."Splitt Index"] * 1) / sum_Dec_Loc) * amountToDispatch_Dec_Loc;
                END;
            END;

            //si la part d'une invoice vaut 0 on ne fait rien
            IF amountToDispatch_Dec_Loc <> 0 THEN BEGIN

                //on vide le tableau et cette fois on va filtrer sur l'affaire pour répartir le montant uniquement sur la bonne affaire
                CLEAR(value_Ar_Loc);

                //step 1
                //On dispatch selon les règles de Ventilation Element
                CASE fee_Re_Loc."Ventilation Element" OF
                    fee_Re_Loc."Ventilation Element"::Value:
                        Dispatcher_Cu.FNC_Element_Value(value_Ar_Loc, element_Re_Loc.ID, TRUE);
                    fee_Re_Loc."Ventilation Element"::"CBM Volume":
                        Dispatcher_Cu.FNC_Element_Volume(value_Ar_Loc, element_Re_Loc.ID, TRUE);
                    fee_Re_Loc."Ventilation Element"::"Reception Number":
                        Dispatcher_Cu.FNC_Element_SommeCout(value_Ar_Loc, element_Re_Loc.ID, TRUE);
                    fee_Re_Loc."Ventilation Element"::"Colis Amount":
                        Dispatcher_Cu.FNC_Element_Colis(value_Ar_Loc, element_Re_Loc.ID, TRUE);
                    fee_Re_Loc."Ventilation Element"::"Gross Weight":
                        Dispatcher_Cu.FNC_Element_Gross_Weight(value_Ar_Loc, element_Re_Loc.ID, TRUE);
                    fee_Re_Loc."Ventilation Element"::"Volume CBM Transported":
                        Dispatcher_Cu.FNC_Element_VolumeTransport(value_Ar_Loc, element_Re_Loc.ID, TRUE);
                    fee_Re_Loc."Ventilation Element"::Quantity:
                        Dispatcher_Cu.FNC_Element_Quantity(value_Ar_Loc, element_Re_Loc.ID, TRUE);
                END;

                //step 2
                //TOTAL DES VALEURS DE L'ARRAY
                sum_Dec_Loc := Dispatcher_Cu.FNC_Array_Sum(value_Ar_Loc);

                IF sum_Dec_Loc = 0 THEN
                    ERROR(
                      'La facture %1 (%2) ne peut pas être répartie sur l''affaire %3 car le type n''est pas ''item'' ou les quantités sont' +
                      'inexistantes sur la facture achat (ou le BR) associé !',
                      element_Re_Loc."Type No.",
                      element_Re_Loc.ID,
                      element_Re_Loc.Deal_ID
                    );

                //ERROR('%1', amountToDispatch_Dec_Loc);

                //step 3a et 3b
                Dispatcher_Cu.FNC_Dispatch_Amount(
                  value_Ar_Loc, //array avec les valeurs de chaque élément
                  sum_Dec_Loc,  //somme des valeurs de l'array
                  amountToDispatch_Dec_Loc //montant du Fee/Invoice en devise de l'article et pas forcément en EUR
                );

                //FNC_Print_Array(value_Ar_Loc);

                //------- dispatch sur les positions
                //itération sur Element Connection pour savoir à quel(s) Element(s) s'applique(nt) le Fee
                elementConnection_Re_Loc.RESET();
                elementConnection_Re_Loc.SETCURRENTKEY(Element_ID, "Split Index");
                elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                arrayIndex := 1;
                IF elementConnection_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        addPositions_Bo_Loc := FALSE;

                        //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                        applyElement_Re_Loc.RESET();
                        applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                        applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                        IF applyElement_Re_Loc.FINDFIRST() THEN
                            addPositions_Bo_Loc := TRUE;

                        IF addPositions_Bo_Loc THEN BEGIN

                            //step 4
                            //On dispatch selon les règles de Ventilation Position
                            CASE fee_Re_Loc."Ventilation Position" OF
                                fee_Re_Loc."Ventilation Position"::"Prorata Value":
                                    Dispatcher_Cu.FNC_Position_Prorata_Value(
                                      elementConnection_Re_Loc.Element_ID,
                                      elementConnection_Re_Loc."Apply To",
                                      value_Ar_Loc[arrayIndex],
                                      Element_Cu.FNC_Get_Amount_FCY(elementConnection_Re_Loc."Apply To")
                                    //montant du Fee/Invoice en devise de l'article et pas forcément en EUR
                                    );
                                fee_Re_Loc."Ventilation Position"::"Prorata Volume":
                                    Dispatcher_Cu.FNC_Position_Prorata_Volume(
                                      elementConnection_Re_Loc.Element_ID,
                                      elementConnection_Re_Loc."Apply To",
                                      value_Ar_Loc[arrayIndex],
                                      Element_Cu.FNC_Get_Volume(elementConnection_Re_Loc."Apply To")
                                    );
                                fee_Re_Loc."Ventilation Position"::"Prorata Gross Weight":
                                    Dispatcher_Cu.FNC_Position_Prorata_G_Weight(
                                      elementConnection_Re_Loc.Element_ID,
                                      elementConnection_Re_Loc."Apply To",
                                      value_Ar_Loc[arrayIndex],
                                      Element_Cu.FNC_Get_Gross_Weight(elementConnection_Re_Loc."Apply To")
                                    );
                                fee_Re_Loc."Ventilation Position"::"Prorata Colisage":
                                    Dispatcher_Cu.FNC_Position_Prorata_Colis(
                                      elementConnection_Re_Loc.Element_ID,
                                      elementConnection_Re_Loc."Apply To",
                                      value_Ar_Loc[arrayIndex],
                                      Element_Cu.FNC_Get_Colis(elementConnection_Re_Loc."Apply To")
                                    );
                                //START CHG05
                                fee_Re_Loc."Ventilation Position"::Quantity:
                                    Dispatcher_Cu.FNC_Position_Prorata_Quantity(
                                      elementConnection_Re_Loc.Element_ID,
                                      elementConnection_Re_Loc."Apply To",
                                      value_Ar_Loc[arrayIndex],
                                      Element_Cu.FNC_Get_Quantity(elementConnection_Re_Loc."Apply To")
                                    );
                            //STOP CHG05

                            END;

                            arrayIndex += 1;

                        END;

                    UNTIL (elementConnection_Re_Loc.NEXT() = 0);

            END

        END

    end;


    procedure FNC_Get_Amount(Fee_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20]; Default_Amount_Dec_Par: Decimal; Default_Factor_Dec_Par: Decimal) Amount_Dec_Ret: Decimal
    var
        deal_Re_Loc: Record "DEL Deal";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        amount_Dec_Loc: Decimal;
        factor_Dec_Loc: Decimal;
    begin
        FNC_Set(fee_Re_Loc, Fee_ID_Co_Par);
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        Amount_Dec_Ret := 0;

        //le montant du frais est fixe
        IF fee_Re_Loc."Amount Type" = fee_Re_Loc."Amount Type"::fixed THEN BEGIN

            IF Default_Amount_Dec_Par > 0 THEN
                Amount_Dec_Ret := Default_Amount_Dec_Par
            ELSE
                Amount_Dec_Ret := fee_Re_Loc.Amount;

            //Le montant du frais est calculé
        END ELSE BEGIN

            //le facteur spécifique dans Fee Connection est défini
            IF Default_Factor_Dec_Par > 0 THEN
                factor_Dec_Loc := Default_Factor_Dec_Par

            ELSE BEGIN
                //START CHG03
                deal_Re_Loc.RESET();
                IF deal_Re_Loc.GET(element_Re_Loc.Deal_ID) THEN BEGIN

                    //recherche d'un facteur spécifique en fonction de la date de l'affaire
                    IF FNC_Get_Factor(fee_Re_Loc.ID, deal_Re_Loc.Date) <> 0 THEN
                        factor_Dec_Loc := FNC_Get_Factor(fee_Re_Loc.ID, deal_Re_Loc.Date)

                    //si aucun facteur n'existe, on prend le facteur par défaut
                    ELSE
                        factor_Dec_Loc := fee_Re_Loc.Factor;

                END ELSE
                    ERROR('Aucune affaire trouvée pour l''élément %1', element_Re_Loc.ID);
                //STOP CHG03
            END;

            //boucle sur les Element Connection du Fee (en principe il y en a que 1, vu qu'un Fee s'applique à 1 ACO ou 1 VCO..)
            elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
            elementConnection_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
            IF elementConnection_Re_Loc.FINDFIRST() THEN
                REPEAT
                    CASE fee_Re_Loc.Field OF
                        fee_Re_Loc.Field::"Net Weight":
                            Amount_Dec_Ret += Element_Cu.FNC_Get_Net_Weight(elementConnection_Re_Loc."Apply To") * factor_Dec_Loc;
                        fee_Re_Loc.Field::"Gross Weight":
                            Amount_Dec_Ret += Element_Cu.FNC_Get_Gross_Weight(elementConnection_Re_Loc."Apply To") * factor_Dec_Loc;
                        fee_Re_Loc.Field::"Transport Volume":
                            Amount_Dec_Ret += Element_Cu.FNC_Get_VolumeTransport(elementConnection_Re_Loc."Apply To") * factor_Dec_Loc;
                        fee_Re_Loc.Field::"CBM Volume":
                            Amount_Dec_Ret += Element_Cu.FNC_Get_Volume(elementConnection_Re_Loc."Apply To") * factor_Dec_Loc;
                        fee_Re_Loc.Field::Colis:
                            Amount_Dec_Ret += Element_Cu.FNC_Get_Colis(elementConnection_Re_Loc."Apply To") * factor_Dec_Loc;
                        fee_Re_Loc.Field::Douane:
                            Amount_Dec_Ret += Element_Cu.FNC_Get_Douane(elementConnection_Re_Loc."Apply To") * factor_Dec_Loc;
                        //CHG02
                        fee_Re_Loc.Field::Quantity:
                            Amount_Dec_Ret += Element_Cu.FNC_Get_Quantity(elementConnection_Re_Loc."Apply To") * factor_Dec_Loc;
                    END
                UNTIL (elementConnection_Re_Loc.NEXT() = 0);
        END
    end;


    procedure FNC_Get_Amount_From_Pos(Element_ID_Co_Par: Code[20]; DealShipmentNo_Co_Par: Code[20]; isPlanned: Boolean): Decimal
    var
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
        plannedElement_Re_Loc: Record "DEL Element";
        realElement_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        item_Re_Loc: Record Item;
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        amount_Dec_Loc: Decimal;
    begin
        IF DealShipmentNo_Co_Par = '' THEN BEGIN

        END ELSE BEGIN

            amount_Dec_Loc := 0;

            //on cherche le montant pour le prévu
            IF isPlanned THEN BEGIN

                purchRcptLine_Re_Loc.RESET();
                purchRcptLine_Re_Loc.SETRANGE("Document No.", DealShipment_Cu.FNC_GetBRNo(DealShipmentNo_Co_Par));
                purchRcptLine_Re_Loc.SETFILTER(purchRcptLine_Re_Loc.Quantity, '<>0');
                IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        position_Re_Loc.RESET();
                        position_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
                        position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");
                        IF position_Re_Loc.FINDFIRST() THEN
                            //THM
                            //  REPEAT
                            //STOP THM
                            amount_Dec_Loc += position_Re_Loc.Amount * purchRcptLine_Re_Loc.Quantity * position_Re_Loc.Rate;
                    //THM
                    //   UNTIL(position_Re_Loc.NEXT() = 0);
                    //STOP THM
                    UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

                EXIT(amount_Dec_Loc);

                //on cherche le montant pour le réel
            END ELSE BEGIN

                plannedElement_Re_Loc.GET(Element_ID_Co_Par);

                //real
                //on cherche les éléments réalisés pour un élément prévu
                realElement_Re_Loc.RESET();
                realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                realElement_Re_Loc.SETRANGE(Deal_ID, plannedElement_Re_Loc.Deal_ID);
                realElement_Re_Loc.SETRANGE(Type, realElement_Re_Loc.Type::Invoice);
                realElement_Re_Loc.SETRANGE(Fee_ID, plannedElement_Re_Loc.Fee_ID);
                realElement_Re_Loc.SETRANGE(Fee_Connection_ID, plannedElement_Re_Loc.Fee_Connection_ID);

                //on boucle sur tous les elements de type Invoice
                IF realElement_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        //si realElement est enregistré pour cette livraison
                        IF dealShipmentConnection_Re_Loc.GET(realElement_Re_Loc.Deal_ID, DealShipmentNo_Co_Par, realElement_Re_Loc.ID) THEN
                            amount_Dec_Loc += Element_Cu.FNC_Get_Amount_From_Positions(realElement_Re_Loc.ID);

                    UNTIL (realElement_Re_Loc.NEXT() = 0);

                EXIT(amount_Dec_Loc);

            END
        END
    end;


    procedure FNC_Get_Description(Fee_ID_Co_Par: Code[20]) Description_Te_Ret: Text[50]
    var
        fee_Re_Loc: Record "DEL Fee";
    begin
        Description_Te_Ret := '';
        IF Fee_ID_Co_Par <> '' THEN BEGIN
            FNC_Set(fee_Re_Loc, Fee_ID_Co_Par);
            Description_Te_Ret := fee_Re_Loc.Description;
        END
    end;


    procedure FNC_Get_Factor(Fee_ID_Co_Par: Code[20]; Date_Par: Date): Decimal
    var
        feeFactor_Re_Loc: Record "DEL Fee Factor";
    begin
        //CHG03
        //Retourne le facteur pour un frais et pour la date d'une affaire
        //retourne zéro si aucun facteur n'existe

        feeFactor_Re_Loc.RESET();
        feeFactor_Re_Loc.SETFILTER(Fee_ID, Fee_ID_Co_Par);
        feeFactor_Re_Loc.SETFILTER("Allow From", '<=%1', Date_Par);
        feeFactor_Re_Loc.SETFILTER("Allow To", '>=%1|%2', Date_Par, 0D);
        IF feeFactor_Re_Loc.FIND('+') THEN
            EXIT(feeFactor_Re_Loc.Factor)
        ELSE
            EXIT(0);
    end;
}

