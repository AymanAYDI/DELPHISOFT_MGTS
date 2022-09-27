tableextension 50024 tableextension50024 extends "No. Series"
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
    //                                              Added new field: 50000 "Check Entry For Reverse"
    // ------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Check Entry For Reverse"; Boolean)
        {
            Caption = 'Check For Relation Entry For Reverse';
            Description = 'MGTS10.00.001';
        }
    }
}

