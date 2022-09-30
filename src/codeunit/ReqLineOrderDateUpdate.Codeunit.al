codeunit 50001 "ReqLine OrderDate Update"
{

    trigger OnRun()
    begin
        ReqLine.SETFILTER(ReqLine."Order Date", '<>%1', 0D);
        IF ReqLine.FINDFIRST THEN BEGIN
            REPEAT

                ReqLine."Order Date" := WORKDATE;
                ReqLine.VALIDATE("Order Date");
                ReqLine.MODIFY;

            UNTIL ReqLine.NEXT = 0;
        END;
    end;

    var
        ReqLine: Record "246";
}

