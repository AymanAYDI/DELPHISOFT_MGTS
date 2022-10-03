codeunit 50005 "DEL update logistic"
{

    trigger OnRun()
    begin


        IF logistic.FINDFIRST() THEN
            REPEAT
                logistic.VALIDATE(Deal_ID);
                logistic.MODIFY();

            UNTIL logistic.NEXT() = 0;
    end;

    var
        logistic: Record "DEL Logistic";
}

