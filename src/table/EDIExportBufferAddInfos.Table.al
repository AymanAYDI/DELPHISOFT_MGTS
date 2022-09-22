table 50080 "EDI Export Buffer Add. Infos"
{
    // MGTSEDI10.00.00.00 | 07.08.2020 | EDI Management

    Caption = 'EDI Export Buffer Additional Infos';

    fields
    {
        field(1; Type; Option)
        {
            Caption = 'Type';
            OptionMembers = ,VAT,Text,Discount,TPraf;
        }
        field(2; "Document Enty No."; BigInteger)
        {
            Caption = 'N° séquence document';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Source No."; Integer)
        {
            Caption = 'N° Source';
        }
        field(5; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header".No. WHERE (Document Type=FIELD(Document Type));
        }
        field(7;"Document Line No.";Integer)
        {
            Caption = 'N° Ligne document';
        }
        field(8;"Code";Code[20])
        {
            Caption = 'Code';
        }
        field(9;"Code Type";Code[20])
        {
            Caption = 'Code Type';
        }
        field(10;"Text 1";Text[250])
        {
            Caption = 'Text 1';
        }
        field(11;"Text 2";Text[250])
        {
            Caption = 'Texte 2';
        }
        field(12;"Text 3";Text[250])
        {
            Caption = 'Text 3';
        }
        field(13;Amount;Decimal)
        {
            Caption = 'Amount';
        }
        field(14;"Amount Inc. VAT";Decimal)
        {
            Caption = 'Amount Inc. VAT';
        }
        field(15;"VAT Amount";Decimal)
        {
            Caption = 'VAT Amount';
        }
        field(16;"Discount %";Decimal)
        {
            Caption = 'Discount %';
        }
        field(17;"VAT %";Decimal)
        {
            Caption = 'VAT %';
        }
    }

    keys
    {
        key(Key1;Type,"Document Enty No.","Line No.")
        {
            Clustered = true;
        }
        key(Key2;Type,"Source No.","Document Type","Document No.")
        {
        }
    }

    fieldgroups
    {
    }
}

