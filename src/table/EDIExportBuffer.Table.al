table 50077 "DEL EDI Export Buffer"
{

    Caption = 'EDI Export Buffer';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(2; "Source No."; Integer)
        {
            Caption = 'N° Source';
        }
        field(3; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(6; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
        }
        field(7; "Contrat ID"; Text[3])
        {
            Caption = 'Numéro de Contrat';
        }
        field(8; "Supplier GLN"; Text[13])
        {
            Caption = 'Supplier GLN';
        }
        field(9; "Buyer GLN"; Text[13])
        {
            Caption = 'Buyer GLN';
        }
        field(10; "Customer GLN"; Text[13])
        {
            Caption = 'Customer GLN';
        }
        field(11; "Delivery GLN"; Text[13])
        {
            Caption = 'Delivery GLN';
        }
        field(12; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
        }
        field(13; "Contact Email"; Text[80])
        {
            Caption = 'Contact Email';
        }
        field(14; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(15; "Document Amount"; Decimal)
        {
            Caption = 'Document Amount';
        }
        field(16; "Document Date Text"; Text[10])
        {
            Caption = 'Document Date';
        }
        field(17; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
        }
        field(18; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(19; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(20; "Delivery Document No."; Code[20])
        {
            Caption = 'Delivery Document No.';
        }
        field(21; "Document Amount Inc. VAT"; Decimal)
        {
            Caption = 'Document Amount Inc. VAT';
        }
        field(22; "Document VAT Amount"; Decimal)
        {
            Caption = 'Document VAT Amount';
        }
        field(100; Exported; Boolean)
        {
            Caption = 'Exporté';
        }
        field(101; "Export Date"; DateTime)
        {
            Caption = 'Date d''export';
        }
        field(118; "Delivery Date Text"; Text[30])
        {
            Caption = 'Delivery Date Text';
        }
        field(119; "EDI Document Type"; Text[10])
        {
            Caption = 'EDI Document Type';
        }
        field(120; "EDI Order Type"; Text[10])
        {
            Caption = 'EDI Order Type';
        }
        field(121; "Order Date Text"; Text[30])
        {
            Caption = 'Order Date Text';
        }
        field(200; "Supplier Name"; Text[50])
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
        field(205; "Supplier Street"; Text[80])
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
        field(300; "Buyer Name"; Text[50])
        {
            Caption = 'Buyer Name';
        }
        field(301; "Buyer City"; Text[30])
        {
            Caption = 'Buyer City';
        }
        field(302; "Buyer Country"; Text[10])
        {
            Caption = 'Buyer Country';
        }
        field(303; "Buyer Street"; Text[80])
        {
            Caption = 'Buyer Street';
        }
        field(304; "Buyer VAT Registration No."; Text[20])
        {
            Caption = 'Buyer VAT Registration No.';
        }
        field(305; "Buyer Post Code"; Code[20])
        {
            Caption = 'Buyer Post Code';
        }
        field(400; "Tax Representative ID"; Text[13])
        {
            Caption = 'Tax Representative ID';
        }
        field(401; "Tax Representative Name"; Text[50])
        {
            Caption = 'Tax Representative Name';
        }
        field(402; "Tax Representative City"; Text[30])
        {
            Caption = 'Tax Representative City';
        }
        field(403; "Tax Representative Country"; Text[10])
        {
            Caption = 'Tax Representative Country';
        }
        field(404; "Tax Representative Street"; Text[80])
        {
            Caption = 'Tax Representative Street';
        }
        field(405; "Tax Representative VAT  No."; Text[20])
        {
            Caption = 'Tax Representative VAT  No.';
        }
        field(406; "Tax Rep. Intracom VAT  No."; Text[20])
        {
            Caption = 'Tax Representative Intracom VAT  No.';
        }
        field(407; "Tax Rep. Post Code"; Code[20])
        {
            Caption = 'Tax Representative Post Code';
        }
        field(500; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(501; "Customer City"; Text[30])
        {
            Caption = 'Customer City';
        }
        field(502; "Customer Country"; Text[10])
        {
            Caption = 'Customer Country';
        }
        field(503; "Customer Street"; Text[80])
        {
            Caption = 'Customer Street';
        }
        field(504; "Customer VAT  No."; Text[20])
        {
            Caption = 'Customer VAT  No.';
        }
        field(505; "Customer Post Code"; Code[20])
        {
            Caption = 'Customer Post Code';
        }
        field(600; "Delivery Name"; Text[50])
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
        field(603; "Delivery Street"; Text[80])
        {
            Caption = 'Delivery Street';
        }
        field(604; "Delivery Post Code"; Code[20])
        {
            Caption = 'Delivery Post Code';
        }
        field(800; "Due Date Text"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; Exported, "Document Type")
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

