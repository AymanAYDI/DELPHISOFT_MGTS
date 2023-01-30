table 50049 "DEL Export Hyperion Datas"
{
    Caption = 'Export Hyperion Datas';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Company Code"; Text[30])
        {
            Caption = 'Company Code';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Text[50])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(3; "No. 2"; Text[50])
        {
            Caption = 'No. acount group';
            DataClassification = CustomerContent;
        }
        field(4; "Reporting Dimension 1 Code"; Code[20])
        {
            Caption = 'Reporting Dimension groupe';
            DataClassification = CustomerContent;
        }
        field(5; "Reporting Dimension 2 Code"; Code[20])
        {
            Caption = 'Reporting Dimension local';
            DataClassification = CustomerContent;
        }
        field(6; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(7; "Dimension ENSEIGNE"; Code[20])
        {
            Caption = 'Dimension ENSEIGNE';
            DataClassification = CustomerContent;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
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

