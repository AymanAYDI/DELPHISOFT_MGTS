page 50112 "Matrix Substance regul List"
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
    //              THM     03.05.16           add "Description Usage"

    Caption = 'Substance regulation';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50051;
    SourceTableView = SORTING(Item Category Code, Product Group Code, Mark, Product Description, No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Materials));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; "Item Category Code")
                {
                    Visible = false;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Visible = false;
                }
                field("Item Category Label"; "Item Category Label")
                {
                    Visible = false;
                }
                field("Product Group Label"; "Product Group Label")
                {
                    Visible = false;
                }
                field(Type; Type)
                {
                    Visible = false;
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
        area(processing)
        {
            action(Card)
            {
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50095;
                RunPageLink = Item Category Code=FIELD(Item Category Code),
                              Product Group Code=FIELD(Product Group Code),
                              No.=FIELD(No.),
                              Type=FIELD(Type),
                              Mark=FIELD(Mark),
                              Product Description=FIELD(Product Description);
            }
        }
    }
}

