page 50138 "DEL DocMatrix Log Entries"
{
    PageType = List;
    SourceTable = "DEL DocMatrix Log";
    SourceTableView = SORTING("Date Time Stamp")
                      ORDER(Descending);
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Time Stamp"; Rec."Date Time Stamp")
                {
                    ApplicationArea = All;
                    Caption = 'Date Time Stamp';
                }
                field("Action"; Rec.Action)
                {
                    ApplicationArea = All;
                    Caption = 'Action';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                }
                field("UserId"; Rec.UserId)
                {
                    ApplicationArea = All;
                    Caption = 'UserId';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field("Process Type"; Rec."Process Type")
                {
                    ApplicationArea = All;
                    Caption = 'Process Type';
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                    Caption = 'Report ID';
                    Visible = false;
                }
                field("Report Caption"; Rec."Report Caption")
                {
                    ApplicationArea = All;
                    Caption = 'Report Caption';
                    Visible = false;
                }
                field(Usage; Rec.Usage)
                {
                    ApplicationArea = All;
                    Caption = 'Usage';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field(Post; Rec.Post)
                {
                    ApplicationArea = All;
                    Caption = 'Post';
                }
                field("Send to FTP 1"; Rec."Send to FTP 1")
                {
                    ApplicationArea = All;
                    Caption = 'Send to FTP 1';
                    Visible = false;
                }
                field("Send to FTP 2"; Rec."Send to FTP 2")
                {
                    ApplicationArea = All;
                    Caption = 'Send to FTP 2';
                    Visible = false;
                }
                field("E-Mail from Sales Order"; Rec."E-Mail from Sales Order")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail from Sales Order';
                }
                field("E-Mail To 1"; Rec."E-Mail To 1")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail To 1';
                    Visible = false;
                }
                field("E-Mail To 2"; Rec."E-Mail To 2")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail To 2';
                    Visible = false;
                }
                field("E-Mail To 3"; Rec."E-Mail To 3")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail To 3';
                    Visible = false;
                }
                field("E-Mail From"; Rec."E-Mail From")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail From';
                    Visible = false;
                }
                field("Save PDF"; Rec."Save PDF")
                {
                    ApplicationArea = All;
                    Caption = 'Save PDF';
                    Visible = false;
                }
                field("Print PDF"; Rec."Print PDF")
                {
                    ApplicationArea = All;
                    Caption = 'Print PDF';
                    Visible = false;
                }
                field("Mail Text Code"; Rec."Mail Text Code")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Text Code';
                    Visible = false;
                }
                field("Mail Text Langauge Code"; Rec."Mail Text Langauge Code")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Text Language Code';
                    Visible = false;
                }
                field("Error"; Rec.Error)
                {
                    ApplicationArea = All;
                    Caption = 'Error';
                }
                field("Process Result Description"; Rec."Process Result Description")
                {
                    ApplicationArea = All;
                    Caption = 'Process Result Description';
                    Visible = false;
                }
                field("Error Solved"; Rec."Error Solved")
                {
                    ApplicationArea = All;
                    Caption = 'Error Solved';
                }
                field("Solving Description"; Rec."Solving Description")
                {
                    ApplicationArea = All;
                    Caption = 'Solving Description';
                }
            }
        }
    }

    actions
    {
    }
}
