
table 50003 "DEL Web_Order_Line"
{
    Caption = 'Web_Order_Line';


    DrillDownPageID = "DEL Error Import";
    LookupPageID = "DEL Error Import";

    fields
    {
        field(10; No; Integer)
        {
            AutoIncrement = false;
            Caption = 'No';
        }
        field(20; Item; Code[20])
        {
            TableRelation = Item;
            Caption = 'Item';
        }
        field(25; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(30; Contact; Code[20])
        {
            TableRelation = Contact;
            Caption = 'Contact';
        }
        field(40; End_Customer; Text[30])
        {
            Caption = 'End_Customer';
        }
        field(50; Qty; Decimal)
        {
            Caption = 'Qty';
        }
        field(55; Unit; Code[10])
        {
            Caption = 'Unit';
        }
        field(60; Max_Date; Text[10])
        {
            Caption = 'Max_Date';
        }

        field(70; "Date"; Text[10])

        {
            Caption = 'Date';
        }
        field(80; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(90; Total_Price; Decimal)
        {
            Caption = 'Total_Price';
        }
        field(95; Devise; Code[10])
        {
            Caption = 'Devise';
        }
        field(100; DateOrderCreated; Date)
        {
            Caption = 'DateOrderCreated';
        }
        field(110; OrderCreated; Boolean)
        {
            Caption = 'OrderCreated';
        }
        field(130; Date_Date; Date)
        {
            Caption = 'Date_Date';
        }
        field(131; CampaignCode; Code[20])
        {
            TableRelation = Campaign."No.";
            Caption = 'CampaignCode';
        }
        field(140; Qty_Commande; Decimal)
        {
            Caption = 'Qty_Commande';
        }
        field(150; "Invoice No"; Code[20])
        {
            Caption = 'Invoice No';
        }
        field(161; ADV_comments; Text[50])
        {
            Caption = 'ADV_comments';
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
        key(Key2; Item, OrderCreated)
        {
            SumIndexFields = Qty;
        }
        key(Key3; Contact)
        {
        }
        key(Key4; Contact, OrderCreated)
        {
        }
        key(Key5; "Invoice No")
        {
        }
    }

    fieldgroups
    {
    }
}

