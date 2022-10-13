report 50022 "Mise à jour statut"
{
    // +------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                |
    // | Status:                                                                                  |
    // | Customer/Project:                                                                        |
    // +------------------------------------------------------------------------------------------+
    // Requirement  UserID   Date       Where             Description
    // -------------------------------------------------------------------------------------------+
    // T-00664     THM      02.06.14          Add Update deal status

    Caption = 'Status update';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1100113000; Table50020)
        {
            DataItemTableView = SORTING (ID)
                                ORDER(Ascending)
                                WHERE (Status = FILTER (<> Closed));
            RequestFilterFields = ID, Status, Date;

            trigger OnAfterGetRecord()
            begin
                i := i + 1;
                Deal.Status := Deal.Status::Closed;
                Deal.MODIFY;
            end;

            trigger OnPostDataItem()
            begin
                IF i > 0 THEN
                    MESSAGE(text0001);
            end;

            trigger OnPreDataItem()
            begin
                i := 0;
                IF NOT CONFIRM(text0002, FALSE) THEN EXIT;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        i: Integer;
        text0001: Label 'Successfully completed.';
        text0002: Label 'Do you want update the deal status ?';
}

