table 50049 "Export Hyperion Datas"
{
    Caption = 'Export Hyperion Datas';
    // +-------------------------------------------------------------------------------------------------+
    // | Logico SA                                                                                       |
    // | Status: 10.12.13                                                                                |
    // | Customer: NGTS                                                                                  |
    // +-------------------------------------------------------------------------------------------------+
    // 
    // Requirement     UserID   Date       Where                                   Description
    // -----------------------------------------------------------------------------------------------------
    // THS             THS     10.12.13    -                                       Object Creation


    fields
    {
        field(1; "Company Code"; Text[30])
        {
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
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(9; "Line No."; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Company Code", "No.", "Dimension ENSEIGNE")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure InsertLines_Fo(GLAccount_Re: Record "15"; GLEntry_Re: Record "17")
    begin
    end;
}

