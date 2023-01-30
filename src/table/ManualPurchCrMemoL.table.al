table 50048 "DEL Manual Purch. Cr. Memo L"
{
    Caption = 'Manual Purchase Cr. Memo L';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Purch Cr. Memo No."; Code[20])
        {
            TableRelation = "Purch. Cr. Memo Hdr.";
            Caption = 'Purch Cr. Memo No.';
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
        key(Key1; "Purch Cr. Memo No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

