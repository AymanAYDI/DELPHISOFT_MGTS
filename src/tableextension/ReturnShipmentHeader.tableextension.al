tableextension 50038 "DEL ReturnShipmentHeader" extends "Return Shipment Header"
{
    fields
    {
        field(50050; "DEL Mention Under Total"; Text[250])
        {
            Caption = 'Mention Under Total';
            Description = 'MGTS10.030';
        }
        field(50051; "DEL Amount Mention Under Total"; Text[30])
        {
            Caption = 'Amount Mention Under Total';
            Description = 'MGTS10.030';
        }
    }
}

