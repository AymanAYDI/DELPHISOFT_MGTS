report 50022 "DEL Mise à jour statut"
{
    Caption = 'Status update';
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Deal"; "DEL Deal")
        {
            DataItemTableView = SORTING(ID)
                                ORDER(Ascending)
                                WHERE(Status = FILTER(<> Closed));
            RequestFilterFields = ID, Status, Date;

            trigger OnAfterGetRecord()
            begin
                i := i + 1;
                "DEL Deal".Status := "DEL Deal".Status::Closed;
                "DEL Deal".MODIFY();
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


    var
        i: Integer;
        text0001: Label 'Successfully completed.';
        text0002: Label 'Do you want update the deal status ?';
}

