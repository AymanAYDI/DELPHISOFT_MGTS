report 50031 "Correction pas gestion stock"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.";
            column(CodeArticle; Item."No.")
            {
            }
            column(Pasgestiondestock; Item."No Stockkeeping")
            {
            }
            column(systemedereappro; Item."Replenishment System")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Item."Replenishment System" := 0;
                Item."No Stockkeeping" := TRUE;
                Item.MODIFY();
            end;
        }
    }


}

