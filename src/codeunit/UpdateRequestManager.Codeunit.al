codeunit 50032 "Update Request Manager"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 06.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            06.04.09   created object
    // CHG02                            20.04.09   created FNC_Import_Requests
    //                                             modified FNC_Process_Requests to add progress bar handling
    // CHG03                            04.05.09   renamed FNC_Import_Requests to FNC_Import_All
    //                                             created FNC_Import_BlankInvoices
    // CHG04                            26.09.11   adapted deal update function with "updatePlanned" parameter
    // T-00759     THM                  13.01.16   add new function FNC_Process_RequestsFilter


    trigger OnRun()
    begin
        FNC_Import_All();
        UpdateRequest_Re.RESET();
        FNC_Process_Requests(UpdateRequest_Re, FALSE, FALSE, TRUE);
    end;

    var
        UpdateRequest_Re: Record "50039";
        Setup: Record "50000";
        NoSeriesMgt_Cu: Codeunit "396";
        Deal_Cu: Codeunit "50020";
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
    procedure FNC_Process_Requests(updateRequest_Re_Par: Record "50039"; deleteWhenUpdated: Boolean; UpdatePlanned_Bo_Par: Boolean; processSilently_Bo_Par: Boolean)
    var
        intProgressI: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        timProgress: Time;
    begin
        /*
        usage:
        
          //create a request
            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
              ACOConnection_Re_Loc.Deal_ID,
              urm_Re_Loc.Requested_By_Type::"Sales Header",
              "No.",
              currentdatetime
            );
        
          //get the created request and process it
            urm_Re_Loc.get(requestid_co_loc);
            UpdateRequestManager_Cu.FNC_Process_Requests(urm_re_loc,false,true);
        
        */

        //Traite la liste des update requests passé dans le record en paramètre

        //on ne traite que les status pas encore traité, les lignes qui ne doivent pas etre ignorées et que les lignes pour l'utilisateur
        //loggé ou vide
        updateRequest_Re_Par.SETFILTER(Requested_By_User, '%1|%2', '', USERID);
        updateRequest_Re_Par.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
        updateRequest_Re_Par.SETRANGE("To be ignored", FALSE);

        //check toutes les 500ms si au moins 1% d'avancé
        FNC_ProgressBar_Init(1, 1000, 100, 'Mise à jour en cours...', updateRequest_Re_Par.COUNT());

        IF updateRequest_Re_Par.FINDFIRST THEN
            REPEAT

                //mise à jour de la barre de progression
                FNC_ProgressBar_Update(1);

                //Test sur une affaire.. si retourne vrai, alors on la met à jour
                IF FNC_Test(updateRequest_Re_Par.Request_For_Deal_ID) THEN BEGIN

                    //mise à jour sans messages de confirmation
                    Deal_Cu.FNC_Reinit_Silently_Deal(updateRequest_Re_Par.Request_For_Deal_ID, UpdatePlanned_Bo_Par);

                    //supprime ou marque la demande de mise à jour en fonction du paramètre deleteWhenUpdated
                    IF deleteWhenUpdated THEN
                        FNC_Remove_Request(updateRequest_Re_Par.ID)
                    ELSE
                        FNC_Validate_Request(updateRequest_Re_Par.ID);

                END ELSE
                    FNC_Ignore_Request(updateRequest_Re_Par.ID);

                //sauve la transaction
                COMMIT();

            UNTIL (updateRequest_Re_Par.NEXT() = 0);

        //ferme la barre de progression
        FNC_ProgressBar_Close(1);

        IF NOT processSilently_Bo_Par THEN MESSAGE('Liste traitée !')

    end;

    [Scope('Internal')]
    procedure FNC_Add_Request(Requested_For_Deal_ID_Co_Par: Code[20]; Requested_By_Type_Co_Par: Option; Requested_By_TypeNo_Co_Par: Code[20]; Requested_At_DateTime_Par: DateTime) updateRequest_ID_Ret: Code[20]
    begin
        //Ajoute une update request à la liste
        /*
        usage :
        
          UpdateRequestManager_Cu.FNC_Add_Request(
            Requested_For_Deal_ID_Co_Par,
            Requested_By_Type_Co_Par,
            Requested_By_TypeNo_Co_Par,
            Requested_At_DateTime_Par //currentdatetime
          );
        */

        Setup.GET();

        updateRequest_ID_Ret := NoSeriesMgt_Cu.GetNextNo(Setup."Update Request Nos.", TODAY, TRUE);

        //MESSAGE('%1', updateRequest_ID_Ret);

        UpdateRequest_Re.INIT();

        UpdateRequest_Re.ID := updateRequest_ID_Ret;
        UpdateRequest_Re.VALIDATE(Request_For_Deal_ID, Requested_For_Deal_ID_Co_Par);
        UpdateRequest_Re.VALIDATE(Requested_By_User, USERID);
        UpdateRequest_Re.VALIDATE(Requested_By_Type, Requested_By_Type_Co_Par);
        UpdateRequest_Re.VALIDATE("Requested_By_Type No.", Requested_By_TypeNo_Co_Par);
        UpdateRequest_Re.VALIDATE(Requested_At, Requested_At_DateTime_Par);
        UpdateRequest_Re.VALIDATE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
        UpdateRequest_Re.VALIDATE("To be ignored", FALSE);

        IF NOT UpdateRequest_Re.INSERT() THEN
            ERROR('Could not insert request')

    end;

    [Scope('Internal')]
    procedure FNC_Remove_Request(Request_ID_Co_Par: Code[20])
    begin
        //Supprime une update request

        IF UpdateRequest_Re.GET(Request_ID_Co_Par) THEN BEGIN
            UpdateRequest_Re.DELETE();
            //UpdateRequest_Re.MODIFY();
        END
    end;

    [Scope('Internal')]
    procedure FNC_Validate_Request(Request_ID_Co_Par: Code[20])
    begin
        //Marque une update request comme étant à ignorer

        IF UpdateRequest_Re.GET(Request_ID_Co_Par) THEN BEGIN
            UpdateRequest_Re.VALIDATE(Request_Status, UpdateRequest_Re.Request_Status::OK);
            UpdateRequest_Re.MODIFY();
        END
    end;

    [Scope('Internal')]
    procedure FNC_Ignore_Request(Request_ID_Co_Par: Code[20])
    begin
        //Marque une update request comme validée

        IF UpdateRequest_Re.GET(Request_ID_Co_Par) THEN BEGIN
            UpdateRequest_Re.VALIDATE("To be ignored", TRUE);
            UpdateRequest_Re.MODIFY();
        END
    end;

    [Scope('Internal')]
    procedure FNC_Test(DealID_Co_Loc: Code[20]): Boolean
    begin
        //Test de l'affaire dans le but de pas la mettre à jour si le(s) test(s) révèle(nt) des irrégularités

        //TEST si le numéro de deal existe
        IF DealID_Co_Loc = '' THEN BEGIN
            MESSAGE('Attention ! Il y a une requête de mise à jour sans numéro d''affaire dans la table Update Request Manager !');
            EXIT(FALSE);
        END;

        //TEST2
        //if testpascool then exit(false);

        //TEST3
        //if testpascool then exit(false);

        EXIT(TRUE);
    end;

    [Scope('Internal')]
    procedure FNC_Import_All()
    var
        deal_Re_Loc: Record "50020";
        element_Re_Loc: Record "50021";
        counter_Loc: Integer;
    begin
        /*
        On veut updater les deals qui ont un status différent de terminé ou annulé ET qui ont des éléments
        qui ont été ajoutés à l'affaire après le dernier update.
        
        lister les deals non terminés et non annulés
        lister les deals ayant des éléments plus récents que le dernier update
          ajouter les requests
        
        traiter la liste
        */
        counter_Loc := 0;

        deal_Re_Loc.RESET();
        deal_Re_Loc.SETFILTER(Status, '%1|%2|%3',
          deal_Re_Loc.Status::"In order",
          deal_Re_Loc.Status::"In progress",
          deal_Re_Loc.Status::Invoiced
          );

        //check toutes les 500ms si au moins 5% d'avancé
        FNC_ProgressBar_Init(1, 500, 500, 'Création des update request...', deal_Re_Loc.COUNT());

        IF deal_Re_Loc.FINDFIRST THEN
            REPEAT

                FNC_ProgressBar_Update(1);

                //ajoute seulement les affaires qui ont des éléments ajoutés plus récent que la dernière update de l'affaire
                //element_Re_Loc.RESET();
                //element_Re_Loc.SETFILTER(Deal_ID, deal_Re_Loc.ID);
                //element_Re_Loc.SETFILTER("Add DateTime", '>%1', deal_Re_Loc."Last Update");
                //IF element_Re_Loc.FINDFIRST THEN BEGIN
                FNC_Add_Request(deal_Re_Loc.ID, UpdateRequest_Re.Requested_By_Type::CUSTOM, 'All', CURRENTDATETIME);
                counter_Loc += 1;
                //END

            UNTIL (deal_Re_Loc.NEXT() = 0);

        FNC_ProgressBar_Close(1);

        MESSAGE('%1 update request(s) ajoutée(s) !', counter_Loc);

    end;

    [Scope('Internal')]
    procedure FNC_Import_BlankInvoices()
    var
        deal_Re_Loc: Record "50020";
        element_Re_Loc: Record "50021";
        position_Re_Loc: Record "50022";
        counter_Loc: Integer;
    begin
        /*
        Ajoute les affaires qui ont des éléments de type "Invoice", sales invoice ou purchase invoice
        mais qui n'ont pas de positions correspondantes dans la table "Position"
        */

        counter_Loc := 0;

        element_Re_Loc.RESET();
        element_Re_Loc.SETFILTER(Type,
          '%1|%2|%3', element_Re_Loc.Type::Invoice, element_Re_Loc.Type::"Sales Invoice", element_Re_Loc.Type::"Purchase Invoice");
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT
                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                IF NOT position_Re_Loc.FINDFIRST THEN BEGIN
                    FNC_Add_Request(element_Re_Loc.Deal_ID, UpdateRequest_Re.Requested_By_Type::CUSTOM, 'blank invoices', CURRENTDATETIME);
                    counter_Loc += 1;
                END;
            UNTIL (element_Re_Loc.NEXT() = 0);

        MESSAGE('%1 update request(s) ajoutée(s) !', counter_Loc);

    end;

    [Scope('Internal')]
    procedure FNC_ProcessRequestsByType(Type_Op_Par: Option Invoice,"Purchase Header","Sales Header","Sales Cr. Memo","Purch. Cr. Memo",Payment,Provision,USERID; TypeNo_Co_Par: Code[20]; processSilently_Bo_Par: Boolean)
    begin
        /*
        Traite la liste des update requests mais seulement pour un type défini
        
        usage:
        
        //met à jour toutes les update request générées par des éléments de provision
        FNC_ProcessRequestsByType(UpdateRequest_Re.Requested_By_Type::Provision, '');
        
        //met à jour toutes les update request donc le type est CUSTOM et la référence 'toto'
        FNC_ProcessRequestsByType(UpdateRequest_Re.Requested_By_Type::CUSTOM, 'toto');
        */

        UpdateRequest_Re.RESET();

        UpdateRequest_Re.SETRANGE(Requested_By_Type, Type_Op_Par);

        IF TypeNo_Co_Par <> '' THEN
            UpdateRequest_Re.SETRANGE("Requested_By_Type No.", TypeNo_Co_Par);

        FNC_Process_Requests(UpdateRequest_Re, FALSE, FALSE, processSilently_Bo_Par);

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

    [Scope('Internal')]
    procedure FNC_Process_RequestsDeal(updateRequest_Re_Par: Record "50039"; deleteWhenUpdated: Boolean; UpdatePlanned_Bo_Par: Boolean; processSilently_Bo_Par: Boolean; NumID: Code[20])
    var
        intProgressI: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        timProgress: Time;
    begin
        /*
        usage:
        
          //create a request
            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
              ACOConnection_Re_Loc.Deal_ID,
              urm_Re_Loc.Requested_By_Type::"Sales Header",
              "No.",
              currentdatetime
            );
        
          //get the created request and process it
            urm_Re_Loc.get(requestid_co_loc);
            UpdateRequestManager_Cu.FNC_Process_Requests(urm_re_loc,false,true);
        
        */

        //Traite la liste des update requests passé dans le record en paramètre

        //on ne traite que les status pas encore traité, les lignes qui ne doivent pas etre ignorées et que les lignes pour l'utilisateur
        //loggé ou vide
        updateRequest_Re_Par.SETFILTER(Requested_By_User, '%1|%2', '', USERID);
        updateRequest_Re_Par.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
        updateRequest_Re_Par.SETRANGE("To be ignored", FALSE);
        updateRequest_Re_Par.SETRANGE(updateRequest_Re_Par.ID, NumID);

        //check toutes les 500ms si au moins 1% d'avancé
        FNC_ProgressBar_Init(1, 1000, 100, 'Mise à jour en cours...', updateRequest_Re_Par.COUNT());

        IF updateRequest_Re_Par.FINDFIRST THEN
            REPEAT

                //mise à jour de la barre de progression
                FNC_ProgressBar_Update(1);

                //Test sur une affaire.. si retourne vrai, alors on la met à jour
                IF FNC_Test(updateRequest_Re_Par.Request_For_Deal_ID) THEN BEGIN

                    //mise à jour sans messages de confirmation
                    Deal_Cu.FNC_Reinit_Silently_Deal(updateRequest_Re_Par.Request_For_Deal_ID, UpdatePlanned_Bo_Par);

                    //supprime ou marque la demande de mise à jour en fonction du paramètre deleteWhenUpdated
                    IF deleteWhenUpdated THEN
                        FNC_Remove_Request(updateRequest_Re_Par.ID)
                    ELSE
                        FNC_Validate_Request(updateRequest_Re_Par.ID);

                END ELSE
                    FNC_Ignore_Request(updateRequest_Re_Par.ID);

                //sauve la transaction
                COMMIT();

            UNTIL (updateRequest_Re_Par.NEXT() = 0);

        //ferme la barre de progression
        FNC_ProgressBar_Close(1);

        IF NOT processSilently_Bo_Par THEN MESSAGE('Liste traitée !')

    end;

    [Scope('Internal')]
    procedure FNC_Process_RequestsFilter(updateRequest_Re_Par: Record "50039"; deleteWhenUpdated: Boolean; UpdatePlanned_Bo_Par: Boolean; processSilently_Bo_Par: Boolean; FilterDeal: Text)
    var
        intProgressI: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        timProgress: Time;
    begin

        //Traite la liste des update requests passé dans le record en paramètre

        //on ne traite que les status pas encore traité, les lignes qui ne doivent pas etre ignorées et que les lignes pour l'utilisateur
        //loggé ou vide
        updateRequest_Re_Par.SETFILTER(Requested_By_User, '%1|%2', '', USERID);
        updateRequest_Re_Par.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
        updateRequest_Re_Par.SETRANGE("To be ignored", FALSE);
        IF FilterDeal <> '' THEN
            updateRequest_Re_Par.SETFILTER(Request_For_Deal_ID, '%1', FilterDeal);

        //check toutes les 500ms si au moins 1% d'avancé
        //FNC_ProgressBar_Init(1, 1000, 100, 'Mise à jour en cours...', updateRequest_Re_Par.COUNT());

        IF updateRequest_Re_Par.FINDFIRST THEN
            REPEAT

                //mise à jour de la barre de progression
                //FNC_ProgressBar_Update(1);

                //Test sur une affaire.. si retourne vrai, alors on la met à jour
                IF FNC_Test(updateRequest_Re_Par.Request_For_Deal_ID) THEN BEGIN

                    //mise à jour sans messages de confirmation
                    Deal_Cu.FNC_Reinit_Silently_Deal(updateRequest_Re_Par.Request_For_Deal_ID, UpdatePlanned_Bo_Par);

                    //supprime ou marque la demande de mise à jour en fonction du paramètre deleteWhenUpdated
                    IF deleteWhenUpdated THEN
                        FNC_Remove_Request(updateRequest_Re_Par.ID)
                    ELSE
                        FNC_Validate_Request(updateRequest_Re_Par.ID);

                END ELSE
                    FNC_Ignore_Request(updateRequest_Re_Par.ID);

                //sauve la transaction
                COMMIT();

            UNTIL (updateRequest_Re_Par.NEXT() = 0);

        //ferme la barre de progression
        //FNC_ProgressBar_Close(1);
    end;
}

