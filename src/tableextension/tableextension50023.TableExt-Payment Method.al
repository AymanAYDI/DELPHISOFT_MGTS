tableextension 50023 tableextension50023 extends "Payment Method"
{
    // //DEL_QR/THS/300620 - Add field 11500 Swiss QRBill Layout
    fields
    {
        field(11500; "Swiss QRBill Layout"; Code[20])
        {
            Caption = 'QR-Bill Layout';
        }
    }
}

