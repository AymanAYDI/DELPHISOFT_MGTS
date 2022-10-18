<<<<<<<< HEAD:src/pageextension/SalesInvoiceList.pageextension.al
pageextension 50055 "DEL SalesInvoiceList" extends "Sales Invoice List"
========
pageextension 50056 "DEL SalesCreditMemos" extends "Sales Credit Memos" //9302
>>>>>>>> 9d6d4b9792ad8c787e0061da2a4e73257e9154b9:src/pageextension/SalesCreditMemos.pageextension.al
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
                    Post(CODEUNIT::"Sales-Post + Print");
                end;
            }
        }
    }
}

