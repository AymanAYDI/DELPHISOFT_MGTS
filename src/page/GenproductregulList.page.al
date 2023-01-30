page 50108 "DEL Gen.product regul. List"
{
    Caption = 'General product regulation';
    CardPageID = "DEL General regulation Card";
    Editable = false;
    PageType = List;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("General product"));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Description pays"; Rec."Description pays")
                {
                    ApplicationArea = All;
                }
                field(Nature; Rec.Nature)
                {
                    ApplicationArea = All;
                }
                field("Title in French"; Rec."Title in French")
                {
                    ApplicationArea = All;
                }
                field("Title in English"; Rec."Title in English")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Publication date"; Rec."Publication date")
                {
                    ApplicationArea = All;
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                    ApplicationArea = All;
                }
                field("Starting date"; Rec."Starting date")
                {
                    ApplicationArea = All;
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    ApplicationArea = All;
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                    ApplicationArea = All;
                }
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = All;
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    ApplicationArea = All;
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
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
