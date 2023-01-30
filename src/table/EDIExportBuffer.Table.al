table 50077 "DEL EDI Export Buffer"
{

    Caption = 'EDI Export Buffer';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; "Source No."; Integer)
        {
            Caption = 'N° Source';
            DataClassification = CustomerContent;
        }
        field(3; "Document Type"; Enum "Purchase Document Type")
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"));
            DataClassification = CustomerContent;
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(6; "Your Reference"; Text[35])
        {
            Caption = 'Your Reference';
            DataClassification = CustomerContent;
        }
        field(7; "Contrat ID"; Text[3])
        {
            Caption = 'Numéro de Contrat';
            DataClassification = CustomerContent;
        }
        field(8; "Supplier GLN"; Text[13])
        {
            Caption = 'Supplier GLN';
            DataClassification = CustomerContent;
        }
        field(9; "Buyer GLN"; Text[13])
        {
            Caption = 'Buyer GLN';
            DataClassification = CustomerContent;
        }
        field(10; "Customer GLN"; Text[13])
        {
            Caption = 'Customer GLN';
            DataClassification = CustomerContent;
        }
        field(11; "Delivery GLN"; Text[13])
        {
            Caption = 'Delivery GLN';
            DataClassification = CustomerContent;
        }
        field(12; "Contact Name"; Text[100])
        {
            Caption = 'Contact Name';
            DataClassification = CustomerContent;
        }
        field(13; "Contact Email"; Text[80])
        {
            Caption = 'Contact Email';
            DataClassification = CustomerContent;
        }
        field(14; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(15; "Document Amount"; Decimal)
        {
            Caption = 'Document Amount';
            DataClassification = CustomerContent;
        }
        field(16; "Document Date Text"; Text[10])
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(17; "Delivery Date"; Date)
        {
            Caption = 'Delivery Date';
            DataClassification = CustomerContent;
        }
        field(18; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = CustomerContent;
        }
        field(19; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            DataClassification = CustomerContent;
        }
        field(20; "Delivery Document No."; Code[20])
        {
            Caption = 'Delivery Document No.';
            DataClassification = CustomerContent;
        }
        field(21; "Document Amount Inc. VAT"; Decimal)
        {
            Caption = 'Document Amount Inc. VAT';
            DataClassification = CustomerContent;
        }
        field(22; "Document VAT Amount"; Decimal)
        {
            Caption = 'Document VAT Amount';
            DataClassification = CustomerContent;
        }
        field(100; Exported; Boolean)
        {
            Caption = 'Exporté';
            DataClassification = CustomerContent;
        }
        field(101; "Export Date"; DateTime)
        {
            Caption = 'Date d''export';
            DataClassification = CustomerContent;
        }
        field(118; "Delivery Date Text"; Text[30])
        {
            Caption = 'Delivery Date Text';
            DataClassification = CustomerContent;
        }
        field(119; "EDI Document Type"; Text[10])
        {
            Caption = 'EDI Document Type';
            DataClassification = CustomerContent;
        }
        field(120; "EDI Order Type"; Text[10])
        {
            Caption = 'EDI Order Type';
            DataClassification = CustomerContent;
        }
        field(121; "Order Date Text"; Text[30])
        {
            Caption = 'Order Date Text';
            DataClassification = CustomerContent;
        }
        field(200; "Supplier Name"; Text[50])
        {
            Caption = 'Supplier Name';
            DataClassification = CustomerContent;
        }
        field(201; "Supplier Legal Form"; Text[50])
        {
            Caption = 'Supplier Legal Form';
            DataClassification = CustomerContent;
        }
        field(202; "Supplier Capital Stock"; Text[50])
        {
            Caption = 'Supplier Capital Stock';
            DataClassification = CustomerContent;
        }
        field(203; "Supplier City"; Text[30])
        {
            Caption = 'Supplier City';
            DataClassification = CustomerContent;
        }
        field(204; "Supplier Country"; Text[10])
        {
            Caption = 'Supplier Country';
            DataClassification = CustomerContent;
        }
        field(205; "Supplier Street"; Text[80])
        {
            Caption = 'Supplier Street';
            DataClassification = CustomerContent;
        }
        field(206; "Supplier VAT No."; Text[20])
        {
            Caption = 'Supplier VAT No.';
            DataClassification = CustomerContent;
        }
        field(207; "Supplier Registration No."; Text[30])
        {
            Caption = 'Supplier Registration No.';
            DataClassification = CustomerContent;
        }
        field(208; "Supplier SIREN No."; Text[100])
        {
            Caption = 'Supplier SIREN No.';
            DataClassification = CustomerContent;
        }
        field(209; "Supplier Post Code"; Code[20])
        {
            Caption = 'Supplier Post Code';
            DataClassification = CustomerContent;
        }
        field(300; "Buyer Name"; Text[50])
        {
            Caption = 'Buyer Name';
            DataClassification = CustomerContent;
        }
        field(301; "Buyer City"; Text[30])
        {
            Caption = 'Buyer City';
            DataClassification = CustomerContent;
        }
        field(302; "Buyer Country"; Text[10])
        {
            Caption = 'Buyer Country';
            DataClassification = CustomerContent;
        }
        field(303; "Buyer Street"; Text[80])
        {
            Caption = 'Buyer Street';
            DataClassification = CustomerContent;
        }
        field(304; "Buyer VAT Registration No."; Text[20])
        {
            Caption = 'Buyer VAT Registration No.';
            DataClassification = CustomerContent;
        }
        field(305; "Buyer Post Code"; Code[20])
        {
            Caption = 'Buyer Post Code';
            DataClassification = CustomerContent;
        }
        field(400; "Tax Representative ID"; Text[13])
        {
            Caption = 'Tax Representative ID';
            DataClassification = CustomerContent;
        }
        field(401; "Tax Representative Name"; Text[50])
        {
            Caption = 'Tax Representative Name';
            DataClassification = CustomerContent;
        }
        field(402; "Tax Representative City"; Text[30])
        {
            Caption = 'Tax Representative City';
            DataClassification = CustomerContent;
        }
        field(403; "Tax Representative Country"; Text[10])
        {
            Caption = 'Tax Representative Country';
            DataClassification = CustomerContent;
        }
        field(404; "Tax Representative Street"; Text[80])
        {
            Caption = 'Tax Representative Street';
            DataClassification = CustomerContent;
        }
        field(405; "Tax Representative VAT  No."; Text[20])
        {
            Caption = 'Tax Representative VAT  No.';
            DataClassification = CustomerContent;
        }
        field(406; "Tax Rep. Intracom VAT  No."; Text[20])
        {
            Caption = 'Tax Representative Intracom VAT  No.';
            DataClassification = CustomerContent;
        }
        field(407; "Tax Rep. Post Code"; Code[20])
        {
            Caption = 'Tax Representative Post Code';
            DataClassification = CustomerContent;
        }
        field(500; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(501; "Customer City"; Text[30])
        {
            Caption = 'Customer City';
            DataClassification = CustomerContent;
        }
        field(502; "Customer Country"; Text[10])
        {
            Caption = 'Customer Country';
            DataClassification = CustomerContent;
        }
        field(503; "Customer Street"; Text[80])
        {
            Caption = 'Customer Street';
            DataClassification = CustomerContent;
        }
        field(504; "Customer VAT  No."; Text[20])
        {
            Caption = 'Customer VAT  No.';
            DataClassification = CustomerContent;
        }
        field(505; "Customer Post Code"; Code[20])
        {
            Caption = 'Customer Post Code';
            DataClassification = CustomerContent;
        }
        field(600; "Delivery Name"; Text[50])
        {
            Caption = 'Delivery Name';
            DataClassification = CustomerContent;
        }
        field(601; "Delivery City"; Text[30])
        {
            Caption = 'Delivery City';
            DataClassification = CustomerContent;
        }
        field(602; "Delivery Country"; Text[10])
        {
            Caption = 'Delivery Country';
            DataClassification = CustomerContent;
        }
        field(603; "Delivery Street"; Text[80])
        {
            Caption = 'Delivery Street';
            DataClassification = CustomerContent;
        }
        field(604; "Delivery Post Code"; Code[20])
        {
            Caption = 'Delivery Post Code';
            DataClassification = CustomerContent;
        }
        field(800; "Due Date Text"; Text[30])
        {
            DataClassification = CustomerContent;
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

