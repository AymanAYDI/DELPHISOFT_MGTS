table 50048 "DEL Manual Purch. Cr. Memo L"
{
    Caption = 'Manual Purchase Cr. Memo L';

    fields
    {
        field(1; "Purch Cr. Memo No."; Code[20])
        {
            TableRelation = "Purch. Cr. Memo Hdr.";
            Caption = 'Purch Cr. Memo No.';
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
            //   TODO //  TableRelation = Table2000000002;
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

