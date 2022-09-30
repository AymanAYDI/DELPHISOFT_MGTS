codeunit 50049 "Purge API Tracking Records"
{
    // Mgts10.00.01.02 | 24.02.2020 | Order API Management : Add C\AL in : OnRun

    TableNo = 472;

    trigger OnRun()
    var
        OrderAPIRecordTracking: Record "50074";
    begin
        OrderAPIRecordTracking.SETCURRENTKEY("Sent Deal");
        OrderAPIRecordTracking.SETRANGE("Sent Deal", TRUE);
        OrderAPIRecordTracking.DELETEALL(TRUE);
    end;
}

