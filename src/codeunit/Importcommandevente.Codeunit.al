codeunit 50036 "DEL Import commande vente"
{
    TableNo = "DEL Import Commande vente";

    trigger OnRun()
    begin
        InsertLine(Rec);
    end;

    local procedure InsertLine(REImportCdeVente: Record "DEL Import Commande vente")
    var
        ItemRef: Record "Item Reference";
        SalesLine: Record "Sales Line";

    begin
        SalesLine.INIT();
        SalesLine."Document Type" := SalesLine."Document Type"::Order;
        SalesLine."Document No." := REImportCdeVente."Document No.";
        SalesLine."Line No." := REImportCdeVente."Line No.";
        SalesLine.Type := SalesLine.Type::Item;
        SalesLine.SetHideValidationDialog(TRUE);
        IF REImportCdeVente."No." <> '' THEN BEGIN
            EVALUATE(SalesLine."No.", REImportCdeVente."No.");

            SalesLine.VALIDATE("No.");
        END
        ELSE BEGIN
            ItemRef.SETRANGE("Reference No.", REImportCdeVente."Cross-Reference No.");
            IF ItemRef.FINDFIRST() THEN
                REPEAT
                    ItemRef.CALCFIELDS(ItemRef."DEL Sale blocked");
                    IF ItemRef."DEL Sale blocked" = FALSE THEN
                        SalesLine.VALIDATE("No.", ItemRef."Item No.");
                UNTIL (ItemRef.NEXT() = 0) OR (SalesLine."No." <> '');
        END;
        IF REImportCdeVente.Description <> '' THEN
            SalesLine.Description := REImportCdeVente.Description;
        EVALUATE(SalesLine.Quantity, REImportCdeVente.Quantity);
        SalesLine.VALIDATE(Quantity);
        IF REImportCdeVente."Unit Price" <> '' THEN BEGIN
            EVALUATE(SalesLine."Unit Price", REImportCdeVente."Unit Price");
            SalesLine.VALIDATE("Unit Price");
        END;
        IF REImportCdeVente.Amount <> '' THEN BEGIN
            EVALUATE(SalesLine.Amount, REImportCdeVente.Amount);
            SalesLine.VALIDATE(Amount);
        END;

        IF SalesLine.INSERT(TRUE) THEN
            REImportCdeVente.DELETE();
    end;


    procedure InsertError(var TextErreur: Text)
    var
        ErrorImportvente: Record "DEL Error Import vente";
        DocNum: Code[20];
        LineNo: Text;
        Pos: Text;
    begin

        DocNum := COPYSTR(TextErreur, 1, STRPOS(TextErreur, ';') - 1);
        TextErreur := COPYSTR(TextErreur, STRPOS(TextErreur, ';') + 1);
        LineNo := COPYSTR(TextErreur, 1, STRPOS(TextErreur, ';') - 1);
        TextErreur := COPYSTR(TextErreur, STRPOS(TextErreur, ';') + 1);
        Pos := COPYSTR(TextErreur, 1, STRPOS(TextErreur, ';') - 1);
        TextErreur := COPYSTR(TextErreur, STRPOS(TextErreur, ';') + 1);
        ErrorImportvente."Document No." := DocNum;
        EVALUATE(ErrorImportvente."Line No.", LineNo);
        ErrorImportvente.Position := Pos;
        ErrorImportvente.Error := COPYSTR(TextErreur, 1, 250);
        ErrorImportvente.INSERT();
    end;
}

