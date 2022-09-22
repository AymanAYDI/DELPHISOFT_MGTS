table 50040 "DEL Manual Deal Cr. Memo Link."
{
    Caption = 'DEL Manual Deal Cr. Memo Link.';

    fields
    {
        field(1; "Sales Cr. Memo No."; Code[20])
        {
            TableRelation = "Sales Cr.Memo Header";
            Caption = 'Sales Cr. Memo No.';
        }
        field(2; "Deal ID"; Code[20])
        {
            TableRelation = "DEL Deal";
            Caption = 'Deal ID';
        }
        field(50; "Shipment Selection"; Code[20])
        {
            TableRelation = "DEL Deal Shipment";
            Caption = 'Shipment Selection';
        }
        field(51; "User ID Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            //TODO // TableRelation = Table2000000002;
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

