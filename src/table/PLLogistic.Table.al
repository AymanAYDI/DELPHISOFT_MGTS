table 50036 "DEL P&L Logistic"
{
    Caption = 'DEL P&L Logistic';

    fields
    {
        field(1; "Planned Element ID"; Code[20])
        {
            TableRelation = "DEL Element".ID;
            Caption = 'Planned Element ID';
        }
        field(10; "Planned Element Type No."; Code[20])
        {
            Caption = 'Planned Element Type No.';
        }
        field(13; "Planned Amount"; Decimal)
        {
            Caption = 'Planned Amount';
        }
        field(20; "Real Element ID"; Code[20])
        {
            TableRelation = "DEL Element".ID;
            Caption = 'Real Element ID';
        }
        field(30; "Real Element Type No."; Code[20])
        {
            Caption = 'Real Element Type No.';
        }
        field(33; "Real Amount"; Decimal)
        {
            Caption = 'Real Amount';
        }
        field(40; Delta; Decimal)
        {
            Caption = 'Delta';
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

