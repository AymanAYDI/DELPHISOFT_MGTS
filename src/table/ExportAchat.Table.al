table 50007 "DEL Export Achat"
{
    Caption = 'DEL Export Achat';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            DataClassification = CustomerContent;
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
        field(23; "Quantity Com."; Decimal)
        {
            Caption = 'Quantity Com.';
            DataClassification = CustomerContent;
        }
        field(24; "CA HT Com."; Decimal)
        {
            Caption = 'CA HT Com.';
            DataClassification = CustomerContent;
        }
        field(25; "Quantity Liv."; Decimal)
        {
            Caption = 'Quantity Liv.';
            DataClassification = CustomerContent;
        }
        field(26; "CA HT Liv."; Decimal)
        {
            Caption = 'CA HT Liv.';
            DataClassification = CustomerContent;
        }
        field(27; "Quantity Fact."; Decimal)
        {
            Caption = 'Quantity Fact.';
            DataClassification = CustomerContent;
        }
        field(28; "CA HT Fact."; Decimal)
        {
            Caption = 'CA HT Fact.';
            DataClassification = CustomerContent;
        }
        field(29; "Quantity Com.Txt"; Text[12])
        {
            Caption = 'Quantity Com.Txt';
            DataClassification = CustomerContent;
        }
        field(30; "CA HT Com. Txt"; Text[12])
        {
            Caption = 'CA HT Com. Txt';
            DataClassification = CustomerContent;
        }
        field(31; "Quantity Liv. Txt"; Text[12])
        {
            Caption = 'Quantity Liv. Txt';
            DataClassification = CustomerContent;
        }
        field(32; "CA HT Liv. Txt"; Text[12])
        {
            Caption = 'CA HT Liv. Txt';
            DataClassification = CustomerContent;
        }
        field(33; "Quantity Fact. Txt"; Text[12])
        {
            Caption = 'Quantity Fact. Txt';
            DataClassification = CustomerContent;
        }
        field(34; "CA HT Fact. Txt"; Text[12])
        {
            Caption = 'CA HT Fact. Txt';
            DataClassification = CustomerContent;
        }
        field(35; "Code Fournisseur"; Text[10])
        {
            Caption = 'Code Fournisseur';
            DataClassification = CustomerContent;
        }
        field(36; "Type flux"; Text[1])
        {
            Caption = 'Type flux';
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

