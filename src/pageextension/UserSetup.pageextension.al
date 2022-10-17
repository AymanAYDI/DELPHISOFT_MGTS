pageextension 50004 "DEL UserSetup" extends "User Setup"
{
    layout
    {
        addafter("Time Sheet Admin.") //control 3 
        {
            field("DEL Resend EDI Document"; Rec."DEL Resend EDI Document")
            {
            }
        }
    }
}

