codeunit 50058 "DEL Sales Event Mgt."
{
    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure OnValidateSalesHeaderBillToCustomer(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        IF NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice]) THEN
            EXIT;
        IF (CurrFieldNo = Rec.FIELDNO("Bill-to Customer No.")) AND (Rec."Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN BEGIN
            IF NOT Customer.GET(Rec."Bill-to Customer No.") THEN
                EXIT;
            Rec."DEL Mention Under Total" := Customer."DEL Mention Under Total";
            Rec."DEL Amount Mention Under Total" := Customer."DEL Amount Mention Under Total";
        END;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnValidateSalesHeaderSellToCustomer(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Customer: Record Customer;
    begin
        IF NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice]) THEN
            EXIT;
        IF (CurrFieldNo = Rec.FIELDNO("Sell-to Customer No.")) AND (Rec."Sell-to Customer No." <> xRec."Sell-to Customer No.") THEN BEGIN
            IF NOT Customer.GET(Rec."Sell-to Customer No.") THEN
                EXIT;
            Rec."DEL Mention Under Total" := Customer."DEL Mention Under Total";
            Rec."DEL Amount Mention Under Total" := Customer."DEL Amount Mention Under Total";
        END;
    end;

    procedure UpdateSalesOrderPrices(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        PriceCalcMgt: Codeunit "Sales Price Calc. Mgt.";

        Win: Dialog;
        CofirmMessage: Label 'Are you sure you want to update the order prices?';
        NothingToHandleErr: Label 'There is nothing to handle.';
        UpdatedPriceMess: Label 'Update completed.';
        UpdatePricesInProgress: Label 'Updating prices...';
    begin
        IF NOT CONFIRM(CofirmMessage) THEN
            EXIT;
        SalesHeader.TESTFIELD(Status, SalesHeader.Status::Open);
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        IF SalesLine.ISEMPTY THEN
            ERROR(NothingToHandleErr);
        IF GUIALLOWED THEN
            Win.OPEN(UpdatePricesInProgress);
        SalesLine.FINDSET();
        REPEAT
            CLEAR(PriceCalcMgt);
            PriceCalcMgt.FindSalesLineLineDisc(SalesHeader, SalesLine);
            PriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, SalesLine.FIELDNO(Quantity));
            SalesLine.VALIDATE("Unit Price");
            SalesLine.MODIFY(TRUE);
        UNTIL SalesLine.NEXT() = 0;
        IF GUIALLOWED THEN BEGIN
            Win.CLOSE();
            MESSAGE(UpdatedPriceMess);
        END;
    end;
}
