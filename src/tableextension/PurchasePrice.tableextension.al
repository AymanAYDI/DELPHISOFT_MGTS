tableextension 50041 "DEL PurchasePrice" extends "Purchase Price"
{
    // NTGS    02.05.13/LOCO/ChC- Add "Qty. optimale" to the primary key
    // Mgts10.00.04.00      07.12.2021 : Add field(50000)
    fields
    {
        field(50000; "DEL Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            Description = 'Mgts10.00.04.00';
        }
        field(50092; "DEL Qty. optimale"; Decimal)
        {
            Description = 'Temp400';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Item No.,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity"(Key)".

        key(Key1; "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity", "DEL Qty. optimale")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Starting Date", "Ending Date")
        {
            SumIndexFields = "Qty. optimale";
        }
        key(Key3; "Entry No.")
        {
        }
        key(Key4; "Starting Date", "Ending Date")
        {
        }
    }
}

