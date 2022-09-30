codeunit 50022 Position
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 09.09.08                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01  RC4                       09.09.08   Created Doc
    // CHG02                            29.01.09   changer les messages d'erreur par des warnings (message)
    // CHG03                            06.04.09   Adapted various update methods to handle silent update
    //                                  20.04.09   Adapted Postion Insert Function Params
    //                                  02.03.18   Add Currency code vide
    // DEL.SAZ                          29.03.19   Modify Function : FNC_Add_Invoice_Position


    trigger OnRun()
    begin
    end;

    var
        Deal_Cu: Codeunit "50020";
        Element_Cu: Codeunit "50021";
        DealItem_Cu: Codeunit "50024";
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';
        NoSeriesMgt_Cu: Codeunit "396";
        Fee_Cu: Codeunit "50023";
        DealShipment_Cu: Codeunit "50029";
        Setup: Record "50000";
        Currency_Exchange_Re: Record "50028";
        INFORMATION_TXT: Label 'INFORMATION\%1';

    [Scope('Internal')]
    procedure FNC_Add_Positions(Deal_ID_Co_Par: Code[20]; Update_Planned_Bo_Par: Boolean; Update_Silently_Bo_Par: Boolean)
    begin
        /*__
        De manière générale, lorsqu'on insère une position, on doit préciser
        l'item qu'elle concerne. Les données de l'item ne sont définies qu'une
        seule fois à partir de la fiche article au moment de la création du Deal.
        DONC:
        Lorsqu'on créer une nouvelle position, on cherche si l'item est déjà
        présent dans la table "Deal Item". Si oui, on récupère les données à
        partir de cette table, sinon, on l'insère et on prend les infos de la
        fiche article (normalement uniquement lors de la création du Deal).
        __*/

        // INSERER LES "Position" EN FONCTION DES "Element" PLANNED

        //on fait l'update du planifié seulement si on aucun élément réel existe
        IF Update_Planned_Bo_Par THEN BEGIN
            // ACO
            FNC_Add_ACO_Position(Deal_ID_Co_Par); //MESSAGE('POSITION ACO OK');

            // VCO
            FNC_Add_VCO_Position(Deal_ID_Co_Par); //MESSAGE('POSITION VCO OK');

            // FEE
            FNC_Add_Fee_Position(Deal_ID_Co_Par); //MESSAGE('POSITION Fee OK');
        END;

        // INSERER LES "Position" EN FONCTION DES "Element" REAL

        // BR
        //pas besoin d'avoir de positions sur les BR car on les utilise seulement pour
        //calculer des % de sommes à ventiler..
        //FNC_Add_BR_Position(Deal_ID_Co_Par); //MESSAGE('POSITION BR OK');

        //Ajoutes les positions pour les éléments d'instance "Dispatched"
        FNC_Add_Dispatched_Positions(Deal_ID_Co_Par);

        // Invoice
        FNC_Add_Invoice_Position(Deal_ID_Co_Par); //MESSAGE('POSITION Invoice OK');

        // Purchase Invoice
        FNC_Add_PurchInvoice_Position(Deal_ID_Co_Par, Update_Silently_Bo_Par); //MESSAGE('POSITION Purchase Invoice OK');

        // Purchase Credit Notes
        FNC_Add_PurchCrMemo_Position(Deal_ID_Co_Par, Update_Silently_Bo_Par); //MESSAGE('POSITION Credit Notes OK');

        // Sales Invoice
        FNC_Add_SalesInvoice_Position(Deal_ID_Co_Par, Update_Silently_Bo_Par); //MESSAGE('POSITION Sales Invoice OK');

        // Sales Credit Notes
        FNC_Add_SalesCrMemo_Position(Deal_ID_Co_Par, Update_Silently_Bo_Par); //MESSAGE('POSITION Credit Notes OK');

    end;

    [Scope('Internal')]
    procedure FNC_Set_Position(var position_Re_Par: Record "50022"; position_ID_Co_Par: Code[20])
    begin
        // défini l'instance du premier paramètre sur le record correspondant au Position.ID passé en 2ème paramètre
        // p.e. j'ai l'ID de la Position et je veux faire pointer ma variable sur le record qui correspond à cet ID
        IF NOT position_Re_Par.GET(position_ID_Co_Par) THEN
            ERROR('ERREUR\Source :Co 50022\Fonction : FNC_Set_Position()\Raison :GET() impossible avec Position.ID >%1<', position_ID_Co_Par
          );
    end;

    [Scope('Internal')]
    procedure FNC_Insert_Position(Deal_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20]; DealItemNo_Co_Par: Code[20]; Quantity_Dec_Par: Decimal; Currency_Co_Par: Code[10]; Amount_Dec_Par: Decimal; Sub_Element_ID_Co_Par: Code[20]; Rate_Dec_Par: Decimal; CampaignCode_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "50020";
        element_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
        position_ID_Co_Loc: Code[20];
    begin
        /*
        usage :
          FNC_Insert_Position(
            Deal_ID_Co_Par,            //related deal ID
            element_Re_Loc.ID,         //related element ID
            ACO_Line_Re_Loc."No.",     //item no.
            ACO_Line_Re_Loc.Quantity,  //quantity
            itemCurrency_Co_Loc,       //currency
            DealItem_Cu.FNC_Get_Unit_Cost(Deal_ID_Co_Par, ACO_Line_Re_Loc."No.") * -1, //amount
            '', //subelement ID
            Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."Currency Code", 'EUR'), //exchange rate to EUR
            DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, ACO_Line_Re_Loc."No.") //campaign code
          );
        */

        //Deal_Cu.FNC_Set_Deal(deal_Re_Loc, deal_ID_Co_Par);
        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Par);

        Setup.GET();
        position_ID_Co_Loc := NoSeriesMgt_Cu.GetNextNo(Setup."Position Nos.", TODAY, TRUE);

        position_Re_Loc.INIT();

        position_Re_Loc.ID := position_ID_Co_Loc;
        position_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
        position_Re_Loc.VALIDATE(Element_ID, element_Re_Loc.ID);
        position_Re_Loc.VALIDATE(Instance, element_Re_Loc.Instance);
        position_Re_Loc.VALIDATE(position_Re_Loc."Deal Item No.", DealItemNo_Co_Par);
        position_Re_Loc.VALIDATE(Quantity, Quantity_Dec_Par);
        position_Re_Loc.VALIDATE(Currency, Currency_Co_Par);
        position_Re_Loc.VALIDATE(Amount, Amount_Dec_Par);
        position_Re_Loc.VALIDATE("Sub Element_ID", Sub_Element_ID_Co_Par);
        position_Re_Loc.VALIDATE(Rate, Rate_Dec_Par);
        position_Re_Loc."Campaign Code" := CampaignCode_Co_Par;

        position_Re_Loc.INSERT();
        //IF NOT position_Re_Loc.INSERT() THEN
        //  ERROR(ERROR_TXT, 'Co50022', 'FNC_Insert_Position()', 'Insertion impossible dans la table Position');

    end;

    [Scope('Internal')]
    procedure FNC_Delete(Element_ID_Co_Par: Code[20])
    var
        position_Re_Loc: Record "50022";
    begin
        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
        position_Re_Loc.DELETEALL();
    end;

    [Scope('Internal')]
    procedure FNC_Flush(Deal_ID_Co_Par: Code[20])
    var
        position_Re_Loc: Record "50022";
    begin
        // VIDER LES ENREGISTREMENT DE LA TABLE "Position" POUR CE Deal.ID
        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        position_Re_Loc.DELETEALL();
    end;

    [Scope('Internal')]
    procedure FNC_Add_ACO_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        ACO_Re_Loc: Record "38";
        ACO_Line_Re_Loc: Record "39";
        itemCurrency_Co_Loc: Code[10];
        importFromInvoice_Re_Temp: Record "50035" temporary;
        purchInvLine_Re_Loc: Record "123";
        purchInvHeader_Re_Loc: Record "122";
    begin
        //on recherche tous les "Element" de type ACO pour un Deal.ID donné
        //element_Re_Loc.RESET();
        //element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        //element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        //element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);

        //si il y a un ou plusieurs ACO
        Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT
                //On filtre les lignes de chaque ACO
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
                        DealItem_Cu.FNC_Add(Deal_ID_Co_Par, ACO_Line_Re_Loc."No.");

                        //La fonction met à jour seulement si Unit Cost n'a jamais été défini
                        DealItem_Cu.FNC_Update_Unit_Cost(
                          Deal_ID_Co_Par,
                          ACO_Line_Re_Loc."No.",
                          ACO_Line_Re_Loc."Direct Unit Cost",
                          ACO_Line_Re_Loc."Currency Code"
                        );

                        //L'amount pour les ACO doivent être négatif car on s'appauvrit en achetant !

                        itemCurrency_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(Deal_ID_Co_Par, ACO_Line_Re_Loc."No.");

                        //on ajoute une position dans la table position
                        FNC_Insert_Position(
                          Deal_ID_Co_Par,
                          element_Re_Loc.ID,
                          ACO_Line_Re_Loc."No.",
                          ACO_Line_Re_Loc.Quantity,
                          itemCurrency_Co_Loc,
                          DealItem_Cu.FNC_Get_Unit_Cost(Deal_ID_Co_Par, ACO_Line_Re_Loc."No.") * -1,
                          '',
                          Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, ACO_Line_Re_Loc."Currency Code", 'EUR'),
                          DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, ACO_Line_Re_Loc."No.")
                        );

                    UNTIL (ACO_Line_Re_Loc.NEXT = 0)

                /*_Si pas de purchase line, alors on cherche si il y a des invoice line_*/
                ELSE BEGIN

                    //1. Remplir table temporaire à partir du numéro ACO référencé sur les lignes facture achat
                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST THEN
                        REPEAT

                            IF NOT purchInvHeader_Re_Loc.GET(purchInvLine_Re_Loc."Document No.") THEN
                                ERROR(
                                  ERROR_TXT, 'Cu50022', 'FNC_Add_ACO_Position',
                                  STRSUBSTNO('Purch. Inv. >%1< not found', purchInvLine_Re_Loc."Document No.")
                                );

                            importFromInvoice_Re_Temp.INIT();
                            importFromInvoice_Re_Temp."Item No." := purchInvLine_Re_Loc."No.";
                            importFromInvoice_Re_Temp.Quantity := purchInvLine_Re_Loc.Quantity;
                            importFromInvoice_Re_Temp.Amount := purchInvLine_Re_Loc."Unit Cost";
                            importFromInvoice_Re_Temp.Currency := purchInvHeader_Re_Loc."Currency Code";
                            importFromInvoice_Re_Temp.Rate :=
                              Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, purchInvHeader_Re_Loc."Currency Code", 'EUR');

                            IF NOT importFromInvoice_Re_Temp.INSERT() THEN BEGIN
                                IF importFromInvoice_Re_Temp.GET(purchInvLine_Re_Loc."No.") THEN BEGIN
                                    importFromInvoice_Re_Temp.Quantity += purchInvLine_Re_Loc.Quantity;
                                    importFromInvoice_Re_Temp.MODIFY();
                                END;
                            END;

                        UNTIL (purchInvLine_Re_Loc.NEXT() = 0);

                    //2. Lire la table et créer les positions
                    importFromInvoice_Re_Temp.RESET();
                    IF importFromInvoice_Re_Temp.FINDFIRST THEN
                        REPEAT

                            //La fonction ajoute seulement si l'item n'a jamais été enregistré !
                            DealItem_Cu.FNC_Add(Deal_ID_Co_Par, importFromInvoice_Re_Temp."Item No.");

                            //La fonction met à jour seulement si Unit Cost n'a jamais été défini
                            DealItem_Cu.FNC_Update_Unit_Cost(
                              Deal_ID_Co_Par,
                              importFromInvoice_Re_Temp."Item No.",
                              importFromInvoice_Re_Temp.Amount,
                              importFromInvoice_Re_Temp.Currency
                            );

                            //L'amount pour les ACO doivent être négatif car on s'appauvrit en achetant !
                            //on ajoute une position dans la table position
                            FNC_Insert_Position(
                              Deal_ID_Co_Par,
                              element_Re_Loc.ID,
                              importFromInvoice_Re_Temp."Item No.",
                              importFromInvoice_Re_Temp.Quantity,
                              importFromInvoice_Re_Temp.Currency,
                              importFromInvoice_Re_Temp.Amount * -1,
                              '',
                              importFromInvoice_Re_Temp.Rate,
                              DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, importFromInvoice_Re_Temp."Item No.")
                            );

                        UNTIL (importFromInvoice_Re_Temp.NEXT() = 0);

                    //correction 06.11.08
                    importFromInvoice_Re_Temp.DELETEALL();

                END

            UNTIL (element_Re_Loc.NEXT = 0);

    end;

    [Scope('Internal')]
    procedure FNC_Add_VCO_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        VCO_Line_Re_Loc: Record "37";
        itemCurrency_Co_Loc: Code[10];
        elementConnection_Re_Loc: Record "50027";
        ACOElement_Re_Loc: Record "50021";
        salesInvLine_Re_Loc: Record "113";
        salesInvHeader_Re_Loc: Record "112";
        importFromInvoice_Re_Temp: Record "50035" temporary;
    begin
        //on recherche tous les "Element" de type VCO pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                //on cherche à quel ACO la VCO appartient
                elementConnection_Re_Loc.RESET();
                elementConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                IF elementConnection_Re_Loc.FINDFIRST THEN BEGIN

                    Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                    //MESSAGE('%1 applies to %2', element_Re_Loc.ID, elementConnection_Re_Loc."Apply To");

                    //On filtre les lignes de chaque VCO
                    VCO_Line_Re_Loc.RESET();
                    VCO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                    VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                    VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                    VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    //si il y a des lignes sur la VCO et que "Special Order Purchase No." est renseigné alors il s'agit d'une nouvelle VCO
                    //sinon c'est qu'on veut récupérer une vieille VCO et à ce moment là on trouve le renseignement sur le champ "Code Achat"
                    //qui est en fait le "Shortcut dimension 1 Code"
                    IF VCO_Line_Re_Loc.FINDFIRST THEN
                        REPEAT

                            //La fonction ajoute seulement si l'item n'a jamais été enregistré !
                            DealItem_Cu.FNC_Add(
                              Deal_ID_Co_Par,
                              VCO_Line_Re_Loc."No."
                            );

                            //La fonction met à jour seulement si Unit Price n'a jamais été défini
                            DealItem_Cu.FNC_Update_Unit_Price(
                              Deal_ID_Co_Par,
                              VCO_Line_Re_Loc."No.",
                              VCO_Line_Re_Loc."Unit Price",
                              VCO_Line_Re_Loc."Currency Code"
                            );

                            //on ajoute une position dans la table position

                            itemCurrency_Co_Loc := DealItem_Cu.FNC_Get_Currency_Price(Deal_ID_Co_Par, VCO_Line_Re_Loc."No.");

                            FNC_Insert_Position(
                              Deal_ID_Co_Par,
                              element_Re_Loc.ID,
                              VCO_Line_Re_Loc."No.",
                              VCO_Line_Re_Loc.Quantity,
                              itemCurrency_Co_Loc,
                              DealItem_Cu.FNC_Get_Unit_Price(Deal_ID_Co_Par, VCO_Line_Re_Loc."No."),
                              '',
                              Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."Currency Code", 'EUR'),
                              DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, VCO_Line_Re_Loc."No.")
                            );

                        UNTIL (VCO_Line_Re_Loc.NEXT = 0)

                    ELSE BEGIN

                        //On filtre les lignes de chaque VCO
                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETRANGE(VCO_Line_Re_Loc."Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST THEN
                            REPEAT

                                //La fonction ajoute seulement si l'item n'a jamais été enregistré !
                                DealItem_Cu.FNC_Add(
                                  Deal_ID_Co_Par,
                                  VCO_Line_Re_Loc."No."
                                );

                                //La fonction met à jour seulement si Unit Price n'a jamais été défini
                                DealItem_Cu.FNC_Update_Unit_Price(
                                  Deal_ID_Co_Par,
                                  VCO_Line_Re_Loc."No.",
                                  VCO_Line_Re_Loc."Unit Price",
                                  VCO_Line_Re_Loc."Currency Code"
                                );

                                //on ajoute une position dans la table position

                                itemCurrency_Co_Loc := DealItem_Cu.FNC_Get_Currency_Price(Deal_ID_Co_Par, VCO_Line_Re_Loc."No.");

                                FNC_Insert_Position(
                                 Deal_ID_Co_Par,
                                 element_Re_Loc.ID,
                                 VCO_Line_Re_Loc."No.",
                                 VCO_Line_Re_Loc.Quantity,
                                 itemCurrency_Co_Loc,
                                 DealItem_Cu.FNC_Get_Unit_Price(Deal_ID_Co_Par, VCO_Line_Re_Loc."No."),
                                 '',
                                 Currency_Exchange_Re.FNC_Get_Rate(element_Re_Loc.Deal_ID, VCO_Line_Re_Loc."Currency Code", 'EUR'),
                                 DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, VCO_Line_Re_Loc."No.")
                                );

                            UNTIL (VCO_Line_Re_Loc.NEXT = 0)

                        //on cherche encore sur les sales invoices dans le cas ou les vco sont basées sur des vco inexistantes..
                        ELSE BEGIN

                            //1. Remplir table temporaire à partir du numéro VCO référencé sur les lignes facture vente
                            salesInvLine_Re_Loc.RESET();
                            salesInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Order No.");
                            salesInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                            //ajouté filtre sur order no. le 05.11.08
                            salesInvLine_Re_Loc.SETRANGE(Type, salesInvLine_Re_Loc.Type::Item);
                            salesInvLine_Re_Loc.SETRANGE("Order No.", element_Re_Loc."Type No.");
                            salesInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                            IF salesInvLine_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    IF NOT salesInvHeader_Re_Loc.GET(salesInvLine_Re_Loc."Document No.") THEN
                                        ERROR(
                                        ERROR_TXT, 'Cu50022', 'FNC_Add_VCO_Position',
                                        STRSUBSTNO('Purch. Inv. >%1< not found', salesInvLine_Re_Loc."Document No."));

                                    importFromInvoice_Re_Temp.INIT();
                                    importFromInvoice_Re_Temp."Item No." := salesInvLine_Re_Loc."No.";
                                    importFromInvoice_Re_Temp.Quantity := salesInvLine_Re_Loc.Quantity;
                                    importFromInvoice_Re_Temp.Amount := salesInvLine_Re_Loc."Unit Price";
                                    importFromInvoice_Re_Temp.Currency := salesInvHeader_Re_Loc."Currency Code";
                                    importFromInvoice_Re_Temp.Rate :=
                                                                            Currency_Exchange_Re.FNC_Get_Rate(
                                                                              element_Re_Loc.Deal_ID, salesInvHeader_Re_Loc."Currency Code", 'EUR');

                                    //si il y a déjà une ligne pour cet article
                                    IF NOT importFromInvoice_Re_Temp.INSERT() THEN BEGIN
                                        //on n'ajoute pas, on modifie simplement la quantité
                                        IF importFromInvoice_Re_Temp.GET(salesInvLine_Re_Loc."No.") THEN BEGIN
                                            importFromInvoice_Re_Temp.Quantity += salesInvLine_Re_Loc.Quantity;
                                            importFromInvoice_Re_Temp.MODIFY();
                                        END;
                                    END;

                                UNTIL (salesInvLine_Re_Loc.NEXT() = 0);

                            //2. Lire la table et créer les positions
                            importFromInvoice_Re_Temp.RESET();
                            IF importFromInvoice_Re_Temp.FINDFIRST THEN
                                REPEAT

                                    //La fonction ajoute seulement si l'item n'a jamais été enregistré !
                                    DealItem_Cu.FNC_Add(Deal_ID_Co_Par, importFromInvoice_Re_Temp."Item No.");

                                    //La fonction met à jour seulement si Unit Price n'a jamais été défini
                                    DealItem_Cu.FNC_Update_Unit_Price(
                                      Deal_ID_Co_Par,
                                      importFromInvoice_Re_Temp."Item No.",
                                      importFromInvoice_Re_Temp.Amount,
                                      importFromInvoice_Re_Temp.Currency
                                    );

                                    //on ajoute une position dans la table position
                                    FNC_Insert_Position(
                                      Deal_ID_Co_Par,
                                      element_Re_Loc.ID,
                                      importFromInvoice_Re_Temp."Item No.",
                                      importFromInvoice_Re_Temp.Quantity,
                                      importFromInvoice_Re_Temp.Currency,
                                      importFromInvoice_Re_Temp.Amount,
                                      '',
                                      importFromInvoice_Re_Temp.Rate,
                                      DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, importFromInvoice_Re_Temp."Item No.")
                                    );

                                UNTIL (importFromInvoice_Re_Temp.NEXT() = 0);

                            //correction 06.11.08
                            importFromInvoice_Re_Temp.DELETEALL();

                        END

                    END;

                END;

            UNTIL (element_Re_Loc.NEXT = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_Fee_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
    begin
        //on recherche tous les "Element" de type Fee ou Ecriture pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT
                Fee_Cu.FNC_Dispatch(element_Re_Loc.ID);
            UNTIL (element_Re_Loc.NEXT = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_BR_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        BR_Line_Re_Loc: Record "121";
    begin
        /* obsolet
        
        //on recherche tous les "Element" de type BR pour un Deal.ID donné
        element_Re_Loc.reset();
        element_re_loc.setcurrentkey(Deal_ID, Type);
        element_Re_Loc.setrange(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::BR);
        IF element_Re_Loc.FINDfirst THEN
          REPEAT
            //supprimer toutes les positions existantes pour cet element
            FNC_Delete(element_Re_Loc.ID);
        
            //réinsérer chaque position du BR
            BR_Line_Re_Loc.RESET();
            BR_Line_Re_Loc.setrange("Document No.", element_Re_Loc."Type No.");
            IF BR_Line_Re_Loc.FINDfirst THEN
        
              REPEAT
        
                //"Currency Code" est un calc field et il prend sa valeur depuis Purch. Recept. Header..
                BR_Line_Re_Loc.CALCFIELDS("Currency Code");
        
                //on ajoute une position dans la table position
                FNC_Insert_Position(
                  Deal_ID_Co_Par,
                  element_Re_Loc.ID,
                  BR_Line_Re_Loc."No.",
                  BR_Line_Re_Loc.Quantity,
                  BR_Line_Re_Loc."Currency Code",
                  BR_Line_Re_Loc."Unit Cost",
                  '',
                  0
                );
        
              UNTIL(BR_Line_Re_Loc.NEXT() = 0)
            ELSE begin
              //CHG02
              if not Add_Silently_Bo_Par then
                message(INFORMATION_TXT,
                  STRSUBSTNO('Aucunes lignes trouvées pour cette affaire sur le BR No. >%1<', element_Re_Loc."Type No."))
                //error(ERROR_TXT, 'Cu50022', 'FNC_Add_BR_Position', STRSUBSTNO('No Lines on BR No. >%1<', element_Re_Loc."Type No."))
            end;
        
          UNTIL(element_Re_Loc.NEXT=0);
        */

    end;

    [Scope('Internal')]
    procedure FNC_Add_Invoice_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        BR_Line_Re_Loc: Record "121";
        position_Re_Loc: Record "50022";
    begin
        //on recherche tous les "Element" de type Invoice pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Invoice);

        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                //si les positions n'existent pas, on dispatch, sinon on laisse tel quel
                //position_Re_Loc.RESET();
                //position_Re_Loc.setrange(Element_ID, element_Re_Loc.ID);
                //IF NOT position_Re_Loc.FINDfirst THEN BEGIN
                //supprimer toutes les positions existantes pour cet element
                //MESSAGE('Supression de l''élément >%1<', element_Re_Loc.ID);
                FNC_Delete(element_Re_Loc.ID);
                //SAZ 080418 element_Re_Loc.CALCFIELDS(Amount); //NEW DEL.SAZ 29.03.19
                //SAZ 080418  IF element_Re_Loc.Amount <> 0 THEN  //NEW DEL.SAZ 29.03.19

                Fee_Cu.FNC_Dispatch(element_Re_Loc.ID);
                //END //ELSE
                //MESSAGE('INVOICE ALREADY DISPATCHED');

            UNTIL (element_Re_Loc.NEXT() = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_Provision_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        BR_Line_Re_Loc: Record "121";
        position_Re_Loc: Record "50022";
    begin
        /*
        //CHG-DEV-PROVISION
        
        //on recherche tous les "Element" de type Invoice pour un Deal.ID donné
        
        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Provision);
        IF element_Re_Loc.FINDfirst THEN
          REPEAT
        
            //si les positions n'existent pas, on dispatch, sinon on laisse tel quel
            position_Re_Loc.RESET();
            position_Re_Loc.setrange(Element_ID, element_Re_Loc.ID);
            IF NOT position_Re_Loc.FINDfirst THEN BEGIN
              //supprimer toutes les positions existantes pour cet element
              //MESSAGE('Supression de l''élément >%1<', element_Re_Loc.ID);
              FNC_Delete(element_Re_Loc.ID);
        
              Fee_Cu.FNC_Dispatch(element_Re_Loc.ID);
            END //ELSE
              //MESSAGE('INVOICE ALREADY DISPATCHED');
        
          UNTIL(element_Re_Loc.NEXT() = 0);
        */

    end;

    [Scope('Internal')]
    procedure FNC_Add_PurchInvoice_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        purchInvHeader_Re_Loc: Record "122";
        purchInv_Line_Re_Loc: Record "123";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
        position_Re_Loc: Record "50022";
        currExRate_Re_loc: Record "330";
        ACOElement_Re_Loc: Record "50021";
    begin
        //on recherche tous les "Element" de type Purchase Invoice pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                //on cherche à quel ACO la sales invoice appartient
                //ACOElement_Re_Loc.RESET();
                //ACOElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                //ACOElement_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                //ACOElement_Re_Loc.SETRANGE(Type, ACOElement_Re_Loc.Type::ACO);

                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST THEN BEGIN

                    //si les positions n'existent pas, on dispatch, sinon on laisse tel quel
                    //position_Re_Loc.RESET();
                    //position_Re_Loc.setrange(Element_ID, element_Re_Loc.ID);
                    //IF NOT position_Re_Loc.FINDfirst THEN BEGIN

                    //supprimer toutes les positions existantes pour cet element
                    FNC_Delete(element_Re_Loc.ID);

                    //réinsérer chaque position
                    purchInv_Line_Re_Loc.RESET();
                    purchInv_Line_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    purchInv_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    purchInv_Line_Re_Loc.SETRANGE(Type, purchInv_Line_Re_Loc.Type::Item);
                    purchInv_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInv_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInv_Line_Re_Loc.FINDFIRST THEN
                        REPEAT
                            purchInvHeader_Re_Loc.GET(purchInv_Line_Re_Loc."Document No.");
                            currency_Co_Loc := purchInvHeader_Re_Loc."Currency Code";
                            IF currency_Co_Loc = 'EUR' THEN
                                currencyRate_Dec_Loc := 1
                            ELSE
                                currencyRate_Dec_Loc :=
                                    (1 / purchInvHeader_Re_Loc."Currency Factor") *
                                    currExRate_Re_loc.ExchangeRate(purchInvHeader_Re_Loc."Posting Date", 'EUR');

                            //on ajoute une position dans la table position
                            FNC_Insert_Position(
                              Deal_ID_Co_Par,
                              element_Re_Loc.ID,
                              purchInv_Line_Re_Loc."No.",
                              purchInv_Line_Re_Loc.Quantity,
                              currency_Co_Loc,
                              purchInv_Line_Re_Loc."Direct Unit Cost" * -1,
                              '',
                              currencyRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, purchInv_Line_Re_Loc."No.")
                            );
                        UNTIL (purchInv_Line_Re_Loc.NEXT() = 0)

                    ELSE BEGIN
                        //CHG02
                        IF NOT Add_Silently_Bo_Par THEN
                            MESSAGE(INFORMATION_TXT,
                            STRSUBSTNO('Aucunes lignes trouvées pour cette affaire sur Purchase Header No. >%1<', element_Re_Loc."Type No."));
                        //ERROR(ERROR_TXT, 'Cu50022', 'FNC_Add_PurchInvoice_Position',
                        //STRSUBSTNO('No Lines on Purchase Header No. >%1<', element_Re_Loc."Type No."));
                    END;

                    //END //ELSE
                    //MESSAGE('PURCHASE INVOICE ALREADY DISPATCHED');

                END;

            UNTIL (element_Re_Loc.NEXT = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_PurchCrMemo_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        ACOElement_Re_Loc: Record "50021";
        purchCreditMemoLine_Re_Loc: Record "125";
        purchCreditMemoHeader_Re_Loc: Record "124";
        currExRate_Re_loc: Record "330";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
    begin
        //on recherche tous les "Element" de type Credit Notes pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purch. Cr. Memo");
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                //on cherche à quel ACO la sales invoice appartient
                //ACOElement_Re_Loc.RESET();
                //ACOElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                //ACOElement_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                //ACOElement_Re_Loc.SETRANGE(Type, ACOElement_Re_Loc.Type::ACO);

                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST THEN BEGIN

                    //si les positions n'existent pas, on dispatch, sinon on laisse tel quel
                    //position_Re_Loc.RESET();
                    //position_Re_Loc.setrange(Element_ID, element_Re_Loc.ID);
                    //IF NOT position_Re_Loc.FINDfirst THEN BEGIN

                    //supprimer toutes les positions existantes pour cet element
                    FNC_Delete(element_Re_Loc.ID);

                    //réinsérer chaque position
                    purchCreditMemoLine_Re_Loc.RESET();
                    purchCreditMemoLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    purchCreditMemoLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    purchCreditMemoLine_Re_Loc.SETRANGE(Type, purchCreditMemoLine_Re_Loc.Type::Item);
                    purchCreditMemoLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchCreditMemoLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchCreditMemoLine_Re_Loc.FINDFIRST THEN
                        REPEAT
                            purchCreditMemoHeader_Re_Loc.GET(purchCreditMemoLine_Re_Loc."Document No.");
                            currency_Co_Loc := purchCreditMemoHeader_Re_Loc."Currency Code";
                            IF currency_Co_Loc = 'EUR' THEN
                                currencyRate_Dec_Loc := 1
                            ELSE
                                currencyRate_Dec_Loc :=
                                    (1 / purchCreditMemoHeader_Re_Loc."Currency Factor") *
                                    currExRate_Re_loc.ExchangeRate(purchCreditMemoHeader_Re_Loc."Posting Date", 'EUR');

                            //on ajoute une position dans la table position
                            FNC_Insert_Position(
                              Deal_ID_Co_Par,
                              element_Re_Loc.ID,
                              purchCreditMemoLine_Re_Loc."No.",
                              purchCreditMemoLine_Re_Loc.Quantity,
                              currency_Co_Loc,
                              purchCreditMemoLine_Re_Loc."Direct Unit Cost",
                              '',
                              currencyRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, purchCreditMemoLine_Re_Loc."No.")
                            );
                        UNTIL (purchCreditMemoLine_Re_Loc.NEXT() = 0)

                    ELSE BEGIN
                        //CHG02
                        IF NOT Add_Silently_Bo_Par THEN
                            MESSAGE(INFORMATION_TXT,
                              STRSUBSTNO('Aucunes lignes trouvées pour cette affaire sur' +
                               ' la note de crédit achat No. >%1<', element_Re_Loc."Type No."));
                        //ERROR(ERROR_TXT, 'Cu50022', 'FNC_Add_PurchCrMemo_Position',
                        //STRSUBSTNO('No Lines on purch Credit Memo Header No. ><', element_Re_Loc."Type No."));
                    END;
                    //END //ELSE
                    //MESSAGE('purch INVOICE ALREADY DISPATCHED');

                END

            UNTIL (element_Re_Loc.NEXT = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_SalesInvoice_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        salesInvHeader_Re_Loc: Record "112";
        salesInv_Line_Re_Loc: Record "113";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
        position_Re_Loc: Record "50022";
        currExRate_Re_loc: Record "330";
        ACOElement_Re_Loc: Record "50021";
    begin
        //on recherche tous les "Element" de type Sales Invoice pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Invoice");
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                //on cherche à quel ACO la sales invoice appartient
                //ACOElement_Re_Loc.RESET();
                //ACOElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                //ACOElement_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                //ACOElement_Re_Loc.SETRANGE(Type, ACOElement_Re_Loc.Type::ACO);

                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST THEN BEGIN

                    //si les positions n'existent pas, on dispatch, sinon on laisse tel quel
                    //position_Re_Loc.RESET();
                    //position_Re_Loc.setrange(Element_ID, element_Re_Loc.ID);
                    //IF NOT position_Re_Loc.FINDfirst THEN BEGIN

                    //supprimer toutes les positions existantes pour cet element
                    FNC_Delete(element_Re_Loc.ID);

                    //réinsérer chaque position
                    salesInv_Line_Re_Loc.RESET();
                    salesInv_Line_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    salesInv_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    salesInv_Line_Re_Loc.SETRANGE(Type, salesInv_Line_Re_Loc.Type::Item);
                    salesInv_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    salesInv_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF salesInv_Line_Re_Loc.FINDFIRST THEN
                        REPEAT
                            salesInvHeader_Re_Loc.GET(salesInv_Line_Re_Loc."Document No.");
                            currency_Co_Loc := salesInvHeader_Re_Loc."Currency Code";
                            IF (currency_Co_Loc = 'EUR')
                              //THM020318 START
                              OR (currency_Co_Loc = '') THEN
                                //THM020318 END
                                currencyRate_Dec_Loc := 1
                            ELSE
                                currencyRate_Dec_Loc :=
                                    (1 / salesInvHeader_Re_Loc."Currency Factor") *
                                    currExRate_Re_loc.ExchangeRate(salesInvHeader_Re_Loc."Posting Date", 'EUR');

                            //on ajoute une position dans la table position
                            FNC_Insert_Position(
                              Deal_ID_Co_Par,
                              element_Re_Loc.ID,
                              salesInv_Line_Re_Loc."No.",
                              salesInv_Line_Re_Loc.Quantity,
                              currency_Co_Loc,
                              salesInv_Line_Re_Loc."Unit Price",
                              '',
                              currencyRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, salesInv_Line_Re_Loc."No.")
                            );
                        UNTIL (salesInv_Line_Re_Loc.NEXT() = 0)

                    ELSE BEGIN
                        //CHG02
                        IF NOT Add_Silently_Bo_Par THEN
                            MESSAGE(INFORMATION_TXT,
                              STRSUBSTNO('La facture No. >%1< n''a pas de lignes concernant cette affaire', element_Re_Loc."Type No."));
                        //ERROR(ERROR_TXT, 'Cu50022', 'FNC_Add_SalesInvoice_Position',
                        //STRSUBSTNO('No Lines on Sales Header No. >%1<', element_Re_Loc."Type No."));
                    END;
                    //END //ELSE
                    //MESSAGE('SALES INVOICE ALREADY DISPATCHED');

                END

            UNTIL (element_Re_Loc.NEXT = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_SalesCrMemo_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "50021";
        ACOElement_Re_Loc: Record "50021";
        salesCreditMemoLine_Re_Loc: Record "115";
        salesCreditMemoHeader_Re_Loc: Record "114";
        currExRate_Re_loc: Record "330";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
    begin
        //on recherche tous les "Element" de type Credit Notes pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Cr. Memo");
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                //on cherche à quel ACO la sales invoice appartient
                //ACOElement_Re_Loc.RESET();
                //ACOElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                //ACOElement_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                //ACOElement_Re_Loc.SETRANGE(Type, ACOElement_Re_Loc.Type::ACO);

                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST THEN BEGIN

                    //si les positions n'existent pas, on dispatch, sinon on laisse tel quel
                    //position_Re_Loc.RESET();
                    //position_Re_Loc.setrange(Element_ID, element_Re_Loc.ID);
                    //IF NOT position_Re_Loc.FINDfirst THEN BEGIN

                    //supprimer toutes les positions existantes pour cet element
                    FNC_Delete(element_Re_Loc.ID);

                    //réinsérer chaque position
                    salesCreditMemoLine_Re_Loc.RESET();
                    salesCreditMemoLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    salesCreditMemoLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    salesCreditMemoLine_Re_Loc.SETRANGE(Type, salesCreditMemoLine_Re_Loc.Type::Item);
                    salesCreditMemoLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    salesCreditMemoLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF salesCreditMemoLine_Re_Loc.FINDFIRST THEN
                        REPEAT
                            salesCreditMemoHeader_Re_Loc.GET(salesCreditMemoLine_Re_Loc."Document No.");
                            currency_Co_Loc := salesCreditMemoHeader_Re_Loc."Currency Code";
                            IF currency_Co_Loc = 'EUR' THEN
                                currencyRate_Dec_Loc := 1
                            ELSE
                                currencyRate_Dec_Loc :=
                                    (1 / salesCreditMemoHeader_Re_Loc."Currency Factor") *
                                    currExRate_Re_loc.ExchangeRate(salesCreditMemoHeader_Re_Loc."Posting Date", 'EUR');

                            //on ajoute une position dans la table position
                            FNC_Insert_Position(
                              Deal_ID_Co_Par,
                              element_Re_Loc.ID,
                              salesCreditMemoLine_Re_Loc."No.",
                              salesCreditMemoLine_Re_Loc.Quantity,
                              currency_Co_Loc,
                              salesCreditMemoLine_Re_Loc."Unit Price" * -1, //on fait crédit, donc on s'appauvrit
                              '',
                              currencyRate_Dec_Loc,
                              DealItem_Cu.FNC_Get_Campaign_Code(Deal_ID_Co_Par, salesCreditMemoLine_Re_Loc."No.")
                            );
                        UNTIL (salesCreditMemoLine_Re_Loc.NEXT() = 0)

                    ELSE BEGIN
                        //CHG02
                        IF NOT Add_Silently_Bo_Par THEN
                            MESSAGE(INFORMATION_TXT,
                              STRSUBSTNO('Aucunes lignes trouvées pour cette affaire sur' +
                              ' la note de crédit vente No. >%1<', element_Re_Loc."Type No."));
                        //ERROR(ERROR_TXT, 'Cu50022', 'FNC_Add_SalesCreditMemo_Position',
                        //STRSUBSTNO('No Lines on Sales Credit Memo Header No. >%1<', element_Re_Loc."Type No."));
                    END
                    //END //ELSE
                    //MESSAGE('SALES INVOICE ALREADY DISPATCHED');

                END

            UNTIL (element_Re_Loc.NEXT = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_Dispatched_Positions(DealID_Co_Par: Code[20])
    var
        ds_Re_Loc: Record "50030";
        dsc_Re_Loc: Record "50032";
        element_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
        feeElement_Re_Loc: Record "50021";
    begin
        //Pour les livraisons de l'affaire qui ont un BR
        ds_Re_Loc.RESET();
        ds_Re_Loc.SETRANGE(Deal_ID, DealID_Co_Par);
        ds_Re_Loc.SETFILTER("BR No.", '<>%1', '');
        IF ds_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                //pour les éléments liés à cette livraison
                dsc_Re_Loc.RESET();
                dsc_Re_Loc.SETRANGE(Deal_ID, ds_Re_Loc.Deal_ID);
                dsc_Re_Loc.SETRANGE(Shipment_ID, ds_Re_Loc.ID);
                IF dsc_Re_Loc.FINDFIRST THEN
                    REPEAT

                        Element_Cu.FNC_Set_Element(element_Re_Loc, dsc_Re_Loc.Element_ID);

                        //si c'est une ACO répartie
                        IF (
                          (element_Re_Loc.Instance = element_Re_Loc.Instance::dispatched) AND
                          (element_Re_Loc.Type = element_Re_Loc.Type::ACO)
                        ) THEN BEGIN

                            //si aucune position n'existe pour cet élément, alors on crée
                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                            IF NOT position_Re_Loc.FINDFIRST THEN
                                FNC_Add_DispatchedACO_Position(dsc_Re_Loc.Deal_ID, ds_Re_Loc."BR No.", element_Re_Loc.ID);

                            //sinon si c'est une VCO répartie
                        END ELSE
                            IF (
                     (element_Re_Loc.Instance = element_Re_Loc.Instance::dispatched) AND
                     (element_Re_Loc.Type = element_Re_Loc.Type::VCO)
                   ) THEN BEGIN

                                //si aucune position n'existe pour cet élément, alors on crée
                                position_Re_Loc.RESET();
                                position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                                IF NOT position_Re_Loc.FINDFIRST THEN
                                    FNC_Add_DispatchedVCO_Position(dsc_Re_Loc.Deal_ID, ds_Re_Loc."BR No.", element_Re_Loc.ID);

                                //sinon si c'est un Fee réparti
                            END ELSE
                                IF (
                         (element_Re_Loc.Instance = element_Re_Loc.Instance::dispatched) AND
                         (element_Re_Loc.Type = element_Re_Loc.Type::Fee)
                       ) THEN BEGIN

                                    //on cherche le planned fee orginial
                                    feeElement_Re_Loc.RESET();
                                    feeElement_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                                    feeElement_Re_Loc.SETRANGE(Type, feeElement_Re_Loc.Type::Fee);
                                    feeElement_Re_Loc.SETRANGE(Instance, feeElement_Re_Loc.Instance::planned);
                                    feeElement_Re_Loc.SETRANGE(Fee_ID, element_Re_Loc.Fee_ID);
                                    feeElement_Re_Loc.SETRANGE(Fee_Connection_ID, element_Re_Loc.Fee_Connection_ID);
                                    IF feeElement_Re_Loc.FINDFIRST THEN BEGIN

                                        //si aucune position n'existe pour cet élément, alors on crée
                                        position_Re_Loc.RESET();
                                        position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                                        IF NOT position_Re_Loc.FINDFIRST THEN
                                            FNC_Add_DispatchedFee_Position(dsc_Re_Loc.Deal_ID, ds_Re_Loc."BR No.", element_Re_Loc.ID, feeElement_Re_Loc.ID);

                                    END

                                END;

                    UNTIL (dsc_Re_Loc.NEXT() = 0);

            UNTIL (ds_Re_Loc.NEXT() = 0);

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Add_DispatchedACO_Position(DealID_Co_Par: Code[20]; BRNo_Co_Par: Code[20]; ElementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        purchRcptLine_Re_Loc: Record "121";
        BRNo_Co: Code[20];
        qty_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
    begin
        /*_
        Cette fonction n'est pas prévue pour être appelée pendant une réinitialisation d'affaire.
        Elle est appelée lorsqu'un BR est ajouté à l'affaire et uniquement à ce moment là.
        _*/

        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST THEN
            REPEAT
                qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(DealID_Co_Par, curr_Co_Loc, 'EUR');
                //Amount_Dec_Ret := qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;

                FNC_Insert_Position(
                  DealID_Co_Par,
                  ElementID_Co_Par,
                  purchRcptLine_Re_Loc."No.",
                  qty_Dec_Loc,
                  curr_Co_Loc,
                  amount_Dec_Loc * -1,
                  '', //subelement ID
                  rate_Dec_Loc,
                  DealItem_Cu.FNC_Get_Campaign_Code(DealID_Co_Par, purchRcptLine_Re_Loc."No.")
                );

            UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

    end;

    [Scope('Internal')]
    procedure FNC_Add_DispatchedVCO_Position(DealID_Co_Par: Code[20]; BRNo_Co_Par: Code[20]; ElementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        purchRcptLine_Re_Loc: Record "121";
        BRNo_Co: Code[20];
        qty_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
    begin
        //On se base sur les quantités des BR et les PRIX (vente) prévus

        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST THEN
            REPEAT
                qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Price(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(DealID_Co_Par, curr_Co_Loc, 'EUR');
                //Amount_Dec_Ret := qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;

                FNC_Insert_Position(
                  DealID_Co_Par,
                  ElementID_Co_Par,
                  purchRcptLine_Re_Loc."No.",
                  qty_Dec_Loc,
                  curr_Co_Loc,
                  amount_Dec_Loc,
                  '', //subelement ID
                  rate_Dec_Loc,
                  DealItem_Cu.FNC_Get_Campaign_Code(DealID_Co_Par, purchRcptLine_Re_Loc."No.")
                );

            UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Add_DispatchedFee_Position(DealID_Co_Par: Code[20]; BRNo_Co_Par: Code[20]; ElementID_Co_Par: Code[20]; FeeElementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "50021";
        purchRcptLine_Re_Loc: Record "121";
        position_Re_Loc: Record "50022";
        BRNo_Co: Code[20];
        qty_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        feeElement_Re_Loc: Record "50021";
    begin
        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST THEN
            REPEAT

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Element_ID, FeeElementID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");
                IF position_Re_Loc.FINDFIRST THEN
                    REPEAT

                        qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                        amount_Dec_Loc := position_Re_Loc.Amount;
                        curr_Co_Loc := position_Re_Loc.Currency;
                        rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(DealID_Co_Par, curr_Co_Loc, 'EUR');

                        FNC_Insert_Position(
                          DealID_Co_Par,
                          ElementID_Co_Par,
                          position_Re_Loc."Deal Item No.",
                          qty_Dec_Loc,
                          curr_Co_Loc,
                          amount_Dec_Loc,
                          '', //subelement ID
                          rate_Dec_Loc,
                          DealItem_Cu.FNC_Get_Campaign_Code(DealID_Co_Par, purchRcptLine_Re_Loc."No.")
                        );

                    UNTIL (position_Re_Loc.NEXT() = 0);

            UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);
    end;

    [Scope('Internal')]
    procedure FNC_Get_Amount(Position_ID_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "50022";
        curr_Re_Loc: Record "50028";
    begin
        /*RETOURNE LE MONTANT D'UNE POSITION EN EURO*/

        //définir la position en cours
        FNC_Set_Position(position_Re_Loc, Position_ID_Co_Par);

        //calcul du prix de la ligne en devise de la ligne
        Amount_Dec_Ret := FNC_Get_Raw_Amount(Position_ID_Co_Par);

        //conversion en euro si la devise est pas déjà l'euro
        Amount_Dec_Ret *= position_Re_Loc.Rate;

    end;

    [Scope('Internal')]
    procedure FNC_Get_Raw_Amount(Position_ID_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "50022";
        curr_Re_Loc: Record "50028";
    begin
        /*RETOURNE LE MONTANT D'UNE POSITION EN DEVISE DE LA POSITION*/

        //définir la position en cours
        FNC_Set_Position(position_Re_Loc, Position_ID_Co_Par);

        //calcul du prix de la ligne en devise de la ligne
        Amount_Dec_Ret := position_Re_Loc.Quantity * position_Re_Loc.Amount;

    end;
}

