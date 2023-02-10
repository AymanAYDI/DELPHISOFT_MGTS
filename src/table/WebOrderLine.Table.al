
table 50003 "DEL Web_Order_Line"
{
    Caption = 'Web_Order_Line';
    DataClassification = CustomerContent;


    DrillDownPageID = "DEL Error Import";
    LookupPageID = "DEL Error Import";
    fields
    {
        field(10; No; Integer)
        {
            AutoIncrement = false;
            Caption = 'No';
            DataClassification = CustomerContent;
        }
        field(20; Item; Code[20])
        {
            Caption = 'Item';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(25; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(30; Contact; Code[20])
        {
            Caption = 'Contact';
            DataClassification = CustomerContent;
            TableRelation = Contact;
        }
        field(40; End_Customer; Text[30])
        {
            Caption = 'End_Customer';
            DataClassification = CustomerContent;
        }
        field(50; Qty; Decimal)
        {
            Caption = 'Qty';
            DataClassification = CustomerContent;
        }
        field(55; Unit; Code[10])
        {
            Caption = 'Unit';
            DataClassification = CustomerContent;
        }
        field(60; Max_Date; Text[10])
        {
            Caption = 'Max_Date';
            DataClassification = CustomerContent;
        }

        field(70; "Date"; Text[10])

        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(80; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = CustomerContent;
        }
        field(90; Total_Price; Decimal)
        {
            Caption = 'Total_Price';
            DataClassification = CustomerContent;
        }
        field(95; Devise; Code[10])
        {
            Caption = 'Devise';
            DataClassification = CustomerContent;
        }
        field(100; DateOrderCreated; Date)
        {
            Caption = 'DateOrderCreated';
            DataClassification = CustomerContent;
        }
        field(110; OrderCreated; Boolean)
        {
            Caption = 'OrderCreated';
            DataClassification = CustomerContent;
        }
        field(130; Date_Date; Date)
        {
            Caption = 'Date_Date';
            DataClassification = CustomerContent;
        }
        field(131; CampaignCode; Code[20])
        {
            Caption = 'CampaignCode';
            DataClassification = CustomerContent;
            TableRelation = Campaign."No.";
        }
        field(140; Qty_Commande; Decimal)
        {
            Caption = 'Qty_Commande';
            DataClassification = CustomerContent;
        }
        field(150; "Invoice No"; Code[20])
        {
            Caption = 'Invoice No';
            DataClassification = CustomerContent;
        }
        field(161; ADV_comments; Text[50])
        {
            Caption = 'ADV_comments';
            DataClassification = CustomerContent;
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

}

