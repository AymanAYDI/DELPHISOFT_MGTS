table 50036 "P&L Logistic"
{
    Caption = 'P&L Logistic';

    fields
    {
        field(1; "Planned Element ID"; Code[20])
        {
            TableRelation = Element.ID;
        }
        field(10; "Planned Element Type No."; Code[20])
        {
        }
        field(13; "Planned Amount"; Decimal)
        {
        }
        field(20; "Real Element ID"; Code[20])
        {
            TableRelation = Element.ID;
        }
        field(30; "Real Element Type No."; Code[20])
        {
        }
        field(33; "Real Amount"; Decimal)
        {
        }
        field(40; Delta; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Planned Element ID", "Real Element ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

