page 50146 "D365FM Mail Template Notif."
{


    Caption = 'D365FM Mail Template Notif.';
    PageType = List;
    SourceTable = "DEL D365FM Mail Template";
    UsageCategory = Lists; // a verifier
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Parameter String"; Rec."Parameter String")
                {
                }
                field("Template mail"; Rec."Template mail")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field("Sender Address"; Rec."Sender Address")
                {
                }
                field(Cci; Rec.Cci)
                {
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

