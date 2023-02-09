table 50046 "DEL Manual DealCredit M Link.2"
{
    Caption = 'Manual Deal Credit M Linking 2';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Entry"."Entry No." WHERE("Document Type" = CONST("Credit Memo"),
                                                           "Credit Amount" = FILTER(> 0));
        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(20; "Account No."; Text[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
        }
        field(50; "Shipment Selection"; Integer)
        {
            CalcFormula = Count("DEL Deal Shipment Selection" WHERE(Checked = CONST(true),
                                                                 "Account Entry No." = FIELD("Entry No."),
                                                                 USER_ID = FIELD("User ID Filter")));
            Caption = 'Shipment Selection';
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "User ID Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = User;
        }
        field(52; "ACO No."; Code[20])
        {
            Caption = 'ACO No.';
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No.";
            ValidateTableRelation = false;
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

