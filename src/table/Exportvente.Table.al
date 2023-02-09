table 50010 "DEL Export vente"
{
    Caption = 'DEL Export vente';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(2; Mois; Text[6])
        {
            Caption = 'Mois';
            DataClassification = CustomerContent;
        }
        field(3; "Activité"; Text[2])
        {
            Caption = 'Activité';
            DataClassification = CustomerContent;
        }
        field(4; Pays; Text[2])
        {
            Caption = 'Pays';
            DataClassification = CustomerContent;
        }
        field(5; Enseigne; Text[3])
        {
            Caption = 'Enseigne';
            DataClassification = CustomerContent;
        }
        field(6; "Type d'identifiant"; Text[1])
        {
            Caption = 'Type d''identifiant';
            DataClassification = CustomerContent;
        }
        field(7; "Identifiant produit"; Text[30])
        {
            Caption = 'Identifiant produit';
            DataClassification = CustomerContent;
        }
        field(8; "Identifiant fabricant"; Text[10])
        {
            Caption = 'Identifiant fabricant';
            DataClassification = CustomerContent;
        }
        field(9; Sens; Text[1])
        {
            Caption = 'Sens';
            DataClassification = CustomerContent;
        }
        field(10; "Quantité"; Text[12])
        {
            Caption = 'Quantité';
            DataClassification = CustomerContent;
        }
        field(11; "C.A. H.T."; Text[12])
        {
            Caption = 'C.A. H.T.';
            DataClassification = CustomerContent;
        }
        field(12; Ean; Text[13])
        {
            Caption = 'Ean';
            DataClassification = CustomerContent;
        }
        field(13; "Code Marque"; Text[10])
        {
            Caption = 'Code Marque';
            DataClassification = CustomerContent;
        }
        field(14; Fournisseur; Text[10])
        {
            Caption = 'Fournisseur';
            DataClassification = CustomerContent;
        }
        field(15; "Référence fournisseur"; Text[30])
        {
            Caption = 'Référence fournisseur';
            DataClassification = CustomerContent;
        }
        field(16; Fabricant; Text[10])
        {
            Caption = 'Fabricant';
            DataClassification = CustomerContent;
        }
        field(17; "Référence fabricant"; Text[30])
        {
            Caption = 'Référence fabricant';
            DataClassification = CustomerContent;
        }
        field(18; "Fournisseur principal"; Text[10])
        {
            Caption = 'Fournisseur principal';
            DataClassification = CustomerContent;
        }
        field(19; "Référence fournisseur Prin."; Text[30])
        {
            Caption = 'Référence fournisseur Prin.';
            DataClassification = CustomerContent;
        }
        field(20; "Code article B.U"; Text[10])
        {
            Caption = 'Code article B.U';
            DataClassification = CustomerContent;
        }
        field(21; "Groupe marchandise B.U"; Text[30])
        {
            Caption = 'Groupe marchandise B.U';
            DataClassification = CustomerContent;
        }
        field(22; "Libellé produit"; Text[50])
        {
            Caption = 'Libellé produit';
            DataClassification = CustomerContent;
        }
        field(23; QuantityDec; Decimal)
        {
            Caption = 'QuantityDec';
            DataClassification = CustomerContent;
        }
        field(24; "CA HT"; Decimal)
        {
            Caption = 'CA HT';
            DataClassification = CustomerContent;
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

