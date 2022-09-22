table 50078 "EDI Export Buffer Line"
{
    // MGTSEDI10.00.00.00 | 07.08.2020 | EDI Management

    Caption = 'EDI Export Buffer';

    fields
    {
        field(1; "Document Enty No."; BigInteger)
        {
            Caption = 'N° séquence document';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Source No."; Integer)
        {
            Caption = 'N° Source';
        }
        field(4; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header".No. WHERE (Document Type=FIELD(Document Type));
        }
        field(6;"Document Line No.";Integer)
        {
            Caption = 'N° Ligne document';
        }
        field(7;"Delivery GLN";Text[13])
        {
            Caption = 'Delivery GLN';
        }
        field(8;"Item No.";Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item.No.;
        }
        field(9;Description;Text[50])
        {
            Caption = 'Description';
        }
        field(10;EAN;Text[13])
        {
            Caption = 'EAN';
        }
        field(11;"Supplier Item No.";Text[30])
        {
            Caption = 'Supplier Item No.';
        }
        field(12;"Customer Item No.";Text[30])
        {
            Caption = 'Customer Item No.';
        }
        field(13;"Unit of Measure";Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(14;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;
        }
        field(15;Price;Decimal)
        {
            Caption = 'Price';
        }
        field(16;"Delivery Quantity";Decimal)
        {
            Caption = 'Delivery Quantity';
        }
        field(17;"Delivery Date";Date)
        {
            Caption = 'Delivery Date';
        }
        field(18;"Delivery Date Text";Text[10])
        {
            Caption = 'Delivery Date Text';
        }
        field(19;"Line Amount";Decimal)
        {
            Caption = 'Line Amount';
        }
        field(20;"VAT Code";Code[10])
        {
            Caption = 'Code TVA';
        }
        field(21;"VAT %";Decimal)
        {
            Caption = 'VAT %';
        }
        field(22;"Net Price";Decimal)
        {
            Caption = 'Net Price';
        }
    }

    keys
    {
        key(Key1;"Document Enty No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;"Document Type","Document No.","Document Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

