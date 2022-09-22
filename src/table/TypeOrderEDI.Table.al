table 50079 "Type Order EDI"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Emil Hr. Hristov = ehh
    // Version : MGTS10.009
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version       Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.009    09.09.20    ehh     List of changes:
    //                                           Created table
    // ------------------------------------------------------------------------------------------

    LookupPageID = 50142;
    Caption = 'Type Order EDI';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Automatic ACO"; Boolean)
        {
            Caption = 'Automatic ACO';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

