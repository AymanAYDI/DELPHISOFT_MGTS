tableextension 50032 "DEL HandledICOutboxPurchHdr" extends "Handled IC Outbox Purch. Hdr"
{
    fields
    {
        field(50000; "DEL Ship Per"; Option)
        {
            Description = 'EDI';
            OptionMembers = "Air Flight","Sea Vessel";
        }
        field(50002; "DEL Code du transitaire"; Code[20])
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
        field(50007; "Code événement Old"; Text[30])
        {
            Description = 'EDI';
        }
    }
}

