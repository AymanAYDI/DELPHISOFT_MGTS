report 50032 "DEL Deal items Update"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
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

    var
        DealItem_Cu: Codeunit "DEL Deal Item";
        i: Integer;
}

