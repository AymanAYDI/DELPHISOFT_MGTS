tableextension 50031 "DEL ICOutboxPurchaseHeader" extends "IC Outbox Purchase Header" //428
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
        field(50003; "DEL Port de départ"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "DEL Code événement"; Enum "DEL Code Event")
        {
            DataClassification = CustomerContent;
        }
        field(50005; "DEL Récépissé transitaire"; Text[30])
        {
            DataClassification = CustomerContent;
        }
    }
}

