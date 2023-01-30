table 50080 "DEL EDI Exp. Buffer Add. Infos"
{


    Caption = 'EDI Export Buffer Additional Infos';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Type; Enum "DEL TYPES VAT")
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(2; "Document Enty No."; BigInteger)
        {
            Caption = 'N° séquence document';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "Source No."; Integer)
        {
            Caption = 'N° Source';
            DataClassification = CustomerContent;
        }
        field(5; "Document Type"; enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'N° Ligne document';
            DataClassification = CustomerContent;
        }
        field(8; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(9; "Code Type"; Code[20])
        {
            Caption = 'Code Type';
            DataClassification = CustomerContent;
        }
        field(10; "Text 1"; Text[250])
        {
            Caption = 'Text 1';
            DataClassification = CustomerContent;
        }
        field(11; "Text 2"; Text[250])
        {
            Caption = 'Texte 2';
            DataClassification = CustomerContent;
        }
        field(12; "Text 3"; Text[250])
        {
            Caption = 'Text 3';
            DataClassification = CustomerContent;
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(14; "Amount Inc. VAT"; Decimal)
        {
            Caption = 'Amount Inc. VAT';
            DataClassification = CustomerContent;
        }
        field(15; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = CustomerContent;
        }
        field(16; "Discount %"; Decimal)
        {
            Caption = 'Discount %';
            DataClassification = CustomerContent;
        }
        field(17; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Type, "Document Enty No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; Type, "Source No.", "Document Type", "Document No.")
        {
        }
    }

}

