tableextension 50018 tableextension50018 extends "Requisition Line"
{
    // 
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // MHH   MGTS0125                   22.07.19   Added new field: 50001 "Purchase Order Due Date"
    //                                             Added new field: 50002 "Recalc. Date Of Delivery"
    fields
    {
        field(50000; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date';
            Description = 'Temp400';
        }
        field(50001; "Purchase Order Due Date"; Date)
        {
            Caption = 'Purchase Order Due Date';
            Description = 'MGTS0125';
        }
        field(50002; "Recalc. Date Of Delivery"; Date)
        {
            Caption = 'Recalculated date of delivery';
            Description = 'MGTS0125';
        }
    }
}

