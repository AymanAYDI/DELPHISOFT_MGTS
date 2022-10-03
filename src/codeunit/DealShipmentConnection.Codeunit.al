codeunit 50027 "DEL Deal Shipment Connection"
{


    procedure FNC_Insert(Deal_ID_Co_Par: Code[20]; Shipment_ID_Co_Par: Code[20]; Element_ID_Co_Par: Code[20])
    var
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
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


    procedure FNC_Delete(Element_ID_Co_Par: Code[20])
    var
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
    begin
        dsc_Re_Loc.RESET();
        dsc_Re_Loc.SETCURRENTKEY(Element_ID);
        dsc_Re_Loc.SETRANGE(Element_ID, Element_ID_Co_Par);
        dsc_Re_Loc.DELETEALL();
    end;
}

