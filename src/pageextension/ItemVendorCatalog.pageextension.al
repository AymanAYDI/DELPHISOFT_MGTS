pageextension 50002 "DEL ItemVendorCatalog" extends "Item Vendor Catalog" //114 
{
    layout
    {
        addafter("Lead Time Calculation") //control 8 
        {
            field("DEL Country/Region Code"; Rec."DEL Country/Region Code")
            {
            }
        }
    }
    actions
    {
    }
}

