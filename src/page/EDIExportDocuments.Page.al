page 50143 "EDI Export Documents"
{
    // MGTSEDI10.00.00.00 | 01.11.2020 | Create Page

    Caption = 'EDI Export Documents';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50077;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("EDI Document Type"; "EDI Document Type")
                {
                }
                field("EDI Order Type"; "EDI Order Type")
                {
                }
                field("Document Type"; "Document Type")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document No."; "Document No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Your Reference"; "Your Reference")
                {
                }
                field("Currency Code"; "Currency Code")
                {
                }
                field("Document Amount"; "Document Amount")
                {
                }
                field("Order No."; "Order No.")
                {
                }
                field(Exported; Exported)
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Export Date"; "Export Date")
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = true;
            }
            systempart(; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(OpenDocument)
            {
                Caption = 'Open Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    MGTSEDIManagement: Codeunit "50052";
                begin
                    MGTSEDIManagement.OpenDocument(Rec);
                end;
            }
            action(ResendDocument)
            {
                Caption = 'Resend Document';
                Image = SendElectronicDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    MGTSEDIManagement: Codeunit "50052";
                begin
                    MGTSEDIManagement.ResendDocument(Rec);
                    CurrPage.UPDATE;
                end;
            }
        }
    }
}

