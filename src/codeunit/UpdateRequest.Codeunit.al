codeunit 50008 "DEL Update Request"
{
    TableNo = "DEL ACO Connection";

    trigger OnRun()
    begin
        UpdateRequestManager_CU.FNC_Process_RequestsFilter(UpdateRequest_Re, FALSE, UpdatePlanned_Bo_Par, TRUE, Rec.Deal_ID);
    end;

    var
        UpdateRequest_Re: Record "DEL Update Request Manager";
        UpdateRequestManager_CU: Codeunit "DEL Update Request Manager";
        UpdatePlanned_Bo_Par: Boolean;

    procedure SetValeur(PrevuVar: Boolean)
    begin
        UpdatePlanned_Bo_Par := PrevuVar;
    end;
}

