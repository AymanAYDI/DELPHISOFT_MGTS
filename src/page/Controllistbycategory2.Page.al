page 50116 "DEL Control list by category 2"
{
    Caption = 'Control list by category';
    Editable = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = "DEL Regulation Matrix Line";
    UsageCategory = Lists; //TODO  : a  verifier 
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Nature; Rec.Nature)
                {
                }
                field("Title in French"; Rec."Title in French")
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
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                }
                field(Statut; Rec.Statut)
                {
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                }
                field("Type of material"; Rec."Type of material")
                {
                }
                field(Usage; Rec.Usage)
                {
                }
                field("Substance - CAS / EINECS"; Rec."Substance - CAS / EINECS")
                {
                }
                field("Substance - nom"; Rec."Substance - nom")
                {
                }
                field(Source; Rec.Source)
                {
                }
                field("Description Usage in French"; Rec."Description Usage in French")
                {
                }
                field("List Items Associated"; Rec."List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "DEL Item Quality List";
                }
                field("Norm of testing"; Rec."Norm of testing")
                {
                }
                field(Pays; Rec.Pays)
                {
                }
                field(Checked; Rec.Checked)
                {
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                }
                field(Scope; Rec.Scope)
                {
                }
                field("Test Type"; Rec."Test Type")
                {
                }
                field(Descriptive; Rec.Descriptive)
                {
                }
                field("Support Text"; Rec."Support Text")
                {
                }
                field("Control Type"; Rec."Control Type")
                {
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                }
                field("Product Description"; Rec."Product Description")
                {
                }
                field(Mark; Rec.Mark)
                {
                }
                field("Description pays"; Rec."Description pays")
                {
                }
                field("Publication date"; Rec."Publication date")
                {
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                }
                field("Description Plan of control"; Rec."Description Plan of control")
                {
                }
                field("Title in English"; Rec."Title in English")
                {
                }
                field("Description Usage in English"; Rec."Description Usage in English")
                {
                }
            }
        }
    }

    actions
    {
    }
}


