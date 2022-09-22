table 50065 "DEL Temp Kiriba"
{
    Caption = 'Temp Kiriba';
    DataClassification = CustomerContent;



    fields
    {
        field(1; Client; Code[20])
        {
            Caption = 'Client';
            DataClassification = CustomerContent;
        }
        field(2; Fournisseur; Code[20])
        {
            Caption = 'Fournisseur';
            DataClassification = CustomerContent;
        }
        field(3; Devise; Text[30])
        {
            Caption = 'Devise';
            DataClassification = CustomerContent;
        }
        field(4; Montant; Decimal)
        {
            Caption = 'Montant';
            DataClassification = CustomerContent;
        }
        field(5; "Date facture"; Date)
        {
            Caption = 'Date facture';
            DataClassification = CustomerContent;
        }
        field(6; "Date compta"; Date)
        {
            Caption = 'Date compta';
            DataClassification = CustomerContent;
        }
        field(7; "N° facture fournisseur"; Code[20])
        {
            Caption = 'N° facture fournisseur';
            DataClassification = CustomerContent;
        }
        field(8; "Cycle de netting"; Text[30])
        {
            Caption = 'Cycle de netting';
            DataClassification = CustomerContent;
        }
        field(9; "Type de document"; Integer)
        {
            Caption = 'Type de document';
            DataClassification = CustomerContent;
        }
        field(10; "Champ libre 1"; Text[30])
        {
            Caption = 'Champ libre 1';
            DataClassification = CustomerContent;
        }
        field(11; "Champ libre 2"; Text[30])
        {
            Caption = 'Champ libre 2';
            DataClassification = CustomerContent;
        }
        field(12; "Champ libre 3"; Text[30])
        {
            Caption = 'Champ libre 3';
            DataClassification = CustomerContent;
        }
        field(13; "No Traitement"; Integer)
        {
            Caption = 'No Traitement';
            DataClassification = CustomerContent;
        }
        field(14; Erreur; Text[50])
        {
            Caption = 'Erreur';
            DataClassification = CustomerContent;
        }
        field(15; LineNo; Integer)
        {
            Caption = 'LineNo';
            DataClassification = CustomerContent;
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

