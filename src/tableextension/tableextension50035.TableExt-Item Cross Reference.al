tableextension 50035 tableextension50035 extends "Item Cross Reference"
{
    // T-00778     THM     16.03.16          add "Sale blocked"
    // 
    // Mgts10.00.04.00      07.12.2021 : Add field(50001)
    fields
    {
        field(50000; "Sale blocked"; Boolean)
        {
            CalcFormula = Lookup (Item."Sale blocked" WHERE (No.=FIELD(Item No.)));
            Caption = 'Sale blocked';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001;"Entry No.";BigInteger)
        {
            Caption = 'Entry No.';
            Description = 'Mgts10.00.04.00';
        }
    }
    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }
}

