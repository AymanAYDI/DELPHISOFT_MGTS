codeunit 50089 "PurchaseFunction Mgt"
{
    // MGTS10.035 :  18.03.2022  Create codeunit AND Add function : UpdateSalesOrderPrices


    trigger OnRun()
    begin
    end;


    procedure UpdatePurchaseOrderPrices(PurchaseHeader: Record "38")
    var
        PurchaseLine: Record "39";
        NothingToHandleErr: Label 'There is nothing to handle.';
        UpdatedPriceMess: Label 'Update completed.';
        PriceCalcMgt: Codeunit "7010";
        Win: Dialog;
        UpdatePricesInProgress: Label 'Updating prices...';
        CofirmMessage: Label 'Are you sure you want to update the order prices?';
    begin
        IF NOT CONFIRM(CofirmMessage) THEN
            EXIT;
        PurchaseHeader.TESTFIELD(Status, PurchaseHeader.Status::Open);
        PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        IF PurchaseLine.ISEMPTY THEN
            ERROR(NothingToHandleErr);
        IF GUIALLOWED THEN
            Win.OPEN(UpdatePricesInProgress);
        PurchaseLine.FINDSET;
        REPEAT
            CLEAR(PriceCalcMgt);
            PriceCalcMgt.FindPurchLineLineDisc(PurchaseHeader, PurchaseLine);
            PriceCalcMgt.FindPurchLinePrice(PurchaseHeader, PurchaseLine, PurchaseLine.FIELDNO(Quantity));
            PurchaseLine.VALIDATE("Direct Unit Cost");
            PurchaseLine.MODIFY(TRUE);
        UNTIL PurchaseLine.NEXT = 0;
        IF GUIALLOWED THEN BEGIN
            Win.CLOSE();
            MESSAGE(UpdatedPriceMess);
        END;
    end;
}

