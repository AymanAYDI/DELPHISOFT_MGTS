tableextension 50012 "DEL GLEntry" extends "G/L Entry"
{

    fields
    {
        field(50000; "DEL Initial Amount (FCY)"; Decimal)
        {
            Caption = 'Initial Amount (FCY)';
        }
        field(50001; "DEL Initial Currency (FCY)"; Code[10])
        {
            Caption = 'Initial Currency (FCY)';
        }
        field(50002; "DEL Customer Provision"; Code[20])
        {
            Caption = 'Customer Provision';

            TableRelation = Customer."No.";
        }
        field(50003; "DEL Reverse With Doc. No."; Code[20])
        {
            Caption = 'Reverse With Doc. No.';

            Editable = false;
        }
    }
    keys
    {
        key(Key1; "DEL Reverse With Doc. No.")
        {
        }
    }



}

