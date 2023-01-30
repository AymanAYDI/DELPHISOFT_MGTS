table 50004 "DEL MyCounter"
{
    Caption = 'DEL MyCounter';
    DataClassification = CustomerContent;
    fields
    {
        field(10; Value; Integer)
        {
            Caption = 'Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; Value)
        {
            Clustered = true;
        }
    }

}

