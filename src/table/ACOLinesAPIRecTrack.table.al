table 50075 "DEL ACO Lines API Rec. Track."
{
    Caption = 'ACO Lines API Record Tracking';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Deal ID"; Code[20])
        {
            Caption = 'Deal ID';
            TableRelation = "DEL Deal".ID;
            DataClassification = CustomerContent;
        }
        field(2; "ACO No."; Code[20])
        {
            Caption = 'ACO No.';
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
            DataClassification = CustomerContent;
        }
        field(3; "ACO Line No."; Integer)
        {
            Caption = 'ACO Line No.';
            DataClassification = CustomerContent;
        }
        field(4; "ACO Line Type"; Enum "Purchase Line Type")
        {
            Caption = 'ACO Line Type';
            DataClassification = CustomerContent;
        }
        field(5; "ACO Mgts Item No."; Code[20])
        {
            Caption = 'Mgts Item No.';
            DataClassification = CustomerContent;
        }
        field(6; "ACO Supplier Item No."; Code[20])
        {
            AccessByPermission = TableData "Item Reference" = R; //TODO: changed from Item CrossReference
            Caption = 'ACO Supplier Item No.';
            DataClassification = CustomerContent;
        }
        field(7; "ACO External reference NGTS"; Text[30])
        {
            Caption = 'External reference NGTS';
            DataClassification = CustomerContent;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(9; "ACO Line Amount"; Decimal)
        {
            Caption = 'ACO Line Amount';
            DataClassification = CustomerContent;
        }
        field(10; "ACO New Product"; Boolean)
        {
            Caption = 'ACO New Product';
            DataClassification = CustomerContent;
        }
        field(11; "ACO Product Description"; Text[250])
        {
            Caption = 'ACO Product Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Deal ID", "ACO Line No.")
        {
            Clustered = true;
        }
    }


}

