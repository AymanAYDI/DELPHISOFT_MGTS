pageextension 50005 pageextension50005 extends "Posted Sales Shpt. Subform"
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
        addafter("Control 32")
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

