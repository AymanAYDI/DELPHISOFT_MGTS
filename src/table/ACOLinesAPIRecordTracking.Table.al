table 50075 "ACO Lines API Record Tracking"
{
    // Mgts10.00.01.00 | 06.02.2020 | Order API Management

    Caption = 'ACO Lines API Record Tracking';

    fields
    {
        field(1; "Deal ID"; Code[20])
        {
            Caption = 'Deal ID';
            TableRelation = Deal.ID;
        }
        field(2; "ACO No."; Code[20])
        {
            Caption = 'ACO No.';
            TableRelation = "Purchase Header".No. WHERE (Document Type=CONST(Order));
        }
        field(3;"ACO Line No.";Integer)
        {
            Caption = 'ACO Line No.';
        }
        field(4;"ACO Line Type";Option)
        {
            Caption = 'ACO Line Type';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(5;"ACO Mgts Item No.";Code[20])
        {
            Caption = 'Mgts Item No.';
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(6;"ACO Supplier Item No.";Code[20])
        {
            AccessByPermission = TableData 5717=R;
            Caption = 'ACO Supplier Item No.';
        }
        field(7;"ACO External reference NGTS";Text[30])
        {
            Caption = 'External reference NGTS';
        }
        field(8;Quantity;Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0:5;
        }
        field(9;"ACO Line Amount";Decimal)
        {
            Caption = 'ACO Line Amount';
        }
        field(10;"ACO New Product";Boolean)
        {
            Caption = 'ACO New Product';
        }
        field(11;"ACO Product Description";Text[250])
        {
            Caption = 'ACO Product Description';
        }
    }

    keys
    {
        key(Key1;"Deal ID","ACO Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

