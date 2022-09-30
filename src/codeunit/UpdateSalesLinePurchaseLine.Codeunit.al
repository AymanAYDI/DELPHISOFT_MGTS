codeunit 50000 "Update SalesLine/PurchaseLine"
{

    trigger OnRun()
    begin
    end;

    var
        Text0001: Label 'Update Successfully Completed';

    [Scope('Internal')]
    procedure UpdateSalesLine(SalesLineNo: Code[20])
    var
        SalesLine: Record "37";
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesLineNo);
        SalesLine.SETFILTER("Qty. to Ship", '<>0');
        IF SalesLine.FINDFIRST THEN
            REPEAT
                SalesLine.VALIDATE("Qty. to Ship", 0);
                SalesLine.MODIFY;
            UNTIL SalesLine.NEXT = 0;
        MESSAGE(Text0001);
    end;

    [Scope('Internal')]
    procedure UpdatePurchaseLine(PurchaseLineNo: Code[20])
    var
        PurchaseLine: Record "39";
    begin
        PurchaseLine.RESET;
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE("Document No.", PurchaseLineNo);
        PurchaseLine.SETFILTER("Qty. to Receive", '<>0');
        IF PurchaseLine.FINDFIRST THEN
            REPEAT
                PurchaseLine.VALIDATE("Qty. to Receive", 0);
                PurchaseLine.MODIFY;
            UNTIL PurchaseLine.NEXT = 0;
        MESSAGE(Text0001);
    end;
}

