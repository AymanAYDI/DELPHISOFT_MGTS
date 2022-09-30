page 50139 "DEL DocMatrix FTP Custom. Card"
{
    // DEL/PD/20190306/LOP003 : object created

    PageType = Card;
    SourceTable = "DEL DocMatrix Customer FTP";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    Visible = false;
                }
                field("FTP1 Server"; Rec."FTP1 Server")
                {
                }
                field("FTP1 UserName"; Rec."FTP1 UserName")
                {
                }
                field("FTP1 Password"; Rec."FTP1 Password")
                {
                }
                field("FTP2 Server"; Rec."FTP2 Server")
                {
                }
                field("FTP2 UserName"; Rec."FTP2 UserName")
                {
                }
                field("FTP2 Password"; Rec."FTP2 Password")
                {
                }
            }
        }
    }

    actions
    {
    }
}

