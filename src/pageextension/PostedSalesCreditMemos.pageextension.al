pageextension 50013 "DEL PostedSalesCreditMemos" extends "Posted Sales Credit Memos" //144
{

    actions
    {

        addafter(ActivityLog)
        {
            action("DEL Print MGTS")
            {
                ApplicationArea = Suite;
                Caption = '&Print MGTS ';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    CduLMinimizingClicksNGTS: Codeunit "DEL Minimizing Clicks - MGTS";
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

