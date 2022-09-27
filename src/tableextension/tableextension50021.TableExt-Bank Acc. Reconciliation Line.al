tableextension 50021 tableextension50021 extends "Bank Acc. Reconciliation Line"
{
    // DEL_QR/THS/07.07.2020 Add 27 "field Payment Reference No."
    fields
    {
        field(27; "Payment Reference No."; Code[50])
        {
            Caption = 'Payment Reference No.';
        }
    }
}

