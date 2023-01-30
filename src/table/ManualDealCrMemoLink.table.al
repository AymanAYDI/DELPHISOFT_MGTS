table 50040 "DEL Manual Deal Cr. Memo Link."
{
    Caption = 'DEL Manual Deal Cr. Memo Link.';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Sales Cr. Memo No."; Code[20])
        {
            TableRelation = "Sales Cr.Memo Header";
            Caption = 'Sales Cr. Memo No.';
            DataClassification = CustomerContent;
        }
        field(2; "Deal ID"; Code[20])
        {
            TableRelation = "DEL Deal";
            Caption = 'Deal ID';
            DataClassification = CustomerContent;
        }
        field(50; "Shipment Selection"; Code[20])
        {
            TableRelation = "DEL Deal Shipment";
            Caption = 'Shipment Selection';
            DataClassification = CustomerContent;
        }
        field(51; "User ID Filter"; Code[50])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = User;
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

