codeunit 50037 LogiProgressBar
{

    trigger OnRun()
    begin
        FNC_TestProgressBar();
    end;

    var
        LogiProgressBar_Cu: Codeunit "50037";
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
    procedure FNC_TestProgressBar()
    var
        i: Integer;
    begin
        LogiProgressBar_Cu.FNC_ProgressBar_Init(1, 100, 1000, 'Updating1...', 10);

        i := 0;

        REPEAT

            i += 1;
            LogiProgressBar_Cu.FNC_ProgressBar_Update(1);
            FNC_TestProgressBar2();

        UNTIL (i >= 10);

        LogiProgressBar_Cu.FNC_ProgressBar_Close(1);
    end;

    [Scope('Internal')]
    procedure FNC_TestProgressBar2()
    var
        i: Integer;
    begin
        LogiProgressBar_Cu.FNC_ProgressBar_Init(2, 200, 500, 'Updating2...', 500000);

        i := 0;

        REPEAT

            LogiProgressBar_Cu.FNC_ProgressBar_Update(2);
            i += 1;

        UNTIL (i >= 500000);

        LogiProgressBar_Cu.FNC_ProgressBar_Close(2);
    end;

    [Scope('Internal')]
    procedure FNC_ProgressBar_Init(index_Int_Par: Integer; interval_Int_Par: Integer; stepProgress_Int_Par: Integer; text_Te_Par: Text[50]; total_Int_Par: Integer)
    begin
        /*
        usage:
          //check toutes les 500ms si 1% d'avancé (100)
          LogiProgressBar.FNC_ProgressBar_Init(1,500,100,'Updating1...',deal_Re_Loc.count())
        
        L'index permet d'avoir plusieur barres de progression lors d'un meme traitement.
        
        valeur par defaut :
        interval 1000;
        step progress 1000;
        
        -> Signifie qu'on met à jour la barre de controle toutes les 1000ms si le traitement a avancé d'au moins 10%
        */

        // nombre de milisecondes après lesquelles il faut vérifier l'avancement
        interval[index_Int_Par] := interval_Int_Par;

        // avancement minimum nécessaire pour la mise à jour de la barre
        intProgressStep[index_Int_Par] := stepProgress_Int_Par;

        // valeur minimum à atteindre pour que la barre soit mise à jour
        intNextProgressStep[index_Int_Par] := stepProgress_Int_Par;

        // représente la variable d'itération
        intProgressI[index_Int_Par] := 0;

        // représente le pourcentage d'avancement affiché dans la barre d'avancement
        intProgress[index_Int_Par] := 0;

        // la barre d'avancement
        diaProgress[index_Int_Par].OPEN(
          text_Te_Par + '\@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\',
          intProgress[index_Int_Par]
        );

        // représente le 100% de l'avancement
        intProgressTotal[index_Int_Par] := total_Int_Par;

        // contient le temps pour comparer les milisecondes
        timProgress[index_Int_Par] := TIME;

    end;

    [Scope('Internal')]
    procedure FNC_ProgressBar_Update(index_Int_Par: Integer)
    begin
        //incrémentation de la variable d'itération
        intProgressI[index_Int_Par] += 1;

        //si au moins x milisecondes se sont écoulé depuis la dernière itération (paramètre interval)
        //controle important pour éviter la surcharge de calcul
        IF timProgress[index_Int_Par] < TIME - interval[index_Int_Par] THEN BEGIN

            //calcul le pourcentage d'avancement
            intProgress[index_Int_Par] := ROUND(intProgressI[index_Int_Par] * (10000 / intProgressTotal[index_Int_Par]), 1);

            //si le pourcentage d'avancement a avancé d'au moins x pourcent (paramètre intProgressStep)
            IF intProgress[index_Int_Par] >= intNextProgressStep[index_Int_Par] THEN BEGIN

                //définition du prochain niveau de progression = le progrès réalisé + l'avancement minimum nécessaire
                intNextProgressStep[index_Int_Par] := intProgress[index_Int_Par] + intProgressStep[index_Int_Par];

                //mise à jour de la barre
                diaProgress[index_Int_Par].UPDATE;

                //mise à jour du temps
                timProgress[index_Int_Par] := TIME;

            END;

        END;
    end;

    [Scope('Internal')]
    procedure FNC_ProgressBar_Close(index_Int_Par: Integer)
    begin
        diaProgress[index_Int_Par].CLOSE;
    end;
}

