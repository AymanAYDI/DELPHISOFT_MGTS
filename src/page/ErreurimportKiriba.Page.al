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
                    Caption = 'Client';
                }
                field(Fournisseur; Rec.Fournisseur)
                {
                    Caption = 'Fournisseur';
                }
                field("N° facture fournisseur"; Rec."N° facture fournisseur")
                {
                    Caption = 'N° facture fournisseur';
                }
                field(Erreur; Rec.Erreur)
                {
                    Caption = 'Erreur';
                }
                field(Devise; Rec.Devise)
                {
                    Caption = 'Devise';
                }
                field(Montant; Rec.Montant)
                {
                    Caption = 'Montant';
                }
                field("Date facture"; Rec."Date facture")
                {
                    Caption = 'Date facture';
                }
                field("Date compta"; Rec."Date compta")
                {
                    Caption = 'Date compta';
                }
                field("Cycle de netting"; Rec."Cycle de netting")
                {
                    Caption = 'Cycle de netting';
                }
            }
        }
    }

    actions
    {
    }
}

