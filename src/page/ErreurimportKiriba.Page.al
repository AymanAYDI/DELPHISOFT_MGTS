page 50124 "DEL Erreur import Kiriba"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "DEL Temp Kiriba";
    SourceTableView = SORTING("N° facture fournisseur", "No Traitement")
                      WHERE(Erreur = FILTER(<> ''));
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Client; Rec.Client)
                {
                    ApplicationArea = All;
                }
                field(Fournisseur; Rec.Fournisseur)
                {
                    ApplicationArea = All;
                }
                field("N° facture fournisseur"; Rec."N° facture fournisseur")
                {
                    ApplicationArea = All;
                }
                field(Erreur; Rec.Erreur)
                {
                    ApplicationArea = All;
                }
                field(Devise; Rec.Devise)
                {
                    ApplicationArea = All;
                }
                field(Montant; Rec.Montant)
                {
                    ApplicationArea = All;
                }
                field("Date facture"; Rec."Date facture")
                {
                    ApplicationArea = All;
                }
                field("Date compta"; Rec."Date compta")
                {
                    ApplicationArea = All;
                }
                field("Cycle de netting"; Rec."Cycle de netting")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
