codeunit 50014 "DEL File recovery/NAV update"
{
    trigger OnRun()
    begin

        CODEUNIT.RUN(50003);
        CODEUNIT.RUN(50006);
    end;
}

