tableextension 50025 tableextension50025 extends "Purchases & Payables Setup"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // NGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    // Added new field 50000"PDF Registration Customer Path"[Text50]
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.004,MGTS10.00.006
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.004    03.02.20    mhh     List of changes:
    //                                              Added new field: 50001 "Do Not Print Invoice"
    // 
    // 002     MGTS10.00.006    04.02.20    mhh     List of changes:
    //                                              Added new field: 50002 "Sales Ship Time By Air Flight"
    //                                              Added new field: 50003 "Sales Ship Time By Sea Vessel"
    //                                              Added new field: 50004 "Sales Ship Time By Sea/Air"
    //                                              Added new field: 50005 "Sales Ship Time By Truck"
    //                                              Added new field: 50006 "Sales Ship Time By Train"
    // ------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "PDF Registration Vendor Path"; Text[50])
        {
            Caption = 'PDF Registration Vendor Path';
        }
        field(50001; "Do Not Print Invoice"; Boolean)
        {
            Caption = 'Do Not Print Invoice When Posting';
            Description = 'MGTS10.00.004';
        }
        field(50002; "Sales Ship Time By Air Flight"; DateFormula)
        {
            Caption = 'Sales shipping time by air flight';
            Description = 'MGTS10.00.006';
        }
        field(50003; "Sales Ship Time By Sea Vessel"; DateFormula)
        {
            Caption = 'Sales shipping time by sea vessel';
            Description = 'MGTS10.00.006';
        }
        field(50004; "Sales Ship Time By Sea/Air"; DateFormula)
        {
            Caption = 'Sales shipping time by see/air';
            Description = 'MGTS10.00.006';
        }
        field(50005; "Sales Ship Time By Truck"; DateFormula)
        {
            Caption = 'Sales shipping time by truck';
            Description = 'MGTS10.00.006';
        }
        field(50006; "Sales Ship Time By Train"; DateFormula)
        {
            Caption = 'Sales shipping time by train';
            Description = 'MGTS10.00.006';
        }
    }
}

