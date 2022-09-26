table 50049 "DEL Export Hyperion Datas"
{
    Caption = 'Export Hyperion Datas';

    fields
    {
        field(1; "Company Code"; Text[30])
        {
            Caption = 'Company Code';
        }
        field(2; "No."; Text[50])
        {
            Caption = 'No.';
        }
        field(3; "No. 2"; Text[50])
        {
            Caption = 'No. acount group';
        }
        field(4; "Reporting Dimension 1 Code"; Code[20])
        {
            Caption = 'Reporting Dimension groupe';
        }
        field(5; "Reporting Dimension 2 Code"; Code[20])
        {
            Caption = 'Reporting Dimension local';
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(7; "Dimension ENSEIGNE"; Code[20])
        {
            Caption = 'Dimension ENSEIGNE';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(9; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(Key1; "Line No.", "Company Code", "No.", "Dimension ENSEIGNE")
        {
            Clustered = true;
        }
    }

}

