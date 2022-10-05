tableextension 50018 "DEL RequisitionLine" extends "Requisition Line" //246
{

    fields
    {
        field(50000; "DEL Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';

        }
        field(50001; "DEL Purchase Order Due Date"; Date)
        {
            Caption = 'Purchase Order Due Date';

        }
        field(50002; "DEL Recalc. Date Of Delivery"; Date)
        {
            Caption = 'Recalculated date of delivery';

        }
    }
}

