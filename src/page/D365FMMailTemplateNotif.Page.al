page 50146 "D365FM Mail Template Notif."
{
    // +--------------------------------------------------------------------+
    // | D365FM14.00.00.11      | 30.11.21 | Job Queue Notification
    // |                                      Create Page
    // +--------------------------------------------------------------------+

    Caption = 'D365FM Mail Template Notif.';
    PageType = List;
    SourceTable = Table50082;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parameter String"; "Parameter String")
                {
                }
                field("Template mail"; "Template mail")
                {
                }
                field(Title; Title)
                {
                }
                field("Sender Address"; "Sender Address")
                {
                }
                field(Cci; Cci)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import template")
            {
                Caption = 'Import template';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    SetHtmlTemplate();
                end;
            }
            action("Import template")
            {
                Caption = 'Import template';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    ExportHtmlTemplate();
                end;
            }
            action("Import template")
            {
                Caption = 'Import template';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    DeleteHtmlTemplate();
                end;
            }
        }
    }
}

