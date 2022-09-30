codeunit 50005 "update logistic"
{

    trigger OnRun()
    begin


        IF logistic.FINDFIRST THEN BEGIN
            REPEAT
                logistic.VALIDATE(Deal_ID);
                logistic.MODIFY();

            UNTIL logistic.NEXT = 0;
        END;
    end;

    var
        logistic: Record "50034";
}

