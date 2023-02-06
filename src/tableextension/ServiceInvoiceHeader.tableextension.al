tableextension 50070 "DEL ServiceInvoiceHeader" extends "Service Invoice Header" //5992
{

    fields
    {
        field(50000; "DEL Payment Reference"; Boolean)
        {
            Caption = 'Payment Reference';
            DataClassification = CustomerContent;
        }
    }
}

