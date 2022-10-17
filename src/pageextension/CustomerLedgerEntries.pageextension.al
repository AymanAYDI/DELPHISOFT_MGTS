pageextension 50022 "DEL CustomerLedgerEntries" extends "Customer Ledger Entries"
{

    actions
    {

        addafter(ShowDocumentAttachment)
        {
            action("DEL Matrix Print")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Matrix Print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    lrecSalesInvoiceHeader: Record "Sales Invoice Header";
                    lrecSalesCrMemoHeader: Record "Sales Cr.Memo Header";
                    lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
                    lcuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
                    ProcessType: enum "DEL Process Type";
                    lUsage: enum "DEL Usage DocMatrix Selection";
                    lNo: Code[20];
                    lRecordVariant: Variant;
                    lFieldSellToNo: Integer;
                    lFieldDocNo: Integer;
                begin
                    //DEL/PD/20190226/LOP003.begin
                    lNo := '';
                    CASE Rec."Document Type" OF
                        Rec."Document Type"::Invoice:
                            BEGIN
                                lrecSalesInvoiceHeader.RESET();
                                lrecSalesInvoiceHeader.SETRANGE("Posting Date", Rec."Posting Date");
                                lrecSalesInvoiceHeader.SETRANGE("No.", Rec."Document No.");
                                IF lrecSalesInvoiceHeader.FINDFIRST() THEN BEGIN
                                    lUsage := lUsage::"S.Invoice";
                                    lNo := lrecSalesInvoiceHeader."Sell-to Customer No.";
                                    lRecordVariant := lrecSalesInvoiceHeader;
                                    lFieldSellToNo := lrecSalesInvoiceHeader.FIELDNO("Sell-to Customer No.");
                                    lFieldDocNo := lrecSalesInvoiceHeader.FIELDNO("No.");
                                END;
                            END;
                        Rec."Document Type"::"Credit Memo":
                            BEGIN
                                lrecSalesCrMemoHeader.RESET();
                                lrecSalesCrMemoHeader.SETRANGE("Posting Date", Rec."Posting Date");
                                lrecSalesCrMemoHeader.SETRANGE("No.", Rec."Document No.");
                                IF lrecSalesCrMemoHeader.FINDFIRST() THEN BEGIN
                                    lUsage := lUsage::"S.Cr.Memo";
                                    lNo := lrecSalesCrMemoHeader."Sell-to Customer No.";
                                    lRecordVariant := lrecSalesCrMemoHeader;
                                    lFieldSellToNo := lrecSalesCrMemoHeader.FIELDNO("Sell-to Customer No.");
                                    lFieldDocNo := lrecSalesCrMemoHeader.FIELDNO("No.");
                                END;
                            END;
                    END;
                    IF lNo <> '' THEN
                        IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(lNo, ProcessType::Manual, lUsage.AsInteger(), lrecDocMatrixSelection, FALSE) THEN
                            lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage.AsInteger(), ProcessType::Manual, lRecordVariant, lFieldSellToNo, lFieldDocNo, lrecDocMatrixSelection, 0);

                    //DEL/PD/20190226/LOP003.end
                end;
            }
        }
    }
}


