pageextension 50046 pageextension50046 extends "Purchase Quote"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.024
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.024       10.02.21    mhh     List of changes:
    //                                             Added new field: "Due Date Calculation"
    // ------------------------------------------------------------------------------------------
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 13".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 5".

        addafter("Control 19")
        {
            field("Due Date Calculation"; "Due Date Calculation")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 63".

    }
}

