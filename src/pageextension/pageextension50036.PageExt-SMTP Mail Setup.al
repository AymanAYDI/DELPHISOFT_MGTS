pageextension 50036 pageextension50036 extends "SMTP Mail Setup"
{
    // DEL.SAZ 25.07.18 Add field Mail1..Mail5 and "Sender mail"
    layout
    {
        addafter("Control 12")
        {
            group(MaillDest)
            {
                Caption = 'Recipient email';
                field("Sender mail"; "Sender mail")
                {
                    Visible = false;
                }
                field(Mail1; Mail1)
                {
                }
                field(Mail2; Mail2)
                {
                }
                field(Mail3; Mail3)
                {
                }
                field(Mail4; Mail4)
                {
                }
                field(Mail5; Mail5)
                {
                }
            }
        }
    }
}

