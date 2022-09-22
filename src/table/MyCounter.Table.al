table 50004 "DEL MyCounter"
{
    Caption = 'DEL MyCounter';

    fields
    {
        field(10; Value; Integer)
        {
            Caption = 'Value';
        }
    }

    keys
    {
        key(Key1; Value)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

