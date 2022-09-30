codeunit 50025 "Element Connection"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 09.09.08                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01  RC4                       09.09.08   Created Doc


    trigger OnRun()
    begin
    end;

    var
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';

    [Scope('Internal')]
    procedure FNC_Add(Deal_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20]; ApplyTo_Co_Par: Code[20]; Instance_Op_Par: Option; SplittIndex_Int_Par: Integer)
    var
        elementConnection_Re_Loc: Record "50027";
    begin
        /*év. faire des trucs avant d'insérer..*/
        /*
        MESSAGE('Connection add\nDeal_ID : %1\nElement_ID : %2\nApply To : %3\nInstance : %4',
          Deal_ID_Co_Par,
          Element_ID_Co_Par,
          ApplyTo_Co_Par,
          Instance_Op_Par,
        );
        */

        FNC_Insert(Deal_ID_Co_Par, Element_ID_Co_Par, ApplyTo_Co_Par, Instance_Op_Par, SplittIndex_Int_Par)

    end;

    [Scope('Internal')]
    procedure FNC_Insert(Deal_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20]; ApplyTo_Co_Par: Code[20]; Instance_Op_Par: Option; SplittIndex_Int_Par: Integer)
    var
        elementConnection_Re_Loc: Record "50027";
    begin
        IF NOT elementConnection_Re_Loc.GET(Deal_ID_Co_Par, Element_ID_Co_Par, ApplyTo_Co_Par) THEN BEGIN

            elementConnection_Re_Loc.INIT();

            elementConnection_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
            elementConnection_Re_Loc.VALIDATE(Element_ID, Element_ID_Co_Par);
            elementConnection_Re_Loc.VALIDATE("Apply To", ApplyTo_Co_Par);
            elementConnection_Re_Loc.VALIDATE(Instance, Instance_Op_Par);
            elementConnection_Re_Loc.VALIDATE("Split Index", SplittIndex_Int_Par);

            /*
            MESSAGE('Connection add\nDeal_ID : %1\nElement_ID : %2\nApply To : %3\nInstance : %4',
              elementConnection_Re_Loc.Deal_ID,
              elementConnection_Re_Loc.Element_ID,
              elementConnection_Re_Loc."Apply To",
              elementConnection_Re_Loc.Instance
            );
            */

            IF NOT elementConnection_Re_Loc.INSERT() THEN
                ERROR(ERROR_TXT, 'Co50025', 'FNC_Insert()', 'Insertion impossible dans la table Element Connection')

        END

    end;

    [Scope('Internal')]
    procedure FNC_Delete(Element_ID_Co_Par: Code[20])
    var
        elementConnection_Re_Loc: Record "50027";
    begin
        elementConnection_Re_Loc.RESET();
        elementConnection_Re_Loc.SETCURRENTKEY(Element_ID);
        elementConnection_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
        elementConnection_Re_Loc.DELETEALL();
    end;
}

