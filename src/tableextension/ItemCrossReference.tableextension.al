tableextension 50035 "DEL ItemCrossReference" extends "Item Cross Reference"
{

    fields
    {
        field(50000; "DEL Sale blocked"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Item."Sales Blocked" WHERE("No." = FIELD("Item No.")));
            Caption = 'Sale blocked';
            Editable = false;

        }
        field(50001; "DEL Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
        }
    }
    keys
    {
        key(Key7; "DEL Entry No.")
        {
        }
    }
}

