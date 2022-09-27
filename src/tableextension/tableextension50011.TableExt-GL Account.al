tableextension 50011 tableextension50011 extends "G/L Account"
{
    // THM    06.02.14       Hyperion: add field 50005,50004
    // MHH    18.09.19       Added new field: 50006 "Mobivia Detail"
    //        23.11.19       Added new field: 50007 "Hyperion Export Sign"
    fields
    {
        field(50000; "Reporting Dimension 1 Code"; Code[20])
        {
            Caption = 'Reporting Dimension 1 Code';
            TableRelation = "Reporting Dimension 1 Code";
        }
        field(50001; "Reporting Dimension 2 Code"; Code[20])
        {
            Caption = 'Reporting Dimension 2 Code';
            TableRelation = "Reporting Dimension 2 Code";
        }
        field(50002; "Shipment Binding Control"; Boolean)
        {
            Caption = 'Excluded from the Link Control Delivery';
        }
        field(50003; "Company Code"; Text[30])
        {
            FieldClass = Normal;
        }
        field(50004; "Customer Posting Group"; Boolean)
        {
            CalcFormula = Exist ("Customer Posting Group" WHERE (Receivables Account=FIELD(No.)));
            Caption = 'Customer Posting Group';
            FieldClass = FlowField;
        }
        field(50005;"Vendor Posting Group";Boolean)
        {
            CalcFormula = Exist("Vendor Posting Group" WHERE (Payables Account=FIELD(No.)));
            Caption = 'Vendor Posting Group';
            FieldClass = FlowField;
        }
        field(50006;"Mobivia Detail";Text[50])
        {
            Caption = 'Mobivia Detail';
            Description = 'MGTS0126';
        }
        field(50007;"Hyperion Export Sign";Option)
        {
            Caption = 'Hyperion Export Sign';
            Description = 'MGTS0126';
            OptionCaption = 'Positive sign,Negative sign';
            OptionMembers = "Positive Sign","Negative Sign";
        }
    }
}

