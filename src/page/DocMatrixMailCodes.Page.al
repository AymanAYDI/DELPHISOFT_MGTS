page 50134 "DEL DocMatrix Mail Codes"
{
    Caption = 'Email Code';
    PageType = List;
    SourceTable = "DEL DocMatrix Email Codes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                }
                field("Language Code"; Rec."Language Code")
                {
                }
                field("All Language Codes"; Rec."All Language Codes")
                {
                }
                field(Subject; Rec.Subject)
                {
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


    procedure ReadBLOB(pCode: Code[20]; pLanguage: Code[10])
    var

    begin


    end;


    procedure WriteBLOB(pCode: Code[20]; pLanguage: Code[10])
    var

    begin


    end;


    procedure SetBodyText(pbtxBigText: BigText)
    begin


    end;
}

