pageextension 50008 pageextension50008 extends "Posted Sales Credit Memo"
{
    // +----------------------------------------------------------------------------------------------------------------+
    // |DBE                                                                                                             |
    // |http://www.dbexcellence.ch/                                                                                     |
    // +----------------------------------------------------------------------------------------------------------------+
    // MGTS:EDD001.02 :TU 06/06/2018 : Minimisation des clics :
    //                   - Add new action "Print MGTS"
    //                   - Add new C/AL code in "Print MGTS - OnAction()"
    // +----------------------------------------------------------------------------------------------------------------+
    // 
    // DEL/PD/20190903/LOP003 : new Action Button "Matrix Print"
    // DEL/PD/20191118/CRQ001 : changed action button "Matrix Print": new parameter for "Purchaser Code", fix "0" not relevant for sales
    layout
    {


        //Unsupported feature: Code Modification on "Control 75.OnAssistEdit".

        //trigger OnAssistEdit()
        //>>>> ORIGINAL CODE:
        //begin
        /*
        ChangeExchangeRate.SetParameter("Currency Code","Currency Factor","Posting Date");
        ChangeExchangeRate.EDITABLE(FALSE);
        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN BEGIN
          "Currency Factor" := ChangeExchangeRate.GetParameter;
          MODIFY;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        //>>>> MODIFIED CODE:
        //begin
        /*
        #1..4
          // LOCO/ChC -
          //MODIFY;
        END;
        CLEAR(ChangeExchangeRate);
        */
        //end;
        addafter("Control 18")
        {
            field("Fiscal Repr."; "Fiscal Repr.")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 49".

        addafter("Action 11")
        {
            action("Matrix Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Matrix Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                var
                    lUsage: Option ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Statement;
                    lcuDocumentMatrixMgt: Codeunit "50015";
                    ProcessType: Option Manual,Automatic;
                    lrecDocMatrixSelection: Record "50071";
                begin
                    //DEL/PD/20190212/LOP003.begin
                    //SalesCrMemoHeader := Rec;
                    //CurrPage.SETSELECTIONFILTER(SalesCrMemoHeader);
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Sell-to Customer No.", ProcessType::Manual, lUsage::"S.Cr.Memo", lrecDocMatrixSelection, TRUE) THEN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"S.Cr.Memo", ProcessType::Manual, Rec, Rec.FIELDNO("Sell-to Customer No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, 0);
                    //DEL/PD/20190212/LOP003.end
                end;
            }
        }
        addafter(IncomingDocument)
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

