table 50048 "DEL Manual Purch. Cr. Memo L"
{
    Caption = 'Manual Purchase Cr. Memo L';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Purch Cr. Memo No."; Code[20])
        {
            Caption = 'Purch Cr. Memo No.';
            DataClassification = CustomerContent;
            TableRelation = "Purch. Cr. Memo Hdr.";
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
        key(Key1; "Purch Cr. Memo No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

