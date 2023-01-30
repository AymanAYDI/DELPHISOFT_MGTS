tableextension 50045 "DEL UserSetup" extends "User Setup"
{
    fields
    {
        field(50000; "DEL Resend EDI Document"; Boolean)
        {
            Caption = 'Resend EDI Document';
            DataClassification = CustomerContent;
        }
        field(4006496; "DEL Katalog ID"; Code[20])
        {
            Caption = 'Catalogue ID';
            DataClassification = CustomerContent;
            // TableRelation = Katalogkopf; TODO: table "Katalogkopf" not migrated yet
        }
        field(4006497; "DEL Agenda"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(4006498; "DEL GL"; Boolean)
        {
            Caption = 'General Ledger';
            DataClassification = CustomerContent;
        }
        field(4006499; "DEL Zeichnungsverwaltung"; Boolean)
        {
            Caption = 'CAD Drawing Management';
            DataClassification = CustomerContent;
        }
        field(4006500; "DEL Importfilter global"; Text[250])
        {
            Caption = 'Global Import Filter';
            DataClassification = CustomerContent;
        }
        field(4006501; "DEL Importfilter"; Text[250])
        {
            Caption = 'Import Filter';
            DataClassification = CustomerContent;
        }
        field(4006502; "DEL Aktualisierung Dokumente"; Boolean)
        {
            Caption = 'Update Documents';
            DataClassification = CustomerContent;
        }
        field(4006503; "DEL Zertifizierung Checkliste"; Boolean)
        {
            Caption = 'Checklist Certification';
            DataClassification = CustomerContent;
        }
        field(4006504; "DEL Zertifizierung Debitor"; Boolean)
        {
            Caption = 'Customer Certification';
            DataClassification = CustomerContent;
        }
        field(4006505; "DEL Zertifizierung Adresse"; Boolean)
        {
            Caption = 'Certification Address';
            DataClassification = CustomerContent;
        }
        field(4006506; "DEL Zertifizierung Kreditor"; Boolean)
        {
            Caption = 'Vendor Vertification';
            DataClassification = CustomerContent;
        }
        field(4006507; "DEL Zertifizierung Artikel"; Boolean)
        {
            Caption = 'Certification Item';
            DataClassification = CustomerContent;
        }
        field(4006508; "DEL Zertifizierung Geraet"; Boolean)
        {
            Caption = 'Certification Device';
            DataClassification = CustomerContent;
        }
        field(4006509; "DEL Zertifizierung Ressource"; Boolean)
        {
            Caption = 'Certification Resource';
            DataClassification = CustomerContent;
        }
        field(4006510; "DEL Zertifizierung Anlage"; Boolean)
        {
            Caption = 'Asset Certification';
            DataClassification = CustomerContent;
        }
        field(4006511; "DEL Zertifizierung Personalwesen"; Boolean)
        {
            Caption = 'Human Resources Certification';
            DataClassification = CustomerContent;
        }
        field(4006512; "DEL Zertifizierung Personalstamm"; Boolean)
        {
            Caption = 'Permanent Staff Certification';
            DataClassification = CustomerContent;
        }
        field(4006513; "DEL Zertifizierung Werkzeug"; Boolean)
        {
            Caption = 'Certification Tool';
            DataClassification = CustomerContent;
        }
        field(4006514; "DEL Zertifizierung Operationsplan"; Boolean)
        {
            Caption = 'Operation Plan Certification';
            DataClassification = CustomerContent;
        }
        field(4006515; "DEL Zertifizierung Person ZW"; Boolean)
        {
            Caption = 'Person Assignment Certification';
            DataClassification = CustomerContent;
        }
        field(4006516; "DEL Zertifizierung Katalog"; Boolean)
        {
            Caption = 'Certification Catalogue';
            DataClassification = CustomerContent;
        }
        field(4006517; "DEL Zertifizierung Artikelgruppe"; Boolean)
        {
            Caption = 'Certification Item Group';
            DataClassification = CustomerContent;
        }
        field(4006518; "DEL Zertifizierung Kapitel"; Boolean)
        {
            Caption = 'Chapter Certification';
            DataClassification = CustomerContent;
        }
        field(4006519; "DEL Zertifizierung Kataloggruppe"; Boolean)
        {
            Caption = 'Catalogue Group Certification';
            DataClassification = CustomerContent;
        }
        field(4006520; "DEL Zertifizierung Gruppensystem"; Boolean)
        {
            Caption = 'Group System Certification';
            DataClassification = CustomerContent;
        }
        field(4006521; "DEL Zertifizierung Textbaustein"; Boolean)
        {
            Caption = 'Extended Texts Certification';
            DataClassification = CustomerContent;
        }
        field(4006522; "DEL Zertifizierung Vorlage"; Boolean)
        {
            Caption = 'Template Certification';
            DataClassification = CustomerContent;
        }
        field(4006523; "DEL Zertifizierung Warengruppe"; Boolean)
        {
            Caption = 'Certification Product Group';
            DataClassification = CustomerContent;
        }
    }
}

