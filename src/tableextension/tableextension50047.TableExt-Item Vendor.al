tableextension 50047 tableextension50047 extends "Item Vendor"
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
    //                                           Added new field: 50001 Country/Region Code
    // ------------------------------------------------------------------------------------------
    fields
    {
        field(50001; "Country/Region Code"; Code[20])
        {
            Caption = 'Coubtry/Region Code';
            Description = 'MGTS10.008';
            TableRelation = Country/Region.Code;
        }
    }
}

