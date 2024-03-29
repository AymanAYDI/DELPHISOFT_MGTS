table 50047 "DEL Manual Deal Sales Inv. L"
{
    Caption = 'Manual Deal Sales Invoice L';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            DataClassification = CustomerContent;
            TableRelation = "Sales Invoice Header";
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
        key(Key1; "Sales Invoice No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

