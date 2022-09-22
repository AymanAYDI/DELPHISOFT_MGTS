table 50023 "DEL Deal Item"
{
    Caption = 'Deal Item';

    //TODO LookupPageID = 50023;

    fields
    {
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
            Caption = 'Item No.';
        }
        field(20; Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
        }
        field(30; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
        }
        field(40; "Currency Price"; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency Price';
        }
        field(50; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
        }
        field(60; "Currency Cost"; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency Cost';
        }
        field(70; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
        }
        field(80; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
        }
        field(90; "Volume CMB"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            Caption = 'Volume CMB';
        }
        field(100; "Volume CMB carton transport"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            Caption = 'Volume CMB carton transport';
        }
        field(120; PCB; Decimal)
        {
            Caption = 'PCB';
        }
        field(130; "Container No."; Integer)
        {
            Caption = 'Container No.';
        }
        field(140; "Droit de douane reduit"; Decimal)
        {
            Caption = 'Droit de douane reduit';
        }
        field(141; Status; Enum "DEL Status")
        {
            CalcFormula = Lookup("DEL Deal".Status WHERE(ID = FIELD(Deal_ID)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Status';

        }
    }

    keys
    {
        key(Key1; Deal_ID, "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

