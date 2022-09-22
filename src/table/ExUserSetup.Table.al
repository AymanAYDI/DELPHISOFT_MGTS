table 99205 "Ex_User Setup"
{
    Caption = 'User Setup';
    DrillDownPageID = 119;
    LookupPageID = 119;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = User."User Name";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                UserMgt: Codeunit "418";
            begin
                UserMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                UserMgt: Codeunit "418";
            begin
                UserMgt.ValidateUserID("User ID");
            end;
        }
        field(2; "Allow Posting From"; Date)
        {
            Caption = 'Allow Posting From';
        }
        field(3; "Allow Posting To"; Date)
        {
            Caption = 'Allow Posting To';
        }
        field(4; "Register Time"; Boolean)
        {
            Caption = 'Register Time';
        }
        field(10; "Salespers./Purch. Code"; Code[10])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = Salesperson/Purchaser.Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSetup: Record "91";
            begin
                IF "Salespers./Purch. Code" <> '' THEN BEGIN
                  UserSetup.SETCURRENTKEY("Salespers./Purch. Code");
                  UserSetup.SETRANGE("Salespers./Purch. Code","Salespers./Purch. Code");
                  IF UserSetup.FINDFIRST THEN
                    ERROR(Text001,"Salespers./Purch. Code",UserSetup."User ID");
                END;
            end;
        }
        field(11;"Approver ID";Code[50])
        {
            Caption = 'Approver ID';
            TableRelation = "User Setup"."User ID";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12;"Sales Amount Approval Limit";Integer)
        {
            BlankZero = true;
            Caption = 'Sales Amount Approval Limit';

            trigger OnValidate()
            begin
                IF "Unlimited Sales Approval" AND ("Sales Amount Approval Limit" <> 0) THEN
                  ERROR(Text003,FIELDCAPTION("Sales Amount Approval Limit"),FIELDCAPTION("Unlimited Sales Approval"));
                IF "Sales Amount Approval Limit" < 0 THEN
                  ERROR(Text005);
            end;
        }
        field(13;"Purchase Amount Approval Limit";Integer)
        {
            BlankZero = true;
            Caption = 'Purchase Amount Approval Limit';

            trigger OnValidate()
            begin
                IF "Unlimited Purchase Approval" AND ("Purchase Amount Approval Limit" <> 0) THEN
                  ERROR(Text003,FIELDCAPTION("Purchase Amount Approval Limit"),FIELDCAPTION("Unlimited Purchase Approval"));
                IF "Purchase Amount Approval Limit" < 0 THEN
                  ERROR(Text005);
            end;
        }
        field(14;"Unlimited Sales Approval";Boolean)
        {
            Caption = 'Unlimited Sales Approval';

            trigger OnValidate()
            begin
                IF "Unlimited Sales Approval" THEN
                  "Sales Amount Approval Limit" := 0;
            end;
        }
        field(15;"Unlimited Purchase Approval";Boolean)
        {
            Caption = 'Unlimited Purchase Approval';

            trigger OnValidate()
            begin
                IF "Unlimited Purchase Approval" THEN
                  "Purchase Amount Approval Limit" := 0;
            end;
        }
        field(16;Substitute;Code[50])
        {
            Caption = 'Substitute';
            TableRelation = "User Setup";
        }
        field(17;"E-Mail";Text[100])
        {
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(19;"Request Amount Approval Limit";Integer)
        {
            BlankZero = true;
            Caption = 'Request Amount Approval Limit';

            trigger OnValidate()
            begin
                IF "Unlimited Request Approval" AND ("Request Amount Approval Limit" <> 0) THEN
                  ERROR(Text003,FIELDCAPTION("Request Amount Approval Limit"),FIELDCAPTION("Unlimited Request Approval"));
                IF "Request Amount Approval Limit" < 0 THEN
                  ERROR(Text005);
            end;
        }
        field(20;"Unlimited Request Approval";Boolean)
        {
            Caption = 'Unlimited Request Approval';

            trigger OnValidate()
            begin
                IF "Unlimited Request Approval" THEN
                  "Request Amount Approval Limit" := 0;
            end;
        }
        field(950;"Time Sheet Admin.";Boolean)
        {
            Caption = 'Time Sheet Admin.';
        }
        field(5600;"Allow FA Posting From";Date)
        {
            Caption = 'Allow FA Posting From';
        }
        field(5601;"Allow FA Posting To";Date)
        {
            Caption = 'Allow FA Posting To';
        }
        field(5700;"Sales Resp. Ctr. Filter";Code[10])
        {
            Caption = 'Sales Resp. Ctr. Filter';
            TableRelation = "Responsibility Center".Code;
        }
        field(5701;"Purchase Resp. Ctr. Filter";Code[10])
        {
            Caption = 'Purchase Resp. Ctr. Filter';
            TableRelation = "Responsibility Center";
        }
        field(5900;"Service Resp. Ctr. Filter";Code[10])
        {
            Caption = 'Service Resp. Ctr. Filter';
            TableRelation = "Responsibility Center";
        }
        field(4006496;"Katalog ID";Code[20])
        {
            Caption = 'Catalogue ID';
            Description = 'AL.KVK4.5';
            TableRelation = Katalogkopf;
        }
        field(4006497;Agenda;Code[30])
        {
            Description = 'AL.KVK4.5';
        }
        field(4006498;GL;Boolean)
        {
            Caption = 'General Ledger';
            Description = 'AL.KVK4.5';
        }
        field(4006499;Zeichnungsverwaltung;Boolean)
        {
            Caption = 'CAD Drawing Management';
            Description = 'AL.KVK4.5';
        }
        field(4006500;"Importfilter global";Text[250])
        {
            Caption = 'Global Import Filter';
            Description = 'AL.KVK4.5';
        }
        field(4006501;Importfilter;Text[250])
        {
            Caption = 'Import Filter';
            Description = 'AL.KVK4.5';
        }
        field(4006502;"Aktualisierung Dokumente";Boolean)
        {
            Caption = 'Update Documents';
            Description = 'AL.KVK4.5';
        }
        field(4006503;"Zertifizierung Checkliste";Boolean)
        {
            Caption = 'Checklist Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006504;"Zertifizierung Debitor";Boolean)
        {
            Caption = 'Customer Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006505;"Zertifizierung Adresse";Boolean)
        {
            Caption = 'Certification Address';
            Description = 'AL.KVK4.5';
        }
        field(4006506;"Zertifizierung Kreditor";Boolean)
        {
            Caption = 'Vendor Vertification';
            Description = 'AL.KVK4.5';
        }
        field(4006507;"Zertifizierung Artikel";Boolean)
        {
            Caption = 'Certification Item';
            Description = 'AL.KVK4.5';
        }
        field(4006508;"Zertifizierung Geraet";Boolean)
        {
            Caption = 'Certification Device';
            Description = 'AL.KVK4.5';
        }
        field(4006509;"Zertifizierung Ressource";Boolean)
        {
            Caption = 'Certification Resource';
            Description = 'AL.KVK4.5';
        }
        field(4006510;"Zertifizierung Anlage";Boolean)
        {
            Caption = 'Asset Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006511;"Zertifizierung Personalwesen";Boolean)
        {
            Caption = 'Human Resources Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006512;"Zertifizierung Personalstamm";Boolean)
        {
            Caption = 'Permanent Staff Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006513;"Zertifizierung Werkzeug";Boolean)
        {
            Caption = 'Certification Tool';
            Description = 'AL.KVK4.5';
        }
        field(4006514;"Zertifizierung Operationsplan";Boolean)
        {
            Caption = 'Operation Plan Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006515;"Zertifizierung Person ZW";Boolean)
        {
            Caption = 'Person Assignment Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006516;"Zertifizierung Katalog";Boolean)
        {
            Caption = 'Certification Catalogue';
            Description = 'AL.KVK4.5';
        }
        field(4006517;"Zertifizierung Artikelgruppe";Boolean)
        {
            Caption = 'Certification Item Group';
            Description = 'AL.KVK4.5';
        }
        field(4006518;"Zertifizierung Kapitel";Boolean)
        {
            Caption = 'Chapter Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006519;"Zertifizierung Kataloggruppe";Boolean)
        {
            Caption = 'Catalogue Group Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006520;"Zertifizierung Gruppensystem";Boolean)
        {
            Caption = 'Group System Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006521;"Zertifizierung Textbaustein";Boolean)
        {
            Caption = 'Extended Texts Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006522;"Zertifizierung Vorlage";Boolean)
        {
            Caption = 'Template Certification';
            Description = 'AL.KVK4.5';
        }
        field(4006523;"Zertifizierung Warengruppe";Boolean)
        {
            Caption = 'Certification Product Group';
            Description = 'AL.KVK4.5';
        }
    }

    keys
    {
        key(Key1;"User ID")
        {
            Clustered = true;
        }
        key(Key2;"Salespers./Purch. Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'The %1 Salesperson/Purchaser code is already assigned to another User ID %2.';
        Text003: Label 'You cannot have both a %1 and %2. ';
        Text005: Label 'You cannot have approval limits less than zero.';
}

