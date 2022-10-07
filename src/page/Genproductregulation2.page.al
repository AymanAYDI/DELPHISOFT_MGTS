page 50104 "DEL Gen. product regulation 2"
{
    Caption = 'General product regulation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
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
                field(Checked; Rec.Checked)
                {
                }
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Description pays"; Rec."Description pays")
                {
                }
                field(Nature; Rec.Nature)
                {
                    Editable = false;
                }
                field("Title in French"; Rec."Title in French")
                {
                    Editable = false;
                }
                field("Title in English"; Rec."Title in English")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Publication date"; Rec."Publication date")
                {
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                }
                field("Starting date"; Rec."Starting date")
                {
                    Editable = false;
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    Editable = false;
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                    Editable = false;
                }
                field(Statut; Rec.Statut)
                {
                    Editable = false;
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    Editable = false;
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'ICS';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Card)
            {
                Caption = 'Card';
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "DEL General regulation Card";
                RunPageLink = "No." = FIELD("No."), Type = FIELD(Type);
                RunPageMode = View;
            }
        }
    }
}

