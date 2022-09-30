codeunit 50036 "Import commande vente"
{
    TableNo = 50002;

    trigger OnRun()
    begin
        InsertLine(Rec);
    end;

    local procedure InsertLine(REImportCdeVente: Record "50002")
    var
        SalesLine: Record "37";
        ItemCrossRef: Record "5717";
    begin
        SalesLine.INIT;
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
            ItemCrossRef.SETRANGE("Cross-Reference No.", REImportCdeVente."Cross-Reference No.");
            IF ItemCrossRef.FINDFIRST THEN
                REPEAT
                    ItemCrossRef.CALCFIELDS(ItemCrossRef."Sale blocked");
                    IF ItemCrossRef."Sale blocked" = FALSE THEN
                        SalesLine.VALIDATE("No.", ItemCrossRef."Item No.");
                UNTIL (ItemCrossRef.NEXT = 0) OR (SalesLine."No." <> '');
        END;
        IF REImportCdeVente.Description <> '' THEN //DEL.SAZ 18.08.2018
            SalesLine.Description := REImportCdeVente.Description;
        EVALUATE(SalesLine.Quantity, REImportCdeVente.Quantity);
        SalesLine.VALIDATE(Quantity);
        IF REImportCdeVente."Unit Price" <> '' THEN BEGIN //DEL.SAZ 18.08.2018
            EVALUATE(SalesLine."Unit Price", REImportCdeVente."Unit Price");
            SalesLine.VALIDATE("Unit Price");
        END;//DEL.SAZ 18.08.2018
        IF REImportCdeVente.Amount <> '' THEN BEGIN
            EVALUATE(SalesLine.Amount, REImportCdeVente.Amount);
            SalesLine.VALIDATE(Amount);
        END;

        IF SalesLine.INSERT(TRUE) THEN
            REImportCdeVente.DELETE;
    end;

    [Scope('Internal')]
    procedure InsertError(var TextErreur: Text)
    var
        ErrorImportvente: Record "50062";
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
        ErrorImportvente.INSERT;
    end;
}

