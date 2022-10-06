page 50115 "DEL Control list by category"
{
    Caption = 'Control list by category';
    Editable = false;
    PageType = List;
    ShowFilter = true;
    SourceTable = "DEL Regulation Matrix Line";
    UsageCategory = Lists; // a verifier
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Caption = 'Product Group Code';
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                    Caption = 'Item category description';
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                    Caption = 'Product group description';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(Nature; Rec.Nature)
                {
                    Caption = 'Type of regulation';
                }
                field("Title in French"; Rec."Title in French")
                {
                    Caption = 'Title in French';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Starting date"; Rec."Starting date")
                {
                    Caption = 'Starting date';
                }
                field("Date Fin"; Rec."Date Fin")
                {
                    Caption = 'End date';
                }
                field("Texte rattachement"; Rec."Texte rattachement")
                {
                    Caption = 'Text of connection';
                }
                field(Statut; Rec.Statut)
                {
                    Caption = 'Status';
                }
                field("Texte de remplacement"; Rec."Texte de remplacement")
                {
                    Caption = 'Text of substitution';
                }
                field("Type of material"; Rec."Type of material")
                {
                    Caption = 'Type of material';
                }
                field(Usage; Rec.Usage)
                {
                    Caption = 'Usage';
                }
                field("Substance - CAS / EINECS"; Rec."Substance - CAS / EINECS")
                {
                    Caption = 'Substance ID';
                }
                field("Substance - nom"; Rec."Substance - nom")
                {
                    Caption = 'Substance name';
                }
                field(Source; Rec.Source)
                {
                    Caption = 'Origine';
                }
                field("Description Usage in French"; Rec."Description Usage in French")
                {
                    Caption = 'Description Usage in French';
                }
                field("List Items Associated"; Rec."List Items Associated")
                {
                    DrillDown = true;
                    DrillDownPageID = "DEL Item Quality List";
                    Caption = 'List Items Associated';
                }
                field("Norm of testing"; Rec."Norm of testing")
                {
                    Caption = 'Norm of testing';
                }
                field(Pays; Rec.Pays)
                {
                    Caption = 'Country Code';
                }
                field(Checked; Rec.Checked)
                {
                    Caption = 'Checked';
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                    Caption = 'Deliverables 1';
                }
                field(Scope; Rec.Scope)
                {
                    Caption = 'Scope';
                }
                field("Test Type"; Rec."Test Type")
                {
                    Caption = 'Test Type';
                }
                field(Descriptive; Rec.Descriptive)
                {
                    Caption = 'Descriptive';
                }
                field("Support Text"; Rec."Support Text")
                {
                    Caption = 'Support Text';
                }
                field("Control Type"; Rec."Control Type")
                {
                    Caption = 'Type de contrôle';
                }
                field(Frequency; Rec.Frequency)
                {
                    Caption = 'Frequency';
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                    Caption = 'Referent Laboratory';
                }
                field("Product Description"; Rec."Product Description")
                {
                    Caption = 'Description produit';
                }
                field(Mark; Rec.Mark)
                {
                    Caption = 'Mark';
                }
                field("Description pays"; Rec."Description pays")
                {
                    Caption = 'Country';
                }
                field("Publication date"; Rec."Publication date")
                {
                    Caption = 'Publication date';
                }
                field("Date limit of the application"; Rec."Date limit of the application")
                {
                    Caption = 'Date limit of the application';
                }
                field("Description Plan of control"; Rec."Description Plan of control")
                {
                    Caption = 'Description';
                }
                field("Title in English"; Rec."Title in English")
                {
                    Caption = 'Title in English';
                }
                field("Description Usage in English"; Rec."Description Usage in English")
                {
                    Caption = 'Description Usage in English';
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

