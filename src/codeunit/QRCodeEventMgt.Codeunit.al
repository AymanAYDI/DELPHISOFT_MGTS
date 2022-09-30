codeunit 50051 "QRCode Event Mgt"
{
    // DEL_QR1.00.00.01/RLA/02/11/2020 -  Create CodeUnit


    trigger OnRun()
    begin
    end;

    [EventSubscriber(ObjectType::Table, 288, 'OnAfterValidateEvent', 'IBAN', false, false)]
    local procedure OnOnAfterValidateIBAN(var Rec: Record "288"; var xRec: Record "288"; CurrFieldNo: Integer)
    var
        BankDirectory: Record "11500";
    begin
        IF Rec.ISTEMPORARY OR (STRLEN(Rec.IBAN) < 10) THEN
            EXIT;

        IF (COPYSTR(Rec.IBAN, 1, 2) <> 'CH') THEN
            EXIT;

        IF (COPYSTR(Rec.IBAN, 5, 1) = '3') THEN
            IF BankDirectory.GET(COPYSTR(Rec.IBAN, 5, 5)) THEN
                IF (BankDirectory."SWIFT Address" <> '') THEN
                    Rec."SWIFT Code" := BankDirectory."SWIFT Address";
    end;
}

