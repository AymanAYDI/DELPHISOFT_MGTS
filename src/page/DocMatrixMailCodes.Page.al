page 50134 "DEL DocMatrix Mail Codes"
{
    Caption = 'Email Code';
    PageType = List;
    SourceTable = "DEL DocMatrix Email Codes";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                }
                field("All Language Codes"; Rec."All Language Codes")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Te&xt")
            {
                Caption = 'Te&xt';
                Image = Text;
                action("Mail Text")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Text';
                    Image = Text;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunPageMode = Edit;

                    trigger OnAction()
                    var
                        lpgDocMatrixEmailText: Page "DEL DocMatrix Email Body";
                    begin
                        lpgDocMatrixEmailText.SETRECORD(Rec);
                        lpgDocMatrixEmailText.RUNMODAL();
                    end;
                }
                action("Mail Place Holders")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Place Holders';
                    Image = CodesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        MESSAGE('%1 = %2\%3 = %4\%5 = %6\%7 = %8',
                                '%1', '"Company Information".Name',
                                '%2', '"Sales Order"."Sell-to Customer No.',
                                '%3', '"Sales Order"."External Document No.',
                                '%4', '"Sales Order"."Your Reference'
                                );
                    end;
                }
            }
        }
    }
}
