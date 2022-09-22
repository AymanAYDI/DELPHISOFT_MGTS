table 50046 "Manual Deal Credit M Linking 2"
{
    Caption = 'Manual Deal Credit M Linking 2';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            TableRelation = "G/L Entry"."Entry No." WHERE(Document Type=CONST(Credit Memo),
                                                           Credit Amount=FILTER(>0));
        }
        field(10;"Document No.";Code[20])
        {
        }
        field(20;"Account No.";Text[20])
        {
        }
        field(50;"Shipment Selection";Integer)
        {
            CalcFormula = Count("Deal Shipment Selection" WHERE (Checked=CONST(Yes),
                                                                 Account Entry No.=FIELD(Entry No.),
                                                                 USER_ID=FIELD(User ID Filter)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51;"User ID Filter";Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = Table2000000002;
        }
        field(52;"ACO No.";Code[20])
        {
            TableRelation = "Purchase Header".No.;
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

