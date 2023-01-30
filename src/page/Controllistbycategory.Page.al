page 50115 "DEL Control list by category"
{
    ApplicationArea = All;
    Caption = 'Control list by category';
    Editable = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = "DEL Regulation Matrix Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    ApplicationArea = All;
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
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
                field(Description; Rec.Description)
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
                field("Type of material"; Rec."Type of material")
                {
                    ApplicationArea = All;
                }
                field(Usage; Rec.Usage)
                {
                    ApplicationArea = All;
                }
                field("Substance - CAS / EINECS"; Rec."Substance - CAS / EINECS")
                {
                    ApplicationArea = All;
                }
                field("Substance - nom"; Rec."Substance - nom")
                {
                    ApplicationArea = All;
                }
                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                }
                field("Description Usage in French"; Rec."Description Usage in French")
                {
                    ApplicationArea = All;
                }
                field("List Items Associated"; Rec."List Items Associated")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    DrillDownPageID = "DEL Item Quality List";
                }
                field("Norm of testing"; Rec."Norm of testing")
                {
                    ApplicationArea = All;
                }
                field(Pays; Rec.Pays)
                {
                    ApplicationArea = All;
                }
                field(Checked; Rec.Checked)
                {
                    ApplicationArea = All;
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                    ApplicationArea = All;
                }
                field(Scope; Rec.Scope)
                {
                    ApplicationArea = All;
                }
                field("Test Type"; Rec."Test Type")
                {
                    ApplicationArea = All;
                }
                field(Descriptive; Rec.Descriptive)
                {
                    ApplicationArea = All;
                }
                field("Support Text"; Rec."Support Text")
                {
                    ApplicationArea = All;
                }
                field("Control Type"; Rec."Control Type")
                {
                    ApplicationArea = All;
                }
                field(Frequency; Rec.Frequency)
                {
                    ApplicationArea = All;
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    ApplicationArea = All;
                }
                field("Product Description"; Rec."Product Description")
                {
                    ApplicationArea = All;
                }
                field(Mark; Rec.Mark)
                {
                    ApplicationArea = All;
                }
                field("Description pays"; Rec."Description pays")
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
                field("Description Plan of control"; Rec."Description Plan of control")
                {
                    ApplicationArea = All;
                }
                field("Title in English"; Rec."Title in English")
                {
                    ApplicationArea = All;
                }
                field("Description Usage in English"; Rec."Description Usage in English")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.SETFILTER(Type, '<>%1', 0);
        Rec.SETFILTER("No.", '<>%1', '');
    end;
}
