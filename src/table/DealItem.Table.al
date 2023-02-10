table 50023 "DEL Deal Item"
{
    Caption = 'Deal Item';
    DataClassification = CustomerContent;

    LookupPageID = "DEL Deal Item";
    fields
    {
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
        }
        field(20; Deal_ID; Code[20])
        {
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
        field(30; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(40; "Currency Price"; Code[10])
        {
            Caption = 'Currency Price';
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
        }
        field(50; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(60; "Currency Cost"; Code[10])
        {
            Caption = 'Currency Cost';
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
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
            Caption = 'Volume CMB';
            DataClassification = CustomerContent;
            DecimalPlaces = 4 : 4;
        }
        field(100; "Volume CMB carton transport"; Decimal)
        {
            Caption = 'Volume CMB carton transport';
            DataClassification = CustomerContent;
            DecimalPlaces = 4 : 4;
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
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;

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

