table 50084 "DEL Container List"
{

    Caption = 'Container List';

    fields
    {
        field(1; "Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
        }
        field(10; "Container No."; Code[30])
        {
            Caption = 'Container Number';
        }
        field(11; "Order No."; Code[20])
        {
            Caption = 'Order No.';
        }
        field(12; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(13; Pieces; Decimal)
        {
            BlankZero = true;
            Caption = 'Pieces';
            DecimalPlaces = 0 : 5;
        }
        field(14; CTNS; Decimal)
        {
            BlankZero = true;
            Caption = 'CTNS';
            DecimalPlaces = 0 : 5;
        }
        field(15; Volume; Decimal)
        {
            BlankZero = true;
            Caption = 'Volume';
            DecimalPlaces = 0 : 5;
        }
        field(16; Weight; Decimal)
        {
            BlankZero = true;
            Caption = 'Weight';
            DecimalPlaces = 0 : 5;
        }
        field(30; "Buy-from Vendor No."; Code[20])
        {
            Caption = 'Buy-from Vendor No.';
            Editable = false;
            TableRelation = Vendor;
        }
        field(31; "Buy-from Vendor Name"; Text[50])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("Buy-from Vendor No.")));
            Caption = 'Buy-from Vendor Name';
            Editable = false;
            FieldClass = FlowField;

        }
        field(32; Description; Text[50])
        {
            Caption = 'Description';
            Editable = false;

        }
        field(33; "Order Quantity"; Decimal)
        {
            BlankZero = true;
            Caption = 'Order Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(34; "Quantity Received"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Lookup("Purchase Line"."Quantity Received" WHERE("Document Type" = CONST(Order),
                                                                            "Document No." = FIELD("Order No."),
                                                                            "Line No." = FIELD("Order Line No.")));
            Caption = 'Quantity Received';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Outstanding Quantity"; Decimal)
        {
            BlankZero = true;
            CalcFormula = Lookup("Purchase Line"."Outstanding Quantity" WHERE("Document Type" = CONST(Order),
                                                                               "Document No." = FIELD("Order No."),
                                                                               "Line No." = FIELD("Order Line No.")));
            Caption = 'Outstanding Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
        }
        field(37; "Special Order Sales No."; Code[20])
        {
            Caption = 'Special Order Sales No.';
            //TODO TableRelation = IF ("Special Order Sales No."=CONST(YES))
            //  "Sales Header"."No." WHERE ("Document Type"=CONST(Order));
        }
        field(38; "Special Order Sales Line No."; Integer)
        {
            Caption = 'Special Order Sales Line No.';
            //TODO TableRelation = IF ("Special Order Sales No."=CONST(YES)) "Sales Line"."Line No." WHERE ("Document Type"=CONST(Order),
            //                                                                                        "Document No."=FIELD("Special Order Sales No."));
        }
        field(50; Level; Integer)
        {
            Caption = 'Level';
        }
        field(51; "Row No."; Integer)
        {
            Caption = 'Row No.';
        }
        field(52; Warnning; Text[250])
        {
            Caption = 'Avertissement';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Container No.", "Order No.", Level)
        {
        }
    }

    fieldgroups
    {
    }
}

