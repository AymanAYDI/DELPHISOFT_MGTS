table 50065 "DEL Temp Kiriba"
{
    Caption = 'Temp Kiriba';
    // DEL.SAZ  27.03.20  Modify field Erreur Lenth to 50


    fields
    {
        field(1; Client; Code[20])
        {
            Caption = 'Client';
        }
        field(2; Fournisseur; Code[20])
        {
            Caption = 'Fournisseur';
        }
        field(3; Devise; Text[30])
        {
            Caption = 'Devise';
        }
        field(4; Montant; Decimal)
        {
            Caption = 'Montant';
        }
        field(5; "Date facture"; Date)
        {
            Caption = 'Date facture';
        }
        field(6; "Date compta"; Date)
        {
            Caption = 'Date compta';
        }
        field(7; "N° facture fournisseur"; Code[20])
        {
            Caption = 'N° facture fournisseur';
        }
        field(8; "Cycle de netting"; Text[30])
        {
            Caption = 'Cycle de netting';
        }
        field(9; "Type de document"; Integer)
        {
            Caption = 'Type de document';
        }
        field(10; "Champ libre 1"; Text[30])
        {
            Caption = 'Champ libre 1';
        }
        field(11; "Champ libre 2"; Text[30])
        {
            Caption = 'Champ libre 2';
        }
        field(12; "Champ libre 3"; Text[30])
        {
            Caption = 'Champ libre 3';
        }
        field(13; "No Traitement"; Integer)
        {
            Caption = 'No Traitement';
        }
        field(14; Erreur; Text[50])
        {
            Caption = 'Erreur';
        }
        field(15; LineNo; Integer)
        {
            Caption = 'LineNo';
        }
    }

    keys
    {
        key(Key1; "N° facture fournisseur", "No Traitement", LineNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

