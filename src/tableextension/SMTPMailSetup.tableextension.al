tableextension 50030 "DEL SMTPMailSetup" extends "SMTP Mail Setup"
{
    fields
    {
        field(50000; "DEL Mail1"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "DEL Mail2"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "DEL Mail3"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "DEL Mail4"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50004; "DEL Mail5"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "DEL Sender mail"; Text[250])
        {
            Caption = 'Sender mail';
            DataClassification = CustomerContent;
        }
    }
}

