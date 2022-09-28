tableextension 50011 "DEL GLAccount" extends "G/L Account"
{

    fields
    {
        field(50000; "DEL Reporting Dimension 1 Code"; Code[20])
        {
            Caption = 'Reporting Dimension 1 Code';
            TableRelation = "DEL Reporting Dimension 1 Code";
        }
        field(50001; "DEL Reporting Dimension 2 Code"; Code[20])
        {
            Caption = 'Reporting Dimension 2 Code';
            TableRelation = "DEL Reporting Dimension 2 Code";
        }
        field(50002; "DEL Shipment Binding Control"; Boolean)
        {
            Caption = 'Excluded from the Link Control Delivery';

        }
        field(50003; "DEL Company Code"; Text[30])
        {
            FieldClass = Normal;
            Caption = 'Company Code';
        }
        field(50004; "DEL Customer Posting Group"; Boolean)
        {
            CalcFormula = Exist("Customer Posting Group" WHERE("Receivables Account" = FIELD("No.")));
            Caption = 'Customer Posting Group';
            FieldClass = FlowField;
        }
        field(50005; "DEL Vendor Posting Group"; Boolean)
        {
            CalcFormula = Exist("Vendor Posting Group" WHERE("Payables Account" = FIELD("No.")));
            Caption = 'Vendor Posting Group';
            FieldClass = FlowField;
        }
        field(50006; "DEL Mobivia Detail"; Text[50])
        {
            Caption = 'Mobivia Detail';

        }
        field(50007; "DEL Hyperion Export Sign"; Enum "DEL Hyperion Export Sign")
        {
            Caption = 'Hyperion Export Sign';
        }
    }
}

