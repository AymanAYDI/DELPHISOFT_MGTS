codeunit 50033 Provision
{

    trigger OnRun()
    begin
    end;

    var
        journalLastLineNo_Int: Integer;
        NoSeriesMgt_Cu: Codeunit "396";
        GeneralSetup: Record "50000";
        DocumentNo_Co: Code[20];
        TempSPS_Re: Record "50042" temporary;
        Element_Cu: Codeunit "50021";
        Dispatcher_Cu: Codeunit "50026";
        Fee_Cu: Codeunit "50023";
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';
        UpdateRequestManager_Cu: Codeunit "50032";
        postingDate_Da: Date;
        postingDateExt_Da: Date;
        "v------PROGRESS BAR------v": Integer;
        intProgressI: array[10] of Integer;
        diaProgress: array[10] of Dialog;
        intProgress: array[10] of Integer;
        intProgressTotal: array[10] of Integer;
        intProgressStep: array[10] of Integer;
        intNextProgressStep: array[10] of Integer;
        timProgress: array[10] of Time;
        interval: array[10] of Integer;

    [Scope('Internal')]
    procedure FNC_TransferToJournal(postingDate_Da_Par: Date; postingDateExt_Da_Par: Date; isCurrentPeriod_Bo_Par: Boolean)
    var
        sps_Re_Loc: Record "50042";
        actual: Code[20];
        intProgressI: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        timProgress: Time;
        interval: Integer;
    begin
        //Initialisation

        postingDate_Da := postingDate_Da_Par;
        postingDateExt_Da := postingDateExt_Da_Par;
        TempSPS_Re.RESET();
        TempSPS_Re.DELETEALL();
        GeneralSetup.GET();
        actual := '';
        //défini le dernier numéro de ligne utilisé sur la feuille PROVISION
        FNC_SetLastGenJnlLineNo();

        sps_Re_Loc.RESET();
        sps_Re_Loc.SETFILTER(USER_ID, USERID);
        sps_Re_Loc.SETFILTER("Provision Amount", '>%1', 0);

        FNC_ProgressBar_Init(1, 1000, 1000, 'Transfert dans le journal...', sps_Re_Loc.COUNT());

        IF sps_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                FNC_ProgressBar_Update(1);

                //createDealShipmentSelection(sps_Re_loc);
                FNC_Add2TempSPS(sps_Re_Loc);

            UNTIL (sps_Re_Loc.NEXT() = 0);
        END;

        //créer un nouveau numéro de document
        DocumentNo_Co := NoSeriesMgt_Cu.GetNextNo(GeneralSetup."Provision Nos.", TODAY, TRUE);
        //Crée le jeu d'écritures pour la provision
        FNC_CreateLedgerEntries(FALSE, isCurrentPeriod_Bo_Par);
        //Met à jour le numéro de document sur le détail de la provision
        FNC_UpdateSPS(DocumentNo_Co, postingDate_Da_Par, FALSE);

        //créer un nouveau numéro de document
        DocumentNo_Co := NoSeriesMgt_Cu.GetNextNo(GeneralSetup."Provision Nos.", TODAY, TRUE);
        //Crée l'extourne du jeu d'écriture ci-dessus
        FNC_CreateLedgerEntries(TRUE, isCurrentPeriod_Bo_Par);
        //Met à jour le numéro de document extourne sur le détail de la provision
        FNC_UpdateSPS(DocumentNo_Co, postingDateExt_Da_Par, TRUE);

        FNC_ProgressBar_Close(1);

        COMMIT();

        PAGE.RUN(39);
    end;

    [Scope('Internal')]
    procedure FNC_CreateLedgerEntries(isExtourne: Boolean; isCurrentPeriod: Boolean)
    var
        sps_Re_Loc: Record "50042";
        description_Te_Loc: Text[50];
    begin
        //Crée le jeu d'écritures pour la provision d'une livraison

        //créer l'écriture principale
        IF NOT isExtourne THEN BEGIN

            IF isCurrentPeriod THEN
                description_Te_Loc := 'Prov ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Month'
            ELSE
                description_Te_Loc := 'Prov ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Previous';

            FNC_CreateLedgerEntry(sps_Re_Loc, postingDate_Da, FNC_GetTempSPSTotal * -1, TRUE, description_Te_Loc)

        END ELSE BEGIN

            IF isCurrentPeriod THEN
                description_Te_Loc := 'Ext Prov ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Month'
            ELSE
                description_Te_Loc := 'Ext Prov ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Previous';

            FNC_CreateLedgerEntry(sps_Re_Loc, postingDateExt_Da, FNC_GetTempSPSTotal, TRUE, description_Te_Loc);

        END;

        //créer les écritures contrepartie
        TempSPS_Re.RESET();
        IF TempSPS_Re.FINDFIRST THEN
            REPEAT
                IF NOT isExtourne THEN BEGIN

                    IF isCurrentPeriod THEN
                        description_Te_Loc :=
                          'Prov ' + FORMAT(TempSPS_Re."Fee Account No.") + ' ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Month'
                    ELSE
                        description_Te_Loc :=
                          'Prov ' + FORMAT(TempSPS_Re."Fee Account No.") + ' ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Previous';

                    FNC_CreateLedgerEntry(TempSPS_Re, postingDate_Da, TempSPS_Re."Provision Amount", FALSE, description_Te_Loc);

                END ELSE BEGIN

                    IF isCurrentPeriod THEN
                        description_Te_Loc :=
                          'Ext. Prov ' + FORMAT(TempSPS_Re."Fee Account No.") + ' ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Month'
                    ELSE
                        description_Te_Loc :=
                          'Ext. Prov ' + FORMAT(TempSPS_Re."Fee Account No.") + ' ' + FORMAT(postingDate_Da, 0, '<Month>/<Year>') + ' Previous';


                    FNC_CreateLedgerEntry(TempSPS_Re, postingDateExt_Da, TempSPS_Re."Provision Amount" * -1, FALSE, description_Te_Loc);

                END;

            UNTIL (TempSPS_Re.NEXT() = 0);
    end;

    [Scope('Internal')]
    procedure FNC_CreateLedgerEntry(sps_Re_Par: Record "50042"; PostingDate_Da_Par: Date; Amount_Dec_Par: Decimal; IsMainEntry_Bo_Par: Boolean; Description_Te_Par: Text[50])
    var
        GenJnlLine_Re_Loc: Record "81";
        DealShipmentSelection_Re_Loc: Record "50031";
        DealShipment_Re_Loc: Record "50030";
    begin
        journalLastLineNo_Int += 10000;

        GenJnlLine_Re_Loc.INIT();

        GenJnlLine_Re_Loc.VALIDATE("Journal Template Name", 'GÉNÉRAL');
        GenJnlLine_Re_Loc.VALIDATE("Journal Batch Name", 'PROVISION');
        GenJnlLine_Re_Loc.VALIDATE("Line No.", journalLastLineNo_Int);
        GenJnlLine_Re_Loc.VALIDATE("Posting Date", PostingDate_Da_Par);
        GenJnlLine_Re_Loc.VALIDATE("Document No.", DocumentNo_Co);
        GenJnlLine_Re_Loc.VALIDATE("Account Type", GenJnlLine_Re_Loc."Account Type"::"G/L Account");

        IF NOT IsMainEntry_Bo_Par THEN BEGIN

            //le numéro de compte associé au frais
            GenJnlLine_Re_Loc.VALIDATE("Account No.", sps_Re_Par."Fee Account No.");
            GenJnlLine_Re_Loc.VALIDATE(Description, Description_Te_Par);

        END ELSE BEGIN

            //le numéro de compte associé aux provisions
            GenJnlLine_Re_Loc.VALIDATE("Account No.", '2051');
            GenJnlLine_Re_Loc.VALIDATE(Description, Description_Te_Par);

        END;

        //params
        GenJnlLine_Re_Loc.VALIDATE(Amount, Amount_Dec_Par);

        GenJnlLine_Re_Loc.INSERT(TRUE);
    end;

    [Scope('Internal')]
    procedure FNC_SetLastGenJnlLineNo()
    var
        GenJnlLine_Re_Loc: Record "81";
    begin
        GenJnlLine_Re_Loc.RESET();
        GenJnlLine_Re_Loc.SETRANGE("Journal Template Name", 'GÉNÉRAL');
        GenJnlLine_Re_Loc.SETRANGE("Journal Batch Name", 'PROVISION');
        IF GenJnlLine_Re_Loc.FIND('+') THEN
            journalLastLineNo_Int := GenJnlLine_Re_Loc."Line No."
        ELSE
            journalLastLineNo_Int := 0;
    end;

    [Scope('Internal')]
    procedure FNC_GetShipmentProvisionAmount(ShipmentID_Co_Par: Code[20]): Decimal
    var
        sps_Re_Loc: Record "50042";
        amount_Dec_Loc: Decimal;
    begin
        amount_Dec_Loc := 0;

        sps_Re_Loc.RESET();
        sps_Re_Loc.SETRANGE(USER_ID, USERID);
        sps_Re_Loc.SETRANGE(Deal_Shipment_ID, ShipmentID_Co_Par);
        sps_Re_Loc.SETFILTER("Provision Amount", '>%1', 0);
        IF sps_Re_Loc.FINDFIRST THEN
            REPEAT
                amount_Dec_Loc += sps_Re_Loc."Provision Amount";
            UNTIL (sps_Re_Loc.NEXT() = 0);

        EXIT(amount_Dec_Loc);
    end;

    [Scope('Internal')]
    procedure FNC_Add2TempSPS(sps_Re_Par: Record "50042")
    begin
        /*
        On ajoute la ligne à un record temporaire global (TempSPS_Re)
        si le fee est déjà existant, on additionne le montant sur la ligne correspondante
        si il n'existe pas, on crée une ligne et on défini le montant
        le but est d'avoir une liste de tous les fee avec pour chacun, le montant cumulé de toutes les provisions
        
        Structure :
        -----------
        Fee_ID   Montant
        FEE1     12
        FEE2     50
        FEE3     33
        
        Usage :
        -------
        TempSPS_Re.RESET();
        IF TempSPS_Re.FINDfirst THEN
          REPEAT
            MESSAGE('Amount for %1 : %2', TempSPS_Re.Fee_ID, TempSPS_Re."Provision Amount");
          UNTIL(TempSPS_Re.NEXT()=0);
        
        */

        TempSPS_Re.RESET();
        TempSPS_Re.SETRANGE(Fee_ID, sps_Re_Par.Fee_ID);
        IF TempSPS_Re.FINDFIRST THEN
          //si ca existe, on cumule
          BEGIN
            TempSPS_Re."Provision Amount" += sps_Re_Par."Provision Amount";
            TempSPS_Re.MODIFY();
        END
        ELSE
          //si ca existe pas on crée
          BEGIN
            TempSPS_Re.INIT();
            TempSPS_Re.Deal_ID := '';
            TempSPS_Re.Deal_Shipment_ID := '';
            TempSPS_Re.VALIDATE(Fee_ID, sps_Re_Par.Fee_ID);
            TempSPS_Re.USER_ID := sps_Re_Par.USER_ID;
            TempSPS_Re."Provision Amount" := sps_Re_Par."Provision Amount";
            IF NOT TempSPS_Re.INSERT() THEN
                ERROR('erreur dans Cu50033');
        END;

    end;

    [Scope('Internal')]
    procedure FNC_GetTempSPSTotal() tot: Decimal
    begin
        //compte le total des provisions pour tous les frais

        tot := 0;

        TempSPS_Re.RESET();
        IF TempSPS_Re.FINDFIRST THEN
            REPEAT
                tot += TempSPS_Re."Provision Amount";
            UNTIL (TempSPS_Re.NEXT() = 0);
    end;

    [Scope('Internal')]
    procedure FNC_UpdateSPS(docNo_Co_Par: Code[20]; postingDate_Da_Par: Date; isExtourne: Boolean)
    var
        sps_Re_Loc: Record "50042";
    begin
        //renseinge le numéro de document pour les écritures ou les extournes

        sps_Re_Loc.RESET();
        sps_Re_Loc.SETFILTER(USER_ID, USERID);
        sps_Re_Loc.SETFILTER("Provision Amount", '>%1', 0);

        IF isExtourne THEN
            FNC_ProgressBar_Init(2, 200, 500, 'Traitement des écritures ext. en cours...', sps_Re_Loc.COUNT())
        ELSE
            FNC_ProgressBar_Init(2, 200, 500, 'Traitement des écritures en cours...', sps_Re_Loc.COUNT());

        IF sps_Re_Loc.FINDFIRST THEN
            REPEAT

                FNC_ProgressBar_Update(2);

                IF isExtourne THEN BEGIN
                    sps_Re_Loc."Document No. Ext." := docNo_Co_Par;
                    sps_Re_Loc."Posting Date Ext." := postingDate_Da_Par;
                END ELSE BEGIN
                    sps_Re_Loc."Document No." := docNo_Co_Par;
                    sps_Re_Loc."Posting Date" := postingDate_Da_Par;
                END;

                sps_Re_Loc.MODIFY();

            UNTIL (sps_Re_Loc.NEXT() = 0);

        FNC_ProgressBar_Close(2);
    end;

    [Scope('Internal')]
    procedure FNC_RunTest()
    var
        sps_Re_Loc: Record "50042";
        element_Re_Loc: Record "50021";
        intProgressI: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        intProgressStep: Integer;
        intNextProgressStep: Integer;
        timProgress: Time;
        interval: Integer;
    begin
        sps_Re_Loc.RESET();
        sps_Re_Loc.SETFILTER(USER_ID, USERID);
        sps_Re_Loc.SETFILTER("Provision Amount", '>%1', 0);

        FNC_ProgressBar_Init(1, 1000, 1000, 'Validation des provisions en cours...', sps_Re_Loc.COUNT());

        IF sps_Re_Loc.FINDFIRST THEN
            REPEAT

                FNC_ProgressBar_Update(1);

                //TEST1
                //si une facture existe pour cette livraison il faut controler si elle exite au sein de l'affaire
                IF sps_Re_Loc."Purchase Invoice No." <> '' THEN BEGIN

                    element_Re_Loc.RESET();
                    element_Re_Loc.SETRANGE(Deal_ID, sps_Re_Loc.Deal_ID);
                    element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
                    element_Re_Loc.SETRANGE("Type No.", sps_Re_Loc."Purchase Invoice No.");
                    IF NOT element_Re_Loc.FINDFIRST THEN
                        ERROR(
                            'Répartition de la provision >%1< sur la livraison >%2< impossible car la facture achat liée >%3< est introuvable ' +
                            'dans l''affaire >%4< !',
                            sps_Re_Loc."Document No.",
                            sps_Re_Loc.Deal_Shipment_ID,
                            sps_Re_Loc."Purchase Invoice No.",
                            sps_Re_Loc.Deal_ID
                          );

                END;

                //TEST2

            UNTIL (sps_Re_Loc.NEXT() = 0);

        FNC_ProgressBar_Close(1);


        //MESSAGE('Test OK');
    end;

    [Scope('Internal')]
    procedure FNC_Dispatch(Element_ID_Co_Loc: Code[20]; ProvisionAmount_Dec_Loc: Decimal)
    var
        element_Re_Loc: Record "50021";
        fee_Re_Loc: Record "50024";
        value_Ar_Loc: array[300] of Decimal;
        sum_Dec_Loc: Decimal;
        arrayIndex: Integer;
        textArray: Text[255];
        elementConnection_Re_Loc: Record "50027";
        applyElement_Re_Loc: Record "50021";
        glEntry_Re_Loc: Record "17";
        amountToDispatch_Dec_Loc: Decimal;
    begin
        /*
        DISPATCH UN ELEMENT (Provision) SUR D'AUTRES ELEMENTS
        
        Exemple:
        On a une provision (Element) de 2000.- à ventiler (dispatcher, répartir) sur 3 livraisons (aussi des Element)
        On ventile selon la méthode du "prorata value".
        Valeur livraison 1 : 150
        Valeur livraison 2 : 350
        Valeur livraison 3 : 500
        --
        Valeur totale : 1000
        
        step 1  : on calcul la somme de la valeur de la livraison en fonction du paramètre choisi (valeur, poid, volume, etc..)
        step 2  : array.sum, = 1000
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

        Element_Cu.FNC_Set_Element(element_Re_Loc, Element_ID_Co_Loc);

        /*_Si le montant du frais à dispatcher vaut 0, alors on le dispatch pas_*/
        IF ProvisionAmount_Dec_Loc <> 0 THEN BEGIN

            Fee_Cu.FNC_Set(fee_Re_Loc, element_Re_Loc.Fee_ID);

            //CHG04
            //la variable value_Ar_Loc est un tableau !

            //step 1
            //On dispatch selon les règles de Ventilation Element
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

            IF sum_Dec_Loc = 0 THEN
                ERROR(ERROR_TXT, 'Co50023', 'FNC_Dispatch()', 'Array total à 0 !');

            amountToDispatch_Dec_Loc := ProvisionAmount_Dec_Loc;

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
            //elementConnection_Re_Loc.setrange(Deal_ID, element_Re_Loc.Deal_ID);
            elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);

            arrayIndex := 1;
            IF elementConnection_Re_Loc.FINDFIRST THEN
                REPEAT

                    //Si elementconnection.apply to fait parti de l'affaire elementconnection.dealID
                    applyElement_Re_Loc.RESET();
                    applyElement_Re_Loc.SETRANGE(Deal_ID, elementConnection_Re_Loc.Deal_ID);
                    applyElement_Re_Loc.SETRANGE(ID, elementConnection_Re_Loc."Apply To");
                    IF applyElement_Re_Loc.FINDFIRST THEN BEGIN

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
                            fee_Re_Loc."Ventilation Position"::Quantity:
                                Dispatcher_Cu.FNC_Position_Prorata_Quantity(
                                  elementConnection_Re_Loc.Element_ID,
                                  elementConnection_Re_Loc."Apply To",
                                  value_Ar_Loc[arrayIndex],
                                  Element_Cu.FNC_Get_Quantity(elementConnection_Re_Loc."Apply To")
                                );
                        END;

                    END;

                    arrayIndex += 1;
                UNTIL (elementConnection_Re_Loc.NEXT = 0);

        END

    end;

    [Scope('Internal')]
    procedure FNC_Add2Deals()
    var
        deal_ID_Co_Loc: Code[20];
        dealShipmentSelection_Re_Loc: Record "50031";
        element_Re_Loc: Record "50021";
        BR_Re_Loc: Record "120";
        genJournalLine_Re_Temp: Record "81" temporary;
        dealShipment_Re_Loc: Record "50030";
        feeConnection_Re_Loc: Record "50025";
        Add_Variant_Op_Loc: Option New,Existing;
        nextEntry: Code[20];
        myTab: array[300] of Code[20];
        dss_Re_Loc: Record "50031";
        element_ID_Co_Loc: Code[20];
        i: Integer;
        ConnectionType_Op_Par: Option Element,Shipment;
        fee_Re_Loc: Record "50024";
        myUpdateRequests: array[300] of Code[20];
        provisionDealID_Co_Loc: Code[20];
        updateRequest_Co_Loc: Code[20];
        sps_Re_Loc: Record "50042";
        urm_Re_Loc: Record "50039";
        dsc_Re_Loc: Record "50032";
    begin
        element_ID_Co_Loc := '';
        provisionDealID_Co_Loc := '';

        //on cherche les provisions dans la table des provisions pour l'utilisateur loggé
        sps_Re_Loc.RESET();           //useserid
        sps_Re_Loc.SETRANGE(USER_ID, USERID);
        sps_Re_Loc.SETFILTER("Provision Amount", '>%1', 0);

        FNC_ProgressBar_Init(1, 1000, 1000, 'Génération des éléments en cours...', sps_Re_Loc.COUNT);

        IF sps_Re_Loc.FINDFIRST THEN BEGIN
            REPEAT

                FNC_ProgressBar_Update(1);

                //CONTROLER SI UNE PROVISION EXISTE DEJA POUR LE MEME FRAIS DANS LA MEME LIVRAISON ET SI OUI LA SUPPRIMER
                //On cherche si pour la meme livraison et le meme frais, une provision a déjà été générée
                element_Re_Loc.RESET();
                element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
                element_Re_Loc.SETRANGE(Deal_ID, sps_Re_Loc.Deal_ID);
                element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Provision);
                element_Re_Loc.SETRANGE(Fee_ID, sps_Re_Loc.Fee_ID);
                element_Re_Loc.SETRANGE(Fee_Connection_ID, sps_Re_Loc.Fee_Connection_ID);
                IF element_Re_Loc.FINDFIRST THEN
                    REPEAT

                        //si la provision fait partie de la livraison en cours
                        IF dsc_Re_Loc.GET(element_Re_Loc.Deal_ID, sps_Re_Loc.Deal_Shipment_ID, element_Re_Loc.ID) THEN
                            Element_Cu.FNC_Delete_Element(element_Re_Loc.ID);

                    UNTIL (element_Re_Loc.NEXT() = 0);

                //AJOUTE L'ELEMENT PROVISION, SES CONNECTIONS ET POSITIONS
                //LE PARAMETRE FALSE INDIQUE QU'IL NE S'AGIT PAS DE L'ELEMENT D'EXTOURNE
                element_ID_Co_Loc := Element_Cu.FNC_Add_Provision(sps_Re_Loc, FALSE);

                IF element_ID_Co_Loc <> '' THEN BEGIN

                    //ajouter une shipment connection
                    Element_Cu.FNC_Add_Provision_Connection(element_ID_Co_Loc, sps_Re_Loc, ConnectionType_Op_Par::Shipment);

                    //ajouter la connection à l'élément
                    Element_Cu.FNC_Add_Provision_Connection(element_ID_Co_Loc, sps_Re_Loc, ConnectionType_Op_Par::Element);

                    //créer les positions pour la provision qu'on vient de créer
                    FNC_Dispatch(element_ID_Co_Loc, sps_Re_Loc."Provision Amount");


                    //AJOUTE L'ELEMENT PROVISION EXTOURNE, SES CONNECTIONS ET POSITIONS
                    //LE PARAMETRE TRUE INDIQUE QU'IL S'AGIT DE L'ELEMENT D'EXTOURNE
                    element_ID_Co_Loc := Element_Cu.FNC_Add_Provision(sps_Re_Loc, TRUE);

                    IF element_ID_Co_Loc <> '' THEN BEGIN

                        //ajouter une shipment connection
                        Element_Cu.FNC_Add_Provision_Connection(element_ID_Co_Loc, sps_Re_Loc, ConnectionType_Op_Par::Shipment);

                        //ajouter la connection à l'élément
                        Element_Cu.FNC_Add_Provision_Connection(element_ID_Co_Loc, sps_Re_Loc, ConnectionType_Op_Par::Element);

                        //créer les positions pour la provision qu'on vient de créer
                        //pour l'extourne, le montant est logiquement inversé
                        FNC_Dispatch(element_ID_Co_Loc, sps_Re_Loc."Provision Amount" * -1);

                    END ELSE
                        ERROR(
                          'L''element provision n''a pas pu etre créé l''affaire %1, livraison %2, frais prévu %3 !',
                          sps_Re_Loc.Deal_ID,
                          sps_Re_Loc.Deal_Shipment_ID,
                          sps_Re_Loc.Fee_ID
                        );


                    //On supprime la sélection
                    //sps_Re_Loc.DELETE();

                    /*en principe une fois les positions créées, il n'y a plus rien à mettre à jour..
                    //si on a changé d'affaire on crée une update request
                    IF provisionDealID_Co_Loc <> sps_Re_Loc.Deal_ID THEN BEGIN

                      provisionDealID_Co_Loc := sps_Re_Loc.Deal_ID;

                      //On crée une demande de mise à jour
                      updateRequest_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                        sps_Re_Loc.Deal_ID,
                        urm_Re_Loc.Requested_By_Type::Provision,
                        '',
                        CURRENTDATETIME
                      );

                    END;
                    */

                END ELSE
                    ERROR(
                      'L''element provision n''a pas pu etre créé l''affaire %1, livraison %2, frais prévu %3 !',
                      sps_Re_Loc.Deal_ID,
                      sps_Re_Loc.Deal_Shipment_ID,
                      sps_Re_Loc.Fee_ID
                    );



            UNTIL (sps_Re_Loc.NEXT() = 0);

            //On supprime la sélection
            //sps_Re_Loc.DELETE(TRUE);


            //On met à jour les affaires pour lesquelles ont a ajouté des provisions
            //UpdateRequestManager_Cu.FNC_ProcessRequestsByType('Provision');

            FNC_ProgressBar_Close(1);

        END;

        sps_Re_Loc.RESET();           //userid
        sps_Re_Loc.SETRANGE(USER_ID, USERID);
        sps_Re_Loc.DELETEALL();

    end;

    [Scope('Internal')]
    procedure FNC_DeleteProvisions()
    var
        element_Re_Loc: Record "50021";
    begin
        //supprime les éléments de type Provision de la base de données

        IF DIALOG.CONFIRM('Cette fonction supprime toutes les provisions de toutes les affaires ! Continuer ?', TRUE) THEN BEGIN
            element_Re_Loc.RESET();
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Provision);

            FNC_ProgressBar_Init(1, 1000, 500, 'Supression des provisions en cours...', element_Re_Loc.COUNT);

            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    FNC_ProgressBar_Update(1);
                    Element_Cu.FNC_Delete_Element(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

            FNC_ProgressBar_Close(1);

        END;
    end;

    [Scope('Internal')]
    procedure FNC_Prune()
    var
        element_Re_Loc: Record "50021";
        date_Loc: Date;
        dateTime_Loc: DateTime;
    begin
        //supprime toutes les provisions donc la date de création est plus vieille que 3 mois

        IF DIALOG.CONFIRM('Voulez-vous supprimer les provisions crées il y a plus de 3 mois ?', TRUE) THEN BEGIN

            date_Loc := CALCDATE('<-3M>', TODAY);
            EVALUATE(dateTime_Loc, FORMAT(date_Loc));

            element_Re_Loc.RESET();
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Provision);
            element_Re_Loc.SETFILTER(element_Re_Loc."Add DateTime", '<%1', dateTime_Loc);

            FNC_ProgressBar_Init(1, 1000, 500, 'Supression des provisions en cours...', element_Re_Loc.COUNT);

            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    FNC_ProgressBar_Update(1);
                    Element_Cu.FNC_Delete_Element(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

            FNC_ProgressBar_Close(1);

        END
    end;

    [Scope('Internal')]
    procedure FNC_ProgressBar_Init(index_Int_Par: Integer; interval_Int_Par: Integer; stepProgress_Int_Par: Integer; text_Te_Par: Text[50]; total_Int_Par: Integer)
    begin
        /*
        L'index permet d'avoir plusieur barres de progression lors d'un meme traitement.
        
        valeur par defaut :
        interval 1000;
        step progress 1000;
        
        -> Signifie qu'on met à jour la barre de controle toutes les 1000ms si le traitement a avancé d'au moins 10%
        */
        intProgress[index_Int_Par] := 0;
        interval[index_Int_Par] := interval_Int_Par; //en milisecondes
        intProgressStep[index_Int_Par] := stepProgress_Int_Par; //update si au moins 5% d'avancé (échelle : 10% = 1000)
        intNextProgressStep[index_Int_Par] := intProgressStep[index_Int_Par];
        intProgressI[index_Int_Par] := 0;
        diaProgress[index_Int_Par].OPEN(
          text_Te_Par + '\@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\', intProgress[index_Int_Par]);
        intProgressTotal[index_Int_Par] := total_Int_Par;
        timProgress[index_Int_Par] := TIME;

    end;

    [Scope('Internal')]
    procedure FNC_ProgressBar_Update(index_Int_Par: Integer)
    begin
        intProgressI[index_Int_Par] += 1;

        //toutes les x milisecondes (paramètre interval)
        IF timProgress[index_Int_Par] < TIME - interval[index_Int_Par] THEN BEGIN

            //calcul le pourcentage d'avancement
            intProgress[index_Int_Par] := ROUND(intProgressI[index_Int_Par] / intProgressTotal[index_Int_Par] * 10000, 1);

            //si le pourcentage d'avancement a avancé de x pourcent (paramètre intProgressStep)
            IF intProgress[index_Int_Par] > intNextProgressStep[index_Int_Par] THEN BEGIN

                //définition du prochain niveau de progression
                intNextProgressStep[index_Int_Par] += intProgressStep[index_Int_Par];

                //mise à jour du temps
                timProgress[index_Int_Par] := TIME;

                //mise à jour de la barre
                diaProgress[index_Int_Par].UPDATE;

            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_ProgressBar_Close(index_Int_Par: Integer)
    begin
        diaProgress[index_Int_Par].CLOSE;
    end;
}

