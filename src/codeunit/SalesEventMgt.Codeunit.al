codeunit 50058 "Sales Event Mgt."
{
    // MGTS10.033 :  11.02.2022  Create codeunit
    // MGTS10.034 :  15.02.2022  Add function : UpdateSalesOrderPrices


    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure OnValidateSalesHeaderBillToCustomer(var Rec: Record "36"; var xRec: Record "36"; CurrFieldNo: Integer)
    var
        Customer: Record "18";
    begin
        IF NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice]) THEN
            EXIT;
        IF (CurrFieldNo = Rec.FIELDNO("Bill-to Customer No.")) AND (Rec."Bill-to Customer No." <> xRec."Bill-to Customer No.") THEN BEGIN
            IF NOT Customer.GET(Rec."Bill-to Customer No.") THEN
                EXIT;
            Rec."Mention Under Total" := Customer."Mention Under Total";
            Rec."Amount Mention Under Total" := Customer."Amount Mention Under Total";
        END;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnValidateSalesHeaderSellToCustomer(var Rec: Record "36"; var xRec: Record "36"; CurrFieldNo: Integer)
    var
        Customer: Record "18";
    begin
        IF NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice]) THEN
            EXIT;
        IF (CurrFieldNo = Rec.FIELDNO("Sell-to Customer No.")) AND (Rec."Sell-to Customer No." <> xRec."Sell-to Customer No.") THEN BEGIN
            IF NOT Customer.GET(Rec."Sell-to Customer No.") THEN
                EXIT;
            Rec."Mention Under Total" := Customer."Mention Under Total";
            Rec."Amount Mention Under Total" := Customer."Amount Mention Under Total";
        END;
    end;


    procedure UpdateSalesOrderPrices(SalesHeader: Record "36")
    var
        SalesLine: Record "37";
        NothingToHandleErr: Label 'There is nothing to handle.';
        UpdatedPriceMess: Label 'Update completed.';
        PriceCalcMgt: Codeunit "7000";
        Win: Dialog;
        UpdatePricesInProgress: Label 'Updating prices...';
        CofirmMessage: Label 'Are you sure you want to update the order prices?';
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
        SalesLine.FINDSET;
        REPEAT
            CLEAR(PriceCalcMgt);
            PriceCalcMgt.FindSalesLineLineDisc(SalesHeader, SalesLine);
            PriceCalcMgt.FindSalesLinePrice(SalesHeader, SalesLine, SalesLine.FIELDNO(Quantity));
            SalesLine.VALIDATE("Unit Price");
            SalesLine.MODIFY(TRUE);
        UNTIL SalesLine.NEXT = 0;
        IF GUIALLOWED THEN BEGIN
            Win.CLOSE();
            MESSAGE(UpdatedPriceMess);
        END;
    end;
}

