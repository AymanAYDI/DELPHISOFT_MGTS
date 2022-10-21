codeunit 50037 "DEL LogiProgressBar"
{

    trigger OnRun()
    begin
        FNC_TestProgressBar();
    end;

    var
        LogiProgressBar_Cu: Codeunit "DEL LogiProgressBar";
        diaProgress: array[10] of Dialog;
        interval: array[10] of Integer;
        intNextProgressStep: array[10] of Integer;
        intProgress: array[10] of Integer;
        intProgressI: array[10] of Integer;
        intProgressStep: array[10] of Integer;
        intProgressTotal: array[10] of Integer;
        timProgress: array[10] of Time;


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


    procedure FNC_ProgressBar_Init(index_Int_Par: Integer; interval_Int_Par: Integer; stepProgress_Int_Par: Integer; text_Te_Par: Text[50]; total_Int_Par: Integer)
    begin
        interval[index_Int_Par] := interval_Int_Par;
        intProgressStep[index_Int_Par] := stepProgress_Int_Par;
        intNextProgressStep[index_Int_Par] := stepProgress_Int_Par;
        intProgressI[index_Int_Par] := 0;
        intProgress[index_Int_Par] := 0;
        diaProgress[index_Int_Par].OPEN(
          text_Te_Par + '\@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\',
          intProgress[index_Int_Par]
        );
        intProgressTotal[index_Int_Par] := total_Int_Par;
        timProgress[index_Int_Par] := TIME;

    end;


    procedure FNC_ProgressBar_Update(index_Int_Par: Integer)
    begin
        intProgressI[index_Int_Par] += 1;

        IF timProgress[index_Int_Par] < TIME - interval[index_Int_Par] THEN BEGIN

            intProgress[index_Int_Par] := ROUND(intProgressI[index_Int_Par] * (10000 / intProgressTotal[index_Int_Par]), 1);

            IF intProgress[index_Int_Par] >= intNextProgressStep[index_Int_Par] THEN BEGIN

                intNextProgressStep[index_Int_Par] := intProgress[index_Int_Par] + intProgressStep[index_Int_Par];

                diaProgress[index_Int_Par].UPDATE();
                timProgress[index_Int_Par] := TIME;

            END;

        END;
    end;


    procedure FNC_ProgressBar_Close(index_Int_Par: Integer)
    begin
        diaProgress[index_Int_Par].CLOSE();
    end;
}

