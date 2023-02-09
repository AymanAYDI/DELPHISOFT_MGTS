table 50026 "DEL ACO Connection"
{

    Caption = 'ACO Connection';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Deal_ID; Code[20])
        {
            Caption = 'Deal_ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal".ID;
        }
        field(2; "ACO No."; Code[20])
        {
            Caption = 'ACO No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No.";

            ValidateTableRelation = false;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            Editable = false;
            FieldClass = Normal;
            TableRelation = Vendor;
        }
        field(4; Status; Enum "DEL Status")
        {
            CalcFormula = Lookup("DEL Deal".Status WHERE(ID = FIELD(Deal_ID)));
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;

        }
    }

    keys
    {
        key(Key1; Deal_ID, "ACO No.")
        {
            Clustered = true;
        }
        key(Key2; "ACO No.")
        {
        }
    }

    fieldgroups
    {
    }
}

