pageextension 50003 pageextension50003 extends "General Ledger Setup"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001    18.12.19    mhh     List of changes:
    //                                              Added new field: "Provision Source Code"
    //                                              Added new field: "Provision Journal Batch"
    // ------------------------------------------------------------------------------------------
    layout
    {
        addafter("Control 4")
        {
            field("Provision Source Code"; "Provision Source Code")
            {
            }
            field("Provision Journal Batch"; "Provision Journal Batch")
            {
            }
        }
        addafter("Control 7")
        {
            group("QR Code")
            {
                Caption = 'QR Code';
                field("SEPA Non-Euro Export"; "SEPA Non-Euro Export")
                {
                }
            }
        }
    }
}

