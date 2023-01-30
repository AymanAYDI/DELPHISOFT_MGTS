
table 50035 "DEL Import From Invoice"
{
    Caption = 'DEL Import From Invoice';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(10; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(30; Currency; Code[10])
        {
            Caption = 'Currency';
            DataClassification = CustomerContent;
        }
        field(40; Rate; Decimal)
        {
            Caption = 'Rate';
            DataClassification = CustomerContent;
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

