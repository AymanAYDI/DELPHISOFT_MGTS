page 50143 "DEL EDI Export Documents"
{
    ApplicationArea = all;
    Caption = 'EDI Export Documents';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DEL EDI Export Buffer";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("EDI Document Type"; Rec."EDI Document Type")
                {
                    ApplicationArea = All;
                }
                field("EDI Order Type"; Rec."EDI Order Type")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Document Amount"; Rec."Document Amount")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field(Exported; Rec.Exported)
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Export Date"; Rec."Export Date")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                ApplicationArea = All;
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

