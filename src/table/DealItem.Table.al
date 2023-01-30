table 50023 "DEL Deal Item"
{
    Caption = 'Deal Item';

    LookupPageID = "DEL Deal Item";
    DataClassification = CustomerContent;
    fields
    {
        field(10; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(20; Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
        }
        field(30; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(40; "Currency Price"; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency Price';
            DataClassification = CustomerContent;
        }
        field(50; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(60; "Currency Cost"; Code[10])
        {
            TableRelation = Currency.Code;
            Caption = 'Currency Cost';
            DataClassification = CustomerContent;
        }
        field(70; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight';
            DataClassification = CustomerContent;
        }
        field(80; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight';
            DataClassification = CustomerContent;
        }
        field(90; "Volume CMB"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            Caption = 'Volume CMB';
            DataClassification = CustomerContent;
        }
        field(100; "Volume CMB carton transport"; Decimal)
        {
            DecimalPlaces = 4 : 4;
            Caption = 'Volume CMB carton transport';
            DataClassification = CustomerContent;
        }
        field(120; PCB; Decimal)
        {
            Caption = 'PCB';
            DataClassification = CustomerContent;
        }
        field(130; "Container No."; Integer)
        {
            Caption = 'Container No.';
            DataClassification = CustomerContent;
        }
        field(140; "Droit de douane reduit"; Decimal)
        {
            Caption = 'Droit de douane reduit';
            DataClassification = CustomerContent;
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

