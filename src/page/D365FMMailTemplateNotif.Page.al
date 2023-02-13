page 50146 "D365FM Mail Template Notif."
{
    Caption = 'D365FM Mail Template Notif.';
    PageType = List;
    SourceTable = "DEL D365FM Mail Template";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parameter String"; Rec."Parameter String")
                {
                    ApplicationArea = All;
                }
                field("Template mail"; Rec."Template mail")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Sender Address"; Rec."Sender Address")
                {
                    ApplicationArea = All;
                }
                field(Cci; Rec.Cci)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import template1")
            {
                ApplicationArea = All;
                Caption = 'Import template';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.SetHtmlTemplate();
                end;
            }
            action("Import template2")
            {
                ApplicationArea = All;
                Caption = 'Import template';
                Image = Export;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.ExportHtmlTemplate();
                end;
            }
            action("Import template")
            {
                ApplicationArea = All;
                Caption = 'Import template';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.DeleteHtmlTemplate();
                end;
            }
        }
    }
}
