codeunit 50049 "DEL Purge API Tracking Records"
{


    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        OrderAPIRecordTracking: Record "DEL Order API Record Tracking";
    begin
        OrderAPIRecordTracking.SETCURRENTKEY("Sent Deal");
        OrderAPIRecordTracking.SETRANGE("Sent Deal", TRUE);
        OrderAPIRecordTracking.DELETEALL(TRUE);
    end;
}

