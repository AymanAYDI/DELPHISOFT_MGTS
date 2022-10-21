codeunit 50014 "DEL File recovery/NAV update"
{
    trigger OnRun()
    begin

        CODEUNIT.RUN(Codeunit::"DEL MGT Tracking");
        CODEUNIT.RUN(Codeunit::"DEL Tracking traitement");
    end;
}

