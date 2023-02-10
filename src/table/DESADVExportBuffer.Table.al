table 50086 "DEL DESADV Export Buffer"
{

    Caption = 'DESADV Export Buffer';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Source No."; Integer)
        {
            Caption = 'Source No.';
        }
        field(3; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));
            ValidateTableRelation = false;
        }
        field(4; "Delivery No."; Code[20])
        {
            Caption = 'Delivery No.';
            TableRelation = "Sales Shipment Header"."No.";
        }
        field(6; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(7; "Container No."; Code[30])
        {
            Caption = 'Container Number';
        }
        field(8; "Supplier GLN"; Text[13])
        {
            Caption = 'Supplier GLN';
        }
        field(11; "Delivery GLN"; Text[13])
        {
            Caption = 'Delivery GLN';
        }
        field(17; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
        }
        field(18; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(100; Exported; Boolean)
        {
            Caption = 'Exported';
        }
        field(101; "Export Date"; DateTime)
        {
            Caption = 'Export Date';
        }
        field(111; "Order Date Text"; Text[30])
        {
            Caption = 'Order Date Text';
        }
        field(112; "Delivery Date Text"; Text[30])
        {
            Caption = 'Delivery Date Text';
        }
        field(200; "Supplier Name"; Text[100])
        {
            Caption = 'Supplier Name';
        }
        field(201; "Supplier Legal Form"; Text[50])
        {
            Caption = 'Supplier Legal Form';
        }
        field(202; "Supplier Capital Stock"; Text[50])
        {
            Caption = 'Supplier Capital Stock';
        }
        field(203; "Supplier City"; Text[30])
        {
            Caption = 'Supplier City';
        }
        field(204; "Supplier Country"; Text[10])
        {
            Caption = 'Supplier Country';
        }
        field(205; "Supplier Street"; Text[100])
        {
            Caption = 'Supplier Street';
        }
        field(206; "Supplier VAT No."; Text[20])
        {
            Caption = 'Supplier VAT No.';
        }
        field(207; "Supplier Registration No."; Text[30])
        {
            Caption = 'Supplier Registration No.';
        }
        field(208; "Supplier SIREN No."; Text[100])
        {
            Caption = 'Supplier SIREN No.';
        }
        field(209; "Supplier Post Code"; Code[20])
        {
            Caption = 'Supplier Post Code';
        }
        field(600; "Delivery Name"; Text[100])
        {
            Caption = 'Delivery Name';
        }
        field(601; "Delivery City"; Text[30])
        {
            Caption = 'Delivery City';
        }
        field(602; "Delivery Country"; Text[10])
        {
            Caption = 'Delivery Country';
        }
        field(603; "Delivery Street"; Text[100])
        {
            Caption = 'Delivery Street';
        }
        field(604; "Delivery Post Code"; Code[20])
        {
            Caption = 'Delivery Post Code';
        }
        field(605; "Delivery Track"; Text[100])
        {
            Caption = 'Delivery Track';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Exported)
        {
        }
    }

    fieldgroups
    {
    }

    procedure UpdateExportedInformations()
    begin
        "Export Date" := CURRENTDATETIME;
        Exported := TRUE;
        MODIFY();
    end;
}

