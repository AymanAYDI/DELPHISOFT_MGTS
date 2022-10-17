pageextension 50002 pageextension50002 extends "Item Vendor Catalog"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Emil Hr. Hristov = ehh
    // Version : MGTS10.008
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version       Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.008    04.09.20    ehh     List of changes:
    //                                           Added new field: "Country/Region Code"
    // ------------------------------------------------------------------------------------------
    layout
    {
        addafter("Control 8")
        {
            field("Country/Region Code"; "Country/Region Code")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 5".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 6".

    }
}

