page 50096 "DEL General regulation"
{


    Caption = 'General product regulation';
    CardPageID = "DEL General regulation Card";
    Editable = false;
    PageType = List;
    SourceTable = "DEL Regulation";
    SourceTableView = SORTING("No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("General product"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Description pays"; Rec."Description pays")
                {
                }
                field(Nature; Rec.Nature)
                {
                }
                field("Title in French"; Rec."Title in French")
                {
                }
                field("Title in English"; Rec."Title in English")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Starting date"; Rec."Starting date")
                {
                }
                field("Date Fin"; Rec."Date Fin")
                {
                }
                field("Publication date"; Rec."Publication date")
                {
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                }
                field(Statut; Rec.Statut)
                {
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                }
            }
        }
    }

    actions
    {
    }
}

