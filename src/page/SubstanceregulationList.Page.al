page 50109 "Substance regulation List"
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
    //              THM     03.05.16           add"Description Usage"

    Caption = 'Substance regulation';
    CardPageID = "Subs. regulation Card";
    Editable = false;
    PageType = List;
    SourceTable = Table50057;
    SourceTableView = SORTING(No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Materials));

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
                field("Type of material"; "Type of material")
                {
                }
                field(Usage; Usage)
                {
                }
                field("Description Usage in French"; "Description Usage in French")
                {
                }
                field("Description Usage in English"; "Description Usage in English")
                {
                }
                field("Substance - CAS / EINECS"; "Substance - CAS / EINECS")
                {
                }
                field("Substance - nom"; "Substance - nom")
                {
                }
                field(Source; Source)
                {
                }
                field("Starting date"; "Starting date")
                {
                }
                field("Date Fin"; "Date Fin")
                {
                }
                field("Norm of testing"; "Norm of testing")
                {
                }
                field(Statut; Statut)
                {
                }
                field("Texte de remplacement"; "Texte de remplacement")
                {
                }
            }
        }
    }

    actions
    {
    }
}

