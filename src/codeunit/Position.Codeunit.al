codeunit 50022 "DEL Position"
{
    trigger OnRun()
    begin
    end;

    var
        Deal_Cu: Codeunit "DEL Deal";
        Element_Cu: Codeunit "DEL Element";
        DealItem_Cu: Codeunit "DEL Deal Item";
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';
        NoSeriesMgt_Cu: Codeunit NoSeriesManagement;
        Fee_Cu: Codeunit "DEL Fee";
        DealShipment_Cu: Codeunit "DEL Deal Shipment";
        Setup: Record "DEL General Setup";
        Currency_Exchange_Re: Record "DEL Currency Exchange";
        INFORMATION_TXT: Label 'INFORMATION\%1';


    procedure FNC_Add_Positions(Deal_ID_Co_Par: Code[20]; Update_Planned_Bo_Par: Boolean; Update_Silently_Bo_Par: Boolean)
    begin
        IF Update_Planned_Bo_Par THEN BEGIN
            // ACO
            FNC_Add_ACO_Position(Deal_ID_Co_Par); //MESSAGE('POSITION ACO OK');

            // VCO
            FNC_Add_VCO_Position(Deal_ID_Co_Par); //MESSAGE('POSITION VCO OK');

            // FEE
            FNC_Add_Fee_Position(Deal_ID_Co_Par); //MESSAGE('POSITION Fee OK');
        END;

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


    procedure FNC_Set_Position(var position_Re_Par: Record "DEL Position"; position_ID_Co_Par: Code[20])
    begin
        IF NOT position_Re_Par.GET(position_ID_Co_Par) THEN
            ERROR('ERREUR\Source :Co 50022\Fonction : FNC_Set_Position()\Raison :GET() impossible avec Position.ID >%1<', position_ID_Co_Par
          );
    end;


    procedure FNC_Insert_Position(Deal_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20]; DealItemNo_Co_Par: Code[20]; Quantity_Dec_Par: Decimal; Currency_Co_Par: Code[10]; Amount_Dec_Par: Decimal; Sub_Element_ID_Co_Par: Code[20]; Rate_Dec_Par: Decimal; CampaignCode_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "DEL Deal";
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        position_ID_Co_Loc: Code[20];
    begin
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

    end;


    procedure FNC_Delete(Element_ID_Co_Par: Code[20])
    var
        position_Re_Loc: Record "DEL Position";
    begin
        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
        position_Re_Loc.DELETEALL();
    end;


    procedure FNC_Flush(Deal_ID_Co_Par: Code[20])
    var
        position_Re_Loc: Record "DEL Position";
    begin
        // VIDER LES ENREGISTREMENT DE LA TABLE "Position" POUR CE Deal.ID
        position_Re_Loc.RESET();
        position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        position_Re_Loc.DELETEALL();
    end;


    procedure FNC_Add_ACO_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        ACO_Re_Loc: Record "Purchase Header";
        ACO_Line_Re_Loc: Record "Purchase Line";
        itemCurrency_Co_Loc: Code[10];
        importFromInvoice_Re_Temp: Record "DEL Import From Invoice" temporary;
        purchInvLine_Re_Loc: Record "Purch. Inv. Line";
        purchInvHeader_Re_Loc: Record "Purch. Inv. Header";
    begin
        Deal_Cu.FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT
                //On filtre les lignes de chaque ACO
                ACO_Line_Re_Loc.RESET();
                ACO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                ACO_Line_Re_Loc.SETRANGE("Document Type", ACO_Line_Re_Loc."Document Type"::Order);
                ACO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                ACO_Line_Re_Loc.SETRANGE(Type, ACO_Line_Re_Loc.Type::Item);
                ACO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                //si il y a des lignes sur l'ACO
                IF ACO_Line_Re_Loc.FINDFIRST() THEN
                    REPEAT
                        DealItem_Cu.FNC_Add(Deal_ID_Co_Par, ACO_Line_Re_Loc."No.");

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

                    UNTIL (ACO_Line_Re_Loc.NEXT() = 0)

                ELSE BEGIN

                    purchInvLine_Re_Loc.RESET();
                    purchInvLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    purchInvLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", element_Re_Loc."Type No.");
                    purchInvLine_Re_Loc.SETRANGE(Type, purchInvLine_Re_Loc.Type::Item);
                    purchInvLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInvLine_Re_Loc.FINDFIRST() THEN
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
                    IF importFromInvoice_Re_Temp.FINDFIRST() THEN
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

            UNTIL (element_Re_Loc.NEXT() = 0);

    end;


    procedure FNC_Add_VCO_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        VCO_Line_Re_Loc: Record "Sales Line";
        itemCurrency_Co_Loc: Code[10];
        elementConnection_Re_Loc: Record "DEL Element Connection";
        ACOElement_Re_Loc: Record "DEL Element";
        salesInvLine_Re_Loc: Record "Sales Invoice Line";
        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
        importFromInvoice_Re_Temp: Record "DEL Import From Invoice" temporary;
    begin


        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT

                elementConnection_Re_Loc.RESET();
                elementConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

                IF elementConnection_Re_Loc.FINDFIRST() THEN BEGIN

                    Element_Cu.FNC_Set_Element(ACOElement_Re_Loc, elementConnection_Re_Loc."Apply To");

                    VCO_Line_Re_Loc.RESET();
                    VCO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                    VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                    VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                    VCO_Line_Re_Loc.SETRANGE("Special Order Purchase No.", ACOElement_Re_Loc."Type No.");
                    VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF VCO_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT

                            //La fonction ajoute seulement si l'item n'a jamais été enregistré !
                            DealItem_Cu.FNC_Add(
                              Deal_ID_Co_Par,
                              VCO_Line_Re_Loc."No."
                            );

                            DealItem_Cu.FNC_Update_Unit_Price(
                              Deal_ID_Co_Par,
                              VCO_Line_Re_Loc."No.",
                              VCO_Line_Re_Loc."Unit Price",
                              VCO_Line_Re_Loc."Currency Code"
                            );


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

                        UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

                    ELSE BEGIN

                        //On filtre les lignes de chaque VCO
                        VCO_Line_Re_Loc.RESET();
                        VCO_Line_Re_Loc.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
                        VCO_Line_Re_Loc.SETRANGE("Document Type", VCO_Line_Re_Loc."Document Type"::Order);
                        VCO_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETRANGE(Type, VCO_Line_Re_Loc.Type::Item);
                        VCO_Line_Re_Loc.SETRANGE(VCO_Line_Re_Loc."Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                        VCO_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                        IF VCO_Line_Re_Loc.FINDFIRST() THEN
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

                            UNTIL (VCO_Line_Re_Loc.NEXT() = 0)

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
                            IF salesInvLine_Re_Loc.FINDFIRST() THEN
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
                            IF importFromInvoice_Re_Temp.FINDFIRST() THEN
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

            UNTIL (element_Re_Loc.NEXT() = 0);
    end;


    procedure FNC_Add_Fee_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
    begin
        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT
                Fee_Cu.FNC_Dispatch(element_Re_Loc.ID);
            UNTIL (element_Re_Loc.NEXT() = 0);
    end;


    procedure FNC_Add_BR_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "DEL Element";
        BR_Line_Re_Loc: Record "Purch. Rcpt. Line";
    begin

    end;


    procedure FNC_Add_Invoice_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        BR_Line_Re_Loc: Record "Purch. Rcpt. Line";
        position_Re_Loc: Record "DEL Position";
    begin
        //on recherche tous les "Element" de type Invoice pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Invoice);

        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT
                FNC_Delete(element_Re_Loc.ID);

                Fee_Cu.FNC_Dispatch(element_Re_Loc.ID);

            UNTIL (element_Re_Loc.NEXT() = 0);
    end;


    procedure FNC_Add_Provision_Position(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        BR_Line_Re_Loc: Record "Purch. Rcpt. Line";
        position_Re_Loc: Record "DEL Position";
    begin

    end;


    procedure FNC_Add_PurchInvoice_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "DEL Element";
        purchInvHeader_Re_Loc: Record "Purch. Inv. Header";
        purchInv_Line_Re_Loc: Record "Purch. Inv. Line";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
        position_Re_Loc: Record "DEL Position";
        currExRate_Re_loc: Record "Currency Exchange Rate";
        ACOElement_Re_Loc: Record "DEL Element";
    begin
        //on recherche tous les "Element" de type Purchase Invoice pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT
                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST() THEN BEGIN
                    FNC_Delete(element_Re_Loc.ID);

                    purchInv_Line_Re_Loc.RESET();
                    purchInv_Line_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    purchInv_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    purchInv_Line_Re_Loc.SETRANGE(Type, purchInv_Line_Re_Loc.Type::Item);
                    purchInv_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchInv_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchInv_Line_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            purchInvHeader_Re_Loc.GET(purchInv_Line_Re_Loc."Document No.");
                            currency_Co_Loc := purchInvHeader_Re_Loc."Currency Code";
                            IF currency_Co_Loc = 'EUR' THEN
                                currencyRate_Dec_Loc := 1
                            ELSE
                                currencyRate_Dec_Loc :=
                                    (1 / purchInvHeader_Re_Loc."Currency Factor") *
                                    currExRate_Re_loc.ExchangeRate(purchInvHeader_Re_Loc."Posting Date", 'EUR');

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
                    END;


                END;

            UNTIL (element_Re_Loc.NEXT() = 0);
    end;


    procedure FNC_Add_PurchCrMemo_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "DEL Element";
        ACOElement_Re_Loc: Record "DEL Element";
        purchCreditMemoLine_Re_Loc: Record "Purch. Cr. Memo Line";
        purchCreditMemoHeader_Re_Loc: Record "Purch. Cr. Memo Hdr.";
        currExRate_Re_loc: Record "Currency Exchange Rate";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
    begin

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purch. Cr. Memo");
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT


                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST() THEN BEGIN

                    FNC_Delete(element_Re_Loc.ID);

                    purchCreditMemoLine_Re_Loc.RESET();
                    purchCreditMemoLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    purchCreditMemoLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    purchCreditMemoLine_Re_Loc.SETRANGE(Type, purchCreditMemoLine_Re_Loc.Type::Item);
                    purchCreditMemoLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    purchCreditMemoLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF purchCreditMemoLine_Re_Loc.FINDFIRST() THEN
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
                    END;

                END

            UNTIL (element_Re_Loc.NEXT() = 0);
    end;


    procedure FNC_Add_SalesInvoice_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "DEL Element";
        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
        salesInv_Line_Re_Loc: Record "Sales Invoice Line";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
        position_Re_Loc: Record "DEL Position";
        currExRate_Re_loc: Record "Currency Exchange Rate";
        ACOElement_Re_Loc: Record "DEL Element";
    begin
        //on recherche tous les "Element" de type Sales Invoice pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Invoice");
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT

                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST() THEN BEGIN

                    FNC_Delete(element_Re_Loc.ID);

                    salesInv_Line_Re_Loc.RESET();
                    salesInv_Line_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    salesInv_Line_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    salesInv_Line_Re_Loc.SETRANGE(Type, salesInv_Line_Re_Loc.Type::Item);
                    salesInv_Line_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    salesInv_Line_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF salesInv_Line_Re_Loc.FINDFIRST() THEN
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
                    END;

                END

            UNTIL (element_Re_Loc.NEXT() = 0);
    end;


    procedure FNC_Add_SalesCrMemo_Position(Deal_ID_Co_Par: Code[20]; Add_Silently_Bo_Par: Boolean)
    var
        element_Re_Loc: Record "DEL Element";
        ACOElement_Re_Loc: Record "DEL Element";
        salesCreditMemoLine_Re_Loc: Record "Sales Cr.Memo Line";
        salesCreditMemoHeader_Re_Loc: Record "Sales Cr.Memo Header";
        currExRate_Re_loc: Record "Currency Exchange Rate";
        currency_Co_Loc: Code[10];
        currencyRate_Dec_Loc: Decimal;
    begin
        //on recherche tous les "Element" de type Credit Notes pour un Deal.ID donné

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Cr. Memo");
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT
                Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, element_Re_Loc.Deal_ID);
                IF ACOElement_Re_Loc.FINDFIRST() THEN BEGIN

                    FNC_Delete(element_Re_Loc.ID);

                    salesCreditMemoLine_Re_Loc.RESET();
                    salesCreditMemoLine_Re_Loc.SETCURRENTKEY("Shortcut Dimension 1 Code", Type, "Document No.");
                    salesCreditMemoLine_Re_Loc.SETRANGE("Shortcut Dimension 1 Code", ACOElement_Re_Loc."Type No.");
                    salesCreditMemoLine_Re_Loc.SETRANGE(Type, salesCreditMemoLine_Re_Loc.Type::Item);
                    salesCreditMemoLine_Re_Loc.SETRANGE("Document No.", element_Re_Loc."Type No.");
                    salesCreditMemoLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
                    IF salesCreditMemoLine_Re_Loc.FINDFIRST() THEN
                        REPEAT
                            salesCreditMemoHeader_Re_Loc.GET(salesCreditMemoLine_Re_Loc."Document No.");
                            currency_Co_Loc := salesCreditMemoHeader_Re_Loc."Currency Code";
                            IF currency_Co_Loc = 'EUR' THEN
                                currencyRate_Dec_Loc := 1
                            ELSE
                                currencyRate_Dec_Loc :=
                                    (1 / salesCreditMemoHeader_Re_Loc."Currency Factor") *
                                    currExRate_Re_loc.ExchangeRate(salesCreditMemoHeader_Re_Loc."Posting Date", 'EUR');

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
                    END

                END

            UNTIL (element_Re_Loc.NEXT() = 0);
    end;


    procedure FNC_Add_Dispatched_Positions(DealID_Co_Par: Code[20])
    var

        ds_Re_Loc: Record "DEL Deal Shipment";
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        feeElement_Re_Loc: Record "DEL Element";
    begin
        //Pour les livraisons de l'affaire qui ont un BR
        ds_Re_Loc.RESET();
        ds_Re_Loc.SETRANGE(Deal_ID, DealID_Co_Par);
        ds_Re_Loc.SETFILTER("BR No.", '<>%1', '');
        IF ds_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT

                //pour les éléments liés à cette livraison
                dsc_Re_Loc.RESET();
                dsc_Re_Loc.SETRANGE(Deal_ID, ds_Re_Loc.Deal_ID);
                dsc_Re_Loc.SETRANGE(Shipment_ID, ds_Re_Loc.ID);
                IF dsc_Re_Loc.FINDFIRST() THEN
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
                            IF NOT position_Re_Loc.FINDFIRST() THEN
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
                                IF NOT position_Re_Loc.FINDFIRST() THEN
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
                                    IF feeElement_Re_Loc.FINDFIRST() THEN BEGIN

                                        //si aucune position n'existe pour cet élément, alors on crée
                                        position_Re_Loc.RESET();
                                        position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                                        IF NOT position_Re_Loc.FINDFIRST() THEN
                                            FNC_Add_DispatchedFee_Position(dsc_Re_Loc.Deal_ID, ds_Re_Loc."BR No.", element_Re_Loc.ID, feeElement_Re_Loc.ID);

                                    END

                                END;

                    UNTIL (dsc_Re_Loc.NEXT() = 0);

            UNTIL (ds_Re_Loc.NEXT() = 0);

        END;
    end;


    procedure FNC_Add_DispatchedACO_Position(DealID_Co_Par: Code[20]; BRNo_Co_Par: Code[20]; ElementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        BRNo_Co: Code[20];
        qty_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
    begin

        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(DealID_Co_Par, curr_Co_Loc, 'EUR');

                FNC_Insert_Position(
                  DealID_Co_Par,
                  ElementID_Co_Par,
                  purchRcptLine_Re_Loc."No.",
                  qty_Dec_Loc,
                  curr_Co_Loc,
                  amount_Dec_Loc * -1,
                  '', rate_Dec_Loc,
                  DealItem_Cu.FNC_Get_Campaign_Code(DealID_Co_Par, purchRcptLine_Re_Loc."No.")
                );

            UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

    end;


    procedure FNC_Add_DispatchedVCO_Position(DealID_Co_Par: Code[20]; BRNo_Co_Par: Code[20]; ElementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        BRNo_Co: Code[20];
        qty_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
    begin
        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Price(DealID_Co_Par, purchRcptLine_Re_Loc."No.");
                rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(DealID_Co_Par, curr_Co_Loc, 'EUR');

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


    procedure FNC_Add_DispatchedFee_Position(DealID_Co_Par: Code[20]; BRNo_Co_Par: Code[20]; ElementID_Co_Par: Code[20]; FeeElementID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        position_Re_Loc: Record "DEL Position";
        BRNo_Co: Code[20];
        qty_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        feeElement_Re_Loc: Record "DEL Element";
    begin
        purchRcptLine_Re_Loc.RESET();
        purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Par);
        purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
        purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
        IF purchRcptLine_Re_Loc.FINDFIRST() THEN
            REPEAT

                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Element_ID, FeeElementID_Co_Par);
                position_Re_Loc.SETRANGE("Deal Item No.", purchRcptLine_Re_Loc."No.");
                IF position_Re_Loc.FINDFIRST() THEN
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


    procedure FNC_Get_Amount(Position_ID_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "DEL Position";
        curr_Re_Loc: Record "DEL Currency Exchange";
    begin
        FNC_Set_Position(position_Re_Loc, Position_ID_Co_Par);

        Amount_Dec_Ret := FNC_Get_Raw_Amount(Position_ID_Co_Par);

        Amount_Dec_Ret *= position_Re_Loc.Rate;

    end;


    procedure FNC_Get_Raw_Amount(Position_ID_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        position_Re_Loc: Record "DEL Position";
        curr_Re_Loc: Record "DEL Currency Exchange";
    begin
        FNC_Set_Position(position_Re_Loc, Position_ID_Co_Par);

        Amount_Dec_Ret := position_Re_Loc.Quantity * position_Re_Loc.Amount;

    end;
}

