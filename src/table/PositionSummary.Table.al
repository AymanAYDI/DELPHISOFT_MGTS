table 50029 "DEL Position Summary"
{
    Caption = 'Description';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;

            TableRelation = Item."No.";
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Planned Sales"; Decimal)
        {
            Caption = 'Planned Sales';
            DataClassification = CustomerContent;
        }
        field(4; "Planned Purchases"; Decimal)
        {
            Caption = 'Planned Purchases';
            DataClassification = CustomerContent;
        }
        field(5; "Planned Fees"; Decimal)
        {
            Caption = 'Planned Fees';
            DataClassification = CustomerContent;
        }
        field(6; "Planned Gross Margin"; Decimal)
        {
            Caption = 'Planned Gross Margin';
            DataClassification = CustomerContent;
        }
        field(7; "Planned Final Margin"; Decimal)
        {
            Caption = 'Planned Final Margin';
            DataClassification = CustomerContent;
        }
        field(8; "Planned % Of Gross Margin"; Decimal)
        {
            Caption = 'Planned % Of Gross Margin';
            DataClassification = CustomerContent;
        }
        field(9; "Planned % Of Final Margin"; Decimal)
        {
            Caption = 'Planned % Of Final Margin';
            DataClassification = CustomerContent;
        }
        field(10; "Real Sales"; Decimal)
        {
            Caption = 'Real Sales';
            DataClassification = CustomerContent;
        }
        field(11; "Real Purchases"; Decimal)
        {
            Caption = 'Real Purchases';
            DataClassification = CustomerContent;
        }
        field(12; "Real Fees"; Decimal)
        {
            Caption = 'Real Fees';
            DataClassification = CustomerContent;
        }
        field(13; "Real Gross Margin"; Decimal)
        {
            Caption = 'Real Gross Margin';
            DataClassification = CustomerContent;
        }
        field(14; "Real Final Margin"; Decimal)
        {
            Caption = 'Real Final Margin';
            DataClassification = CustomerContent;
        }
        field(15; "Real % Of Gross Margin"; Decimal)
        {
            Caption = 'Real % Of Gross Margin';
            DataClassification = CustomerContent;
        }
        field(16; "Real % Of Final Margin"; Decimal)
        {
            Caption = 'Real % Of Final Margin';
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

    fieldgroups
    {
    }
}

