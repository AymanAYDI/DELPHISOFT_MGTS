pageextension 50057 "DEL SalesOrderList" extends "Sales Order List" //9305
{
    layout
    {


        addafter("Amount Including VAT")
        {
            field("DEL Has Spec. Purch. Order"; Rec."DEL Has Spec. Purch. Order")
            {
            }
        }
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
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';

                trigger OnAction()
                begin
                    //TODO 
                    // PostDocument(CODEUNIT::"Sales-Post + Print"); //post() --> PostDocument() mais elle est une Procedure locale 

                end;
            }
        }
        addafter("Sales Reservation Avail.")
        {
            action("DEL Print Confirmation MGTS")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Confirmation MGTS';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Print MGTS';

                trigger OnAction()
                var
                    CduLMinimizingClicksNGTS: Codeunit "DEL Minimizing Clicks - MGTS";
                begin
                    CduLMinimizingClicksNGTS.FctSalesOrderConfirmationPDFSave(Rec);
                    //TODO  // DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                end;
            }
        }
    }
}

