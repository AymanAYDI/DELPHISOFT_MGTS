page 50124 "DEL Erreur import Kiriba"
{
    PageType = List;
    SourceTable = "DEL Temp Kiriba";
    SourceTableView = SORTING("N° facture fournisseur", "No Traitement")
                      WHERE(Erreur = FILTER(<> ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Client; Rec.Client)
                {
                }
                field(Fournisseur; Rec.Fournisseur)
                {
                }
                field("N° facture fournisseur"; Rec."N° facture fournisseur")
                {
                }
                field(Erreur; Rec.Erreur)
                {
                }
                field(Devise; Rec.Devise)
                {
                }
                field(Montant; Rec.Montant)
                {
                }
                field("Date facture"; Rec."Date facture")
                {
                }
                field("Date compta"; Rec."Date compta")
                {
                }
                field("Cycle de netting"; Rec."Cycle de netting")
                {
                }
            }
        }
    }

    actions
    {
    }
}

