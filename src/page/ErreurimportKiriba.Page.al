page 50124 "Erreur import Kiriba"
{
    PageType = List;
    SourceTable = Table50065;
    SourceTableView = SORTING (N° facture fournisseur, No Traitement)
                      WHERE (Erreur = FILTER (<> ''));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Client; Client)
                {
                }
                field(Fournisseur; Fournisseur)
                {
                }
                field("N° facture fournisseur"; "N° facture fournisseur")
                {
                }
                field(Erreur; Erreur)
                {
                }
                field(Devise; Devise)
                {
                }
                field(Montant; Montant)
                {
                }
                field("Date facture"; "Date facture")
                {
                }
                field("Date compta"; "Date compta")
                {
                }
                field("Cycle de netting"; "Cycle de netting")
                {
                }
            }
        }
    }

    actions
    {
    }
}

