pageextension 50022 pageextension50022 extends "Customer Ledger Entries"
{
    // DEL/PD/20190903/LOP003 : new action button "Matrix Print"
    // DEL/PD/20191118/CRQ001 : changed action button "Matrix Print": new parameter for "Purchaser Code", fix "0" not relevant for sales

    //Unsupported feature: Property Modification (SourceTableView) on ""Customer Ledger Entries"(Page 25)".

    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 52".

        addafter("Action 13")
        {
            action("Matrix Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Matrix Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lrecSalesInvoiceHeader: Record "112";
                    lrecSalesCrMemoHeader: Record "114";
                    lUsage: Option ,"S.Order","S.Invoice","S.Cr.Memo",,,"P.Order","P.Invoice",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,Statement;
                    lcuDocumentMatrixMgt: Codeunit "50015";
                    ProcessType: Option Manual,Automatic;
                    lrecDocMatrixSelection: Record "50071";
                    lNo: Code[20];
                    lRecordVariant: Variant;
                    lFieldSellToNo: Integer;
                    lFieldDocNo: Integer;
                begin
                    //DEL/PD/20190226/LOP003.begin
                    lNo := '';
                    CASE "Document Type" OF
                        "Document Type"::Invoice:
                            BEGIN
                                lrecSalesInvoiceHeader.RESET;
                                lrecSalesInvoiceHeader.SETRANGE("Posting Date", Rec."Posting Date");
                                lrecSalesInvoiceHeader.SETRANGE("No.", Rec."Document No.");
                                IF lrecSalesInvoiceHeader.FINDFIRST THEN BEGIN
                                    lUsage := lUsage::"S.Invoice";
                                    lNo := lrecSalesInvoiceHeader."Sell-to Customer No.";
                                    lRecordVariant := lrecSalesInvoiceHeader;
                                    lFieldSellToNo := lrecSalesInvoiceHeader.FIELDNO("Sell-to Customer No.");
                                    lFieldDocNo := lrecSalesInvoiceHeader.FIELDNO("No.");
                                END;
                            END;
                        "Document Type"::"Credit Memo":
                            BEGIN
                                lrecSalesCrMemoHeader.RESET;
                                lrecSalesCrMemoHeader.SETRANGE("Posting Date", Rec."Posting Date");
                                lrecSalesCrMemoHeader.SETRANGE("No.", Rec."Document No.");
                                IF lrecSalesCrMemoHeader.FINDFIRST THEN BEGIN
                                    lUsage := lUsage::"S.Cr.Memo";
                                    lNo := lrecSalesCrMemoHeader."Sell-to Customer No.";
                                    lRecordVariant := lrecSalesCrMemoHeader;
                                    lFieldSellToNo := lrecSalesCrMemoHeader.FIELDNO("Sell-to Customer No.");
                                    lFieldDocNo := lrecSalesCrMemoHeader.FIELDNO("No.");
                                END;
                            END;
                    END;
                    IF lNo <> '' THEN BEGIN
                        IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(lNo, ProcessType::Manual, lUsage, lrecDocMatrixSelection, FALSE) THEN
                            lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage, ProcessType::Manual, lRecordVariant, lFieldSellToNo, lFieldDocNo, lrecDocMatrixSelection, 0);
                    END;
                    //DEL/PD/20190226/LOP003.end
                end;
            }
        }
    }
}

