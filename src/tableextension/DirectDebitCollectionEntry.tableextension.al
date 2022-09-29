tableextension 50007 "DEL DirectDebitCollectionEntry" extends "Direct Debit Collection Entry"
{

    fields
    {
        field(50000; "DEL Payment Reference"; Code[50])
        {
            CalcFormula = Lookup("Cust. Ledger Entry"."Payment Reference" WHERE("Entry No." = FIELD("Applies-to Entry No.")));
            Caption = 'Payment Reference';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}

