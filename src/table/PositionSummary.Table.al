table 50029 "DEL Position Summary"
{
    Caption = 'Description';

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item."No.";
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Planned Sales"; Decimal)
        {
            Caption = 'Planned Sales';
        }
        field(4; "Planned Purchases"; Decimal)
        {
            Caption = 'Planned Purchases';
        }
        field(5; "Planned Fees"; Decimal)
        {
            Caption = 'Planned Fees';
        }
        field(6; "Planned Gross Margin"; Decimal)
        {
            Caption = 'Planned Gross Margin';
        }
        field(7; "Planned Final Margin"; Decimal)
        {
            Caption = 'Planned Final Margin';
        }
        field(8; "Planned % Of Gross Margin"; Decimal)
        {
            Caption = 'Planned % Of Gross Margin';
        }
        field(9; "Planned % Of Final Margin"; Decimal)
        {
            Caption = 'Planned % Of Final Margin';
        }
        field(10; "Real Sales"; Decimal)
        {
            Caption = 'Real Sales';
        }
        field(11; "Real Purchases"; Decimal)
        {
            Caption = 'Real Purchases';
        }
        field(12; "Real Fees"; Decimal)
        {
            Caption = 'Real Fees';
        }
        field(13; "Real Gross Margin"; Decimal)
        {
            Caption = 'Real Gross Margin';
        }
        field(14; "Real Final Margin"; Decimal)
        {
            Caption = 'Real Final Margin';
        }
        field(15; "Real % Of Gross Margin"; Decimal)
        {
            Caption = 'Real % Of Gross Margin';
        }
        field(16; "Real % Of Final Margin"; Decimal)
        {
            Caption = 'Real % Of Final Margin';
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

