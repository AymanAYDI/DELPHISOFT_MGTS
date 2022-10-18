codeunit 50034 "AUTO Update Request Manager"
{
    trigger OnRun()
    var
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
    begin
        UpdateRequestManager_Cu.FNC_Import_All();
        updateRequest_Re.RESET();
        UpdateRequestManager_Cu.FNC_Process_Requests(updateRequest_Re, FALSE, FALSE, TRUE);
    end;

    var
        updateRequest_Re: Record "DEL Update Request Manager";
}

