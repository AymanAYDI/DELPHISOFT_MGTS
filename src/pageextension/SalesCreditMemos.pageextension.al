pageextension 50056 "DEL SalesCreditMemos" extends "Sales Credit Memos" //9302

{

    layout

    {

    }

    actions

    {




        addafter(Post)

        {

            action("DEL PostAndPrint")

            {

                Caption = 'Post and &Print';

                Ellipsis = true;

                Image = PostPrint;

                Promoted = true;

                PromotedCategory = Category5;

                PromotedIsBig = true;

                ShortCutKey = 'Shift+F9';



                trigger OnAction()

                begin

                    // PostDocument(CODEUNIT::"Sales-Post + Print"); // TODO: Procedure local "this last name Post"

                end;

            }

        }

    }

}