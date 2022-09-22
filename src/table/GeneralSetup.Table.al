table 50000 "DEL General Setup"
{

    Caption = 'General Setup';

    fields
    {
        field(1; "*** Web Server"; Integer)
        {
            Caption = '*** Web Server';
        }
        field(2; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
        }
        field(10; "IIS images path"; Text[250])
        {
            Caption = 'IIS images path';

        }
        field(100; "****** suite"; Integer)
        {
            Caption = '****** suite';
        }
        field(200; "****** suite 2"; Integer)
        {
            Caption = '****** suite 2';
        }
        field(500; "NWP Items to order days"; Integer)
        {
            Caption = 'NWP Items to order days';

        }
        field(600; "****** Axe Achats"; Integer)
        {
            Caption = '****** Axe Achats';
        }
        field(601; "Code Axe Achat"; Code[10])
        {
            TableRelation = Dimension;
            Caption = 'Code Axe Achat';
        }
        field(700; "Nom emetteur"; Code[10])
        {
            Caption = 'Nom emetteur';
        }
        field(710; "Nom achat commande transitaire"; Code[10])
        {

            Caption = 'Nom achat commande transitaire';
        }
        field(720; "IC Forwarding Agent Code"; Code[20])
        {
            Caption = 'IC Forwarding Agent Code';

        }
        field(810; "Element Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Element Nos.';
        }
        field(820; "Position Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Position Nos.';
        }
        field(830; "Fee Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Fee Nos.';
        }
        field(840; "Fee Connection Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Fee Connection Nos.';
        }
        field(851; "Default Purchasing Code"; Code[10])
        {
            Caption = 'Default Purchasing Code';

            TableRelation = Purchasing;
        }
        field(852; Logico; BLOB)
        {
            Caption = 'Logico';
        }
        field(854; "Update Request Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Update Request Nos.';
        }
        field(855; "Provision Nos."; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Provision Nos.';
        }
        field(856; "Folder Expeditors"; Text[250])
        {
            Caption = 'Folder Expeditors';

            trigger OnValidate()
            begin
                //TODO //codeunit // GeneralMgt.CheckFolderName("Folder Expeditors");
            end;
        }
        field(857; "Folder Expeditors Archive"; Text[250])
        {
            Caption = 'Folder Expeditors Archive';

            trigger OnValidate()
            begin
                //TODO //codeunit //   GeneralMgt.CheckFolderName("Folder Expeditors Archive");
            end;
        }
        field(858; "Folder Maersk"; Text[250])
        {
            Caption = 'Folder Maersk';

            trigger OnValidate()
            begin
                //TODO //codeunit //    GeneralMgt.CheckFolderName("Folder Maersk");
            end;
        }
        field(859; "Folder Maersk Archive"; Text[250])
        {
            Caption = 'Folder Maersk Archive';

            trigger OnValidate()
            begin
                //TODO //codeunit // GeneralMgt.CheckFolderName("Folder Maersk Archive");
            end;
        }
        field(860; "Reporting File"; Text[250])
        {
            Caption = 'Reporting File';
        }
        field(861; "Hyperion File"; Text[250])
        {
            Caption = 'Hyperion File';
        }
        field(862; "Hyperion Company Code"; Text[50])
        {
            Caption = 'Hyperion Company Code';

            trigger OnValidate()
            var
                GLAccount_Re: Record "G/L Account";
            begin
                GLAccount_Re.RESET;
                IF GLAccount_Re.FINDFIRST THEN BEGIN
                    IF ("Hyperion Company Code" <> '') THEN BEGIN
                        REPEAT
                            //TODO  GLAccount_Re."Company Code" := "Hyperion Company Code";
                            GLAccount_Re.MODIFY;
                        UNTIL GLAccount_Re.NEXT = 0;
                    END;
                END;
            end;
        }
        field(863; "Sales File"; Text[250])
        {
            Caption = 'Sales File';
        }
        field(864; "Purchase File"; Text[250])
        {
            Caption = 'Purchase File';
        }
        field(50001; "Risque Securitaire"; Decimal)
        {
            Caption = 'Coefficient of Security Level Of Risk %';
            DecimalPlaces = 0 : 2;

        }
        field(50002; "Risque Reglementaire"; Decimal)
        {
            Caption = 'Coefficient Of Regulation Level Of Risk %';
            DecimalPlaces = 0 : 2;

        }
        field(50003; "Marque Produit"; Decimal)
        {
            Caption = 'Coefficient Of Brand Type %';
            DecimalPlaces = 0 : 2;

        }
        field(50004; "Origine Fournisseur"; Decimal)
        {
            Caption = 'Coefficient Of Supplier %';
            DecimalPlaces = 0 : 2;

        }
        field(50005; "Coefficient Of Quality Rating"; Decimal)
        {
            Caption = 'Coefficient Of Quality Rating Of Product %';
            DecimalPlaces = 0 : 2;

        }
        field(50006; "Dernier num séq maj Dev Init"; Integer)
        {
            Caption = 'Dernier num séq maj Dev Init';

        }
        field(50007; "Vendor Template"; Code[10])
        {
            Caption = 'Vendor Template';

            TableRelation = "Config. Template Header".Code WHERE("Table ID" = CONST(23));
        }
        field(50008; "API URL"; Text[250])
        {
            Caption = 'API URL';

        }
        field(50009; "API KEY"; Text[250])
        {
            Caption = 'API KEY';

        }
        field(50010; "Item Template"; Code[10])
        {
            Caption = 'Item Template';

            TableRelation = "Config. Template Header".Code WHERE("Table ID" = CONST(27));
        }
        field(50011; "Worksheet Template Name"; Code[10])
        {
            Caption = 'Worksheet Template Name';

            TableRelation = "Req. Wksh. Template";
        }
        field(50012; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';

            TableRelation = "Requisition Wksh. Name".Name WHERE("Worksheet Template Name" = FIELD("Worksheet Template Name"));
        }
        field(50013; "Sender Email Payment Advice"; Text[80])
        {
            Caption = 'Sender Email Payment Advice';

            ExtendedDatatype = EMail;
        }
        field(50014; "Default Email Template"; Code[20])
        {
            Caption = 'Default Email Template';

            //TODO  TableRelation = "DocMatrix Email Codes".Code;
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
    //TODO //codeunit 
    // GeneralMgt: Codeunit "11501";
}

