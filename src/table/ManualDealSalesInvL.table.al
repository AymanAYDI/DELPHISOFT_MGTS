table 50047 "DEL Manual Deal Sales Inv. L"
{
    Caption = 'Manual Deal Sales Invoice L';

    fields
    {
        field(1; "Sales Invoice No."; Code[20])
        {
            TableRelation = "Sales Invoice Header";
            Caption = 'Sales Invoice No.';
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
        key(Key1; "Sales Invoice No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

