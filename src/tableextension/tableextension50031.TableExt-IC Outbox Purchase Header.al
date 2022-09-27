tableextension 50031 tableextension50031 extends "IC Outbox Purchase Header"
{
    // EDI       22.05.13/LOCO/ChC- New fields 50000..50005
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
        field(50000; "Ship Per"; Option)
        {
            Description = 'EDI';
            OptionMembers = "Air Flight","Sea Vessel";
        }
        field(50002; "Code du transitaire"; Code[20])
        {
            Description = 'EDI';
        }
        field(50003; "Port de départ"; Text[30])
        {
            Description = 'EDI';
        }
        field(50004; "Code événement"; Option)
        {
            Description = 'EDI,MGTS10.025';
            OptionCaption = 'NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED';
            OptionMembers = NORM,TYRE,SPARE,SMOOVE,ISP,CANCELLED;
        }
        field(50005; "Récépissé transitaire"; Text[30])
        {
            Description = 'EDI';
        }
    }
}

