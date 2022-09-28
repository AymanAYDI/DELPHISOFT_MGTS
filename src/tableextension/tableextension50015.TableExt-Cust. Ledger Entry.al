tableextension 50015 tableextension50015 extends "Cust. Ledger Entry"
{
    // DEL_QR/THS/07.07.2020  Add field 171 "Payment Reference"
    fields
    {
        field(171; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
            Description = 'DEL_QR';
        }
    }
}

