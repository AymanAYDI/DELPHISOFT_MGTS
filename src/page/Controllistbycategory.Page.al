page 50115 "Control list by category"
{
    Caption = 'Control list by category';
    Editable = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = Table50051;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; "Item Category Code")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Item Category Label"; "Item Category Label")
                {
                }
                field("Product Group Label"; "Product Group Label")
                {
                }
                field("No."; "No.")
                {
                }
                field(Type; Type)
                {
                }
                field(Nature; Nature)
                {
                }
                field("Title in French"; "Title in French")
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
                field("Texte rattachement"; "Texte rattachement")
                {
                }
                field(Statut; Statut)
                {
                }
                field("Texte de remplacement"; "Texte de remplacement")
                {
                }
                field("Type of material"; "Type of material")
                {
                }
                field(Usage; Usage)
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
                field("Description Usage in French"; "Description Usage in French")
                {
                }
                field("List Items Associated"; "List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "Item Quality List";
                }
                field("Norm of testing"; "Norm of testing")
                {
                }
                field(Pays; Pays)
                {
                }
                field(Checked; Checked)
                {
                }
                field("Livrables 1"; "Livrables 1")
                {
                }
                field(Scope; Scope)
                {
                }
                field("Test Type"; "Test Type")
                {
                }
                field(Descriptive; Descriptive)
                {
                }
                field("Support Text"; "Support Text")
                {
                }
                field("Control Type"; "Control Type")
                {
                }
                field(Frequency; Frequency)
                {
                }
                field("Referent Laboratory"; "Referent Laboratory")
                {
                }
                field("Product Description"; "Product Description")
                {
                }
                field(Mark; Mark)
                {
                }
                field("Description pays"; "Description pays")
                {
                }
                field("Publication date"; "Publication date")
                {
                }
                field("Date limit of the application"; "Date limit of the application")
                {
                }
                field("Description Plan of control"; "Description Plan of control")
                {
                }
                field("Title in English"; "Title in English")
                {
                }
                field("Description Usage in English"; "Description Usage in English")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        SETFILTER(Type, '<>%1', 0);
        SETFILTER("No.", '<>%1', '');
    end;
}

