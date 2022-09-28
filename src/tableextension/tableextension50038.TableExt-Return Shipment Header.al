tableextension 50038 tableextension50038 extends "Return Shipment Header"
{
    // MGTS10.031  | 22.07.2021 | Add fields : 50050, 50051
    fields
    {
        field(50050; "Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';
            Description = 'MGTS10.030';
        }
        field(50051; "Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';
            Description = 'MGTS10.030';
        }
    }
}

