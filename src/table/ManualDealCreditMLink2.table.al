table 50046 "DEL Manual DealCredit M Link.2"
{
    Caption = 'Manual Deal Credit M Linking 2';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            TableRelation = "G/L Entry"."Entry No." WHERE("Document Type" = CONST("Credit Memo"),
                                                           "Credit Amount" = FILTER(> 0));
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
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
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Shipment Selection';
        }
        field(51; "User ID Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = User;
        }
        field(52; "ACO No."; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
            ValidateTableRelation = false;
            Caption = 'ACO No.';
            DataClassification = CustomerContent;
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

