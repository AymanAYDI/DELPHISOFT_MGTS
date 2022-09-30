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
                }
                field("Action"; Rec.Action)
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("UserId"; Rec.UserId)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Process Type"; Rec."Process Type")
                {
                }
                field("Report ID"; Rec."Report ID")
                {
                    Visible = false;
                }
                field("Report Caption"; Rec."Report Caption")
                {
                    Visible = false;
                }
                field(Usage; Rec.Usage)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(Post; Rec.Post)
                {
                }
                field("Send to FTP 1"; Rec."Send to FTP 1")
                {
                    Visible = false;
                }
                field("Send to FTP 2"; Rec."Send to FTP 2")
                {
                    Visible = false;
                }
                field("E-Mail from Sales Order"; Rec."E-Mail from Sales Order")
                {
                }
                field("E-Mail To 1"; Rec."E-Mail To 1")
                {
                    Visible = false;
                }
                field("E-Mail To 2"; Rec."E-Mail To 2")
                {
                    Visible = false;
                }
                field("E-Mail To 3"; Rec."E-Mail To 3")
                {
                    Visible = false;
                }
                field("E-Mail From"; Rec."E-Mail From")
                {
                    Visible = false;
                }
                field("Save PDF"; Rec."Save PDF")
                {
                    Visible = false;
                }
                field("Print PDF"; Rec."Print PDF")
                {
                    Visible = false;
                }
                field("Mail Text Code"; Rec."Mail Text Code")
                {
                    Visible = false;
                }
                field("Mail Text Langauge Code"; Rec."Mail Text Langauge Code")
                {
                    Visible = false;
                }
                field("Error"; Rec.Error)
                {
                }
                field("Process Result Description"; Rec."Process Result Description")
                {
                    Visible = false;
                }
                field("Error Solved"; Rec."Error Solved")
                {
                }
                field("Solving Description"; Rec."Solving Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

