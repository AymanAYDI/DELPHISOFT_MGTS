codeunit 50001 "DEL ReqLine OrderDate Update"
{

    trigger OnRun()
    begin
        ReqLine.SETFILTER(ReqLine."Order Date", '<>%1', 0D);
        IF ReqLine.FindSet() THEN
            REPEAT

                ReqLine."Order Date" := WORKDATE();
                ReqLine.VALIDATE("Order Date");
                ReqLine.MODIFY();

            UNTIL ReqLine.NEXT() = 0;
    end;

    var
        ReqLine: Record "Requisition Line";
}

