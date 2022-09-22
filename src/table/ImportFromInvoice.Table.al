table 50035 "DEL Import From Invoice"
{
    Caption = 'DEL Import From Invoice';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(30; Currency; Code[10])
        {
            Caption = 'Currency';
        }
        field(40; Rate; Decimal)
        {
            Caption = 'Rate';
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }


}

