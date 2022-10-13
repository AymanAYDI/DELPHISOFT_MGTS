report 50016 "Import commande vente"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table50002)
        {

            trigger OnAfterGetRecord()
            begin

                IF NOT CUImportcdevente.RUN("Import Commande vente") THEN BEGIN
                    i += 1;
                    MsgErreur[i] := "Import Commande vente"."Document No." + ';' + FORMAT("Import Commande vente"."Line No.") + ';' + "Import Commande vente".Position + ';' + GETLASTERRORTEXT;
                END;

            end;

            trigger OnPostDataItem()
            begin
                IF i = 0 THEN
                    MESSAGE(Text001)
                ELSE
                    MESSAGE(Text002, i);
                ErrorImportvente.SETRANGE(ErrorImportvente."Document No.", "Import Commande vente"."Document No.");
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
        CUImportcdevente: Codeunit "50036";
        i: Integer;
        MsgErreur: array[1000] of Text;
        ErrorImportvente: Record "50062";
        j: Integer;
        Text001: Label 'Import successfully';
        Text002: Label 'Import with %1 error(s)';
}

