table 50047 "Manual Deal Sales Invoice L"
{
    Caption = 'Manual Deal Sales Invoice L';

    fields
    {
        field(1; "Sales Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
        }
        field(2; "Deal ID"; Code[20])
        {
            TableRelation = Deal;
        }
        field(50; "Shipment Selection"; Code[20])
        {
            TableRelation = "Deal Shipment";
        }
        field(51; "User ID Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = Table2000000002;
        }
    }

    keys
    {
        key(Key1; "Sales Invoice No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

