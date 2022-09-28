tableextension 50045 tableextension50045 extends "User Setup"
{
    // AL.KVK5.0
    // 19.05.16/AL/MK  - Felder gemäss Kennzeichnung
    // 
    // MGTSEDI10.00.00.00 | 01.11.2020 | EDI Management : Add field : Resend EDI Document
    fields
    {
        field(50000; "Resend EDI Document"; Boolean)
        {
            Caption = 'Resend EDI Document';
        }
        field(4006496; "Katalog ID"; Code[20])
        {
            Caption = 'Catalogue ID';
            Description = 'AL.KVK4.5';
            TableRelation = Katalogkopf;
        }
        field(4006497; Agenda; Code[30])
        {
            Description = 'AL.KVK4.5';
        }
        field(4006498; GL; Boolean)
        {
            Caption = 'General Ledger';
            Description = 'AL.KVK4.5';
        }
        field(4006499; Zeichnungsverwaltung; Boolean)
        {
            Caption = 'CAD Drawing Management';
            Description = 'AL.KVK4.5';
        }
        field(4006500; "Importfilter global"; Text[250])
        {
            Caption = 'Global Import Filter';
            Description = 'AL.KVK4.5';
        }
        field(4006501; Importfilter; Text[250])
        {
            Caption = 'Import Filter';
            Description = 'AL.KVK4.5';
        }
        field(4006502; "Aktualisierung Dokumente"; Boolean)
        {
            Caption = 'Update Documents';
            Description = 'AL.KVK4.5';
        }
        field(4006503; "Zertifizierung Checkliste"; Boolean)
        {
            Caption = 'Checklist Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006504; "Zertifizierung Debitor"; Boolean)
        {
            Caption = 'Customer Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006505; "Zertifizierung Adresse"; Boolean)
        {
            Caption = 'Certification Address';
            Description = 'AL.KVK4.5';
        }
        field(4006506; "Zertifizierung Kreditor"; Boolean)
        {
            Caption = 'Vendor Vertification';
            Description = 'AL.KVK4.5';
        }
        field(4006507; "Zertifizierung Artikel"; Boolean)
        {
            Caption = 'Certification Item';
            Description = 'AL.KVK4.5';
        }
        field(4006508; "Zertifizierung Geraet"; Boolean)
        {
            Caption = 'Certification Device';
            Description = 'AL.KVK4.5';
        }
        field(4006509; "Zertifizierung Ressource"; Boolean)
        {
            Caption = 'Certification Resource';
            Description = 'AL.KVK4.5';
        }
        field(4006510; "Zertifizierung Anlage"; Boolean)
        {
            Caption = 'Asset Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006511; "Zertifizierung Personalwesen"; Boolean)
        {
            Caption = 'Human Resources Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006512; "Zertifizierung Personalstamm"; Boolean)
        {
            Caption = 'Permanent Staff Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006513; "Zertifizierung Werkzeug"; Boolean)
        {
            Caption = 'Certification Tool';
            Description = 'AL.KVK4.5';
        }
        field(4006514; "Zertifizierung Operationsplan"; Boolean)
        {
            Caption = 'Operation Plan Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006515; "Zertifizierung Person ZW"; Boolean)
        {
            Caption = 'Person Assignment Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006516; "Zertifizierung Katalog"; Boolean)
        {
            Caption = 'Certification Catalogue';
            Description = 'AL.KVK4.5';
        }
        field(4006517; "Zertifizierung Artikelgruppe"; Boolean)
        {
            Caption = 'Certification Item Group';
            Description = 'AL.KVK4.5';
        }
        field(4006518; "Zertifizierung Kapitel"; Boolean)
        {
            Caption = 'Chapter Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006519; "Zertifizierung Kataloggruppe"; Boolean)
        {
            Caption = 'Catalogue Group Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006520; "Zertifizierung Gruppensystem"; Boolean)
        {
            Caption = 'Group System Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006521; "Zertifizierung Textbaustein"; Boolean)
        {
            Caption = 'Extended Texts Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006522; "Zertifizierung Vorlage"; Boolean)
        {
            Caption = 'Template Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006523; "Zertifizierung Warengruppe"; Boolean)
        {
            Caption = 'Certification Product Group';
            Description = 'AL.KVK4.5';
        }
    }
}

