pageextension 50008 "DEL PostedSalesCreditMemo" extends "Posted Sales Credit Memo" //134
{
    layout
    {


        addafter("No. Printed") //18
        {
            field("DEL Fiscal Repr."; Rec."DEL Fiscal Repr.")
            {
            }
        }
    }
    actions
    {
        addafter("Send by &Email") //11
        {
            action("DEL Matrix Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Matrix Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
                    lcuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
                    ProcessType: Enum "DEL Process Type";

                    lUsage: Enum "DEL Usage DocMatrix Selection";

                begin
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Sell-to Customer No.", ProcessType::Manual, lUsage::"S.Cr.Memo", lrecDocMatrixSelection, TRUE) THEN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"S.Cr.Memo", ProcessType::Manual, Rec, Rec.FIELDNO("Sell-to Customer No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, 0);
                end;
            }
        }
        addafter(IncomingDocument)
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

