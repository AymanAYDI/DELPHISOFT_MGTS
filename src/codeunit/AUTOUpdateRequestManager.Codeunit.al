codeunit 50034 "AUTO Update Request Manager"
{
    // CHG04                            26.09.11   adapted deal update function with "updatePlanned" parameter


    trigger OnRun()
    var
        UpdateRequestManager_Cu: Codeunit "50032";
    begin
        UpdateRequestManager_Cu.FNC_Import_All();
        updateRequest_Re.RESET();
        UpdateRequestManager_Cu.FNC_Process_Requests(updateRequest_Re, FALSE, FALSE, TRUE);
    end;

    var
        updateRequest_Re: Record "50039";
}

