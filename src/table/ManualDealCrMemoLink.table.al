table 50040 "DEL Manual Deal Cr. Memo Link."
{
    Caption = 'DEL Manual Deal Cr. Memo Link.';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Sales Cr. Memo No."; Code[20])
        {
            Caption = 'Sales Cr. Memo No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Cr.Memo Header";
        }
        field(2; "Deal ID"; Code[20])
        {
            Caption = 'Deal ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal";
        }
        field(50; "Shipment Selection"; Code[20])
        {
            Caption = 'Shipment Selection';
            DataClassification = CustomerContent;
            TableRelation = "DEL Deal Shipment";
        }
        field(51; "User ID Filter"; Code[50])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
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

