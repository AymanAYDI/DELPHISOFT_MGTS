pageextension 50029 pageextension50029 extends "Recurring General Journal"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version         Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001   18.12.19    mhh     List of changes:
    //                                             Added new field: "Customer Provision"
    // ------------------------------------------------------------------------------------------
    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".

        addafter("Control 3")
        {
            field("Customer Provision"; "Customer Provision")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 84".

    }
}

