
table 50036 "DEL P&L Logistic"
{
    Caption = 'DEL P&L Logistic';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Planned Element ID"; Code[20])
        {

            Caption = 'Planned Element ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Element".ID;
        }
        field(10; "Planned Element Type No."; Code[20])
        {
            Caption = 'Planned Element Type No.';
            DataClassification = CustomerContent;
        }
        field(13; "Planned Amount"; Decimal)
        {
            Caption = 'Planned Amount';
            DataClassification = CustomerContent;
        }
        field(20; "Real Element ID"; Code[20])
        {
            Caption = 'Real Element ID';
            DataClassification = CustomerContent;
            TableRelation = "DEL Element".ID;
        }
        field(30; "Real Element Type No."; Code[20])
        {
            Caption = 'Real Element Type No.';
            DataClassification = CustomerContent;
        }
        field(33; "Real Amount"; Decimal)
        {
            Caption = 'Real Amount';
            DataClassification = CustomerContent;
        }
        field(40; Delta; Decimal)
        {
            Caption = 'Delta';
            DataClassification = CustomerContent;
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

