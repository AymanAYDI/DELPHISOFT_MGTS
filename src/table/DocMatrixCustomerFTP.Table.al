
table 50072 "DEL DocMatrix Customer FTP"

{
    Caption = 'DocMatrix Customer FTP';
    // DEL/PD/20190306/LOP003 : object created


    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(10; "FTP1 Server"; Text[50])
        {
            Caption = 'FTP1 Server';
            DataClassification = ToBeClassified;
        }
        field(11; "FTP1 UserName"; Text[20])
        {
            Caption = 'FTP1 UserName';
            DataClassification = ToBeClassified;
        }
        field(12; "FTP1 Password"; Text[20])
        {
            Caption = 'FTP1 Password';
            DataClassification = ToBeClassified;
        }
        field(20; "FTP2 Server"; Text[50])
        {
            Caption = 'FTP2 Server';
            DataClassification = ToBeClassified;
        }
        field(21; "FTP2 UserName"; Text[20])
        {
            Caption = 'FTP2 UserName';
            DataClassification = ToBeClassified;
        }
        field(22; "FTP2 Password"; Text[20])
        {
            Caption = 'FTP2 Password';
            DataClassification = ToBeClassified;
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

