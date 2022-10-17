report 50051 "DEL Update lines CAMT054"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; "Gen. Journal Line")
        {

            trigger OnAfterGetRecord()
            begin
                InvoiceNo := COPYSTR(Description, 19, 8);
                InvoiceNo := TrimInvoiceNo(InvoiceNo);
                CustLedgerEntry.SETRANGE("Document Type", CustLedgerEntry."Document Type"::Invoice);
                CustLedgerEntry.SETRANGE("Document No.", InvoiceNo);
                CustLedgerEntry.SETRANGE(Open, TRUE);
                IF CustLedgerEntry.FINDFIRST() THEN BEGIN
                    VALIDATE("Account Type", "Account Type"::Customer);
                    VALIDATE("Account No.", CustLedgerEntry."Customer No.");
                    "Applies-to Doc. Type" := "Applies-to Doc. Type"::Invoice;
                    "Applies-to Doc. No." := InvoiceNo;
                    MODIFY();
                    LinesUpdated += 1;
                END;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE(ML_LinesUpdated, LinesUpdated);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        LinesUpdated := 0;
    end;

    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        InvoiceNo: Code[20];
        LinesUpdated: Integer;
        ML_LinesUpdated: Label '%1 lines updated.';

    local procedure TrimInvoiceNo(InInvoiceNo: Code[10]) InvoiceReturn: Code[20]
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        InvCount: Integer;
        TmpInvNo: Code[10];
        ReferenceNo: Code[10];
        Text042: Label 'More than one open invoice were found for the Reference No. %1.';
    begin
        ReferenceNo := InInvoiceNo;
        TmpInvNo := InInvoiceNo;
        CustLedgEntry.SETCURRENTKEY("Document No.");
        CustLedgEntry.SETRANGE("Document Type", CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SETRANGE(Open, TRUE);
        WHILE TmpInvNo[1] = '0' DO BEGIN
            CustLedgEntry.SETRANGE("Document No.", TmpInvNo);
            IF CustLedgEntry.FINDFIRST() THEN BEGIN
                InvCount := InvCount + 1;
                IF InvCount > 1 THEN
                    ERROR(Text042, ReferenceNo);
                InInvoiceNo := TmpInvNo;
            END;
            TmpInvNo := COPYSTR(TmpInvNo, 2);
        END;
        IF InvCount = 0 THEN
            InInvoiceNo := TmpInvNo;

        IF (TmpInvNo[1] <> '0') AND (InvCount = 1) THEN BEGIN
            CustLedgEntry2.SETCURRENTKEY("Document No.");
            CustLedgEntry2.SETRANGE("Document Type", CustLedgEntry2."Document Type"::Invoice);
            CustLedgEntry2.SETRANGE(Open, TRUE);
            CustLedgEntry2.SETRANGE("Document No.", TmpInvNo);
            IF CustLedgEntry2.FINDFIRST() THEN
                ERROR(Text042, ReferenceNo);
        END;

        InvoiceReturn := InInvoiceNo;
    end;
}

