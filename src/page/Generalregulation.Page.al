page 50096 "DEL General regulation"
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
                    Caption = 'ICS';
                }
            }
        }
    }

    actions
    {
    }
}

