tableextension 50030 tableextension50030 extends "SMTP Mail Setup"
{
    // DEL.SAZ  25.07.18  Add filed 50000..50005
    fields
    {
        field(50000; Mail1; Text[250])
        {
        }
        field(50001; Mail2; Text[250])
        {
        }
        field(50002; Mail3; Text[250])
        {
        }
        field(50003; Mail4; Text[250])
        {
        }
        field(50004; Mail5; Text[250])
        {
        }
        field(50005; "Sender mail"; Text[250])
        {
            Caption = 'Sender mail';
        }
    }
}

