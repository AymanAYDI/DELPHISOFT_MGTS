
table 50039 "DEL Update Request Manager"
{
    Caption = 'DEL Update Request Manager';

    fields
    {
        field(1; ID; Code[20])
        {

            Caption = 'ID';
        }
        field(10; Request_For_Deal_ID; Code[20])
        {
            TableRelation = "DEL Deal".ID;
            Caption = 'Request_For_Deal_ID';

        }
        field(15; Requested_By_User; Code[50])
        {

            Caption = 'Requested_By_User';
        }
        field(20; Requested_By_Type; enum "DEL Requested By Type")
        {
            Caption = 'Requested_By_Type';
        }
        field(30; "Requested_By_Type No."; Code[20])
        {
            Caption = 'Requested_By_Type No.';

        }
        field(40; Requested_At; DateTime)
        {

            Caption = 'Requested_At';
        }
        field(50; Request_Status; Enum "DEL Request_Status")
        {
            InitValue = NOK;
            Caption = 'Request_Status';
        }
        field(60; "To be ignored"; Boolean)
        {
            Caption = 'To be ignored';
        }
        field(70; Description; Text[250])
        {
            Caption = 'Description';

        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
        key(Key2; Request_For_Deal_ID, Requested_By_Type, "Requested_By_Type No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        VALIDATE(Requested_By_User, USERID);
    end;

    trigger OnModify()
    begin
        VALIDATE(Requested_By_User, USERID);
    end;
}

