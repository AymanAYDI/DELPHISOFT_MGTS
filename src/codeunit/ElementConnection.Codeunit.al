codeunit 50025 "DEL Element Connection"
{
    var
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';


    procedure FNC_Add(Deal_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20]; ApplyTo_Co_Par: Code[20]; Instance_Op_Par: Option; SplittIndex_Int_Par: Integer)
    var
        elementConnection_Re_Loc: Record "DEL Element Connection";
    begin
        FNC_Insert(Deal_ID_Co_Par, Element_ID_Co_Par, ApplyTo_Co_Par, Instance_Op_Par, SplittIndex_Int_Par)

    end;


    procedure FNC_Insert(Deal_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20]; ApplyTo_Co_Par: Code[20]; Instance_Op_Par: Option; SplittIndex_Int_Par: Integer)
    var
        elementConnection_Re_Loc: Record "DEL Element Connection";
    begin
        IF NOT elementConnection_Re_Loc.GET(Deal_ID_Co_Par, Element_ID_Co_Par, ApplyTo_Co_Par) THEN BEGIN

            elementConnection_Re_Loc.INIT();

            elementConnection_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
            elementConnection_Re_Loc.VALIDATE(Element_ID, Element_ID_Co_Par);
            elementConnection_Re_Loc.VALIDATE("Apply To", ApplyTo_Co_Par);
            elementConnection_Re_Loc.VALIDATE(Instance, Instance_Op_Par);
            elementConnection_Re_Loc.VALIDATE("Split Index", SplittIndex_Int_Par);


            IF NOT elementConnection_Re_Loc.INSERT() THEN
                ERROR(ERROR_TXT, 'Co50025', 'FNC_Insert()', 'Insertion impossible dans la table Element Connection')

        END

    end;


    procedure FNC_Delete(Element_ID_Co_Par: Code[20])
    var
        elementConnection_Re_Loc: Record "DEL Element Connection";
    begin
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID);
        elementConnection_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
        elementConnection_Re_Loc.DELETEALL();
    end;
}

