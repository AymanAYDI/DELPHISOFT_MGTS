codeunit 50099 "DEL TEMP TOOLS 2"
{
    Permissions = TableData "Sales Invoice Header" = rimd;

    trigger OnRun()
    var

        JSONRequestslog: Record "DEL JSON Requests log";
    begin
        JSONRequestslog.SETRANGE(Error, TRUE);
        MESSAGE('%1', JSONRequestslog.COUNT);

    end;
}

