tableextension 50007 tableextension50007 extends "Direct Debit Collection Entry"
{
    // DEL_QR/THS/07.07.2020 Add Field 22 "Payment Reference"
    fields
    {
        field(22; "Payment Reference"; Code[50])
        {
            CalcFormula = Lookup ("Cust. Ledger Entry"."Payment Reference" WHERE (Entry No.=FIELD(Applies-to Entry No.)));
            Caption = 'Payment Reference';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

