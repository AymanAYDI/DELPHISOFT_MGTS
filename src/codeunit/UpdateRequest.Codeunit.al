codeunit 50008 "Update Request"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------

    TableNo = 50026;

    trigger OnRun()
    begin
        UpdateRequestManager_CU.FNC_Process_RequestsFilter(UpdateRequest_Re, FALSE, UpdatePlanned_Bo_Par, TRUE, Rec.Deal_ID);
    end;

    var
        UpdateRequestManager_CU: Codeunit "50032";
        UpdateRequest_Re: Record "50039";
        filterdeal: Text;
        UpdatePlanned_Bo_Par: Boolean;
        i: Integer;

    [Scope('Internal')]
    procedure SetValeur(PrevuVar: Boolean)
    begin
        UpdatePlanned_Bo_Par := PrevuVar;
    end;
}

