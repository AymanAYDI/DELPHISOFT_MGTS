tableextension 50032 "DEL HandledICOutboxPurchHdr" extends "Handled IC Outbox Purch. Hdr" //432
{
    fields
    {
        field(50000; "DEL Ship Per"; Enum "DEL Ship Per")
        {
            DataClassification = CustomerContent;
        }
        field(50002; "DEL Code du transitaire"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Port de départ"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Code événement"; Enum "DEL Code Event")
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Récépissé transitaire"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50007; "Code événement Old"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }
}

