pageextension 50045 pageextension50045 extends "Sales Invoice Subform"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.014
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS10.014       23.11.20    mhh     List of changes:
    //                                              Added new field: "Ship-to Code"
    //                                              Added new field: "Ship-to Name"
    // ------------------------------------------------------------------------------------------
    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".

        addafter("Control 19")
        {
            field("Ship-to Code"; "Ship-to Code")
            {
            }
            field("Ship-to Name"; "Ship-to Name")
            {
            }
        }
    }
}

