pageextension 50004 pageextension50004 extends "User Setup"
{
    // MGTSEDI10.00.00.00 | 01.11.2020 | EDI Management : Add field : Resend EDI Document
    layout
    {
        addafter("Control 3")
        {
            field("Resend EDI Document"; "Resend EDI Document")
            {
            }
        }
    }
}

