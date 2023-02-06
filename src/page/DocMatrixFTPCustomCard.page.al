page 50139 "DEL DocMatrix FTP Custom. Card"
{
    PageType = Card;
    SourceTable = "DEL DocMatrix Customer FTP";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    Visible = false;
                }
                field("FTP1 Server"; Rec."FTP1 Server")
                {
                    ApplicationArea = All;
                    Caption = 'FTP1 Server';
                }
                field("FTP1 UserName"; Rec."FTP1 UserName")
                {
                    ApplicationArea = All;
                    Caption = 'FTP1 UserName';
                }
                field("FTP1 Password"; Rec."FTP1 Password")
                {
                    ApplicationArea = All;
                    Caption = 'FTP1 Password';
                }
                field("FTP2 Server"; Rec."FTP2 Server")
                {
                    ApplicationArea = All;
                    Caption = 'FTP2 Server';
                }
                field("FTP2 UserName"; Rec."FTP2 UserName")
                {
                    ApplicationArea = All;
                    Caption = 'FTP2 UserName';
                }
                field("FTP2 Password"; Rec."FTP2 Password")
                {
                    ApplicationArea = All;
                    Caption = 'FTP2 Password';
                }
            }
        }
    }

    actions
    {
    }
}
