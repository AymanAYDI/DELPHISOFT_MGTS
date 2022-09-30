codeunit 50046 "API Orders  Mgt.Job"
{
    // Mgts10.00.01.00 | 11.01.2020 | Order API Management

    TableNo = 472;

    trigger OnRun()
    begin
        APIOrdersMgt.RUN;
    end;

    var
        APIOrdersMgt: Codeunit "50045";
}

