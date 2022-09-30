codeunit 50027 "Deal Shipment Connection"
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

    [Scope('Internal')]
    procedure FNC_Insert(Deal_ID_Co_Par: Code[20]; Shipment_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20])
    var
        dsc_Re_Loc: Record "50032";
    begin
        /*
        INSERE UNE SHIPMENT CONNECTION DANS LA TABLE DEAL SHIPMENT CONNECTION
        */

        dsc_Re_Loc.INIT();

        dsc_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
        dsc_Re_Loc.VALIDATE(Shipment_ID, Shipment_ID_Co_Par);
        dsc_Re_Loc.VALIDATE(Element_ID, Element_ID_Co_Par);

        IF NOT dsc_Re_Loc.INSERT() THEN
            ERROR('ERREUR\Source : Co 50027\Fonction : FNC_Insert()\Raison : Insertion impossible')

    end;

    [Scope('Internal')]
    procedure FNC_Delete(Element_ID_Co_Par: Code[20])
    var
        dsc_Re_Loc: Record "50032";
    begin
        dsc_Re_Loc.RESET();
        dsc_Re_Loc.SETCURRENTKEY(Element_ID);
        dsc_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
        dsc_Re_Loc.DELETEALL();
    end;
}

