tableextension 50040 "DEL SalesPrice" extends "Sales Price"
{
    fields
    {
        field(50000; "DEL Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            Editable = false;
            TableRelation = Vendor;
            ValidateTableRelation = true;
            DataClassification = CustomerContent;
        }
        field(50001; "DEL Vendor Name"; Text[50])
        {
            CalcFormula = Lookup(Vendor.Name WHERE("No." = FIELD("DEL Vendor No.")));
            Caption = 'Vendor Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50002; "DEL Entry No."; BigInteger)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key5; "DEL Entry No.")
        {
        }
        key(Key6; "Starting Date", "Ending Date")
        {
        }
    }
}

