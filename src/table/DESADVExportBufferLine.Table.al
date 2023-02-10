table 50087 "DEL DESADV Export Buffer Line"
{

    Caption = 'DESADV Export Buffer Line';

    fields
    {
        field(1; "Document Enty No."; BigInteger)
        {
            Caption = 'Document Enty No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Source No."; Integer)
        {
            Caption = 'Source No.';
        }
        field(5; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Shipment Header"."No.";
        }
        field(6; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(7; "Delivery GLN"; Text[30])
        {
            Caption = 'Delivery GLN';
        }
        field(8; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(10; EAN; Text[13])
        {
            Caption = 'EAN';
        }
        field(11; "Supplier Item No."; Text[30])
        {
            Caption = 'Supplier Item No.';
        }
        field(12; "Customer Item No."; Code[50]) //TODO : it was text[50]
        {
            Caption = 'Customer Item No.';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(14; "Ordered Quantity"; Decimal)
        {
            Caption = 'Ordered Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(16; "Delivery Quantity"; Decimal)
        {
            Caption = 'Delivery Quantity';
        }
        field(17; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
        }
        field(18; "Delivery Date Text"; Text[30])
        {
            Caption = 'Delivery Date Text';
        }
    }

    keys
    {
        key(Key1; "Document Enty No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document No.", "Document Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

