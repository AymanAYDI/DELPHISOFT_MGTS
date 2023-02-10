page 50070 "DEL Liste suivi liasse doc"
{
    ApplicationArea = all;
    Caption = 'follow General contract doc case List';
    CardPageID = "DEL Fiche suivi liasse doc";
    Editable = false;
    PageType = List;
    SourceTable = Vendor;
    SourceTableView = SORTING("No.")
                      ORDER(Ascending)
                      WHERE("Vendor Posting Group" = FILTER('MARCH'));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("Statut CG"; Rec."DEL Statut CG")
                {
                    ApplicationArea = All;
                }
                field("Date de maj statut CG"; Rec."DEL Date de maj statut CG")
                {
                    ApplicationArea = All;
                }
                field("Statut CE"; Rec."DEL Statut CE")
                {
                    ApplicationArea = All;
                }
                field("Date de maj statut CE"; Rec."DEL Date de maj statut CE")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
