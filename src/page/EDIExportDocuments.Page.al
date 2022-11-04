page 50143 "DEL EDI Export Documents"
{
    Caption = 'EDI Export Documents';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL EDI Export Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("EDI Document Type"; Rec."EDI Document Type")
                {
                }
                field("EDI Order Type"; Rec."EDI Order Type")
                {
                }
                field("Document Type"; Rec."Document Type")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document No."; Rec."Document No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document Date"; Rec."Document Date")
                {
                }
                field("Your Reference"; Rec."Your Reference")
                {
                }
                field("Currency Code"; Rec."Currency Code")
                {
                }
                field("Document Amount"; Rec."Document Amount")
                {
                }
                field("Order No."; Rec."Order No.")
                {
                }
                field(Exported; Rec.Exported)
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Export Date"; Rec."Export Date")
                {
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = true;
            }
            systempart(Notes; Notes)
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
                    MGTSEDIManagement: Codeunit "DEL MGTS EDI Management";
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
                    MGTSEDIManagement: Codeunit "DEL MGTS EDI Management";
                begin
                    MGTSEDIManagement.ResendDocument(Rec);
                    CurrPage.UPDATE();
                end;
            }
        }
    }
}

