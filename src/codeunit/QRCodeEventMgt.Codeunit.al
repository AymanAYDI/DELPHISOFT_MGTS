codeunit 50051 "DEL QRCode Event Mgt"
{


    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnAfterValidateEvent', 'IBAN', false, false)]
    local procedure OnOnAfterValidateIBAN(var Rec: Record "Vendor Bank Account"; var xRec: Record "Vendor Bank Account"; CurrFieldNo: Integer)
    var
        BankDirectory: Record "Bank Directory";
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

