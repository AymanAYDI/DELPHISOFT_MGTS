table 50026 "DEL ACO Connection"
{

    Caption = 'ACO Connection';

    fields
    {
        field(1; Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Deal_ID';
        }
        field(2; "ACO No."; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
            Caption = 'ACO No.';

            ValidateTableRelation = false;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Editable = false;
            FieldClass = Normal;
            TableRelation = Vendor;
        }
        field(4; Status; Enum "DEL Status")
        {
            CalcFormula = Lookup("DEL Deal".Status WHERE(ID = FIELD(Deal_ID)));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Status';

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

