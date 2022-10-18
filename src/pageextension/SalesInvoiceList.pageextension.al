pageextension 50055 "DEL SalesInvoiceList" extends "Sales Invoice List"
{
    // RBO         19.08.2019          add page Action Post and Print
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 1902018507".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1900316107".

    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 1102601023".

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
                    //THM15.01.18
                    Post(CODEUNIT::"Sales-Post + Print");
                    //THM15.01.18
                end;
            }
        }
    }
}

