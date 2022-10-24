tableextension 50032 "DEL HandledICOutboxPurchHdr" extends "Handled IC Outbox Purch. Hdr"
{
    fields
    {
        field(50000; "DEL Ship Per"; Enum "DEL Ship Per")
        {
        }
        field(50002; "DEL Code du transitaire"; Code[20])
        {
        }
        field(50003; "Port de départ"; Text[30])
        {
        }
        field(50004; "Code événement"; Enum "DEL Code Event")
        {
        }
        field(50005; "Récépissé transitaire"; Text[30])
        {
        }
        field(50007; "Code événement Old"; Text[30])
        {
        }
    }
}

