table 50010 "DEL Export vente"
{
    Caption = 'DEL Export vente';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(2; Mois; Text[6])
        {
            Caption = 'Mois';
        }
        field(3; "Activité"; Text[2])
        {
            Caption = 'Activité';
        }
        field(4; Pays; Text[2])
        {
            Caption = 'Pays';
        }
        field(5; Enseigne; Text[3])
        {
            Caption = 'Enseigne';
        }
        field(6; "Type d'identifiant"; Text[1])
        {
            Caption = 'Type d''identifiant';
        }
        field(7; "Identifiant produit"; Text[30])
        {
            Caption = 'Identifiant produit';
        }
        field(8; "Identifiant fabricant"; Text[10])
        {
            Caption = 'Identifiant fabricant';
        }
        field(9; Sens; Text[1])
        {
            Caption = 'Sens';
        }
        field(10; "Quantité"; Text[12])
        {
            Caption = 'Quantité';
        }
        field(11; "C.A. H.T."; Text[12])
        {
            Caption = 'C.A. H.T.';
        }
        field(12; Ean; Text[13])
        {
            Caption = 'Ean';
        }
        field(13; "Code Marque"; Text[10])
        {
            Caption = 'Code Marque';
        }
        field(14; Fournisseur; Text[10])
        {
            Caption = 'Fournisseur';
        }
        field(15; "Référence fournisseur"; Text[30])
        {
            Caption = 'Référence fournisseur';
        }
        field(16; Fabricant; Text[10])
        {
            Caption = 'Fabricant';
        }
        field(17; "Référence fabricant"; Text[30])
        {
            Caption = 'Référence fabricant';
        }
        field(18; "Fournisseur principal"; Text[10])
        {
            Caption = 'Fournisseur principal';
        }
        field(19; "Référence fournisseur Prin."; Text[30])
        {
            Caption = 'Référence fournisseur Prin.';
        }
        field(20; "Code article B.U"; Text[10])
        {
            Caption = 'Code article B.U';
        }
        field(21; "Groupe marchandise B.U"; Text[30])
        {
            Caption = 'Groupe marchandise B.U';
        }
        field(22; "Libellé produit"; Text[50])
        {
            Caption = 'Libellé produit';
        }
        field(23; QuantityDec; Decimal)
        {
            Caption = 'QuantityDec';
        }
        field(24; "CA HT"; Decimal)
        {
            Caption = 'CA HT';
        }
    }

    keys
    {
        key(Key1; "Item No.", Sens)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

