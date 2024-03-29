codeunit 50032 "DEL Update Request Manager"
{
    trigger OnRun()
    begin
        FNC_Import_All();
        UpdateRequest_Re.RESET();
        FNC_Process_Requests(UpdateRequest_Re, FALSE, FALSE, TRUE);
    end;

    var
        Setup: Record "DEL General Setup";
        UpdateRequest_Re: Record "DEL Update Request Manager";
        Deal_Cu: Codeunit "DEL Deal";
        NoSeriesMgt_Cu: Codeunit NoSeriesManagement;
        diaProgress: Array[10] of Dialog;
        interval: array[10] of Integer;
        intNextProgressStep: array[10] of Integer;
        intProgress: Array[10] of Integer;
        intProgressI: Array[10] of Integer;
        intProgressStep: array[10] of Integer;
        intProgressTotal: array[10] of Integer;
        timProgress: array[10] of Time;

    procedure FNC_Process_Requests(updateRequest_Re_Par: Record "DEL Update Request Manager"; deleteWhenUpdated: Boolean; UpdatePlanned_Bo_Par: Boolean; processSilently_Bo_Par: Boolean)
    var

    begin

        updateRequest_Re_Par.SETFILTER(Requested_By_User, '%1|%2', '', USERID);
        updateRequest_Re_Par.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
        updateRequest_Re_Par.SETRANGE("To be ignored", FALSE);
        FNC_ProgressBar_Init(1, 1000, 100, 'Mise à jour en cours...', updateRequest_Re_Par.COUNT());

        IF updateRequest_Re_Par.FINDFIRST() THEN
            REPEAT

                FNC_ProgressBar_Update(1);

                IF FNC_Test(updateRequest_Re_Par.Request_For_Deal_ID) THEN BEGIN

                    Deal_Cu.FNC_Reinit_Silently_Deal(updateRequest_Re_Par.Request_For_Deal_ID, UpdatePlanned_Bo_Par);

                    IF deleteWhenUpdated THEN
                        FNC_Remove_Request(updateRequest_Re_Par.ID)
                    ELSE
                        FNC_Validate_Request(updateRequest_Re_Par.ID);

                END ELSE
                    FNC_Ignore_Request(updateRequest_Re_Par.ID);

                COMMIT();
            UNTIL (updateRequest_Re_Par.NEXT() = 0);
        FNC_ProgressBar_Close(1);

        IF NOT processSilently_Bo_Par THEN MESSAGE('Liste traitée !')
    end;

    procedure FNC_Add_Request(Requested_For_Deal_ID_Co_Par: Code[20]; Requested_By_Type_Co_Par: Option; Requested_By_TypeNo_Co_Par: Code[20]; Requested_At_DateTime_Par: DateTime) updateRequest_ID_Ret: Code[20]
    begin

        Setup.GET();

        updateRequest_ID_Ret := NoSeriesMgt_Cu.GetNextNo(Setup."Update Request Nos.", TODAY, TRUE);
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

    procedure FNC_Remove_Request(Request_ID_Co_Par: Code[20])
    begin

        IF UpdateRequest_Re.GET(Request_ID_Co_Par) THEN
            UpdateRequest_Re.DELETE();
    end;

    procedure FNC_Validate_Request(Request_ID_Co_Par: Code[20])
    begin

        IF UpdateRequest_Re.GET(Request_ID_Co_Par) THEN BEGIN
            UpdateRequest_Re.VALIDATE(Request_Status, UpdateRequest_Re.Request_Status::OK);
            UpdateRequest_Re.MODIFY();
        END
    end;

    procedure FNC_Ignore_Request(Request_ID_Co_Par: Code[20])
    begin

        IF UpdateRequest_Re.GET(Request_ID_Co_Par) THEN BEGIN
            UpdateRequest_Re.VALIDATE("To be ignored", TRUE);
            UpdateRequest_Re.MODIFY();
        END
    end;

    procedure FNC_Test(DealID_Co_Loc: Code[20]): Boolean
    begin
        IF DealID_Co_Loc = '' THEN BEGIN
            MESSAGE('Attention ! Il y a une requête de mise à jour sans numéro d''affaire dans la table Update Request Manager !');
            EXIT(FALSE);
        END;

        EXIT(TRUE);
    end;

    procedure FNC_Import_All()
    var
        deal_Re_Loc: Record "DEL Deal";
        counter_Loc: Integer;
    begin

        counter_Loc := 0;

        deal_Re_Loc.RESET();
        deal_Re_Loc.SETFILTER(Status, '%1|%2|%3',
          deal_Re_Loc.Status::"In order",
          deal_Re_Loc.Status::"In progress",
          deal_Re_Loc.Status::Invoiced
          );

        FNC_ProgressBar_Init(1, 500, 500, 'Création des update request...', deal_Re_Loc.COUNT());

        IF deal_Re_Loc.FINDFIRST() THEN
            REPEAT

                FNC_ProgressBar_Update(1);

                FNC_Add_Request(deal_Re_Loc.ID, UpdateRequest_Re.Requested_By_Type::CUSTOM.AsInteger(), 'All', CURRENTDATETIME);
                counter_Loc += 1;
            UNTIL (deal_Re_Loc.NEXT() = 0);

        FNC_ProgressBar_Close(1);

        MESSAGE('%1 update request(s) ajoutée(s) !', counter_Loc);
    end;

    procedure FNC_Import_BlankInvoices()
    var
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        counter_Loc: Integer;
    begin
        counter_Loc := 0;

        element_Re_Loc.RESET();
        element_Re_Loc.SETFILTER(Type,
          '%1|%2|%3', element_Re_Loc.Type::Invoice, element_Re_Loc.Type::"Sales Invoice", element_Re_Loc.Type::"Purchase Invoice");
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT
                position_Re_Loc.RESET();
                position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                IF NOT position_Re_Loc.FINDFIRST() THEN BEGIN
                    FNC_Add_Request(element_Re_Loc.Deal_ID, UpdateRequest_Re.Requested_By_Type::CUSTOM.AsInteger(), 'blank invoices', CURRENTDATETIME);
                    counter_Loc += 1;
                END;
            UNTIL (element_Re_Loc.NEXT() = 0);

        MESSAGE('%1 update request(s) ajoutée(s) !', counter_Loc);
    end;

    procedure FNC_ProcessRequestsByType(Type_Op_Par: Option Invoice,"Purchase Header","Sales Header","Sales Cr. Memo","Purch. Cr. Memo",Payment,Provision,USERID; TypeNo_Co_Par: Code[20]; processSilently_Bo_Par: Boolean)
    begin

        UpdateRequest_Re.RESET();

        UpdateRequest_Re.SETRANGE(Requested_By_Type, Type_Op_Par);

        IF TypeNo_Co_Par <> '' THEN
            UpdateRequest_Re.SETRANGE("Requested_By_Type No.", TypeNo_Co_Par);

        FNC_Process_Requests(UpdateRequest_Re, FALSE, FALSE, processSilently_Bo_Par);
    end;

    procedure FNC_ProgressBar_Init(index_Int_Par: Integer; interval_Int_Par: Integer; stepProgress_Int_Par: Integer; text_Te_Par: Text[50]; total_Int_Par: Integer)
    begin
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

    procedure FNC_ProgressBar_Update(index_Int_Par: Integer)
    begin
        intProgressI[index_Int_Par] += 1;

        IF timProgress[index_Int_Par] < TIME - interval[index_Int_Par] THEN BEGIN

            intProgress[index_Int_Par] := ROUND(intProgressI[index_Int_Par] / intProgressTotal[index_Int_Par] * 10000, 1);

            IF intProgress[index_Int_Par] > intNextProgressStep[index_Int_Par] THEN BEGIN

                intNextProgressStep[index_Int_Par] += intProgressStep[index_Int_Par];

                timProgress[index_Int_Par] := TIME;

                diaProgress[index_Int_Par].UPDATE();
            END;
        END;
    end;

    procedure FNC_ProgressBar_Close(index_Int_Par: Integer)
    begin
        diaProgress[index_Int_Par].CLOSE();
    end;

    procedure FNC_Process_RequestsDeal(updateRequest_Re_Par: Record "DEL Update Request Manager"; deleteWhenUpdated: Boolean; UpdatePlanned_Bo_Par: Boolean; processSilently_Bo_Par: Boolean; NumID: Code[20])
    var
    begin
        updateRequest_Re_Par.SETFILTER(Requested_By_User, '%1|%2', '', USERID);
        updateRequest_Re_Par.SETRANGE(Request_Status, UpdateRequest_Re.Request_Status::NOK);
        updateRequest_Re_Par.SETRANGE("To be ignored", FALSE);
        updateRequest_Re_Par.SETRANGE(updateRequest_Re_Par.ID, NumID);

        //check toutes les 500ms si au moins 1% d'avancé
        FNC_ProgressBar_Init(1, 1000, 100, 'Mise à jour en cours...', updateRequest_Re_Par.COUNT());

        IF updateRequest_Re_Par.FINDFIRST() THEN
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

    procedure FNC_Process_RequestsFilter(updateRequest_Re_Par: Record "DEL Update Request Manager"; deleteWhenUpdated: Boolean; UpdatePlanned_Bo_Par: Boolean; processSilently_Bo_Par: Boolean; FilterDeal: Text)
    var

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

        IF updateRequest_Re_Par.FINDFIRST() THEN
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
    end;
}
