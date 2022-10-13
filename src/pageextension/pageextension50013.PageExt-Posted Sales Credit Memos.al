pageextension 50013 pageextension50013 extends "Posted Sales Credit Memos"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.02 :TU 06/06/2018 : Minimisation des clics :
    //                        -  Add new Action "Print MGTS"
    //                        - Add new C/AL code in "Print MGTS - OnAction()"
    // +----------------------------------------------------------------------------------------------------------------+

    //Unsupported feature: Property Modification (SourceTableView) on ""Posted Sales Credit Memos"(Page 144)".

    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 32".

        addafter(ActivityLog)
        {
            action("Print MGTS")
            {
                ApplicationArea = Suite;
                Caption = '&Print MGTS ';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record "114";
                    CduLMinimizingClicksNGTS: Codeunit "50012";
                begin
                    SalesCrMemoHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    CduLMinimizingClicksNGTS.FctPrintCrMemoMGTS(SalesCrMemoHeader);
                    SalesCrMemoHeader.PrintRecords(TRUE);
                end;
            }
        }
    }
}

