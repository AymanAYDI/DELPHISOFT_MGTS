pageextension 50057 pageextension50057 extends "Sales Order List"
{
    // THM     THM15.01.18   add page action post and print
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // NGTS:EDD001.01 :TU 24/05/2018 : Minimisation des clics :
    //   #Added new Action <Action1000000002>Print Confirmation MGTS
    // +----------------------------------------------------------------------------------------------------------------+
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 1902018507".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1900316107".

        addafter("Control 30")
        {
            field("Has Spec. Purch. Order"; "Has Spec. Purch. Order")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 1102601008".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 1102601016".


        //Unsupported feature: Property Modification (RunPageLink) on "Action 1102601017".

        addafter(Post)
        {
            action(PostAndPrint)
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
                    //THM15.01.18
                    Post(CODEUNIT::"Sales-Post + Print");
                    //THM15.01.18
                end;
            }
        }
        addafter("Action 1904702706")
        {
            action("Print Confirmation MGTS")
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
                    CduLMinimizingClicksNGTS: Codeunit "50012";
                begin
                    CduLMinimizingClicksNGTS.FctSalesOrderConfirmationPDFSave(Rec);
                    DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                end;
            }
        }
    }
}

