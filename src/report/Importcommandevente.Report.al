report 50016 "DEL Import commande vente"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Import Commande vente"; "DEL Import Commande vente")
        {

            trigger OnAfterGetRecord()
            begin

                IF NOT CUImportcdevente.RUN("DEL Import Commande vente") THEN BEGIN
                    i += 1;
                    MsgErreur[i] := "DEL Import Commande vente"."Document No." + ';' + FORMAT("DEL Import Commande vente"."Line No.") + ';' + "DEL Import Commande vente".Position + ';' + GETLASTERRORTEXT;
                END;

            end;

            trigger OnPostDataItem()
            begin
                IF i = 0 THEN
                    MESSAGE(Text001)
                ELSE
                    MESSAGE(Text002, i);
                ErrorImportvente.SETRANGE(ErrorImportvente."Document No.", "DEL Import Commande vente"."Document No.");
                IF ErrorImportvente.FINDSET THEN
                    ErrorImportvente.DELETEALL;
                FOR j := 1 TO i DO
                    CUImportcdevente.InsertError(MsgErreur[j]);
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

    var
        CUImportcdevente: Codeunit "DEL Import commande vente";
        i: Integer;
        MsgErreur: array[1000] of Text;
        ErrorImportvente: Record "DEL Error Import vente";
        j: Integer;
        Text001: Label 'Import successfully';
        Text002: Label 'Import with %1 error(s)';
}

