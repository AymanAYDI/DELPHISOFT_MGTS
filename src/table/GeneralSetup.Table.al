table 50000 "DEL General Setup"
{
    Caption = 'General Setup';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "*** Web Server"; Integer)
        {
            Caption = '*** Web Server';
            DataClassification = CustomerContent;
        }
        field(2; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "IIS images path"; Text[250])
        {
            Caption = 'IIS images path';
            DataClassification = CustomerContent;
        }
        field(100; "****** suite"; Integer)
        {
            Caption = '****** suite';
            DataClassification = CustomerContent;
        }
        field(200; "****** suite 2"; Integer)
        {
            Caption = '****** suite 2';
            DataClassification = CustomerContent;
        }
        field(500; "NWP Items to order days"; Integer)
        {
            Caption = 'NWP Items to order days';
            DataClassification = CustomerContent;
        }
        field(600; "****** Axe Achats"; Integer)
        {
            Caption = '****** Axe Achats';
            DataClassification = CustomerContent;
        }
        field(601; "Code Axe Achat"; Code[10])
        {
            Caption = 'Code Axe Achat';
            DataClassification = CustomerContent;
            TableRelation = Dimension;
        }
        field(700; "Nom emetteur"; Code[10])
        {
            Caption = 'Nom emetteur';
            DataClassification = CustomerContent;
        }
        field(710; "Nom achat commande transitaire"; Code[10])
        {

            Caption = 'Nom achat commande transitaire';
            DataClassification = CustomerContent;
        }
        field(720; "IC Forwarding Agent Code"; Code[20])
        {
            Caption = 'IC Forwarding Agent Code';
            DataClassification = CustomerContent;
        }
        field(810; "Element Nos."; Code[10])
        {
            Caption = 'Element Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(820; "Position Nos."; Code[10])
        {
            Caption = 'Position Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(830; "Fee Nos."; Code[10])
        {
            Caption = 'Fee Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(840; "Fee Connection Nos."; Code[10])
        {
            Caption = 'Fee Connection Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(851; "Default Purchasing Code"; Code[10])
        {
            Caption = 'Default Purchasing Code';
            DataClassification = CustomerContent;

            TableRelation = Purchasing;
        }
        field(852; Logico; BLOB)
        {
            Caption = 'Logico';
            DataClassification = CustomerContent;
        }
        field(854; "Update Request Nos."; Code[10])
        {
            Caption = 'Update Request Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(855; "Provision Nos."; Code[10])
        {
            Caption = 'Provision Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(856; "Folder Expeditors"; text[250])
        {
            Caption = 'Folder Expeditors';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            begin
                //TODOGeneralMgt.CheckFolderName("Folder Expeditors");

            end;
        }
        field(857; "Folder Expeditors Archive"; text[250])
        {
            Caption = 'Folder Expeditors Archive';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            begin
                //TODO: à corriger //codeunit //   GeneralMgt.CheckFolderName("Folder Expeditors Archive");

            end;
        }
        field(858; "Folder Maersk"; text[250])
        {
            Caption = 'Folder Maersk';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
                //TODO:GeneralMgt.CheckFolderName("Folder Maersk");

            end;

        }
        field(859; "Folder Maersk Archive"; text[250])
        {
            Caption = 'Folder Maersk Archive';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            begin
                //TODO //codeunit // GeneralMgt.CheckFolderName("Folder Maersk Archive");
            end;
        }
        field(860; "Reporting File"; Text[250])
        {
            Caption = 'Reporting File';
            DataClassification = CustomerContent;
        }
        field(861; "Hyperion File"; Text[250])
        {
            Caption = 'Hyperion File';
            DataClassification = CustomerContent;
        }
        field(862; "Hyperion Company Code"; Text[50])
        {
            Caption = 'Hyperion Company Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GLAccount_Re: Record "G/L Account";
            begin
                GLAccount_Re.RESET();
                IF GLAccount_Re.FINDFIRST() THEN
                    IF ("Hyperion Company Code" <> '') THEN
                        REPEAT
                            GLAccount_Re."DEL Company Code" := "Hyperion Company Code";
                            GLAccount_Re.MODIFY();
                        UNTIL GLAccount_Re.NEXT() = 0;
            end;
        }
        field(863; "Sales File"; Text[250])
        {
            Caption = 'Sales File';
            DataClassification = CustomerContent;
        }
        field(864; "Purchase File"; Text[250])
        {
            Caption = 'Purchase File';
            DataClassification = CustomerContent;
        }
        field(50001; "Risque Securitaire"; Decimal)
        {
            Caption = 'Coefficient of Security Level Of Risk %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(50002; "Risque Reglementaire"; Decimal)
        {
            Caption = 'Coefficient Of Regulation Level Of Risk %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(50003; "Marque Produit"; Decimal)
        {
            Caption = 'Coefficient Of Brand Type %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(50004; "Origine Fournisseur"; Decimal)
        {
            Caption = 'Coefficient Of Supplier %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(50005; "Coefficient Of Quality Rating"; Decimal)
        {
            Caption = 'Coefficient Of Quality Rating Of Product %';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 2;
        }
        field(50006; "Dernier num séq maj Dev Init"; Integer)
        {
            Caption = 'Dernier num séq maj Dev Init';
            DataClassification = CustomerContent;
        }
        field(50007; "Vendor Template"; Code[10])
        {
            Caption = 'Vendor Template';
            DataClassification = CustomerContent;

            TableRelation = "Config. Template Header".Code WHERE("Table ID" = CONST(23));
        }
        field(50008; "API URL"; Text[250])
        {
            Caption = 'API URL';
            DataClassification = CustomerContent;
        }
        field(50009; "API KEY"; Text[250])
        {
            Caption = 'API KEY';
            DataClassification = CustomerContent;
        }
        field(50010; "Item Template"; Code[10])
        {
            Caption = 'Item Template';
            DataClassification = CustomerContent;

            TableRelation = "Config. Template Header".Code WHERE("Table ID" = CONST(27));
        }
        field(50011; "Worksheet Template Name"; Code[10])
        {
            Caption = 'Worksheet Template Name';
            DataClassification = CustomerContent;

            TableRelation = "Req. Wksh. Template";
        }
        field(50012; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            DataClassification = CustomerContent;

            TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"));
        }
        field(50013; "Sender Email Payment Advice"; Text[80])
        {
            Caption = 'Sender Email Payment Advice';
            DataClassification = CustomerContent;

            ExtendedDatatype = EMail;
        }
        field(50014; "Default Email Template"; Code[20])
        {
            Caption = 'Default Email Template';
            DataClassification = CustomerContent;

            TableRelation = "DEL DocMatrix Email Codes".Code;
        }
        field(50015; Mail1; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50016; Mail2; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50017; Mail3; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50018; Mail4; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50019; Mail5; Text[250])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
    //TODO //GeneralMgt: Codeunit GeneralMgt;

}

