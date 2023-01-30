tableextension 50035 "DEL ItemReference" extends "Item Reference" //5777
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
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key7; "DEL Entry No.")
        {
        }
    }
}

