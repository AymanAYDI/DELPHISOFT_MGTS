table 50035 "Import From Invoice"
{
    Caption = 'Import From Invoice';

    fields
    {
        field(1; "Item No."; Code[20])
        {
        }
        field(10; Quantity; Decimal)
        {
        }
        field(20; Amount; Decimal)
        {
        }
        field(30; Currency; Code[10])
        {
        }
        field(40; Rate; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Item No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

