page 50138 "DEL DocMatrix Log Entries"
{


    PageType = List;
    SourceTable = "DEL DocMatrix Log";
    SourceTableView = SORTING("Date Time Stamp")
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Time Stamp"; Rec."Date Time Stamp")
                {
                    Caption = 'Date Time Stamp';
                }
                field("Action"; Rec.Action)
                {
                    Caption = 'Action';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("UserId"; Rec.UserId)
                {
                    Caption = 'UserId';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Process Type"; Rec."Process Type")
                {
                    Caption = 'Process Type';
                }
                field("Report ID"; Rec."Report ID")
                {
                    Visible = false;
                    Caption = 'Report ID';
                }
                field("Report Caption"; Rec."Report Caption")
                {
                    Visible = false;
                    Caption = 'Report Caption';
                }
                field(Usage; Rec.Usage)
                {
                    Caption = 'Usage';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(Post; Rec.Post)
                {
                    Caption = 'Post';
                }
                field("Send to FTP 1"; Rec."Send to FTP 1")
                {
                    Visible = false;
                    Caption = 'Send to FTP 1';
                }
                field("Send to FTP 2"; Rec."Send to FTP 2")
                {
                    Visible = false;
                    Caption = 'Send to FTP 2';
                }
                field("E-Mail from Sales Order"; Rec."E-Mail from Sales Order")
                {
                    Caption = 'E-Mail from Sales Order';
                }
                field("E-Mail To 1"; Rec."E-Mail To 1")
                {
                    Visible = false;
                    Caption = 'E-Mail To 1';
                }
                field("E-Mail To 2"; Rec."E-Mail To 2")
                {
                    Visible = false;
                    Caption = 'E-Mail To 2';
                }
                field("E-Mail To 3"; Rec."E-Mail To 3")
                {
                    Visible = false;
                    Caption = 'E-Mail To 3';
                }
                field("E-Mail From"; Rec."E-Mail From")
                {
                    Visible = false;
                    Caption = 'E-Mail From';
                }
                field("Save PDF"; Rec."Save PDF")
                {
                    Visible = false;
                    Caption = 'Save PDF';
                }
                field("Print PDF"; Rec."Print PDF")
                {
                    Visible = false;
                    Caption = 'Print PDF';
                }
                field("Mail Text Code"; Rec."Mail Text Code")
                {
                    Visible = false;
                    Caption = 'Mail Text Code';
                }
                field("Mail Text Langauge Code"; Rec."Mail Text Langauge Code")
                {
                    Visible = false;
                    Caption = 'Mail Text Language Code';
                }
                field("Error"; Rec.Error)
                {
                    Caption = 'Error';
                }
                field("Process Result Description"; Rec."Process Result Description")
                {
                    Visible = false;
                    Caption = 'Process Result Description';
                }
                field("Error Solved"; Rec."Error Solved")
                {
                    Caption = 'Error Solved';
                }
                field("Solving Description"; Rec."Solving Description")
                {
                    Caption = 'Solving Description';
                }
            }
        }
    }

    actions
    {
    }
}

