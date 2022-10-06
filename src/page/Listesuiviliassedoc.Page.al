page 50070 "DEL Liste suivi liasse doc"
{

    Caption = 'follow General contract doc case List';
    CardPageID = "DEL Fiche suivi liasse doc";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;
    //TODO SourceTableView = SORTING("No.")
    //                   ORDER(Ascending)
    //                   WHERE("Vendor Posting Group"=FILTER(MARCH));


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field(Contact; Rec.Contact)
                {
                }
                field("Statut CG"; Rec."DEL Statut CG")
                {
                }
                field("Date de maj statut CG"; Rec."DEL Date de maj statut CG")
                {
                }
                field("Statut CE"; Rec."DEL Statut CE")
                {
                }
                field("Date de maj statut CE"; Rec."DEL Date de maj statut CE")
                {
                }
            }
        }
    }

    actions
    {
    }
}

