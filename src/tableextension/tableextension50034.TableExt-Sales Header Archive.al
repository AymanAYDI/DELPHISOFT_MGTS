tableextension 50034 tableextension50034 extends "Sales Header Archive"
{
    // THM       16.03.18      add field "Event Code"
    // 
    // MGTSEDI10.00.00.22 | 11.02.2021 | EDI Management : Add field 50010
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // 
    // Version : MGTS10.025
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS10.025       17.02.21    mhh     List of changes:
    //                                              Changed type of field: 50004 "Event Code"
    // ------------------------------------------------------------------------------------------
    fields
    {
        field(50000; "Fiscal Repr."; Code[10])
        {
            Caption = 'Fiscal Repr.';
            Description = 'T-00551-SPEC35';
            TableRelation = Contact;
        }
        field(50004; "Event Code"; Option)
        {
            Caption = 'Event Code';
            Description = 'EDI,MGTS10.025';
            OptionCaption = 'NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED';
            OptionMembers = NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED;
        }
        field(50011; "Shipment No."; Text[50])
        {
            Caption = 'Shipment No.';
        }
    }
}

