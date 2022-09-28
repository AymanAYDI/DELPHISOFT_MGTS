tableextension 50041 "DEL PurchasePrice" extends "Purchase Price"
{
    fields
    {
        field(50000; "DEL Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
        }
        field(50092; "DEL Qty. optimale"; Decimal)
        {
            Caption = 'Qty. optimale';
        }
    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Item No.,Vendor No.,Starting Date,Currency Code,Variant Code,Unit of Measure Code,Minimum Quantity"(Key)".

        key(Key3; "Item No.", "Vendor No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity", "DEL Qty. optimale")
        {
            Clustered = true;
        }
        key(Key4; "Item No.", "Starting Date", "Ending Date")
        {
            SumIndexFields = "DEL Qty. optimale";
        }
        key(Key5; "DEL Entry No.")
        {
        }
        key(Key6; "Starting Date", "Ending Date")
        {
        }
    }
}

