codeunit 50089 "DEL PurchaseFunction Mgt"
{


    procedure UpdatePurchaseOrderPrices(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PriceCalcMgt: Codeunit "Purch. Price Calc. Mgt.";

        NothingToHandleErr: Label 'There is nothing to handle.';
        UpdatedPriceMess: Label 'Update completed.';
        Win: Dialog;
        CofirmMessage: Label 'Are you sure you want to update the order prices?';
        UpdatePricesInProgress: Label 'Updating prices...';
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
        PurchaseLine.FINDSET();
        REPEAT
            CLEAR(PriceCalcMgt);
            PriceCalcMgt.FindPurchLineLineDisc(PurchaseHeader, PurchaseLine);
            PriceCalcMgt.FindPurchLinePrice(PurchaseHeader, PurchaseLine, PurchaseLine.FIELDNO(Quantity));
            PurchaseLine.VALIDATE("Direct Unit Cost");
            PurchaseLine.MODIFY(TRUE);
        UNTIL PurchaseLine.NEXT() = 0;
        IF GUIALLOWED THEN BEGIN
            Win.CLOSE();
            MESSAGE(UpdatedPriceMess);
        END;
    end;
}

