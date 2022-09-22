table 50037 "DEL Manual Deal Inv. Linking"
{
    Caption = 'DEL Manual Deal Inv. Linking';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            TableRelation = "G/L Entry"."Entry No." WHERE("Document Type" = CONST(Invoice),
                                                           "System-Created Entry" = CONST(false),
                                                           Amount = FILTER(> 0));
            Caption = 'Entry No.';
        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(20; "Account No."; Text[20])
        {
            Caption = 'Account No.';
        }
        field(50; "Shipment Selection"; Integer)
        {

            CalcFormula = Count("DEL Deal Shipment Selection" WHERE(Checked = CONST(true),
                                                                 "Account Entry No." = FIELD("Entry No."),
                                                                 USER_ID = FIELD("User ID Filter")));
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Shipment Selection';
        }
        field(51; "User ID Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            //TODO // TableRelation = 2000000002;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

