tableextension 50027 "DEL SalesLine" extends "Sales Line"
{
    fields
    {
        field(50000; "DEL Customer line reference2"; Text[30])
        {
            Caption = 'Kundenreferenz';
            Description = 'Temp400';
        }
        field(50001; "DEL Qty. Init. Client"; Decimal)
        {
            Description = 'Temp400';
        }
        field(50002; "DEL Campaign Code"; Code[20])
        {
            Description = 'T-00551-SPEC40';
        }
        field(50003; "DEL Requested qtity"; Decimal)
        {
            Caption = 'Requested qtity';
        }
        field(50005; "DEL Estimated Delivery Date"; Date)
        {
            Caption = 'Estimated delivery date';
        }
        field(50006; "DEL Post With Purch. Order No."; Code[20])
        {
            Caption = 'Post with purchase order No.';
            Description = 'MGTS10.00.003';
        }
        field(50007; "DEL Shipped With Difference"; Boolean)
        {
            Caption = 'Shipped with difference';
            Description = 'MGTS10.00.003';
            Editable = false;
        }
        field(50008; "DEL Ship-to Code"; Code[10])
        {
            Caption = 'Ship-to Code';
            Description = 'MGTS10.014';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Customer No."));


        }
        field(50009; "DEL Ship-to Name"; Text[50])
        {
            Caption = 'Ship-to Name';
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


    var
        CustPriceGroup: Record "Customer Price Group";
        GeneralSetup: Record "DEL General Setup";
        element_Re_Loc: Record "DEL Element";
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
        DealItem_Cu: Codeunit "DEL Deal Item";
        Deal_Cu: Codeunit "DEL Deal";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        requestID_Co_Loc: Code[20];
        ArchQte: Label 'Voulez vous archivé l''ancienne quantité';
        Text50000: Label '%1|%2';
}

