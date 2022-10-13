report 50032 "Deal items Update"
{
    //  THM        25.08.17      Create

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table27)
        {
            DataItemTableView = SORTING (No.)
                                ORDER(Ascending);
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                DealItem_Cu.FNC_Manual_Update2("No.");
                i := i + 1;
            end;

            trigger OnPostDataItem()
            begin
                IF i <> 0 THEN
                    MESSAGE('Mise à jour effectuée !');
            end;

            trigger OnPreDataItem()
            begin
                i := 0;
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
        DealItem_Cu: Codeunit "50024";
        i: Integer;
}

