table 50040 "Manual Deal Cr. Memo Linking"
{
    Caption = 'Manual Deal Cr. Memo Linking';

    fields
    {
        field(1; "Sales Cr. Memo No."; Code[20])
        {
            TableRelation = "Sales Cr.Memo Header";
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
        key(Key1; "Sales Cr. Memo No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

