
table 50078 "DEL EDI Export Buffer Line"
{

    Caption = 'EDI Export Buffer';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Document Enty No."; BigInteger)
        {
            Caption = 'N° séquence document';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Source No."; Integer)
        {
            Caption = 'N° Source';
            DataClassification = CustomerContent;
        }

        field(4; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;

            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(6; "Document Line No."; Integer)
        {
            Caption = 'N° Ligne document';
            DataClassification = CustomerContent;
        }
        field(7; "Delivery GLN"; Text[13])
        {
            Caption = 'Delivery GLN';
            DataClassification = CustomerContent;
        }
        field(8; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(10; EAN; Text[13])
        {
            Caption = 'EAN';
            DataClassification = CustomerContent;
        }
        field(11; "Supplier Item No."; Text[30])
        {
            Caption = 'Supplier Item No.';
            DataClassification = CustomerContent;
        }
        field(12; "Customer Item No."; Text[30])
        {
            Caption = 'Customer Item No.';
            DataClassification = CustomerContent;
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(15; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
        }
        field(16; "Delivery Quantity"; Decimal)
        {
            Caption = 'Delivery Quantity';
            DataClassification = CustomerContent;
        }
        field(17; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            DataClassification = CustomerContent;
        }
        field(18; "Delivery Date Text"; Text[10])
        {
            Caption = 'Delivery Date Text';
            DataClassification = CustomerContent;
        }
        field(19; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(20; "VAT Code"; Code[10])
        {
            Caption = 'Code TVA';
            DataClassification = CustomerContent;
        }
        field(21; "VAT %"; Decimal)
        {
            Caption = 'VAT %';
            DataClassification = CustomerContent;
        }
        field(22; "Net Price"; Decimal)

        {
            Caption = 'Net Price';
            DataClassification = CustomerContent;
        }
    }

    keys
    {

        key(Key1; "Document Enty No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Document Line No.")

        {
        }
    }


}

