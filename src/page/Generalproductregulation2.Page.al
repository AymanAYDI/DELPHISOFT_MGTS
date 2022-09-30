page 50104 "General product regulation 2"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00757      THM     07.01.16           add and modify Field
    // T-00758      THM     12.01.16           add new field

    Caption = 'General product regulation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = Table50057;
    SourceTableView = SORTING(No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(General product));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Checked; Checked)
                {
                }
                field(Type; Type)
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Description pays"; "Description pays")
                {
                }
                field(Nature; Nature)
                {
                    Editable = false;
                }
                field("Title in French"; "Title in French")
                {
                    Editable = false;
                }
                field("Title in English"; "Title in English")
                {
                }
                field(Description; Description)
                {
                }
                field("Publication date"; "Publication date")
                {
                }
                field("Date limit of the application"; "Date limit of the application")
                {
                }
                field("Starting date"; "Starting date")
                {
                    Editable = false;
                }
                field("Date Fin"; "Date Fin")
                {
                    Editable = false;
                }
                field("Texte rattachement"; "Texte rattachement")
                {
                    Editable = false;
                }
                field(Statut; Statut)
                {
                    Editable = false;
                }
                field("Texte de remplacement"; "Texte de remplacement")
                {
                    Editable = false;
                }
                field("Referent Laboratory"; "Referent Laboratory")
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
                RunObject = Page 50097;
                RunPageLink = No.=FIELD(No.),
                              Type=FIELD(Type);
                RunPageMode = View;
            }
        }
    }
}

