page 50138 "DocMatrix Log Entries"
{
    // DEL/PD/20190227/LOP003 : object created
    // DEL/PD/20190228/LOP003 : field "Post" inserted
    // DEL/PD/20190305/LOP003 : new field Description
    // 20200915/DEL/PD/CR100  : new field "E-Mail from Sales Order"
    // 20201007/DEL/PD/CR100  : published to PROD

    PageType = List;
    SourceTable = Table50068;
    SourceTableView = SORTING (Date Time Stamp)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Time Stamp"; "Date Time Stamp")
                {
                }
                field(Action; Action)
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field(UserId; UserId)
                {
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Process Type"; "Process Type")
                {
                }
                field("Report ID"; "Report ID")
                {
                    Visible = false;
                }
                field("Report Caption"; "Report Caption")
                {
                    Visible = false;
                }
                field(Usage; Usage)
                {
                }
                field(Name; Name)
                {
                }
                field(Post; Post)
                {
                }
                field("Send to FTP 1"; "Send to FTP 1")
                {
                    Visible = false;
                }
                field("Send to FTP 2"; "Send to FTP 2")
                {
                    Visible = false;
                }
                field("E-Mail from Sales Order"; "E-Mail from Sales Order")
                {
                }
                field("E-Mail To 1"; "E-Mail To 1")
                {
                    Visible = false;
                }
                field("E-Mail To 2"; "E-Mail To 2")
                {
                    Visible = false;
                }
                field("E-Mail To 3"; "E-Mail To 3")
                {
                    Visible = false;
                }
                field("E-Mail From"; "E-Mail From")
                {
                    Visible = false;
                }
                field("Save PDF"; "Save PDF")
                {
                    Visible = false;
                }
                field("Print PDF"; "Print PDF")
                {
                    Visible = false;
                }
                field("Mail Text Code"; "Mail Text Code")
                {
                    Visible = false;
                }
                field("Mail Text Langauge Code"; "Mail Text Langauge Code")
                {
                    Visible = false;
                }
                field(Error; Error)
                {
                }
                field("Process Result Description"; "Process Result Description")
                {
                    Visible = false;
                }
                field("Error Solved"; "Error Solved")
                {
                }
                field("Solving Description"; "Solving Description")
                {
                }
            }
        }
    }

    actions
    {
    }
}

