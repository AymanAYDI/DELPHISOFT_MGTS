table 50045 "DEL Ship. Prov. Sele. Params"
{
    Caption = 'Ship. Prov. Sele. Params';

    fields
    {
        field(1; user_id; Code[20])
        {
            Caption = 'user_id';
        }
        field(10; period; Date)
        {
            Caption = 'period';
        }
        field(20; isCurrentPeriod; Boolean)
        {
            Caption = 'isCurrentPeriod';
        }
    }

    keys
    {
        key(Key1; user_id)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }


    procedure FNC_Define(period_Da_Par: Date; isCurrentPeriod_Bo_Par: Boolean)
    begin
        FNC_DeleteUserid();

        RESET();
        INIT();
        user_id := USERID();
        period := period_Da_Par;
        isCurrentPeriod := isCurrentPeriod_Bo_Par;
        INSERT();
    end;


    procedure FNC_DeleteUserid()
    begin
        RESET();
        SETRANGE(user_id, USERID);
        IF FINDFIRST() THEN
            DELETEALL();
    end;
}

