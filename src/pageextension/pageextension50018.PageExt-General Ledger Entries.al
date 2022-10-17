pageextension 50018 pageextension50018 extends "General Ledger Entries"
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
    //                                              Created function: SetGLEntry()
    //                                              Added new field: "Customer Provision"
    // ------------------------------------------------------------------------------------------

    //Unsupported feature: Property Modification (SourceTableView) on ""General Ledger Entries"(Page 20)".

    layout
    {
        addafter("Control 4")
        {
            field("External Document No."; "External Document No.")
            {
            }
        }
        addafter("Control 20")
        {
            field("Initial Currency (FCY)"; "Initial Currency (FCY)")
            {
            }
            field("Initial Amount (FCY)"; "Initial Amount (FCY)")
            {
            }
            field("Customer Provision"; "Customer Provision")
            {
            }
        }
    }

    procedure SetGLEntry(var GLEntry: Record "17")
    begin

        //MGTS10.00.001; 001; mhh; entire function
        CurrPage.SETSELECTIONFILTER(GLEntry);
    end;
}

