page 50096 "General regulation"
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
    // T-00783      THM     04.04.16           Delete Fields
    //              THM     26.08.16           modify captionML

    Caption = 'General product regulation';
    CardPageID = "General regulation Card";
    Editable = false;
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
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Description pays"; "Description pays")
                {
                }
                field(Nature; Nature)
                {
                }
                field("Title in French"; "Title in French")
                {
                }
                field("Title in English"; "Title in English")
                {
                }
                field(Description; Description)
                {
                }
                field("Starting date"; "Starting date")
                {
                }
                field("Date Fin"; "Date Fin")
                {
                }
                field("Publication date"; "Publication date")
                {
                }
                field("Date limit of the application"; "Date limit of the application")
                {
                }
                field("Texte rattachement"; "Texte rattachement")
                {
                }
                field(Statut; Statut)
                {
                }
                field("Texte de remplacement"; "Texte de remplacement")
                {
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
    }
}

