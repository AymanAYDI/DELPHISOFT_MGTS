
table 50072 "DEL DocMatrix Customer FTP"

{
    Caption = 'DocMatrix Customer FTP';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(10; "FTP1 Server"; Text[50])
        {
            Caption = 'FTP1 Server';
            DataClassification = CustomerContent;
        }
        field(11; "FTP1 UserName"; Text[20])
        {
            Caption = 'FTP1 UserName';
            DataClassification = CustomerContent;
        }
        field(12; "FTP1 Password"; Text[20])
        {
            Caption = 'FTP1 Password';
            DataClassification = CustomerContent;
        }
        field(20; "FTP2 Server"; Text[50])
        {
            Caption = 'FTP2 Server';
            DataClassification = CustomerContent;
        }
        field(21; "FTP2 UserName"; Text[20])
        {
            Caption = 'FTP2 UserName';
            DataClassification = CustomerContent;
        }
        field(22; "FTP2 Password"; Text[20])
        {
            Caption = 'FTP2 Password';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Customer No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

