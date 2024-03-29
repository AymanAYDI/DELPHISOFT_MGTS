tableextension 50027 "DEL SalesLine" extends "Sales Line"
{
    fields
    {
        field(50000; "DEL Customer line reference2"; Text[30])
        {
            Caption = 'Kundenreferenz';
            DataClassification = CustomerContent;
            Description = 'Temp400';
        }
        field(50001; "DEL Qty. Init. Client"; Decimal)
        {
            DataClassification = CustomerContent;
            Description = 'Temp400';
        }
        field(50002; "DEL Campaign Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Description = 'T-00551-SPEC40';
        }
        field(50003; "DEL Requested qtity"; Decimal)
        {
            Caption = 'Requested qtity';
            DataClassification = CustomerContent;
        }
        field(50005; "DEL Estimated Delivery Date"; Date)
        {
            Caption = 'Estimated delivery date';
            DataClassification = CustomerContent;
        }
        field(50006; "DEL Post With Purch. Order No."; Code[20])
        {
            Caption = 'Post with purchase order No.';
            DataClassification = CustomerContent;
            Description = 'MGTS10.00.003';
        }
        field(50007; "DEL Shipped With Difference"; Boolean)
        {
            Caption = 'Shipped with difference';
            DataClassification = CustomerContent;
            Description = 'MGTS10.00.003';
            Editable = false;
        }
        field(50008; "DEL Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            DataClassification = CustomerContent;
            Description = 'MGTS10.014';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));
        }
        field(50009; "DEL Ship-to Name"; Text[100])
        {
            Caption = 'Ship-to Name';
            DataClassification = CustomerContent;
            Description = 'MGTS10.014';
            Editable = false;
        }

    }
    keys
    {
        key(Key21; "Special Order Purchase No.")
        {
        }
    }
}

