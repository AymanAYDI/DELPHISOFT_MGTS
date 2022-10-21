pageextension 50028 "DEL VendorList" extends "Vendor List"
{

    layout
    {
        addafter("Balance Due (LCY)")
        {
            field("DEL Supplier Base ID"; Rec."DEL Supplier Base ID")
            {
            }
        }
    }


}

