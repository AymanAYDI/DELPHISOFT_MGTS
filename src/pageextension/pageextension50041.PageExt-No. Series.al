pageextension 50041 pageextension50041 extends "No. Series"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001    28.01.20    mhh     List of changes:
    //                                              Added new field: "Check Entry For Reverse"
    // ------------------------------------------------------------------------------------------
    layout
    {
        addafter("Control 32")
        {
            field("Check Entry For Reverse"; "Check Entry For Reverse")
            {
                Caption = 'Check For Relation Entry For Reverse';
            }
        }
    }
}

