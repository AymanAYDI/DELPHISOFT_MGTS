codeunit 50021 "DEL Element"
{

    var
        Currency_Exchange_Re: Record "DEL Currency Exchange";
        Setup: Record "DEL General Setup";
        DealItem_Cu: Codeunit "DEL Deal Item";
        DealShipment_Cu: Codeunit "Deal Shipment";
        DealShipmentConnection_Cu: Codeunit "Deal Shipment Connection";
        Deal_Cu: Codeunit "DEL Deal";
        Element_Cu: Codeunit "DEL Element";
        ElementConnection_Cu: Codeunit "DEL Element Connection";
        Fee_Cu: Codeunit "DEL Fee";
        NoSeriesMgt_Cu: Codeunit NoSeriesManagement;
        Position_Cu: Codeunit "DEL Position";
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';


    procedure FNC_Add_ACO(Deal_ID_Co_Par: Code[20]; ACO_Re_Par: Record "Purchase Header") element_ID_Co_Ret: Code[20]
    var
        deal_Re_Loc: Record "DEL Deal";
        element_Re_Loc: Record "DEL Element";
        isPlanned_Op_Loc: Option;
    begin
        // Ajoute un "Element" de type ACO

        //CHG07
        deal_Re_Loc.GET(Deal_ID_Co_Par);

        //insère un enregistrement dans la table "Element" 50021
        element_ID_Co_Ret :=
          FNC_Insert_Element(
            Deal_ID_Co_Par,
            element_Re_Loc.Instance::planned,
            element_Re_Loc.Type::ACO,
            ACO_Re_Par."No.",
            '',
            element_Re_Loc."Subject Type"::Vendor,
            ACO_Re_Par."Buy-from Vendor No.",
            '',
            '',
            deal_Re_Loc."ACO Document Date", //CHG07 //cette date est définie lors de la création de l'affaire et n'est jamais mise à jour !
            0,
            '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
            0D,
            0 //splitt index
          );

        //insère tous les "Element" "Fee" associés à la commande d'achat que l'on vient d'ajouter
        FNC_Add_Element_Fee(element_ID_Co_Ret);
    end;


    procedure FNC_Add_ACO_From_Invoice(Deal_ID_Co_Par: Code[20]; PurchaseInvoiceHeader_Re_Par: Record "Purch. Inv. Header") element_ID_Co_Ret: Code[20]
    var
        deal_Re_Loc: Record "DEL Deal";
        element_Re_Loc: Record "DEL Element";
        isPlanned_Op_Loc: Option;
    begin
        // Ajoute un "Element" de type ACO

        //CHG07
        deal_Re_Loc.GET(Deal_ID_Co_Par);

        //insère un enregistrement dans la table "Element" 50021
        element_ID_Co_Ret :=
          FNC_Insert_Element(
            Deal_ID_Co_Par,
            element_Re_Loc.Instance::planned,
            element_Re_Loc.Type::ACO,
            PurchaseInvoiceHeader_Re_Par."Order No.",
            '',
            element_Re_Loc."Subject Type"::Vendor,
            PurchaseInvoiceHeader_Re_Par."Buy-from Vendor No.",
            '',
            '',
            deal_Re_Loc."ACO Document Date", //CHG07 //cette date est définie lors de la création de l'affaire et n'est jamais mise à jour !
            0,
            '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
            0D,
            0  //splitt index
          );

        //insère tous les "Element" "Fee" associés à la commande d'achat que l'on vient d'ajouter
        FNC_Add_Element_Fee(element_ID_Co_Ret);
    end;


    procedure FNC_Add_BR(Deal_ID_Co_Par: Code[20]; BR_Header_Re_Par: Record "Purch. Rcpt. Header"; DealShipmentNo_Co_Par: Code[20]; Add_Variant_Op_Par: Option New,Existing)
    var
        deal_Re_Loc: Record "DEL Deal";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        element_Re_Loc: Record "DEL Element";
        logistic_Re_Loc: Record "DEL Logistic";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        BRID_Co_Loc: Code[20];
        element_ID_Loc: Code[20];
        last: Code[20];
        shipmentID_Co_Loc: Code[20];
    begin
        /*__
          Ajoute un "Element" de type BR
          Fonction appelé lors de la création d'un BR (si le BR est déjà existant, alors on utilisera FNC_Check_For_BR
        
          Paramètre de type option :
            -> Add_Variant_Op_Par::New      : add a new specific BR
            -> Add_Variant_Op_Par::Existing : check for existing BRs and add them if they are not linked to the deal yet
        __*/

        IF Add_Variant_Op_Par = Add_Variant_Op_Par::New THEN BEGIN

            /*_
              1. On filtre "Deal Shipment Selection" avec le numéro de l'ACO qu'on a sur le BR Header. On garde que les lignes cochées
              2. On prend la première ligne et on récupère le numéro de livraison, puis on ajoute la connection de ce BR à cette livraison
            _*/
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", BR_Header_Re_Par."Order No.");
            dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            IF dealShipmentSelection_Re_Loc.FINDFIRST() THEN BEGIN

                //on cherche si il existe un BR pour cette livraison
                BRID_Co_Loc := DealShipment_Cu.FNC_GetBRElementID(dealShipmentSelection_Re_Loc."Shipment No.");

                //si il en existe pas, on créer un nouvel élément et une nouvelle connection
                IF BRID_Co_Loc = '' THEN BEGIN

                    //rechercher l'ACO à laquelle ce BR correspond
                    element_Re_Loc.RESET();
                    element_Re_Loc.SETRANGE("Type No.", BR_Header_Re_Par."Order No.");

                    //insère un enregistrement dans la table "Element" 50021
                    element_ID_Loc := FNC_Insert_Element(
                      Deal_ID_Co_Par,
                      element_Re_Loc.Instance::real,
                      element_R_Loc.Type::BR,
                      BR_Header_Re_Par."No.",
                      element_Re_Loc.ID,
                      element_Re_Loc."Subject Type"::Vendor,
                      BR_Header_Re_Par."Buy-from Vendor No.",
                      '',
                      '',
                      BR_Header_Re_Par."Posting Date",
                      0,
                      '', //"Bill-To Customer No." est vide pour les BR
                      0D,
                      0 //splitt index
                    );

                    DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, dealShipmentSelection_Re_Loc."Shipment No.", element_ID_Loc);

                    /*_Crée les éléments de type Dispatched en fonction du BR qui vient d'être créé_*/
                    FNC_Add_Dispatched_Elements(Deal_ID_Co_Par, dealShipmentSelection_Re_Loc."Shipment No.", BR_Header_Re_Par."No.");

                    //si un BR existe, on met à jour Type No. de l'élément et on laisse la connection tel quel
                END ELSE BEGIN

                    //on récupère l'élément BR et on met Type No. à jour
                    //pas besoin de faire plus car lors d'un reinit(), le dispatch va se faire sur le new BR
                    Element_Cu.FNC_Set_Element(element_Re_Loc, BRID_Co_Loc);
                    element_Re_Loc.VALIDATE("Type No.", BR_Header_Re_Par."No.");
                    element_Re_Loc.MODIFY();

                END;

                //met à jour la ligne sur la table Deal Shipment
                //IF dealShipment_Re_Loc.GET(dealShipmentSelection_Re_Loc."Shipment No.") THEN BEGIN
                //  dealShipment_Re_Loc.VALIDATE("BR No.", BR_Header_Re_Par."No.");
                //  dealShipment_Re_Loc.MODIFY();
                //END;
                DealShipment_Cu.FNC_SetBRNo(dealShipmentSelection_Re_Loc."Shipment No.", BR_Header_Re_Par."No.");

                //grc01 begin
                IF logistic_Re_Loc.GET(dealShipmentSelection_Re_Loc."Shipment No.", dealShipmentSelection_Re_Loc.Deal_ID) THEN BEGIN
                    logistic_Re_Loc.VALIDATE("BR No.", BR_Header_Re_Par."No.");
                    logistic_Re_Loc.MODIFY();
                END;
                //grc01 end



            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_BR()',
                  STRSUBSTNO('Aucune livraison sélectionnée pour lier le BR >%1< !', BR_Header_Re_Par."No."));

        END ELSE
            IF Add_Variant_Op_Par = Add_Variant_Op_Par::Existing THEN BEGIN

                /*_On cherche l'ACO liée à l'affaire_*/
                //element_Re_Loc.RESET();
                //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
                //element_Re_Loc.setrange(Instance, element_Re_Loc.Instance::Planned);

                Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
                IF element_Re_Loc.FINDFIRST() THEN BEGIN

                    /*_On cherche les BR liés à l'ACO de cette affaire_*/
                    last := '';
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Correction, FALSE);
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    // START STG01
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '<>%1', 0);
                    // STOP STG01
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN BEGIN

                        REPEAT

                            IF purchRcptLine_Re_Loc."Document No." <> last THEN BEGIN
                                //MESSAGE(purchRcptLine_Re_Loc."Document No.");

                                IF BR_Header_Re_Par.GET(purchRcptLine_Re_Loc."Document No.") THEN BEGIN

                                    /*_Ajoute une ligne dans table "Element"_*/

                                    /*_Avant d'ajouter, on controle si le BR est pas déjà lié à l'affaire_*/
                                    element_Re_Loc.RESET();
                                    element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                                    element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                    element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::BR);
                                    element_Re_Loc.SETRANGE("Type No.", BR_Header_Re_Par."No.");
                                    IF NOT element_Re_Loc.FINDFIRST() THEN BEGIN

                                        //rechercher l'ACO à laquelle ce BR correspond
                                        //element_Re_Loc.RESET();
                                        //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, instance);
                                        //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                        //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
                                        //element_Re_Loc.setrange(Instance, element_Re_Loc.Instance::planned);

                                        Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
                                        element_Re_Loc.SETRANGE("Type No.", BR_Header_Re_Par."Order No.");

                                        /*_Insère un enregistrement dans la table "Element" 50021_*/
                                        element_ID_Loc := FNC_Insert_Element(
                                         Deal_ID_Co_Par,                          //deal id
                                         element_Re_Loc.Instance::real,           //instance
                                         element_Re_Loc.Type::BR,                 //type
                                         BR_Header_Re_Par."No.",                  //type no
                                         element_Re_Loc.ID,                       //apply-to
                                         element_Re_Loc."Subject Type"::Vendor,   //subject type
                                         BR_Header_Re_Par."Buy-from Vendor No.",  //subject no
                                         '',                                      //fee id
                                         '',                                      //fee connection id
                                         BR_Header_Re_Par."Posting Date",         //date
                                         0,
                                         '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
                                         0D,
                                         0 //splitt index
                                        );

                                        /*_Ajoute une ligne dans table "Deal Shipment"_*/
                                        shipmentID_Co_Loc := DealShipment_Cu.FNC_Insert(
                                         Deal_ID_Co_Par,
                                         BR_Header_Re_Par."Posting Date",
                                         BR_Header_Re_Par."No."
                                        );

                                        /*_Ajoute une ligne dans table "Deal Shipment Connection" (lie le BR à la livraison)_*/
                                        DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, shipmentID_Co_Loc, element_ID_Loc);

                                        /*_Crée les éléments de type Dispatched en fonction du BR qui vient d'être créé_*/
                                        FNC_Add_Dispatched_Elements(Deal_ID_Co_Par, dealShipmentSelection_Re_Loc."Shipment No.", BR_Header_Re_Par."No.");

                                    END;

                                END;

                            END;

                            last := purchRcptLine_Re_Loc."Document No.";

                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

                    END ELSE BEGIN

                        //créer une livraison vierge seulement si il n'en existe pas encore
                        IF DealShipment_Cu.FNC_GetFirstShipmentNo(Deal_ID_Co_Par) = '' THEN
                            DealShipment_Cu.FNC_Insert(Deal_ID_Co_Par, TODAY, '');

                    END

                END;

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_BR()', 'L''option d''ajout du BR doit être de type New ou Existing !');

    end;


    procedure FNC_Add_Dispatched_Elements(DealID_Co_Par: Code[20]; ShipmentID_Co_Par: Code[20]; BRNo_Co_Par: Code[20])
    var
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
        ACOElement_Re_Loc: Record "DEL Element";
        BRElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        FeeElement_Re_Loc: Record "DEL Element";
        VCOElement_Re_Loc: Record "DEL Element";
        addACODispatchedElement_Bo_Loc: Boolean;
        addFeeDispatchedElement_Bo_Loc: Boolean;
        addVCODispatchedElement_Bo_Loc: Boolean;
        element_ID_Loc: Code[20];
        period_Da_Loc: Date;
    begin
        /*_
        Ajoute les éléments d'instance Dispatched représentant le prévu par livraison
        _*/

        //par défaut on ajoute les 3 types d'éléments dispatched
        addACODispatchedElement_Bo_Loc := TRUE;
        addVCODispatchedElement_Bo_Loc := TRUE;
        addFeeDispatchedElement_Bo_Loc := TRUE;

        //si une ACO, une VCO ou un FEE répartie existe déjà pour la livraison, on a ajoute pas !
        dsc_Re_Loc.RESET();
        dsc_Re_Loc.SETRANGE(Deal_ID, DealID_Co_Par);
        dsc_Re_Loc.SETRANGE(Shipment_ID, ShipmentID_Co_Par);
        IF dsc_Re_Loc.FINDFIRST() THEN
            REPEAT
                Element_Cu.FNC_Set_Element(element_Re_Loc, dsc_Re_Loc.Element_ID);

                IF ((element_Re_Loc.Instance = element_Re_Loc.Instance::dispatched) AND (element_Re_Loc.Type = element_Re_Loc.Type::ACO)) THEN
                    addACODispatchedElement_Bo_Loc := FALSE
                ELSE
                    IF ((element_Re_Loc.Instance = element_Re_Loc.Instance::dispatched) AND (element_Re_Loc.Type = element_Re_Loc.Type::VCO)) THEN
                        addVCODispatchedElement_Bo_Loc := FALSE
                    ELSE
                        IF ((element_Re_Loc.Instance = element_Re_Loc.Instance::dispatched) AND (element_Re_Loc.Type = element_Re_Loc.Type::Fee)) THEN
                            addFeeDispatchedElement_Bo_Loc := FALSE

            UNTIL (dsc_Re_Loc.NEXT() = 0);


        period_Da_Loc := DealShipment_Cu.FNC_GetSalesInvoicePeriod(ShipmentID_Co_Par);

        //ACO--------------------------------------------------------------------------

        IF addACODispatchedElement_Bo_Loc THEN BEGIN

            //on ajoute une seule ACO par livraison qui contiendra les éléments avec prix d'achat des items du BR

            Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, DealID_Co_Par);
            IF ACOElement_Re_Loc.FINDFIRST() THEN BEGIN

                //Ajout d'un élément dispatched ACO pour la livraison concernée
                /*_Insère un enregistrement dans la table "Element" 50021_*/
                element_ID_Loc := FNC_Insert_Element(
                  ACOElement_Re_Loc.Deal_ID,                 //deal id
                  ACOElement_Re_Loc.Instance::dispatched,    //instance           !!!!!!!!!!!!
                  ACOElement_Re_Loc.Type::ACO,               //type
                  ACOElement_Re_Loc."Type No.",              //type no
                  '',                                        //apply-to
                  ACOElement_Re_Loc."Subject Type",          //subject type
                  ACOElement_Re_Loc."Subject No.",           //subject no
                  '',                                        //fee id
                  '',                                        //fee connection id
                  ACOElement_Re_Loc.Date,                    //date
                  0,                                         //entry No.
                  ACOElement_Re_Loc."Bill-to Customer No.",  //bill to
                  period_Da_Loc,                             //period             !!!!!!!!!!!!
                  0 //splitt index
                );

                //surtout on lie l'ACO partielle (dispatched) à une livraison !!!
                DealShipmentConnection_Cu.FNC_Insert(DealID_Co_Par, ShipmentID_Co_Par, element_ID_Loc);

                //on ajoute pas les positions ici, mais à la réinitialisation des positions..

            END;
        END;

        //VCO--------------------------------------------------------------------------
        //par défaut on ajoute

        IF addVCODispatchedElement_Bo_Loc THEN BEGIN

            //on ajoute une seule VCO par livraison qui contiendra les éléments avec prix de vente des items du BR
            //on ne lui attribue pas numéro de client ou autre car le br peut contenir des quantités nécessisant
            //plusieurs VCO..

            //Ajout d'un élément dispatched VCO pour la livraison concernée
            VCOElement_Re_Loc.RESET();
            VCOElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            VCOElement_Re_Loc.SETRANGE(Deal_ID, DealID_Co_Par);
            VCOElement_Re_Loc.SETRANGE(Type, VCOElement_Re_Loc.Type::VCO);
            VCOElement_Re_Loc.SETRANGE(Instance, VCOElement_Re_Loc.Instance::planned);
            IF VCOElement_Re_Loc.FINDFIRST() THEN BEGIN
                //REPEAT

                //Ajout d'un élément dispatched VCO pour la livraison concernée
                /*_Insère un enregistrement dans la table "Element" 50021_*/
                element_ID_Loc := FNC_Insert_Element(
                  VCOElement_Re_Loc.Deal_ID,                 //deal id
                  VCOElement_Re_Loc.Instance::dispatched,    //instance           !!!!!!!!!!!!
                  VCOElement_Re_Loc.Type::VCO,               //type
                  '', //VCOElement_Re_Loc."Type No.",        //type no
                  '',                                        //apply-to
                  0, //VCOElement_Re_Loc."Subject Type",     //subject type
                  '', //VCOElement_Re_Loc."Subject No.",     //subject no
                  '',                                        //fee id
                  '',                                        //fee connection id
                  0D, //VCOElement_Re_Loc.Date,              //date
                  0,                                         //entry No.
                  '', //VCOElement_Re_Loc."Bill-to Customer No.",  //bill to
                  period_Da_Loc,                             //period             !!!!!!!!!!!!
                  0 //splitt index
                );

                //surtout on lie la VCO partielle (dispatched) à une livraison !!!
                DealShipmentConnection_Cu.FNC_Insert(DealID_Co_Par, ShipmentID_Co_Par, element_ID_Loc);

                //on ajoute pas les positions ici, mais à la réinitialisation des positions..
            END;
            //UNTIL(VCOElement_Re_Loc.NEXT()=0);

        END;

        //Fee--------------------------------------------------------------------------

        IF addFeeDispatchedElement_Bo_Loc THEN BEGIN

            //Ajout d'un élément dispatched Fee pour la livraison concernée
            FeeElement_Re_Loc.RESET();
            FeeElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            FeeElement_Re_Loc.SETRANGE(Deal_ID, DealID_Co_Par);
            FeeElement_Re_Loc.SETRANGE(Type, FeeElement_Re_Loc.Type::Fee);
            FeeElement_Re_Loc.SETRANGE(Instance, FeeElement_Re_Loc.Instance::planned);
            IF FeeElement_Re_Loc.FINDFIRST() THEN
                REPEAT

                    //Ajout d'un élément dispatched Fee pour la livraison concernée
                    /*_Insère un enregistrement dans la table "Element" 50021_*/
                    element_ID_Loc := FNC_Insert_Element(
                      FeeElement_Re_Loc.Deal_ID,                 //deal id
                      FeeElement_Re_Loc.Instance::dispatched,    //instance           !!!!!!!!!!!!
                      FeeElement_Re_Loc.Type::Fee,               //type
                      FeeElement_Re_Loc."Type No.",              //type no
                      '',                                        //apply-to
                      FeeElement_Re_Loc."Subject Type",          //subject type
                      '',                                        //subject no
                      FeeElement_Re_Loc.Fee_ID,                  //fee id
                      FeeElement_Re_Loc.Fee_Connection_ID,       //fee connection id
                      FeeElement_Re_Loc.Date,                    //date
                      0,                                         //entry No.
                      FeeElement_Re_Loc."Bill-to Customer No.",  //bill to
                      period_Da_Loc,                             //period             !!!!!!!!!!!!
                      0 //splitt index
                    );

                    //surtout on lie les Fee partiels (dispatched) à une livraison !!!
                    DealShipmentConnection_Cu.FNC_Insert(DealID_Co_Par, ShipmentID_Co_Par, element_ID_Loc);

                //on ajoute pas les positions ici, mais à la réinitialisation des positions..

                UNTIL (FeeElement_Re_Loc.NEXT() = 0);
        END;

    end;


    procedure FNC_Add_Element_Fee(Element_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        ACO_Re_Loc: Record "Purchase Header";
        VCO_Re_Loc: Record "Sales Header";
    begin
        // Ajoute tous les "Fee" d'un "Element" en fonction de son ID
        // P.e. ajoute tous les "Fee" liés à un ACO ou une VCO

        Fee_Cu.FNC_Add(Element_ID_Co_Par);
    end;


    procedure FNC_Add_Invoice(Deal_ID_Co_Par: Code[20]; Type_No_Par: Code[20]; Subject_Type_Par: Option; Subject_No_Par: Code[20]; Fee_ID_Co_Par: Code[20]; FeeConnection_ID_Co_Par: Code[20]; Add_Variant_Op_Par: Option New,Existing)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        element_Re_Loc: Record "DEL Element";
        fee_Re_Loc: Record "DEL Fee";
        GLAccount_Re_Loc: Record "G/L Account";
        GLEntries_Re_Loc: Record "G/L Entry";
        applyTo_Co_Loc: Code[20];
        BRNo_Co_Loc: Code[20];
        element_ID_Loc: Code[20];
        purchaseInvoiceNo_Co_Loc: Code[20];
        shipmentID_Co_Loc: Code[20];
    begin
        /*__La partie new a été remplacée par les fonctions FNC_Add_New_Invoice et FNC_Add_New_Invoice_Connection__*/
        /*
        IF Add_Variant_Op_Par = Add_Variant_Op_Par::New THEN BEGIN
        end else
        */
        IF Add_Variant_Op_Par = Add_Variant_Op_Par::Existing THEN BEGIN

            /*_On cherche l'ACO liée à l'affaire_*/
            //element_Re_Loc.RESET();
            //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
            //element_Re_Loc.setrange(Instance, element_Re_Loc.Instance::planned);

            Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            IF element_Re_Loc.FINDFIRST() THEN BEGIN

                GLEntries_Re_Loc.RESET();
                GLEntries_Re_Loc.SETRANGE("Document Type", GLEntries_Re_Loc."Document Type"::Invoice);
                GLEntries_Re_Loc.SETFILTER("Source Code", '%1|%2', 'ACHATOD', 'COMPTA');
                GLEntries_Re_Loc.SETRANGE("Global Dimension 1 Code", element_Re_Loc."Type No.");

                IF GLEntries_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        GLAccount_Re_Loc.RESET();
                        GLAccount_Re_Loc.SETRANGE("No.", GLEntries_Re_Loc."G/L Account No.");
                        GLAccount_Re_Loc.SETRANGE("Income/Balance", GLAccount_Re_Loc."Income/Balance"::"Income Statement");
                        IF GLAccount_Re_Loc.FINDFIRST() THEN BEGIN
                            //REPEAT

                            //MESSAGE('ADD');

                            /*_Avant d'ajouter, on controle si l'invoice est pas déjà liée à l'affaire_*/
                            element_Re_Loc.RESET();
                            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Invoice);
                            element_Re_Loc.SETRANGE("Type No.", GLEntries_Re_Loc."Document No.");
                            element_Re_Loc.SETRANGE("Entry No.", GLEntries_Re_Loc."Entry No.");
                            IF NOT element_Re_Loc.FINDFIRST() THEN BEGIN

                                /*_Filtrer la table Fee par GLEntries_Re_Loc."G/L Account No." et "code reprise" true_*/
                                fee_Re_Loc.RESET();
                                fee_Re_Loc.SETRANGE("No compte", GLEntries_Re_Loc."G/L Account No.");
                                fee_Re_Loc.SETRANGE("Used For Import", TRUE);
                                IF fee_Re_Loc.FINDFIRST() THEN BEGIN

                                    //MESSAGE('ici ok');
                                    /*_Insère un enregistrement dans la table "Element" 50021_*/
                                    element_ID_Loc := FNC_Insert_Element(
                                     Deal_ID_Co_Par,                               //deal id
                                     element_Re_Loc.Instance::real,                //instance
                                     element_Re_Loc.Type::Invoice,                 //type
                                     GLEntries_Re_Loc."Document No.",              //type no
                                     '',                                           //apply-to
                                     element_Re_Loc."Subject Type"::"G/L Account", //subject type
                                     FORMAT(GLEntries_Re_Loc."G/L Account No."),   //subject no
                                     fee_Re_Loc.ID,                                //fee id
                                     '',                                           //fee connection id
                                     GLEntries_Re_Loc."Posting Date",              //date
                                     GLEntries_Re_Loc."Entry No.",                 //entry no,
                                     '',                                           //bill-to
                                     0D,                                           //period
                                     0                                             //splitt index
                                    );


                                    //ajouter la liaison à la première livraison de l'affaire et crée les connections elements
                                    /*_Recherche la première livraison de l'affaire_*/
                                    shipmentID_Co_Loc := DealShipment_Cu.FNC_GetFirstShipmentNo(Deal_ID_Co_Par);

                                    IF shipmentID_Co_Loc <> '' THEN BEGIN

                                        //purchase invoice no pour ce shipment
                                        purchaseInvoiceNo_Co_Loc := DealShipment_Cu.FNC_GetPurchaseInvoiceNo(shipmentID_Co_Loc);
                                        //br no pour ce shipment
                                        BRNo_Co_Loc := DealShipment_Cu.FNC_GetBRNo(shipmentID_Co_Loc);

                                        IF purchaseInvoiceNo_Co_Loc <> '' THEN BEGIN

                                            element_Re_Loc.RESET();
                                            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                                            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
                                            element_Re_Loc.SETRANGE("Type No.", purchaseInvoiceNo_Co_Loc);
                                            IF element_Re_Loc.FINDFIRST() THEN BEGIN
                                                ElementConnection_Cu.FNC_Add(
                                                  Deal_ID_Co_Par, element_ID_Loc,
                                                  element_Re_Loc.ID,
                                                  element_Re_Loc.Instance::real,
                                                  0
                                                );
                                                DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, shipmentID_Co_Loc, element_ID_Loc);
                                            END

                                        END ELSE
                                            IF BRNo_Co_Loc <> '' THEN BEGIN

                                                element_Re_Loc.RESET();
                                                element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                                                element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                                element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::BR);
                                                element_Re_Loc.SETRANGE("Type No.", BRNo_Co_Loc);
                                                IF element_Re_Loc.FINDFIRST() THEN BEGIN
                                                    ElementConnection_Cu.FNC_Add(
                                                      Deal_ID_Co_Par,
                                                      element_ID_Loc,
                                                      element_Re_Loc.ID,
                                                      element_Re_Loc.Instance::real,
                                                      0);
                                                    DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, shipmentID_Co_Loc, element_ID_Loc);
                                                END

                                            END ELSE
                                                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Invoice()',
                                                  STRSUBSTNO('Répartition de l''Invoice >%1< sur la livraison >%2< impossible car celle-ci n''a ' +
                                                  'ni de facture achat liée ni de bulletin de réception liée !',
                                                  Type_No_Par,
                                                  dealShipmentSelection_Re_Loc."Shipment No.")
                                                );

                                    END

                                END

                            END

                            //UNTIL(GLAccount_Re_Loc.NEXT() = 0);
                        END

                    UNTIL (GLEntries_Re_Loc.NEXT() = 0);

            END

        END

    end;


    procedure FNC_Add_Nclient(dealNo: Code[20])
    var
        element: Record "DEL Element";
        element2: Record "DEL Element";
        BillNumer: Code[20];
    begin

        element.SETRANGE(Deal_ID, dealNo);

        element.SETFILTER(element.Type, '<>%1', element.Type::VCO);
        element.SETFILTER("Bill-to Customer No.", '=%1', '');
        IF element.FINDFIRST() THEN BEGIN
            REPEAT


                element2.SETRANGE(Deal_ID, element.Deal_ID);
                element2.SETRANGE(element2.Type, element2.Type::VCO);
                element2.SETRANGE(Instance, element2.Instance::planned);
                IF element2.FINDFIRST() THEN
                    BillNumer := element2."Bill-to Customer No.";


                IF BillNumer <> '' THEN BEGIN

                    element."Bill-to Customer No." := BillNumer;
                    element.MODIFY();
                END;

            UNTIL element.NEXT() = 0;
        END;
    end;


    procedure FNC_Add_New_CreditM(DealShipmentSelection_Re_Par: Record "DEL Deal Shipment Selection"; SplittIndex_Int_Par: Integer) element_ID_Co_Ret: Code[20]
    var
        element_Re_Loc: Record "DEL Element";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        glEntry_Re_Loc: Record "G/L Entry";
        genJournalLine_Re_Loc: Record "Gen. Journal Line";
        billToCustomerNo_Co_Loc: Code[20];
        element_ID_Co_Loc: Code[20];
    begin
        /*__Ajoute un element de type invoice à partir de la feuille compta ou feuille achat__*/

        element_ID_Co_Ret := '';
        billToCustomerNo_Co_Loc := '';

        IF feeConnection_Re_Loc.GET(DealShipmentSelection_Re_Par."Fee Connection") THEN BEGIN

            //lorsqu'on connait déjà le numéro de la facture (p.e. quand on a validé une facture et qu'on attribue à une affaire après coup)
            IF DealShipmentSelection_Re_Par."Account Entry No." <> 0 THEN BEGIN

                glEntry_Re_Loc.GET(DealShipmentSelection_Re_Par."Account Entry No.");

                CASE DealShipmentSelection_Re_Par."Account Type" OF
                    DealShipmentSelection_Re_Par."Account Type"::Customer:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Customer;
                            billToCustomerNo_Co_Loc := DealShipmentSelection_Re_Par."Account No.";
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::Vendor:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Vendor;
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::"G/L Account":
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::"G/L Account";
                        END;
                END;

                //insère un enregistrement dans la table "Element" 50021
                element_ID_Co_Ret :=
                FNC_Insert_Element(
                  DealShipmentSelection_Re_Par.Deal_ID,
                  element_Re_Loc.Instance::real,
                  //element_Re_Loc.Type::Invoice, ancien grc
                  element_Re_Loc.Type::"Sales Cr. Memo",
                  DealShipmentSelection_Re_Par."Document No.",
                  '',
                  element_Re_Loc."Subject Type",
                  DealShipmentSelection_Re_Par."Account No.",
                  feeConnection_Re_Loc."Fee ID",
                  feeConnection_Re_Loc.ID,
                  TODAY,
                  glEntry_Re_Loc."Entry No.", //peut etre faut ajouter le numéro de la ligne ou de la facture..
                  billToCustomerNo_Co_Loc,
                  0D,
                  SplittIndex_Int_Par
                );

                //Lorsque la facture vient d'etre crée, on doit la rechercher
            END ELSE BEGIN

                glEntry_Re_Loc.RESET();
                //glEntry_Re_Loc.SETRANGE("Bal. Account No.",   DealShipmentSelection_Re_Par."Account No.");
                glEntry_Re_Loc.SETFILTER(
                  "Document Type", '%1|%2|%3',
                  glEntry_Re_Loc."Document Type"::Invoice,
                  glEntry_Re_Loc."Document Type"::Payment,
                  glEntry_Re_Loc."Document Type"::"Credit Memo");
                glEntry_Re_Loc.SETRANGE("Document No.", DealShipmentSelection_Re_Par."Document No.");
                glEntry_Re_Loc.SETRANGE("Journal Batch Name", DealShipmentSelection_Re_Par."Journal Batch Name");

                CASE DealShipmentSelection_Re_Par."Account Type" OF
                    DealShipmentSelection_Re_Par."Account Type"::Customer:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Customer;
                            glEntry_Re_Loc.SETRANGE("Source Type", glEntry_Re_Loc."Source Type"::Customer);
                            glEntry_Re_Loc.SETRANGE("Source No.", DealShipmentSelection_Re_Par."Account No.");
                            billToCustomerNo_Co_Loc := DealShipmentSelection_Re_Par."Account No.";
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::Vendor:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Vendor;
                            glEntry_Re_Loc.SETRANGE("Source Type", glEntry_Re_Loc."Source Type"::Vendor);
                            glEntry_Re_Loc.SETRANGE("Source No.", DealShipmentSelection_Re_Par."Account No.");
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::"G/L Account":
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::"G/L Account";
                            //glEntry_Re_Loc.SETRANGE("Source Type", glEntry_Re_Loc."Source Type"::" ");
                            glEntry_Re_Loc.SETRANGE("G/L Account No.", DealShipmentSelection_Re_Par."Account No.");
                        END;
                END;

                IF glEntry_Re_Loc.FINDFIRST() THEN BEGIN

                    //insère un enregistrement dans la table "Element" 50021
                    element_ID_Co_Ret :=
                      FNC_Insert_Element(
                        DealShipmentSelection_Re_Par.Deal_ID,
                        element_Re_Loc.Instance::real,
                        //element_Re_Loc.Type::Invoice, ancien grc
                        element_Re_Loc.Type::"Sales Cr. Memo",
                        DealShipmentSelection_Re_Par."Document No.",
                        '',
                        element_Re_Loc."Subject Type",
                        DealShipmentSelection_Re_Par."Account No.",
                        feeConnection_Re_Loc."Fee ID",
                        feeConnection_Re_Loc.ID,
                        TODAY,
                        glEntry_Re_Loc."Entry No.",
                        billToCustomerNo_Co_Loc,
                        0D,
                        SplittIndex_Int_Par
                      );

                END ELSE
                    ERROR('no glEntry found for Invoice >%1<', DealShipmentSelection_Re_Par."Document No.");

            END

        END ELSE
            ERROR('fee connection problem');

    end;


    procedure FNC_Add_New_Invoice(DealShipmentSelection_Re_Par: Record "DEL Deal Shipment Selection"; SplittIndex_Int_Par: Integer) element_ID_Co_Ret: Code[20]
    var
        element_Re_Loc: Record "DEL Element";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        glEntry_Re_Loc: Record "G/L Entry";
        genJournalLine_Re_Loc: Record "Gen. Journal Line";
        billToCustomerNo_Co_Loc: Code[20];
        element_ID_Co_Loc: Code[20];
    begin
        /*__Ajoute un element de type invoice à partir de la feuille compta ou feuille achat__*/

        element_ID_Co_Ret := '';
        billToCustomerNo_Co_Loc := '';

        IF feeConnection_Re_Loc.GET(DealShipmentSelection_Re_Par."Fee Connection") THEN BEGIN

            //lorsqu'on connait déjà le numéro de la facture (p.e. quand on a validé une facture et qu'on attribue à une affaire après coup)
            IF DealShipmentSelection_Re_Par."Account Entry No." <> 0 THEN BEGIN

                glEntry_Re_Loc.GET(DealShipmentSelection_Re_Par."Account Entry No.");

                CASE DealShipmentSelection_Re_Par."Account Type" OF
                    DealShipmentSelection_Re_Par."Account Type"::Customer:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Customer;
                            billToCustomerNo_Co_Loc := DealShipmentSelection_Re_Par."Account No.";
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::Vendor:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Vendor;
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::"G/L Account":
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::"G/L Account";
                        END;
                END;

                //insère un enregistrement dans la table "Element" 50021
                element_ID_Co_Ret :=
                FNC_Insert_Element(
                  DealShipmentSelection_Re_Par.Deal_ID,
                  element_Re_Loc.Instance::real,
                  element_Re_Loc.Type::Invoice,
                  DealShipmentSelection_Re_Par."Document No.",
                  '',
                  element_Re_Loc."Subject Type",
                  DealShipmentSelection_Re_Par."Account No.",
                  feeConnection_Re_Loc."Fee ID",
                  feeConnection_Re_Loc.ID,
                  TODAY,
                  glEntry_Re_Loc."Entry No.", //peut etre faut ajouter le numéro de la ligne ou de la facture..
                  billToCustomerNo_Co_Loc,
                  0D,
                  SplittIndex_Int_Par
                );

                //Lorsque la facture vient d'etre crée, on doit la rechercher
            END ELSE BEGIN

                glEntry_Re_Loc.RESET();
                //glEntry_Re_Loc.SETRANGE("Bal. Account No.",   DealShipmentSelection_Re_Par."Account No.");
                glEntry_Re_Loc.SETFILTER(
                  "Document Type", '%1|%2|%3',
                  glEntry_Re_Loc."Document Type"::Invoice,
                  glEntry_Re_Loc."Document Type"::Payment,
                  glEntry_Re_Loc."Document Type"::"Credit Memo");
                glEntry_Re_Loc.SETRANGE("Document No.", DealShipmentSelection_Re_Par."Document No.");
                glEntry_Re_Loc.SETRANGE("Journal Batch Name", DealShipmentSelection_Re_Par."Journal Batch Name");

                CASE DealShipmentSelection_Re_Par."Account Type" OF
                    DealShipmentSelection_Re_Par."Account Type"::Customer:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Customer;
                            glEntry_Re_Loc.SETRANGE("Source Type", glEntry_Re_Loc."Source Type"::Customer);
                            glEntry_Re_Loc.SETRANGE("Source No.", DealShipmentSelection_Re_Par."Account No.");
                            billToCustomerNo_Co_Loc := DealShipmentSelection_Re_Par."Account No.";
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::Vendor:
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::Vendor;
                            glEntry_Re_Loc.SETRANGE("Source Type", glEntry_Re_Loc."Source Type"::Vendor);
                            glEntry_Re_Loc.SETRANGE("Source No.", DealShipmentSelection_Re_Par."Account No.");
                        END;

                    DealShipmentSelection_Re_Par."Account Type"::"G/L Account":
                        BEGIN
                            element_Re_Loc."Subject Type" := element_Re_Loc."Subject Type"::"G/L Account";
                            //glEntry_Re_Loc.SETRANGE("Source Type", glEntry_Re_Loc."Source Type"::" ");
                            glEntry_Re_Loc.SETRANGE("G/L Account No.", DealShipmentSelection_Re_Par."Account No.");
                        END;
                END;

                IF glEntry_Re_Loc.FINDFIRST() THEN BEGIN

                    //insère un enregistrement dans la table "Element" 50021
                    element_ID_Co_Ret :=
                      FNC_Insert_Element(
                        DealShipmentSelection_Re_Par.Deal_ID,
                        element_Re_Loc.Instance::real,
                        element_Re_Loc.Type::Invoice,
                        DealShipmentSelection_Re_Par."Document No.",
                        '',
                        element_Re_Loc."Subject Type",
                        DealShipmentSelection_Re_Par."Account No.",
                        feeConnection_Re_Loc."Fee ID",
                        feeConnection_Re_Loc.ID,
                        TODAY,
                        glEntry_Re_Loc."Entry No.",
                        billToCustomerNo_Co_Loc,
                        0D,
                        SplittIndex_Int_Par
                      );

                END ELSE
                    ERROR('no glEntry found for Invoice >%1<', DealShipmentSelection_Re_Par."Document No.");

            END

        END ELSE
            ERROR('fee connection problem');

    end;


    procedure FNC_Add_New_Invoice_Connection(Element_ID_Co_Par: Code[20]; DealShipmentSelection_Re_Par: Record "DEL Deal Shipment Selection"; ConnectionType_Op_Par: Option Element,Shipment; SplitIndex_Int_Par: Integer)
    var
        element_Re_Loc: Record "DEL Element";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        genJournalLine_Re_Loc: Record "Gen. Journal Line";
        deal_ID_Co_Loc: Code[20];
        element_ID_Co_Loc: Code[20];
    begin
        /*
          2. On regarde pour chaque livraison si une facture d'achat a été liée à l'affaire.. l'info est dispo sur la ligne
          3. Si aucune facture d'achat, alors on regarde si un BR a été lié.. l'info aussi dispo sur la ligne.
          4. On crée une ligne dans la table "Element Connection" pour dire que cet Invoice doit etre dispatché sur cet élément
        */

        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_Loc := element_Re_Loc.Deal_ID;

        //si une facture existe pour cette livraison
        IF DealShipmentSelection_Re_Par."Purchase Invoice No." <> '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, DealShipmentSelection_Re_Par.Deal_ID);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
            element_Re_Loc.SETRANGE("Type No.", DealShipmentSelection_Re_Par."Purchase Invoice No.");
            IF element_Re_Loc.FINDFIRST() THEN BEGIN

                IF ConnectionType_Op_Par = ConnectionType_Op_Par::Element THEN
                    //on lie la facture sur la première facture achat de la livraison
                    ElementConnection_Cu.FNC_Add(
                deal_ID_Co_Loc,
                Element_ID_Co_Par,
                element_Re_Loc.ID,
                element_Re_Loc.Instance::real,
                SplitIndex_Int_Par
              )
                ELSE
                    DealShipmentConnection_Cu.FNC_Insert(
                      DealShipmentSelection_Re_Par.Deal_ID,
                      DealShipmentSelection_Re_Par."Shipment No.",
                      Element_ID_Co_Par
                    );

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_New_Invoice_Connection()',
                  STRSUBSTNO(
                    'Répartition de l''Invoice >%1< sur la livraison >%2< impossible car la facture achat liée >%3< est introuvable ' +
                    'dans l''affaire >%4< !',
                    DealShipmentSelection_Re_Par."Document No.",
                    DealShipmentSelection_Re_Par."Shipment No.",
                    DealShipmentSelection_Re_Par."Purchase Invoice No.",
                    DealShipmentSelection_Re_Par.Deal_ID)
                  );

            //si un BR existe pour cette facture
        END ELSE
            IF DealShipmentSelection_Re_Par."BR No." <> '' THEN BEGIN

                element_Re_Loc.RESET();
                element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                element_Re_Loc.SETRANGE(Deal_ID, DealShipmentSelection_Re_Par.Deal_ID);
                element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::BR);
                element_Re_Loc.SETRANGE("Type No.", DealShipmentSelection_Re_Par."BR No.");
                IF element_Re_Loc.FINDFIRST() THEN BEGIN

                    IF ConnectionType_Op_Par = ConnectionType_Op_Par::Element THEN BEGIN
                        ElementConnection_Cu.FNC_Add(
                          deal_ID_Co_Loc,
                          Element_ID_Co_Par,
                          element_Re_Loc.ID,
                          element_Re_Loc.Instance::real,
                          SplitIndex_Int_Par
                        )
                    END ELSE BEGIN
                        DealShipmentConnection_Cu.FNC_Insert(
                          DealShipmentSelection_Re_Par.Deal_ID,
                          DealShipmentSelection_Re_Par."Shipment No.",
                          Element_ID_Co_Par
                        );
                    END

                END ELSE BEGIN
                    ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_New_Invoice_Connection()',
                      STRSUBSTNO(
                        'Répartition de l''Invoice >%1< sur la livraison >%2< impossible car le bulletin de réception lié >%3< est introuvable ' +
                        'dans l''affaire >%4< !',
                        DealShipmentSelection_Re_Par."Document No.",
                        DealShipmentSelection_Re_Par."Shipment No.",
                        DealShipmentSelection_Re_Par."BR No.",
                        DealShipmentSelection_Re_Par.Deal_ID)
                      );

                END

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_New_Invoice_Connection()',
                  STRSUBSTNO(
                    'Répartition de l''Invoice >%1< sur la livraison >%2< impossible car celle-ci n''a ni de facture achat liée ni ' +
                    'de bulletin de réception liée !',
                    DealShipmentSelection_Re_Par."Document No.",
                    DealShipmentSelection_Re_Par."Shipment No.")
                  );

    end;


    procedure FNC_Add_Planned_Elements(Deal_ID_Par: Code[20]; update_planned_Bo_Par: Boolean) success: Boolean
    var
        ACO_Connection_Re_Loc: Record "DEL ACO Connection";
        purchaseInvoiceHeader_Re_Loc: Record "Purch. Inv. Header";
        ACO_Re_Loc: Record "Purchase Header";
        purchaseLine_Re_Loc: Record "Purchase Line";
        salesHeader_Re_Loc: Record "Sales Header";
        VCO_Re_Loc: Record "Sales Header";
        salesInvoiceHeader_Re_Loc: Record "Sales Invoice Header";
        salesInvoiceLine_Re_Loc: Record "Sales Invoice Line";
        salesLine_Re_Loc: Record "Sales Line";
        element_ID_Co_Loc: Code[20];
        last: Code[20];
    begin
        /*
        - Boucle sur les ACO présentes dans la table "ACO Connection" pour Deal_ID_Par
          - Ajoute l'ACO (soit présente dans purchase header, ou alors basée sur une purchase invoice)
          - Ajoute les VCO associées à l'ACO (VCO soit présente dans sales header, soir basée sur une sales invoice)
        */

        /*_Valeur de retour de la fonction_*/
        success := TRUE;

        IF update_planned_Bo_Par THEN BEGIN

            /*_Boucle sur les ACO de la table ACO_Connection pour this.Deal_*/
            ACO_Connection_Re_Loc.RESET();
            ACO_Connection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Par);
            IF ACO_Connection_Re_Loc.FINDFIRST() THEN BEGIN

                /*_L'affaire se base sur une ACO existante_*/
                IF ACO_Re_Loc.GET(ACO_Re_Loc."Document Type"::Order, ACO_Connection_Re_Loc."ACO No.") THEN BEGIN

                    /*_Ajoute la commande d'achat_*/
                    element_ID_Co_Loc := FNC_Add_ACO(Deal_ID_Par, ACO_Re_Loc);

                    /*_
                    Ajoute la/les commande(s) de vente associée(s) à la commande d'achat
                    Sur les lignes des VCOs (Sales Line), on cherche celles qui appartiennent à l'ACO

                    Jusqu'au 01.10.08

                    Le lien ACO-VCO est assuré par le champ "Shortcut Dimension 1 Code" sur les lignes VCO

                    A partir du 01.10.08
                    Le lien ACO-VCO est assuré par le champ "Special Order Purchase No." sur les lignes VCO

                    Si "Special Order Purchase No." est défini, alors il s'agit d'une ACO recente
                    Si "Special Order Purchase No." n'est pas défini, alors il s'agit d'une ACO crée avant
                    la mise ne place de la gestion d'affaire. Il faudra donc aller vérifier si des Elements
                    prévus et réels ont déjà été attribués à cette affaire.
                    _*/

                    last := '';
                    salesLine_Re_Loc.RESET();
                    salesLine_Re_Loc.SETCURRENTKEY("Special Order Purchase No.");
                    salesLine_Re_Loc.SETRANGE("Special Order Purchase No.", ACO_Re_Loc."No.");
                    salesLine_Re_Loc.SETRANGE(Type, salesLine_Re_Loc.Type::Item);
                    salesLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    /*_Si il y a des ACO récentes_*/
                    IF salesLine_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            IF last <> salesLine_Re_Loc."Document No." THEN BEGIN

                                IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, salesLine_Re_Loc."Document No.") THEN
                                    FNC_Add_VCO(Deal_ID_Par, element_ID_Co_Loc, salesHeader_Re_Loc)
                                ELSE BEGIN
                                    ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Elements()',
                                      STRSUBSTNO('Sales Header >%1< introuvable', salesLine_Re_Loc."Document No."));
                                    success := FALSE;
                                END;

                                last := salesLine_Re_Loc."Document No.";

                            END;

                        UNTIL (salesLine_Re_Loc.NEXT() = 0)

                    ELSE BEGIN

                        /*_Filtre sur les anciens types de liens_*/
                        salesLine_Re_Loc.RESET();
                        salesLine_Re_Loc.SETRANGE(salesLine_Re_Loc."Shortcut Dimension 1 Code", ACO_Re_Loc."No.");
                        salesLine_Re_Loc.SETRANGE(salesLine_Re_Loc.Type, salesLine_Re_Loc.Type::Item);
                        salesLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        /*_Si il y a des vieilles ACO_*/
                        IF salesLine_Re_Loc.FINDFIRST() THEN
                            REPEAT

                                IF last <> salesLine_Re_Loc."Document No." THEN BEGIN

                                    IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, salesLine_Re_Loc."Document No.") THEN
                                        FNC_Add_VCO(Deal_ID_Par, element_ID_Co_Loc, salesHeader_Re_Loc)
                                    ELSE BEGIN
                                        ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Elements()',
                                          STRSUBSTNO('Sales Header >%1< introuvable', salesLine_Re_Loc."Document No."));
                                        success := FALSE;
                                    END;

                                    last := salesLine_Re_Loc."Document No.";

                                END;

                            UNTIL (salesLine_Re_Loc.NEXT() = 0)

                        ELSE

                            //ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Elements()',
                            //STRSUBSTNO('ACO >%1< inexistant', ACO_Connection_Re_Loc."ACO No."));
                            //MESSAGE('ACO >%1< inexistante. Update annulée pour la partie planifiée', ACO_Connection_Re_Loc."ACO No.");
                            success := FALSE;

                    END;

                    /*_L'affaire se base sur une ACO qui n'existe plus mais qui est sous forme de une ou plusieurs purchase invoice_*/
                END ELSE BEGIN

                    purchaseInvoiceHeader_Re_Loc.RESET();
                    purchaseInvoiceHeader_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACO_Connection_Re_Loc."ACO No.");
                    IF purchaseInvoiceHeader_Re_Loc.FINDFIRST() THEN BEGIN
                        /*_pas de boucle, parce qu'on veut ajouter qu'une seule ACO_*/

                        /*_Ajoute la commande d'achat_*/
                        element_ID_Co_Loc := FNC_Add_ACO_From_Invoice(Deal_ID_Par, purchaseInvoiceHeader_Re_Loc);

                        /*_Boucler sur les sales invoice line et chercher celles qui ont un code achat = à l'aco_*/
                        salesInvoiceLine_Re_Loc.RESET();
                        salesInvoiceLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Order No.");
                        salesInvoiceLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACO_Connection_Re_Loc."ACO No.");
                        salesInvoiceLine_Re_Loc.SETRANGE(Type, salesInvoiceLine_Re_Loc.Type::Item);
                        salesInvoiceLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        last := '';
                        IF salesInvoiceLine_Re_Loc.FINDFIRST() THEN
                            REPEAT

                                IF last <> salesInvoiceLine_Re_Loc."Order No." THEN BEGIN

                                    IF salesInvoiceHeader_Re_Loc.GET(salesInvoiceLine_Re_Loc."Document No.") THEN
                                        FNC_Add_VCO_From_Invoice(Deal_ID_Par, element_ID_Co_Loc, salesInvoiceHeader_Re_Loc)
                                    ELSE BEGIN
                                        ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Elements()',
                                          STRSUBSTNO('Sales Invoice Header >%1< introuvable', salesInvoiceLine_Re_Loc."Order No."));
                                        success := FALSE;
                                    END;

                                    last := salesInvoiceLine_Re_Loc."Order No.";

                                END;

                            UNTIL (salesInvoiceLine_Re_Loc.NEXT() = 0)

                    END ELSE
                        ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Elements()',
                          STRSUBSTNO('L''ACO %1 n''est ni présente, ni archivée, ni basée sur une facture d''achat !',
                          ACO_Connection_Re_Loc."ACO No."));

                END

            END ELSE BEGIN
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Elements()',
                  STRSUBSTNO('Aucun ACO enregistrée pour le Deal >%1<', Deal_ID_Par));
                success := FALSE;
            END

        END

    end;


    procedure FNC_Add_Provision(sps_Re_Par: Record "DEL Shipment Provision Select."; isExtourne_Bo_Par: Boolean) element_ID_Co_Ret: Code[20]
    var
        element_Re_Loc: Record "DEL Element";
        docNo_Co_Par: Code[20];
        element_ID_Co_Loc: Code[20];
        postingDate_Da_Loc: Date;
    begin
        //ajoute un element de type provision

        IF isExtourne_Bo_Par THEN BEGIN
            docNo_Co_Par := sps_Re_Par."Document No. Ext.";
            postingDate_Da_Loc := sps_Re_Par."Posting Date Ext.";
        END ELSE BEGIN
            docNo_Co_Par := sps_Re_Par."Document No.";
            postingDate_Da_Loc := sps_Re_Par."Posting Date";
        END;

        //insertion de la provision
        element_ID_Co_Ret :=
          FNC_Insert_Element(
            sps_Re_Par.Deal_ID,                            //deal id
            element_Re_Loc.Instance::real,                 //instance type
            element_Re_Loc.Type::Provision,                //type
            docNo_Co_Par,                                  //type no
            '',                                            //apply-to
            element_Re_Loc."Subject Type"::" ",            //subject type
            '',                                            //subjet no
            sps_Re_Par.Fee_ID,                             //fee id
            sps_Re_Par.Fee_Connection_ID,                  //fee connection id
            postingDate_Da_Loc,                            //date
            0,                                             //entry no
            '',                                            //bill-to
            sps_Re_Par.Period,                             //period
            0                                              //splitt index
          );
    end;


    procedure FNC_Add_Provision_Connection(Element_ID_Co_Par: Code[20]; sps_Re_Par: Record "DEL Shipment Provision Select."; ConnectionType_Op_Par: Option Element,Shipment)
    var
        element_Re_Loc: Record "DEL Element";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        genJournalLine_Re_Loc: Record "Gen. Journal Line";
        deal_ID_Co_Loc: Code[20];
        element_ID_Co_Loc: Code[20];
    begin
        /*
        //DEV-CHG-PROVISION
        s'inspirer de FNC_Add_New_Invoice_Connection
        
        Selon la valeur du paramètre connectionType :
        
          - Crée une liaison entre la provision et l'élément à laquelle elle s'applique
            par exemple, la provision X s'applique à la facture d'achat Y ou au BR Y
            -> indispensable !!! sinon on ne pourra pas dispatcher le montant de la provision correctement
        
          - Crée une liaison entre la provision et la livraison
            par exemple, la provision X appartient à la livraison Y
            -> indispensable !!! sinon on ne peut pas rechercher toutes les provisions pour une livraison !!!
        */

        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_Loc := element_Re_Loc.Deal_ID;

        //si une facture existe pour cette livraison
        IF sps_Re_Par."Purchase Invoice No." <> '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, sps_Re_Par.Deal_ID);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
            element_Re_Loc.SETRANGE("Type No.", sps_Re_Par."Purchase Invoice No.");
            IF element_Re_Loc.FINDFIRST() THEN BEGIN

                IF ConnectionType_Op_Par = ConnectionType_Op_Par::Element THEN
                    //on lie la provision sur la facture achat de la livraison
                    ElementConnection_Cu.FNC_Add(
                deal_ID_Co_Loc,
                Element_ID_Co_Par,
                element_Re_Loc.ID,
                element_Re_Loc.Instance::real,
                0
              )
                ELSE
                    DealShipmentConnection_Cu.FNC_Insert(
                      sps_Re_Par.Deal_ID,
                      sps_Re_Par.Deal_Shipment_ID,
                      Element_ID_Co_Par
                    );

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Provision_Connection()',
                  STRSUBSTNO(
                    'Répartition de la provision >%1< sur la livraison >%2< impossible car la facture achat liée >%3< est introuvable ' +
                    'dans l''affaire >%4< !',
                    sps_Re_Par."Document No.",
                    sps_Re_Par.Deal_Shipment_ID,
                    sps_Re_Par."Purchase Invoice No.",
                    sps_Re_Par.Deal_ID)
                  );

            //si un BR existe pour cette facture
        END ELSE
            IF sps_Re_Par."BR No." <> '' THEN BEGIN

                element_Re_Loc.RESET();
                element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                element_Re_Loc.SETRANGE(Deal_ID, sps_Re_Par.Deal_ID);
                element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::BR);
                element_Re_Loc.SETRANGE("Type No.", sps_Re_Par."BR No.");
                IF element_Re_Loc.FINDFIRST() THEN BEGIN

                    IF ConnectionType_Op_Par = ConnectionType_Op_Par::Element THEN BEGIN
                        ElementConnection_Cu.FNC_Add(
                          deal_ID_Co_Loc,
                          Element_ID_Co_Par,
                          element_Re_Loc.ID,
                          element_Re_Loc.Instance::real,
                          0
                        )
                    END ELSE BEGIN
                        DealShipmentConnection_Cu.FNC_Insert(
                          sps_Re_Par.Deal_ID,
                          sps_Re_Par.Deal_Shipment_ID,
                          Element_ID_Co_Par
                        );
                    END

                END ELSE BEGIN
                    ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Provision_Connection()',
                      STRSUBSTNO(
                        'Répartition de la provision >%1< sur la livraison >%2< impossible car le bulletin de réception lié >%3< est introuvable ' +
                        'dans l''affaire >%4< !',
                        sps_Re_Par."Document No.",
                        sps_Re_Par.Deal_Shipment_ID,
                        sps_Re_Par."BR No.",
                        sps_Re_Par.Deal_ID)
                      );

                END

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Provision_Connection()',
                  STRSUBSTNO(
                    'Répartition de la provision >%1< sur la livraison >%2< impossible car celle-ci n''a ni de facture achat liée ni ' +
                    'de bulletin de réception liée !',
                    sps_Re_Par."Document No.",
                    sps_Re_Par.Deal_Shipment_ID)
                  );

    end;


    procedure FNC_Add_Purch_Cr_Memo(Deal_ID_Co_Par: Code[20]; creditMemoHeader_Re_Par: Record "Purch. Cr. Memo Hdr."; ShipmentNo_Co_Par: Code[20]; Add_Variant_Op_Par: Option New,Existing)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        element_Re_Loc: Record "DEL Element";
        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        element_ID_Loc: Code[20];
        last: Code[20];
        purchInvID_Co_Loc: Code[20];
        shipmentID_Co_Loc: Code[20];
    begin
        /*__
          Ajoute un "Element" de type Purchase Credit Memo
          Fonction appelée lors de la création d'une Purchase Credit Memo
        __*/

        IF Add_Variant_Op_Par = Add_Variant_Op_Par::New THEN BEGIN

            IF ShipmentNo_Co_Par <> '' THEN BEGIN

                purchInvID_Co_Loc := DealShipment_Cu.FNC_GetPurchInvoiceElementID(ShipmentNo_Co_Par);

                /*_Insère un enregistrement dans la table "Element" 50021_*/
                element_ID_Loc := FNC_Insert_Element(
                  Deal_ID_Co_Par,                                   //deal id
                  element_Re_Loc.Instance::real,                    //instance
                  element_Re_Loc.Type::"Purch. Cr. Memo",           //type
                  creditMemoHeader_Re_Par."No.",                    //type no
                  purchInvID_Co_Loc,                                //apply-to
                  element_Re_Loc."Subject Type"::Customer,          //subject type
                  creditMemoHeader_Re_Par."Sell-to Customer No.",   //subject no
                  '',                                               //fee id
                  '',                                               //fee connection id
                  creditMemoHeader_Re_Par."Posting Date",           //date
                  0,                                                //entry No.
                  '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
                  0D,
                  0 //splitt index
                );

                DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, ShipmentNo_Co_Par, element_ID_Loc);

                //dealShipmentSelection_Re_Loc.DELETEALL();

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Purch_Cr_Memo()',
                  STRSUBSTNO('Aucune livraison sélectionnée pour la Note de Crédit >%1< !', creditMemoHeader_Re_Par."No."));

        END ELSE
            IF Add_Variant_Op_Par = Add_Variant_Op_Par::Existing THEN BEGIN

                /*_Pas d'implémentation prévue pour le moment_*/

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Purch_Cr_Memo()',
                  'L''option d''ajout d''une Note de Crédit doit être de type ''New'' ou ''Existing'' !');

    end;


    procedure FNC_Add_Purchase_Invoice(Deal_ID_Co_Par: Code[20]; PurchaseInvoiceHeader_Re_Par: Record "Purch. Inv. Header"; ShipmentNo_Co_Par: Code[20]; Add_Variant_Op_Par: Option New,Existing)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        element_Re_Loc: Record "DEL Element";
        purchInvHeader_Re_Loc: Record "Purch. Inv. Header";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        element_ID_Loc: Code[20];
        last: Code[20];
        shipmentID_Co_Loc: Code[20];
    begin
        /*__
          Ajoute un "Element" de type Purchase Invoice
          Fonction appelée lors de la création d'une Purchase Invoice (si la Purchase Invoice est déjà existante,
          alors on utilisera FNC_Add_Purchase_Invoice avec paramètre Add_Variant_Op_Par::Existing)
        
          Paramètre de type option :
            -> Add_Variant_Op_Par::New      : add a new specific Purchase Invoice
            -> Add_Variant_Op_Par::Existing : check for existing Purchase Invoices and add them if they are not linked to the deal yet
        __*/

        IF Add_Variant_Op_Par = Add_Variant_Op_Par::New THEN BEGIN

            //rechercher l'ACO de la purchase invoice
            //element_Re_Loc.RESET();
            //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
            //element_Re_Loc.setrange(Instance, element_Re_Loc.Instance::planned);

            Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE("Type No.", PurchaseInvoiceHeader_Re_Par."Order No.");
            //si on trouve, tant mieux, sinon c'est pas grave car il ne s'agit pas d'une info vitale
            IF element_Re_Loc.FINDFIRST() THEN;

            //insère un enregistrement dans la table "Element" 50021
            element_ID_Loc :=
              FNC_Insert_Element(
               Deal_ID_Co_Par,
               element_Re_Loc.Instance::real,
               element_Re_Loc.Type::"Purchase Invoice",
               PurchaseInvoiceHeader_Re_Par."No.",
               element_Re_Loc.ID,
               element_Re_Loc."Subject Type"::Vendor,
               PurchaseInvoiceHeader_Re_Par."Pay-to Vendor No.",
               '',
               '',
               PurchaseInvoiceHeader_Re_Par."Posting Date",
               0,
               '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
               0D,
               0 //splitt index
              );

            IF ShipmentNo_Co_Par <> '' THEN BEGIN
                DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, ShipmentNo_Co_Par, element_ID_Loc);
                DealShipment_Cu.FNC_SetPurchaseInvoiceNo(
                  ShipmentNo_Co_Par,
                  PurchaseInvoiceHeader_Re_Par."No."
                );

                //inutile car effectué à la fin du processus dans le codeunit 91 !
                //dealShipmentSelection_Re_Loc.DELETEALL();

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Purchase_Invoice()',
                  STRSUBSTNO('Aucune livraison sélectionnée pour la Purchase Invoice >%1< !', PurchaseInvoiceHeader_Re_Par."No."));

        END ELSE
            IF Add_Variant_Op_Par = Add_Variant_Op_Par::Existing THEN BEGIN

                /*_On cherche l'ACO liée à l'affaire_*/
                //element_Re_Loc.RESET();
                //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
                //element_Re_Loc.setrange(Instance, element_Re_Loc.Instance::planned);

                Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
                IF element_Re_Loc.FINDFIRST() THEN BEGIN

                    /*_On cherche les Purchase Invoices liées à l'ACO de cette affaire_*/
                    last := '';
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN BEGIN

                        REPEAT

                            IF purchInvLine_Re_Loc."Document No." <> last THEN BEGIN
                                //MESSAGE(purchInvLine_Re_Loc."Document No.");

                                IF purchInvHeader_Re_Loc.GET(purchInvLine_Re_Loc."Document No.") THEN BEGIN

                                    /*_Ajoute une ligne dans table "Element"_*/

                                    /*_Avant d'ajouter, on controle si l element est pas déjà lié à l'affaire_*/
                                    element_Re_Loc.RESET();
                                    element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                                    element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                    element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
                                    element_Re_Loc.SETRANGE("Type No.", purchInvHeader_Re_Loc."No.");
                                    IF NOT element_Re_Loc.FINDFIRST() THEN BEGIN

                                        //rechercher l'ACO à laquelle cet Purchase Invoice correspond
                                        //element_Re_Loc.RESET();
                                        //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                                        //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                        //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
                                        //element_Re_Loc.setrange(Instance, element_Re_Loc.Instance::planned);

                                        Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
                                        element_Re_Loc.SETRANGE("Type No.", purchInvHeader_Re_Loc."Order No.");
                                        IF element_Re_Loc.FINDFIRST() THEN BEGIN

                                            /*_Insère un enregistrement dans la table "Element" 50021_*/
                                            element_ID_Loc := FNC_Insert_Element(
                                             Deal_ID_Co_Par,                            //deal id
                                             element_Re_Loc.Instance::real,             //instance
                                             element_Re_Loc.Type::"Purchase Invoice",   //type
                                             purchInvHeader_Re_Loc."No.",               //type no
                                             element_Re_Loc.ID,                         //apply-to
                                             element_Re_Loc."Subject Type"::Vendor,     //subject type
                                             purchInvHeader_Re_Loc."Pay-to Vendor No.", //subject no
                                             '',                                        //fee id
                                             '',                                        //fee connection id
                                             purchInvHeader_Re_Loc."Posting Date",      //date
                                             0,
                                             '', //"Bill-To Customer No." est vide car sur une aco, on paye un fournisseur
                                             0D,
                                             0 //splitt index
                                            );

                                            /*_Recherche la première livraison de l'affaire_*/
                                            shipmentID_Co_Loc := DealShipment_Cu.FNC_GetFirstShipmentNo(Deal_ID_Co_Par);

                                            /*_Ajoute une ligne dans table "Deal Shipment Connection" (lie la Purchase Invoice à la livraison)_*/
                                            DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, shipmentID_Co_Loc, element_ID_Loc);

                                            //MD_FIX
                                            // DealShipment_Cu.FNC_SetPurchaseInvoiceNo(shipmentID_Co_Loc, purchInvHeader_Re_Loc."No.");
                                            DealShipment_Cu.FNC_SetSalesInvoiceNo(shipmentID_Co_Loc, purchInvHeader_Re_Loc."No.");

                                        END;

                                    END;

                                END;

                            END;

                            last := purchInvLine_Re_Loc."Document No.";

                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

                    END;

                END;

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Purchase_Invoice()',
                  'L''option d''ajout d''une Purchase Invoice doit être de type ''New'' ou ''Existing'' !');

    end;


    procedure FNC_Add_Real_Elements(deal_ID_Co_Par: Code[20])
    var
        PurchInvHeader_Re_Loc: Record "Purch. Inv. Header";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        SalesInvHeader_Re_Loc: Record "Sales Invoice Header";
        option: Option;
        option_Re_Loc: Option New,Existing;
    begin
        /*_Fonction pour la reprise de données_*/

        FNC_Add_BR(deal_ID_Co_Par, BR_Header_Re_Loc, '', option_Re_Loc::Existing);
        FNC_Add_Purchase_Invoice(deal_ID_Co_Par, PurchInvHeader_Re_Loc, '', option_Re_Loc::Existing);
        FNC_Add_Sales_Invoice(deal_ID_Co_Par, SalesInvHeader_Re_Loc, '', option_Re_Loc::Existing);
        FNC_Add_Invoice(deal_ID_Co_Par, '', option, '', '', '', option_Re_Loc::Existing);

    end;


    procedure FNC_Add_Sales_Cr_Memo(Deal_ID_Co_Par: Code[20]; creditMemoHeader_Re_Par: Record "Sales Cr.Memo Header"; ShipmentNo_Co_Par: Code[20]; Add_Variant_Op_Par: Option New,Existing)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        element_Re_Loc: Record "DEL Element";
        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        element_ID_Loc: Code[20];
        last: Code[20];
        salesInvID_Co_Loc: Code[20];
        shipmentID_Co_Loc: Code[20];
    begin
        /*__
          Ajoute un "Element" de type Credit Memo
          Fonction appelée lors de la création d'une Credit Memo
        __*/

        IF Add_Variant_Op_Par = Add_Variant_Op_Par::New THEN BEGIN

            IF ShipmentNo_Co_Par <> '' THEN BEGIN

                salesInvID_Co_Loc := DealShipment_Cu.FNC_GetSalesInvoiceElementID(ShipmentNo_Co_Par);

                /*_Insère un enregistrement dans la table "Element" 50021_*/
                element_ID_Loc := FNC_Insert_Element(
                  Deal_ID_Co_Par,                                   //deal id
                  element_Re_Loc.Instance::real,                    //instance
                  element_Re_Loc.Type::"Sales Cr. Memo",            //type
                  creditMemoHeader_Re_Par."No.",                    //type no
                  salesInvID_Co_Loc,                                //apply-to
                  element_Re_Loc."Subject Type"::Customer,          //subject type
                  creditMemoHeader_Re_Par."Sell-to Customer No.",   //subject no
                  '',                                               //fee id
                  '',                                               //fee connection id
                  creditMemoHeader_Re_Par."Posting Date",           //date
                  0,                                                //entry No.
                  creditMemoHeader_Re_Par."Bill-to Customer No.",
                  0D,
                  0 //splitt index
                );

                DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, ShipmentNo_Co_Par, element_ID_Loc);

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Sales_Cr_Memo()',
                  STRSUBSTNO('Aucune livraison sélectionnée pour la Note de Crédit >%1< !', creditMemoHeader_Re_Par."No."));

        END ELSE
            IF Add_Variant_Op_Par = Add_Variant_Op_Par::Existing THEN BEGIN

                /*_Pas d'implémentation prévue pour le moment_*/

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Sales_Cr_Memo()',
                  'L''option d''ajout d''une Note de Crédit doit être de type ''New'' ou ''Existing'' !');

    end;


    procedure FNC_Add_Sales_Invoice(Deal_ID_Co_Par: Code[20]; SalesInvoiceHeader_Re_Par: Record "Sales Invoice Header"; ShipmentNo_Co_Par: Code[20]; Add_Variant_Op_Par: Option New,Existing)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        element_Re_Loc: Record "DEL Element";
        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        element_ID_Loc: Code[20];
        last: Code[20];
        shipmentID_Co_Loc: Code[20];
    begin
        /*__
          Ajoute un "Element" de type Sales Invoice
          Fonction appelée lors de la création d'une Sales Invoice (si la Sales Invoice est déjà existante,
          alors on utilisera FNC_Add_Sales_Invoice avec paramètre Add_Variant_Op_Par::Existing)
        
          Paramètre de type option :
            -> Add_Variant_Op_Par::New      : add a new specific Purchase Invoice
            -> Add_Variant_Op_Par::Existing : check for existing Purchase Invoices and add them if they are not linked to the deal yet
        __*/

        IF Add_Variant_Op_Par = Add_Variant_Op_Par::New THEN BEGIN

            //rechercher la VCO
            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            element_Re_Loc.SETRANGE("Type No.", SalesInvoiceHeader_Re_Par."Order No.");
            //si on trouve, tant mieux, sinon c'est pas grave car il ne s'agit pas d'une info vitale
            IF element_Re_Loc.FINDFIRST() THEN;

            //insère un enregistrement dans la table "Element" 50021
            element_ID_Loc :=
              FNC_Insert_Element(
               Deal_ID_Co_Par,
               element_Re_Loc.Instance::real,
               element_Re_Loc.Type::"Sales Invoice",
               SalesInvoiceHeader_Re_Par."No.",
               element_Re_Loc.ID,
               element_Re_Loc."Subject Type"::Customer,
               SalesInvoiceHeader_Re_Par."Bill-to Customer No.",
               '',
               '',
               SalesInvoiceHeader_Re_Par."Posting Date",
               0,
               SalesInvoiceHeader_Re_Par."Bill-to Customer No.",
               SalesInvoiceHeader_Re_Par."Posting Date", //la période des élé. réels = la posting date de la sales invoice d'une livraison
               0 //splitt index
              );

            //START CHG05
            //link in ShipmentConnection table and set sales invoice no
            IF ShipmentNo_Co_Par <> '' THEN BEGIN

                DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, ShipmentNo_Co_Par, element_ID_Loc);
                DealShipment_Cu.FNC_SetSalesInvoiceNo(ShipmentNo_Co_Par, SalesInvoiceHeader_Re_Par."No.");

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Sales_Purchase_Invoice()',
                  STRSUBSTNO('Aucune livraison sélectionnée pour la Sales Invoice >%1< !', SalesInvoiceHeader_Re_Par."No."));
            //STOP CHG05


        END ELSE
            IF Add_Variant_Op_Par = Add_Variant_Op_Par::Existing THEN BEGIN

                /*_On cherche l'ACO liée à l'affaire_*/
                //element_Re_Loc.RESET();
                //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
                //element_Re_Loc.setrange(Instance, element_Re_Loc.Instance::planned);

                Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
                IF element_Re_Loc.FINDFIRST() THEN BEGIN

                    /*_On cherche les Sales Invoices liées à l'ACO de cette affaire_*/
                    last := '';
                    salesInvLine_Re_Loc.RESET();
                    salesInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Order No.");
                    salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                    salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                    salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF salesInvLine_Re_Loc.FINDFIRST() THEN BEGIN
                        REPEAT

                            IF salesInvLine_Re_Loc."Document No." <> last THEN BEGIN
                                //MESSAGE(salesInvLine_Re_Loc."Document No.");

                                IF salesInvHeader_Re_Loc.GET(salesInvLine_Re_Loc."Document No.") THEN BEGIN

                                    /*_Ajoute une ligne dans table "Element"_*/

                                    /*_Avant d'ajouter, on controle si le est pas déjà lié à l'affaire_*/
                                    element_Re_Loc.RESET();
                                    element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                                    element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                    element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Invoice");
                                    element_Re_Loc.SETRANGE("Type No.", salesInvHeader_Re_Loc."No.");
                                    IF NOT element_Re_Loc.FINDFIRST() THEN BEGIN

                                        //rechercher la VCO à laquelle cet Sales Invoice correspond
                                        element_Re_Loc.RESET();
                                        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
                                        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
                                        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
                                        element_Re_Loc.SETRANGE("Type No.", salesInvHeader_Re_Loc."Order No.");
                                        IF element_Re_Loc.FINDFIRST() THEN BEGIN

                                            /*_Insère un enregistrement dans la table "Element" 50021_*/
                                            element_ID_Loc := FNC_Insert_Element(
                                             Deal_ID_Co_Par,                                   //deal id
                                             element_Re_Loc.Instance::real,                    //instance
                                             element_Re_Loc.Type::"Sales Invoice",             //type
                                             salesInvHeader_Re_Loc."No.",                      //type no
                                             element_Re_Loc.ID,                                //apply-to
                                             element_Re_Loc."Subject Type"::Customer,          //subject type
                                             salesInvHeader_Re_Loc."Sell-to Customer No.",     //subject no
                                             '',                                               //fee id
                                             '',                                               //fee connection id
                                             salesInvHeader_Re_Loc."Posting Date",             //date
                                             0,
                                             SalesInvoiceHeader_Re_Par."Bill-to Customer No.",
                                             salesInvHeader_Re_Loc."Posting Date",
                                             0 //splitt index
                                            );

                                            /*_Recherche la première livraison de l'affaire_*/
                                            shipmentID_Co_Loc := DealShipment_Cu.FNC_GetFirstShipmentNo(Deal_ID_Co_Par);

                                            /*_Ajoute une ligne dans table "Deal Shipment Connection" (lie le Sales Invoice à la livraison)_*/
                                            DealShipmentConnection_Cu.FNC_Insert(Deal_ID_Co_Par, shipmentID_Co_Loc, element_ID_Loc);

                                            DealShipment_Cu.FNC_SetSalesInvoiceNo(shipmentID_Co_Loc, salesInvHeader_Re_Loc."No.");

                                        END;

                                    END;

                                END;

                            END;

                            last := salesInvLine_Re_Loc."Document No.";

                        UNTIL (salesInvLine_Re_Loc.NEXT() = 0);

                    END;

                END;

            END ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Sales_Invoice()',
                  'L''option d''ajout d''une Sales Invoice doit être de type ''New'' ou ''Existing'' !');

    end;


    procedure FNC_Add_VCO(Deal_ID_Co_Par: Code[20]; ACO_Co_Par: Code[20]; VCO_Re_Par: Record "Sales Header")
    var
        element_Re_Loc: Record "DEL Element";
        element_ID_Co_Loc: Code[20];
        isPlanned_Op_Loc: Option;
    begin
        // Ajoute un "Element" de type VCO

        //insère un enregistrement dans la table "Element" 50021
        element_ID_Co_Loc :=
          FNC_Insert_Element(
            Deal_ID_Co_Par,
            element_Re_Loc.Instance::planned,
            element_Re_Loc.Type::VCO,
            VCO_Re_Par."No.",
            ACO_Co_Par,
            element_Re_Loc."Subject Type"::Customer,
            VCO_Re_Par."Sell-to Customer No.",
            '',
            '',
            VCO_Re_Par."Document Date",
            0,
            VCO_Re_Par."Bill-to Customer No.",
            0D,
            0 //splitt index
          );

        //insère tous les "Element" "Fee" associés à la commande d'achat que l'on vient d'ajouter
        FNC_Add_Element_Fee(element_ID_Co_Loc);
    end;


    procedure FNC_Add_VCO_From_Invoice(Deal_ID_Co_Par: Code[20]; ACO_Co_Par: Code[20]; SalesInvoiceHeader_Re_Loc: Record 112)
    var
        element_Re_Loc: Record "DEL Element";
        element_ID_Co_Loc: Code[20];
        isPlanned_Op_Loc: Option;
    begin
        // Ajoute un "Element" de type VCO

        //insère un enregistrement dans la table "Element" 50021
        element_ID_Co_Loc :=
          FNC_Insert_Element(
            Deal_ID_Co_Par,
            element_Re_Loc.Instance::planned,
            element_Re_Loc.Type::VCO,
            SalesInvoiceHeader_Re_Loc."Order No.",
            ACO_Co_Par,
            element_Re_Loc."Subject Type"::Customer,
            SalesInvoiceHeader_Re_Loc."Sell-to Customer No.",
            '',
            '',
            SalesInvoiceHeader_Re_Loc."Document Date",
            0,
            SalesInvoiceHeader_Re_Loc."Bill-to Customer No.",
            0D,
            0 //splitt index
          );

        //insère tous les "Element" "Fee" associés à la commande d'achat que l'on vient d'ajouter
        FNC_Add_Element_Fee(element_ID_Co_Loc);
    end;


    procedure FNC_Delete_Element(Element_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
    begin
        //supprimer de la table position
        Position_Cu.FNC_Delete(Element_ID_Co_Par);

        //supprimer de la table element connection
        ElementConnection_Cu.FNC_Delete(Element_ID_Co_Par);

        //supprimer de la table deal shipment connection
        DealShipmentConnection_Cu.FNC_Delete(Element_ID_Co_Par);

        //supprimer de la table element
        element_Re_Loc.RESET();
        IF element_Re_Loc.GET(Element_ID_Co_Par) THEN
            element_Re_Loc.DELETE()
        ELSE
            ERROR(ERROR_TXT, 'Co_50021', 'FNC_Delete_Element()',
              STRSUBSTNO('Raison : impossible de supprimer l''element >%1<', Element_ID_Co_Par));
    end;


    procedure FNC_Get_Amount_FCY(Element_ID_Co_Par: Code[20]) amount_Dec_Ret: Decimal
    var
        currExRate_Re_loc: Record "Currency Exchange Rate";
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        GLEntry_Re_Loc: Record "G/L Entry";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        curr_Co_Loc: Code[10];
        deal_ID_Co_Loc: Code[20];
        amount_Dec_Loc: Decimal;
        qty_Dec_Loc: Decimal;
        rate_Dec_Loc: Decimal;
        entryNo_Int_Loc: Integer;
    begin
        /*__Retourne l'amount en devise du document__*/

        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_Loc := element_Re_Loc.Deal_ID;

        amount_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            qty_Dec_Loc := ACO_Line_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.");
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc;

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT

                                qty_Dec_Loc := purchInvLine_Re_Loc.Quantity;
                                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                                amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc;

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                qty_Dec_Loc := VCO_Line_Re_Loc.Quantity;
                                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc;

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    qty_Dec_Loc := VCO_Line_Re_Loc.Quantity;
                                    amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                    amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc;
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Order No.");
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF salesInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        qty_Dec_Loc := salesInvLine_Re_Loc.Quantity;
                                        amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, salesInvLine_Re_Loc."No.");
                                        amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc;
                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::Fee:
                BEGIN
                    //SI IL Y A UNE Fee Connection, on la prend en compte
                    IF feeConnection_Re_Loc.GET(element_Re_Loc.Fee_Connection_ID) THEN
                        amount_Dec_Ret :=
                          Fee_Cu.FNC_Get_Amount(
                            element_Re_Loc.Fee_ID,
                            Element_ID_Co_Par,
                            feeConnection_Re_Loc."Default Amount",
                            feeConnection_Re_Loc."Default Factor"
                          )
                    ELSE
                        amount_Dec_Ret := Fee_Cu.FNC_Get_Amount(element_Re_Loc.Fee_ID, Element_ID_Co_Par, 0, 0)
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.");
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc;
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::Invoice:
                BEGIN
                    CASE element_Re_Loc."Subject Type" OF
                        element_Re_Loc."Subject Type"::Vendor:
                            BEGIN
                                vendorLedgerEntry.RESET();
                                vendorLedgerEntry.SETRANGE("Vendor No.", element_Re_Loc."Subject No.");
                                vendorLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF vendorLedgerEntry.FINDFIRST() THEN BEGIN
                                    vendorLedgerEntry.CALCFIELDS(Amount);
                                    qty_Dec_Loc := 1;
                                    amount_Dec_Loc := vendorLedgerEntry.Amount;
                                    //curr_Co_Loc    := 'EUR';
                                    //rate_Dec_Loc   := currExRate_Re_loc.ExchangeRate(vendorLedgerEntry."Posting Date", curr_Co_Loc);
                                    amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * -1; // * rate_Dec_Loc;
                                END;
                            END;
                        element_Re_Loc."Subject Type"::Customer:
                            BEGIN
                                customerLedgerEntry.RESET();
                                customerLedgerEntry.SETRANGE("Customer No.", element_Re_Loc."Subject No.");
                                customerLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF customerLedgerEntry.FINDFIRST() THEN BEGIN
                                    customerLedgerEntry.CALCFIELDS(Amount);
                                    qty_Dec_Loc := 1;
                                    amount_Dec_Loc := customerLedgerEntry.Amount;
                                    //curr_Co_Loc    := 'EUR';
                                    //rate_Dec_Loc   := currExRate_Re_loc.ExchangeRate(customerLedgerEntry."Posting Date", curr_Co_Loc);
                                    amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * -1; // * rate_Dec_Loc;
                                END;
                            END;
                        element_Re_Loc."Subject Type"::"G/L Account":
                            BEGIN
                                vendorLedgerEntry.RESET();
                                vendorLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                vendorLedgerEntry.SETFILTER("Document Type", '%1|%2|%3',
                                  vendorLedgerEntry."Document Type"::Invoice,
                                  vendorLedgerEntry."Document Type"::Payment,
                                  vendorLedgerEntry."Document Type"::"Credit Memo");
                                IF vendorLedgerEntry.FINDFIRST() THEN BEGIN
                                    vendorLedgerEntry.CALCFIELDS(Amount);
                                    amount_Dec_Ret := FNC_Get_Amount_LCY(Element_ID_Co_Par) * vendorLedgerEntry."Adjusted Currency Factor";
                                END ELSE BEGIN

                                    customerLedgerEntry.RESET();
                                    customerLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                    customerLedgerEntry.SETFILTER("Document Type", '%1|%2|%3',
                                      customerLedgerEntry."Document Type"::Invoice,
                                      customerLedgerEntry."Document Type"::Payment,
                                      customerLedgerEntry."Document Type"::"Credit Memo");
                                    IF customerLedgerEntry.FINDFIRST() THEN BEGIN
                                        customerLedgerEntry.CALCFIELDS(Amount);
                                        amount_Dec_Ret := FNC_Get_Amount_LCY(Element_ID_Co_Par) * customerLedgerEntry."Adjusted Currency Factor";
                                    END ELSE
                                        amount_Dec_Ret :=
                                          FNC_Get_Amount_LCY(Element_ID_Co_Par);// * currExRate_Re_loc.ExchangeRate(element_Re_Loc.Date, 'EUR');
                                END

                            END
                    END
                END;

            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            qty_Dec_Loc := purchInvLine_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc;
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            //CHG-DEV-PROVISION
            element_Re_Loc.Type::Provision:
                BEGIN
                    //on cherche dans la table Shipment Provision Selection
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Amount()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Get_Amount_From_Positions(Element_ID_Co_Par: Code[20]) amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
    begin
        //retourne l'amount d'un element en fonction de ses positions dans la table position
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        amount_Dec_Ret := 0;

        element_Re_Loc.CALCFIELDS("Amount(EUR)");
        amount_Dec_Ret := element_Re_Loc."Amount(EUR)";

        //deprecated since working with flowfields
        /*
        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
        position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
        IF position_Re_Loc.FINDFIRST THEN
          REPEAT
            amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID);
          UNTIL(position_Re_Loc.NEXT() = 0);
        */

    end;


    procedure FNC_Get_Amount_LCY(Element_ID_Co_Par: Code[20]) amount_Dec_Ret: Decimal
    var
        currExRate_Re_loc: Record "Currency Exchange Rate";
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        GLEntry_Re_Loc: Record "G/L Entry";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        curr_Co_Loc: Code[10];
        deal_ID_Co_Loc: Code[20];
        amount_Dec_Loc: Decimal;
        qty_Dec_Loc: Decimal;
        rate_Dec_Loc: Decimal;
        EntryNo_Int_Loc: Integer;
    begin
        /*__Retourne l'amount en EUR d'un element__*/

        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_Loc := element_Re_Loc.Deal_ID;

        amount_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            qty_Dec_Loc := ACO_Line_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.");
                            curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.");
                            rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT

                                qty_Dec_Loc := purchInvLine_Re_Loc.Quantity;
                                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                                curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                                rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                qty_Dec_Loc := VCO_Line_Re_Loc.Quantity;
                                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    qty_Dec_Loc := VCO_Line_Re_Loc.Quantity;
                                    amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                    curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                    rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                    amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF salesInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        qty_Dec_Loc := salesInvLine_Re_Loc.Quantity;
                                        amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, salesInvLine_Re_Loc."No.");
                                        curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Price(deal_ID_Co_Loc, salesInvLine_Re_Loc."No.");
                                        rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                        amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::Fee:
                BEGIN
                    //SI IL Y A UNE Fee Connection, on la prend en compte
                    IF feeConnection_Re_Loc.GET(element_Re_Loc.Fee_Connection_ID) THEN
                        amount_Dec_Ret :=
                          Fee_Cu.FNC_Get_Amount(
                            element_Re_Loc.Fee_ID,
                            Element_ID_Co_Par,
                            feeConnection_Re_Loc."Default Amount",
                            feeConnection_Re_Loc."Default Factor"
                          )
                    ELSE
                        amount_Dec_Ret := Fee_Cu.FNC_Get_Amount(element_Re_Loc.Fee_ID, Element_ID_Co_Par, 0, 0)
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.");
                            curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.");
                            rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::Invoice:
                BEGIN
                    CASE element_Re_Loc."Subject Type" OF
                        element_Re_Loc."Subject Type"::Vendor:
                            BEGIN
                                vendorLedgerEntry.RESET();
                                vendorLedgerEntry.SETRANGE("Vendor No.", element_Re_Loc."Subject No.");
                                vendorLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF vendorLedgerEntry.FINDFIRST() THEN BEGIN
                                    vendorLedgerEntry.CALCFIELDS("Amount (LCY)");
                                    qty_Dec_Loc := 1;
                                    amount_Dec_Loc := vendorLedgerEntry."Amount (LCY)";
                                    curr_Co_Loc := 'EUR';
                                    rate_Dec_Loc := currExRate_Re_loc.ExchangeRate(vendorLedgerEntry."Posting Date", curr_Co_Loc);
                                    amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                                END;
                            END;
                        element_Re_Loc."Subject Type"::Customer:
                            BEGIN
                                customerLedgerEntry.RESET();
                                customerLedgerEntry.SETRANGE("Customer No.", element_Re_Loc."Subject No.");
                                customerLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF customerLedgerEntry.FINDFIRST() THEN BEGIN
                                    customerLedgerEntry.CALCFIELDS("Amount (LCY)");
                                    qty_Dec_Loc := 1;
                                    amount_Dec_Loc := customerLedgerEntry."Amount (LCY)";
                                    curr_Co_Loc := 'EUR';
                                    rate_Dec_Loc := currExRate_Re_loc.ExchangeRate(customerLedgerEntry."Posting Date", curr_Co_Loc);
                                    amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                                END;
                            END;
                        element_Re_Loc."Subject Type"::"G/L Account":
                            BEGIN
                                //Entry No. est pas forcément défini pour tous les éléments mais si il existe, alors il faut l'utiliser
                                IF GLEntry_Re_Loc.GET(element_Re_Loc."Entry No.") THEN BEGIN

                                    amount_Dec_Ret := GLEntry_Re_Loc.Amount;

                                    //IF GLEntry_Re_Loc."Document Type" = GLEntry_Re_Loc."Document Type"::"Credit Memo" THEN
                                    //  amount_Dec_Ret := GLEntry_Re_Loc.Amount * -1;

                                END ELSE BEGIN

                                    //ACOElement_Re_Loc.RESET();
                                    //acoelement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                                    //ACOElement_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                                    //ACOElement_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
                                    //ACOElement_Re_Loc.setrange(Instance, element_Re_Loc.Instance::planned);

                                    Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                                    IF NOT ACOElement_Re_Loc.FINDFIRST() THEN ERROR('aucune ACO');

                                    GLEntry_Re_Loc.RESET();
                                    GLEntry_Re_Loc.SETRANGE("G/L Account No.", element_Re_Loc."Subject No.");
                                    GLEntry_Re_Loc.SETFILTER("Document Type", '%1|%2|%3',
                                      GLEntry_Re_Loc."Document Type"::Invoice,
                                      GLEntry_Re_Loc."Document Type"::Payment,
                                      GLEntry_Re_Loc."Document Type"::"Credit Memo");
                                    GLEntry_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                    GLEntry_Re_Loc.SETRANGE("Global Dimension 1 Code", ACOElement_Re_Loc."Type No.");

                                    IF GLEntry_Re_Loc.FINDFIRST() THEN BEGIN
                                        //les montants G/L entry sont toujours en Devise Société
                                        ////on gère la conversion en dur et on retourne toujours des EUR
                                        //amount_Dec_Ret := GLEntry_Re_Loc.Amount * currExRate_Re_loc.ExchangeRate(GLEntry_Re_Loc."Posting Date", 'EUR');
                                        amount_Dec_Ret := GLEntry_Re_Loc.Amount;
                                    END ELSE BEGIN
                                        GLEntry_Re_Loc.RESET();
                                        GLEntry_Re_Loc.SETRANGE("G/L Account No.", element_Re_Loc."Subject No.");
                                        GLEntry_Re_Loc.SETFILTER("Document Type", '%1|%2|%3',
                                          GLEntry_Re_Loc."Document Type"::Invoice,
                                          GLEntry_Re_Loc."Document Type"::Payment,
                                          GLEntry_Re_Loc."Document Type"::"Credit Memo");
                                        GLEntry_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                        GLEntry_Re_Loc.SETRANGE("Global Dimension 1 Code", '');

                                        IF GLEntry_Re_Loc.FINDFIRST() THEN BEGIN
                                            //les montants G/L entry sont toujours en Devise Société
                                            ////on gère la conversion en dur et on retourne toujours des EUR
                                            amount_Dec_Ret := GLEntry_Re_Loc.Amount * currExRate_Re_loc.ExchangeRate(GLEntry_Re_Loc."Posting Date", 'EUR');
                                        END
                                    END;

                                    //pas encore compris comment déterminer selon les cas si il faut retrourner l'amount en positif ou négatif..
                                    IF GLEntry_Re_Loc.Amount < 0 THEN
                                        amount_Dec_Ret := GLEntry_Re_Loc.Amount * -1
                                    ELSE
                                        amount_Dec_Ret := GLEntry_Re_Loc.Amount;
                                END

                            END
                    END;
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            qty_Dec_Loc := purchInvLine_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                            curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                            rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;

            /*
            //CHG-DEV-PROVISION
            element_Re_Loc.Type::Provision:
              begin
                //à implémenter
              end;
            */

            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Amount()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Get_Colis(Element_ID_Co_Par: Code[20]) nbColis_Dec_Ret: Decimal
    var
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        deal_ID_Co_loc: Code[20];
    begin
        //retourne le nombre de colis standard
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_loc := element_Re_Loc.Deal_ID;

        nbColis_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            nbColis_Dec_Ret +=
                              ACO_Line_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, ACO_Line_Re_Loc."No.")
                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                nbColis_Dec_Ret +=
                                  purchInvLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                nbColis_Dec_Ret +=
                                  VCO_Line_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, VCO_Line_Re_Loc."No.")

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN
                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    nbColis_Dec_Ret +=
                                      VCO_Line_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, VCO_Line_Re_Loc."No.")
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                purchInvLine_Re_Loc.RESET();
                                purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                                purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF purchInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        nbColis_Dec_Ret +=
                                          purchInvLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                                    UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;

            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            nbColis_Dec_Ret +=
                              purchRcptLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchRcptLine_Re_Loc."No.")
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            nbColis_Dec_Ret +=
                              purchInvLine_Re_Loc.Quantity / DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Colis()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Get_Currency(Element_ID_Co_Par: Code[20]) currency_Code_Ret: Code[10]
    var

        currExRate_Re_Loc: Record "Currency Exchange Rate";
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        element_Re_Loc: Record "DEL Element";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        position_Re_Loc: Record "DEL Position";
        GLEntry_Re_Loc: Record "G/L Entry";
        purchInvHeader_Re_Loc: Record "Purch. Inv. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        purchHeader_Re_Loc: Record "Purchase Header";
        ACO_Line_Re_Loc: Record "Purchase Line";
        salesHeader_Re_Loc: Record "Sales Header";
        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        entryNo_Int_Loc: Integer;
    begin
        //retourne l'amount d'un element selon le montant des documents
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        currency_Code_Ret := '';

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    IF purchHeader_Re_Loc.GET(purchHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN
                        currency_Code_Ret := purchHeader_Re_Loc."Currency Code"
                    ELSE BEGIN
                        purchInvHeader_Re_Loc.RESET();
                        purchInvHeader_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        IF purchInvHeader_Re_Loc.FINDFIRST() THEN
                            currency_Code_Ret := purchInvHeader_Re_Loc."Currency Code"
                        ELSE
                            ERROR(
                              'La devise de l''ACO >%1< est introuvable alors qu''elle est nécessaire pour calculer un frais de douane' +
                              'pour l''affaire >%2<.',
                              element_Re_Loc."Type No.",
                              element_Re_Loc.Deal_ID
                            )
                    END
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN
                        currency_Code_Ret := salesHeader_Re_Loc."Currency Code"
                    ELSE BEGIN
                        salesInvHeader_Re_Loc.RESET();
                        salesInvHeader_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        IF salesInvHeader_Re_Loc.FINDFIRST() THEN
                            currency_Code_Ret := salesInvHeader_Re_Loc."Currency Code"
                        ELSE
                            ERROR(
                              'La devise de la VCO >%1< est introuvable alors qu''elle est nécessaire pour calculer un frais de douane' +
                              'pour l''affaire >%2<.',
                              element_Re_Loc."Type No.",
                              element_Re_Loc.Deal_ID
                            )
                    END
                END;
            element_Re_Loc.Type::Fee:
                BEGIN
                    //le plus rapide est de regarder sur la première position de l'élément quelle devise a été assignée lors de sa création
                    position_Re_Loc.RESET();
                    position_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF position_Re_Loc.FINDFIRST() THEN
                        currency_Code_Ret := position_Re_Loc.Currency;
                END;
            element_Re_Loc.Type::BR:
                ;
            element_Re_Loc.Type::Invoice:
                BEGIN
                    CASE element_Re_Loc."Subject Type" OF
                        element_Re_Loc."Subject Type"::Vendor:
                            BEGIN
                                vendorLedgerEntry.RESET();
                                vendorLedgerEntry.SETRANGE("Vendor No.", element_Re_Loc."Subject No.");
                                vendorLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF vendorLedgerEntry.FINDFIRST() THEN BEGIN
                                    currency_Code_Ret := vendorLedgerEntry."Currency Code";
                                END;
                            END;
                        element_Re_Loc."Subject Type"::Customer:
                            BEGIN
                                //si il existe une posted invoice header, alors on cherche son total
                                customerLedgerEntry.RESET();
                                customerLedgerEntry.SETRANGE("Customer No.", element_Re_Loc."Subject No.");
                                customerLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF customerLedgerEntry.FINDFIRST() THEN BEGIN
                                    currency_Code_Ret := customerLedgerEntry."Currency Code";
                                END;
                            END;
                        element_Re_Loc."Subject Type"::"G/L Account":
                            BEGIN
                                vendorLedgerEntry.RESET();
                                vendorLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF vendorLedgerEntry.FINDFIRST() THEN
                                    currency_Code_Ret := vendorLedgerEntry."Currency Code"
                                ELSE BEGIN
                                    customerLedgerEntry.RESET();
                                    customerLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                    IF customerLedgerEntry.FINDFIRST() THEN
                                        currency_Code_Ret := customerLedgerEntry."Currency Code"
                                    ELSE BEGIN

                                        //les montants sur les lignes G/L Entry sont tous en Devise Societé, mais nous on veut de l'euro
                                        //on converti donc le montant de toutes les G/L Entry dans FNC_Get_Amount
                                        currency_Code_Ret := ''; // '' pour DS soit CHF en fait

                                    END;
                                END
                            END;
                    END;
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    IF purchInvHeader_Re_Loc.GET(element_Re_Loc."Type No.") THEN
                        currency_Code_Ret := purchInvHeader_Re_Loc."Currency Code";
                END;

            element_Re_Loc.Type::"Sales Invoice":
                BEGIN
                    IF salesInvHeader_Re_Loc.GET(element_Re_Loc."Type No.") THEN
                        currency_Code_Ret := salesInvHeader_Re_Loc."Currency Code";
                END;


            //CHG-DEV-PROVISION
            element_Re_Loc.Type::Provision:
                BEGIN
                    //Les provisions sont toujours en DS
                    currency_Code_Ret := ''; // '' pour DS soit CHF en fait
                END;



            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Currency()',
                  STRSUBSTNO('Get_Currency impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;
    end;


    procedure FNC_Get_Douane(Element_ID_Co_Par: Code[20]) amount_Dec_Ret: Decimal
    var
        currExRate_Re_loc: Record "Currency Exchange Rate";
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";

        GLEntry_Re_Loc: Record "G/L Entry";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        curr_Co_Loc: Code[10];
        deal_ID_Co_loc: Code[20];
        amount_Dec_Loc: Decimal;
        douane_Dec_Loc: Decimal;

        qty_Dec_Loc: Decimal;
        rate_Dec_Loc: Decimal;
        EntryNo_Int_Loc: Integer;
    begin
        /*__Retourne le montant douane en Devise de l'element__*/

        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_Loc := element_Re_Loc.Deal_ID;

        amount_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            qty_Dec_Loc := ACO_Line_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.");
                            //curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.");
                            //rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                            douane_Dec_Loc := DealItem_Cu.FNC_Get_Droit_Douanne(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.");
                            //amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc * douane_Dec_Loc;
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * douane_Dec_Loc;

                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT

                                qty_Dec_Loc := purchInvLine_Re_Loc.Quantity;
                                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                                //curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                                //rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                douane_Dec_Loc := DealItem_Cu.FNC_Get_Droit_Douanne(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                                //amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc * douane_Dec_Loc;
                                amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * douane_Dec_Loc;

                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                qty_Dec_Loc := VCO_Line_Re_Loc.Quantity;
                                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                //curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                //rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                douane_Dec_Loc := DealItem_Cu.FNC_Get_Droit_Douanne(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                //amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc * douane_Dec_Loc;
                                amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * douane_Dec_Loc;
                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN

                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    qty_Dec_Loc := VCO_Line_Re_Loc.Quantity;
                                    amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                    //curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Price(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                    //rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                    douane_Dec_Loc := DealItem_Cu.FNC_Get_Droit_Douanne(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.");
                                    //amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc * douane_Dec_Loc;
                                    amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * douane_Dec_Loc;
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                salesInvLine_Re_Loc.RESET();
                                salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                                salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF salesInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        qty_Dec_Loc := salesInvLine_Re_Loc.Quantity;
                                        amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(deal_ID_Co_Loc, salesInvLine_Re_Loc."No.");
                                        //curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Price(deal_ID_Co_Loc, salesInvLine_Re_Loc."No.");
                                        //rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                                        douane_Dec_Loc := DealItem_Cu.FNC_Get_Droit_Douanne(deal_ID_Co_Loc, salesInvLine_Re_Loc."No.");
                                        //amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc * douane_Dec_Loc;
                                        amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * douane_Dec_Loc;
                                    UNTIL (salesInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.");
                            //curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.");
                            //rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                            douane_Dec_Loc := DealItem_Cu.FNC_Get_Droit_Douanne(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.");
                            //amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc * douane_Dec_Loc;
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * douane_Dec_Loc;
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            qty_Dec_Loc := purchInvLine_Re_Loc.Quantity;
                            amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                            //curr_Co_Loc    := DealItem_Cu.FNC_Get_Currency_Cost(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                            //rate_Dec_Loc   := Currency_Exchange_Re.FNC_Get_Rate(deal_ID_Co_Loc, curr_Co_Loc, 'EUR');
                            douane_Dec_Loc := DealItem_Cu.FNC_Get_Droit_Douanne(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.");
                            //amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc * douane_Dec_Loc;
                            amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * douane_Dec_Loc;
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Douane()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

        //MESSAGE(FORMAT(amount_Dec_Ret));

    end;


    procedure FNC_Get_Exchange_Rate(Element_ID_Co_Par: Code[20]) currencyRate_Dec_Ret: Decimal
    var
        currExRate_Re_loc: Record "Currency Exchange Rate";
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        element_Re_Loc: Record "DEL Element";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        purchInvHeader_Re_Loc: Record "Purch. Inv. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        //retourne l'amount d'un element selon le montant des documents
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        currencyRate_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                ;
            element_Re_Loc.Type::VCO:
                ;
            element_Re_Loc.Type::Fee:
                ;
            element_Re_Loc.Type::BR:
                ;
            element_Re_Loc.Type::Invoice:
                BEGIN
                    CASE element_Re_Loc."Subject Type" OF
                        //facture achat
                        element_Re_Loc."Subject Type"::Vendor:
                            BEGIN
                                vendorLedgerEntry.RESET();
                                vendorLedgerEntry.SETRANGE("Vendor No.", element_Re_Loc."Subject No.");
                                vendorLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF vendorLedgerEntry.FINDFIRST() THEN BEGIN
                                    currencyRate_Dec_Ret :=
                                      (1 / vendorLedgerEntry."Original Currency Factor") *
                                      currExRate_Re_loc.ExchangeRate(vendorLedgerEntry."Posting Date", 'EUR');
                                END;
                            END;
                        //facture vente
                        element_Re_Loc."Subject Type"::Customer:
                            BEGIN
                                //si il existe une posted invoice header, alors on cherche son total
                                customerLedgerEntry.RESET();
                                customerLedgerEntry.SETRANGE("Customer No.", element_Re_Loc."Subject No.");
                                customerLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF customerLedgerEntry.FINDFIRST() THEN BEGIN
                                    currencyRate_Dec_Ret :=
                                      (1 / customerLedgerEntry."Original Currency Factor") *
                                      currExRate_Re_loc.ExchangeRate(customerLedgerEntry."Posting Date", 'EUR');
                                END;
                            END;
                        //facture vente
                        element_Re_Loc."Subject Type"::"G/L Account":
                            BEGIN
                                vendorLedgerEntry.RESET();
                                vendorLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                IF vendorLedgerEntry.FINDFIRST() THEN BEGIN
                                    currencyRate_Dec_Ret :=
                                      (1 / vendorLedgerEntry."Original Currency Factor") *
                                      currExRate_Re_loc.ExchangeRate(vendorLedgerEntry."Posting Date", 'EUR');
                                END ELSE BEGIN
                                    //si il existe une posted invoice header, alors on cherche son total
                                    customerLedgerEntry.RESET();
                                    customerLedgerEntry.SETRANGE("Document No.", element_Re_Loc."Type No.");
                                    IF customerLedgerEntry.FINDFIRST() THEN BEGIN
                                        currencyRate_Dec_Ret :=
                                          (1 / customerLedgerEntry."Original Currency Factor") *
                                          currExRate_Re_loc.ExchangeRate(customerLedgerEntry."Posting Date", 'EUR');
                                    END ELSE
                                        currencyRate_Dec_Ret := currExRate_Re_loc.ExchangeRate(element_Re_Loc.Date, 'EUR');
                                END
                            END;
                    END;
                END;
            //écriture
            element_Re_Loc.Type::"Purchase Invoice":
                ;


            //CHG-DEV-PROVISION
            element_Re_Loc.Type::Provision:
                BEGIN
                    currencyRate_Dec_Ret := currExRate_Re_loc.ExchangeRate(element_Re_Loc.Date, 'EUR');
                END;


            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Exchange_Rate()',
                  STRSUBSTNO('Get_Exchange_Rate impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;
    end;


    procedure FNC_Get_Gross_Weight(Element_ID_Co_Par: Code[20]) Gross_Weight_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        deal_ID_Co_Loc: Code[20];
    begin
        //retourne le Gross Weight d'un element
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_Loc := element_Re_Loc.Deal_ID;

        Gross_Weight_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Gross_Weight_Dec_Ret +=
                              ACO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.")
                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Gross_Weight_Dec_Ret +=
                                  purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.")
                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Gross_Weight_Dec_Ret +=
                                  VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.")
                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN
                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    Gross_Weight_Dec_Ret +=
                                      VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.")
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                purchInvLine_Re_Loc.RESET();
                                purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                                purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF purchInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        Gross_Weight_Dec_Ret +=
                                          purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.")
                                    UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Gross_Weight_Dec_Ret +=
                              purchRcptLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.")
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Gross_Weight_Dec_Ret +=
                              purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Gross_Weight(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.")
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Gross_Weight()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Get_Net_Weight(Element_ID_Co_Par: Code[20]) Net_Weight_Dec_Ret: Decimal
    var
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        deal_ID_Co_Loc: Code[20];
    begin
        //retourne le Net Weight d'un element
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_Loc := element_Re_Loc.Deal_ID;

        Net_Weight_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Net_Weight_Dec_Ret += ACO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Net_Weight(deal_ID_Co_Loc, ACO_Line_Re_Loc."No.")
                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Net_Weight_Dec_Ret +=
                                  purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Net_Weight(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.")
                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Net_Weight_Dec_Ret +=
                                  VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Net_Weight(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.")
                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN
                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    Net_Weight_Dec_Ret +=
                                      VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Net_Weight(deal_ID_Co_Loc, VCO_Line_Re_Loc."No.")
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                purchInvLine_Re_Loc.RESET();
                                purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                                purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF purchInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        Net_Weight_Dec_Ret +=
                                          purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Net_Weight(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.")
                                    UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Net_Weight_Dec_Ret +=
                              purchRcptLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Net_Weight(deal_ID_Co_Loc, purchRcptLine_Re_Loc."No.")
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Net_Weight_Dec_Ret +=
                              purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Net_Weight(deal_ID_Co_Loc, purchInvLine_Re_Loc."No.")
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Net_Weight()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Get_Period(Element_ID_Co_Par: Code[20]): Text[10]
    var
        element_Re_Loc: Record "DEL Element";
    begin
        //retourne la période en texte sous forme (M)MYYYY
        //p.e. '82009' pour aout 2009
        //p.e. '112010' pour novembre 2010

        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        IF element_Re_Loc.Period <> 0D THEN
            EXIT(FORMAT(element_Re_Loc.Period, 0, '<Month>') + FORMAT(element_Re_Loc.Period, 0, '<Year4>'));
    end;


    procedure FNC_Get_Quantity(Element_ID_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";

        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        deal_ID_Co_loc: Code[20];



    begin
        //retourne le nombre d'articles d'un element

        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        Deal_ID_Co_loc := element_Re_Loc.Deal_ID;

        Amount_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Amount_Dec_Ret += ACO_Line_Re_Loc.Quantity;
                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Amount_Dec_Ret += purchInvLine_Re_Loc.Quantity;
                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Amount_Dec_Ret += VCO_Line_Re_Loc.Quantity;
                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN
                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    Amount_Dec_Ret += VCO_Line_Re_Loc.Quantity;
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                purchInvLine_Re_Loc.RESET();
                                purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                                purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF purchInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        Amount_Dec_Ret += purchInvLine_Re_Loc.Quantity;
                                    UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Amount_Dec_Ret += purchRcptLine_Re_Loc.Quantity;
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Amount_Dec_Ret += purchInvLine_Re_Loc.Quantity;
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Quantity()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Get_Raw_Amount_From_Pos(Element_ID_Co_Par: Code[20]) amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
    begin
        //retourne l'amount d'un element en fonction de ses positions dans la table position
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        amount_Dec_Ret := 0;

        element_Re_Loc.CALCFIELDS(Amount);
        amount_Dec_Ret := element_Re_Loc.Amount;

        //deprecated since working with flowfields
        /*
        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
        position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
        IF position_Re_Loc.FINDFIRST THEN
          REPEAT
            amount_Dec_Ret += Position_Cu.FNC_Get_Raw_Amount(position_Re_Loc.ID);
          UNTIL(position_Re_Loc.NEXT() = 0);
        */

    end;


    procedure FNC_Get_Volume(Element_ID_Co_Par: Code[20]) Volume_Dec_Ret: Decimal
    var
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        Deal_ID_Co_loc: Code[20];
    begin
        //retourne le volume d'un element
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        Deal_ID_Co_loc := element_Re_Loc.Deal_ID;

        Volume_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF
            element_Re_Loc.Type::ACO:
                BEGIN
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Volume_Dec_Ret +=
                              ACO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(Deal_ID_Co_loc, ACO_Line_Re_Loc."No.")
                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Volume_Dec_Ret +=
                                  purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(Deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                Volume_Dec_Ret +=
                                  VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(Deal_ID_Co_loc, VCO_Line_Re_Loc."No.")

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN
                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    Volume_Dec_Ret +=
                                      VCO_Line_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(Deal_ID_Co_loc, VCO_Line_Re_Loc."No.")
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                purchInvLine_Re_Loc.RESET();
                                purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                                purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF purchInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        Volume_Dec_Ret +=
                                          purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(Deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                                    UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Volume_Dec_Ret +=
                              purchRcptLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(Deal_ID_Co_loc, purchRcptLine_Re_Loc."No.")
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            Volume_Dec_Ret +=
                              purchInvLine_Re_Loc.Quantity * DealItem_Cu.FNC_Get_Volume_CMB(Deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_Volume()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Get_VolumeTransport(Element_ID_Co_Par: Code[20]) volume_Dec_Ret: Decimal
    var
        customerLedgerEntry: Record "Cust. Ledger Entry";
        dealItem_Re_Loc: Record "DEL Deal Item";
        ACOElement_Re_Loc: Record "DEL Element";
        element_Re_Loc: Record "DEL Element";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        fee_Re_Loc: Record "DEL Fee";
        feeConnection_Re_Loc: Record "DEL Fee Connection";
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        ACO_Line_Re_Loc: Record "Purchase Line";
        VCO_Line_Re_Loc: Record "Sales Line";
        vendorLedgerEntry: Record "Vendor Ledger Entry";
        deal_ID_Co_loc: Code[20];
    begin
        //retourne le volume d'un element
        FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);
        deal_ID_Co_loc := element_Re_Loc.Deal_ID;

        volume_Dec_Ret := 0;

        CASE element_Re_Loc.Type OF

            element_Re_Loc.Type::ACO:
                BEGIN
                    //MESSAGE('ACO');
                    ACO_Line_Re_Loc.RESET();
                    ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                    ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                    ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF ACO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            volume_Dec_Ret +=
                              ACO_Line_Re_Loc.Quantity *
                              DealItem_Cu.FNC_Get_Volume_CMB_Carton(deal_ID_Co_loc, ACO_Line_Re_Loc."No.") /
                              DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, ACO_Line_Re_Loc."No.")
                        UNTIL (ACO_Line_Re_Loc.NEXT() = 0)
                    /*_si on trouve pas sur les lignes achat, on cherche sur les lignes factures achat_*/
                    ELSE BEGIN
                        purchInvLine_Re_Loc.RESET();
                        purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                        purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                        purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF purchInvLine_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                volume_Dec_Ret +=
                                  purchInvLine_Re_Loc.Quantity *
                                  DealItem_Cu.FNC_Get_Volume_CMB_Carton(deal_ID_Co_loc, purchInvLine_Re_Loc."No.") /
                                  DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                            UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                    END;
                END;
            element_Re_Loc.Type::VCO:
                BEGIN
                    //MESSAGE('VCO');
                    //on cherche à quel ACO la VCO appartient
                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                        Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
                            REPEAT
                                volume_Dec_Ret +=
                                  VCO_Line_Re_Loc.Quantity *
                                  DealItem_Cu.FNC_Get_Volume_CMB_Carton(deal_ID_Co_loc, VCO_Line_Re_Loc."No.") /
                                  DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, VCO_Line_Re_Loc."No.")
                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                        /*_si on trouve pas en cherchant sur special order no, on cherche sur code axe 1_*/
                        ELSE BEGIN
                            VCO_Line_Re_Loc.RESET();
                            VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                            VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                            VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF VCO_Line_Re_Loc.FINDFIRST() THEN
                                REPEAT
                                    volume_Dec_Ret +=
                                      VCO_Line_Re_Loc.Quantity *
                                      DealItem_Cu.FNC_Get_Volume_CMB_Carton(deal_ID_Co_loc, VCO_Line_Re_Loc."No.") /
                                      DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, VCO_Line_Re_Loc."No.")
                                UNTIL (VCO_Line_Re_Loc.NEXT() = 0)
                            /*_si on trouve pas sur code axe 1, on cherche sur les factures ventes_*/
                            ELSE BEGIN
                                purchInvLine_Re_Loc.RESET();
                                purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                                purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                                purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                                IF purchInvLine_Re_Loc.FINDFIRST() THEN
                                    REPEAT
                                        volume_Dec_Ret +=
                                          purchInvLine_Re_Loc.Quantity *
                                          DealItem_Cu.FNC_Get_Volume_CMB_Carton(deal_ID_Co_loc, purchInvLine_Re_Loc."No.") /
                                          DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                                    UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                            END
                        END
                    END
                END;
            element_Re_Loc.Type::BR:
                BEGIN
                    //MESSAGE('BR');
                    purchRcptLine_Re_Loc.RESET();
                    purchRcptLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
                    purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchRcptLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            volume_Dec_Ret +=
                              purchRcptLine_Re_Loc.Quantity *
                              DealItem_Cu.FNC_Get_Volume_CMB_Carton(deal_ID_Co_loc, purchRcptLine_Re_Loc."No.") /
                              DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchRcptLine_Re_Loc."No.")
                        UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
                END;
            element_Re_Loc.Type::"Purchase Invoice":
                BEGIN
                    //MESSAGE('Purch. Inv.');
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            volume_Dec_Ret +=
                              purchInvLine_Re_Loc.Quantity *
                              DealItem_Cu.FNC_Get_Volume_CMB_Carton(deal_ID_Co_loc, purchInvLine_Re_Loc."No.") /
                              DealItem_Cu.FNC_Get_PCB(deal_ID_Co_loc, purchInvLine_Re_Loc."No.")
                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);
                END;
            ELSE
                ERROR(ERROR_TXT, 'Co_50021', 'FNC_Get_VolumeTransport()',
                  STRSUBSTNO('Impossible pour Element de type >%1<', element_Re_Loc.Type));
        END;

    end;


    procedure FNC_Insert_Element(Deal_ID_Co_Par: Code[20]; Instance_Op_Par: Option; Type_Op_Par: Option; "No._Co_Par": Code[20]; Apply_To_Co_Par: Code[20]; SubjectType_Op_Par: Option; SubjectNo_Co_Par: Code[20]; Fee_ID_Co_Par: Code[20]; Fee_Connection_ID_Co_Par: Code[20]; Element_Date_Par: Date; EntryNo_Int_Par: Integer; BillToCustomerNo_Co_Par: Code[20]; Period_Da_Par: Date; SplittIndex_Int_Par: Integer) element_ID_Ret: Code[20]
    var
        element_Re_Loc: Record "DEL Element";
    begin
        /*
        usage :
        
          {_Insère un enregistrement dans la table "Element" 50021_}
          element_ID_Loc := FNC_Insert_Element(
            Deal_ID_Co_Par,                                   //deal id
            element_Re_Loc.Instance::dispatched,              //instance
            element_Re_Loc.Type::"ACO",                       //type
            creditMemoHeader_Re_Par."No.",                    //type no
            '',                                               //apply-to (crée un connexion élément à l'insertion de l'élément)
            element_Re_Loc."Subject Type"::Customer,          //subject type
            creditMemoHeader_Re_Par."Sell-to Customer No.",   //subject no
            '',                                               //fee id
            '',                                               //fee connection id
            0D,                                               //date
            0,                                                //entry No.
            creditMemoHeader_Re_Par."Bill-to Customer No.",   //bill to
            0D,                                               //period
            2                                                 //splitt index (utile pour les types "Invoice" uniquement)
          );
        
        */

        Setup.GET();

        element_ID_Ret := NoSeriesMgt_Cu.GetNextNo(Setup."Element Nos.", TODAY, TRUE);

        element_Re_Loc.INIT();

        element_Re_Loc.ID := element_ID_Ret;
        element_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.VALIDATE(Instance, Instance_Op_Par);
        element_Re_Loc.VALIDATE(Type, Type_Op_Par);
        element_Re_Loc.VALIDATE("Type No.", "No._Co_Par");
        element_Re_Loc.VALIDATE("Subject No.", SubjectNo_Co_Par);
        element_Re_Loc.VALIDATE("Subject Type", SubjectType_Op_Par);
        element_Re_Loc.VALIDATE(Fee_ID, Fee_ID_Co_Par);
        element_Re_Loc.VALIDATE(Fee_Connection_ID, Fee_Connection_ID_Co_Par);
        element_Re_Loc.Date := Element_Date_Par;
        element_Re_Loc.VALIDATE("Entry No.", EntryNo_Int_Par);
        element_Re_Loc.VALIDATE("Bill-to Customer No.", BillToCustomerNo_Co_Par);
        //START CHG04
        element_Re_Loc."Add DateTime" := CURRENTDATETIME;
        //STOP CHG04
        element_Re_Loc.Period := Period_Da_Par;
        element_Re_Loc."Splitt Index" := SplittIndex_Int_Par;

        IF NOT element_Re_Loc.INSERT() THEN
            ERROR(ERROR_TXT, 'Co_50021', 'FNC_Add_Element()', 'Insertion impossible')
        ELSE BEGIN
            IF Apply_To_Co_Par <> '' THEN
                ElementConnection_Cu.FNC_Add(Deal_ID_Co_Par, element_ID_Ret, Apply_To_Co_Par, Instance_Op_Par, 0);
        END;

        //GRC03 begin add n.client sur chaque element
        FNC_Add_Nclient(Deal_ID_Co_Par);

        //GRC03 end

    end;


    procedure FNC_Set_Element(var element_Re_Par: Record "DEL Element"; element_ID_Co_Par: Code[20])
    begin
        // défini l'instance du premier paramètre sur le record correspondant au Element.ID passé en 2ème paramètre
        // j'ai l'ID de l'Element et je veux faire pointer ma variable sur le record qui correspond à cet ID
        IF NOT element_Re_Par.GET(element_ID_Co_Par) THEN
            ERROR('ERREUR\Source : Co 50021\Fonction : FNC_Set()\Raison : GET() impossible avec Element.ID >%1<', element_ID_Co_Par);
    end;
}

