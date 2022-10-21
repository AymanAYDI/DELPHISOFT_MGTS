codeunit 50029 "DEL Deal Shipment"
{

    var
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';


    procedure FNC_Insert(Deal_ID_Co_Par: Code[20]; Date_Par: Date; BR_No_Co_Par: Code[20]) DealShipment_ID_Ret: Code[20]
    var
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        Logistic_Re_Loc: Record "DEL Logistic";
        AlertMgt_Cu_Loc: Codeunit "DEL Alert and fee copy Mgt";
    begin
        DealShipment_ID_Ret := FNC_GetNextShipmentNo(Deal_ID_Co_Par);

        dealShipment_Re_Loc.INIT();
        dealShipment_Re_Loc.ID := DealShipment_ID_Ret;
        dealShipment_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
        dealShipment_Re_Loc.VALIDATE("BR No.", BR_No_Co_Par);
        dealShipment_Re_Loc.Date := TODAY;

        IF NOT dealShipment_Re_Loc.INSERT() THEN
            ERROR(ERROR_TXT, 'Cu50029', 'FNC_Insert()', 'Insert impossible !');

        //START JUK
        AlertMgt_Cu_Loc.FNC_LogisticCopy(Deal_ID_Co_Par, DealShipment_ID_Ret);
        //STOP JUK

        //GRC modif begin Création dans table logistic à la création de l'affaire
        Logistic_Re_Loc.SETRANGE(ID, dealShipment_Re_Loc.ID);
        Logistic_Re_Loc.SETRANGE(Deal_ID, dealShipment_Re_Loc.Deal_ID);
        //Logistic_Re_Loc.SETRANGE("BR No.","BR No.");

        IF Logistic_Re_Loc.ISEMPTY THEN BEGIN
            Logistic_Re_Loc.INIT();
            Logistic_Re_Loc.ID := dealShipment_Re_Loc.ID;
            Logistic_Re_Loc.Deal_ID := dealShipment_Re_Loc.Deal_ID;
            Logistic_Re_Loc.FNC_GetInfo(Logistic_Re_Loc);
        END;
        //grc modif end
    end;


    procedure FNC_GetFirstShipmentNo(Deal_ID_Co_Par: Code[20]) ShipmentNo_Co_Ret: Code[20]
    var
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
    begin
        /*__Retourne l'ID du premier Shipment trouvé pour this.Deal__*/
        ShipmentNo_Co_Ret := '';

        dealShipment_Re_Loc.RESET();
        dealShipment_Re_Loc.SETCURRENTKEY(Deal_ID);
        dealShipment_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        IF dealShipment_Re_Loc.FINDFIRST() THEN
            ShipmentNo_Co_Ret := dealShipment_Re_Loc.ID

    end;


    procedure FNC_GetNextShipmentNo(Deal_ID_Co_Par: Code[20]) ShipmentNo_Co_Ret: Code[20]
    var
        deal_Re_Loc: Record "DEL Deal";
    begin
        IF deal_Re_Loc.GET(Deal_ID_Co_Par) THEN BEGIN
            deal_Re_Loc."Next Shipment No." += 1;
            ShipmentNo_Co_Ret := deal_Re_Loc.ID + '-' + FORMAT(deal_Re_Loc."Next Shipment No.");
            deal_Re_Loc.MODIFY();
        END ELSE
            ERROR(
              ERROR_TXT,
              'Cu50029',
              'FNC_GetNextShipmentNo',
              STRSUBSTNO('Deal No. >%1< does not exist !', Deal_ID_Co_Par));
    end;


    procedure FNC_GetPurchaseInvoiceNo(DealShipmentID_Co_Par: Code[20]) PurchInvNo_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin
        /*__Retourne le numéro de Purchase Invoice associé au shipmentNo si il existe, sinon retourne ''__*/

        PurchInvNo_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETCURRENTKEY(dealShipmentConnection_Re_Loc.Shipment_ID);
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN

            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::"Purchase Invoice" THEN BEGIN
                        PurchInvNo_Co_Ret := element_Re_Loc."Type No.";
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END //ELSE
            //ERROR('wrong dealShipmentID');

    end;


    procedure FNC_GetSalesInvoiceNo(DealShipmentID_Co_Par: Code[20]) SalesInvNo_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin
        /*__Retourne le numéro de Purchase Invoice associé au shipmentNo si il existe, sinon retourne ''__*/

        SalesInvNo_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETCURRENTKEY(dealShipmentConnection_Re_Loc.Shipment_ID);
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN

            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::"Sales Invoice" THEN BEGIN
                        SalesInvNo_Co_Ret := element_Re_Loc."Type No.";
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END //ELSE
            //ERROR('wrong dealShipmentID');

    end;


    procedure FNC_GetBRNo(DealShipmentID_Co_Par: Code[20]) BRNo_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin
        /*__Retourne le numéro de BR associé au shipmentNo si il existe, sinon retourne ''__*/

        BRNo_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETCURRENTKEY(dealShipmentConnection_Re_Loc.Shipment_ID);
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::BR THEN BEGIN
                        BRNo_Co_Ret := element_Re_Loc."Type No.";
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END //ELSE
            //ERROR('wrong dealShipmentID');

    end;


    procedure FNC_GetPurchInvoiceElementID(DealShipmentID_Co_Par: Code[20]) PurchInvID_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin

        PurchInvID_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::"Purchase Invoice" THEN BEGIN
                        PurchInvID_Co_Ret := element_Re_Loc.ID;
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END //ELSE
            //ERROR('wrong dealShipmentID');

    end;


    procedure FNC_GetSalesInvoiceElementID(DealShipmentID_Co_Par: Code[20]) SalesInvID_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin
        SalesInvID_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::"Sales Invoice" THEN BEGIN
                        SalesInvID_Co_Ret := element_Re_Loc.ID;
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END //ELSE
            //ERROR('wrong dealShipmentID');

    end;


    procedure FNC_GetBRElementID(DealShipmentID_Co_Par: Code[20]) BRID_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin
        BRID_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::BR THEN BEGIN
                        BRID_Co_Ret := element_Re_Loc.ID;
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END //ELSE
            //ERROR('wrong dealShipmentID');

    end;


    procedure FNC_GetSalesCrMemoElementID(DealShipmentID_Co_Par: Code[20]) CrMemoID_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin

        CrMemoID_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::"Sales Cr. Memo" THEN BEGIN
                        CrMemoID_Co_Ret := element_Re_Loc.ID;
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END
    end;


    procedure FNC_GetPurchCrMemoElementID(DealShipmentID_Co_Par: Code[20]) CrMemoID_Co_Ret: Code[20]
    var
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
    begin

        CrMemoID_Co_Ret := '';

        dealShipmentConnection_Re_Loc.RESET();
        dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipmentID_Co_Par);
        IF dealShipmentConnection_Re_Loc.FINDFIRST() THEN BEGIN
            REPEAT

                IF element_Re_Loc.GET(dealShipmentConnection_Re_Loc.Element_ID) THEN BEGIN
                    IF element_Re_Loc.Type = element_Re_Loc.Type::"Purch. Cr. Memo" THEN BEGIN
                        CrMemoID_Co_Ret := element_Re_Loc.ID;
                        EXIT
                    END
                END

            UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);
        END
    end;


    procedure FNC_GetSalesInvoicePeriod(DealShipmentID_Co_Par: Code[20]) period_Da_Ret: Date
    var
        salesInvoiceHeader_Co_Loc: Record "Sales Invoice Header";
        salesInvoiceNo_Co_Loc: Code[20];
    begin
        period_Da_Ret := 0D;

        salesInvoiceNo_Co_Loc := FNC_GetSalesInvoiceNo(DealShipmentID_Co_Par);

        IF salesInvoiceHeader_Co_Loc.GET(salesInvoiceNo_Co_Loc) THEN
            period_Da_Ret := CALCDATE('<-CM>', salesInvoiceHeader_Co_Loc."Posting Date")
    end;


    procedure FNC_SetPurchaseInvoiceNo(DealShipmentID_Co_Par: Code[20]; PurchaseInvoiceNo_Co_Par: Code[20])
    var
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
    begin
        IF dealShipment_Re_Loc.GET(DealShipmentID_Co_Par) THEN BEGIN
            dealShipment_Re_Loc."Purchase Invoice No." := PurchaseInvoiceNo_Co_Par;
            dealShipment_Re_Loc.MODIFY();
        END
    end;


    procedure FNC_SetSalesInvoiceNo(DealShipmentID_Co_Par: Code[20]; SalesInvoiceNo_Co_Par: Code[20])
    var
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
    begin
        IF dealShipment_Re_Loc.GET(DealShipmentID_Co_Par) THEN BEGIN
            dealShipment_Re_Loc."Sales Invoice No." := SalesInvoiceNo_Co_Par;
            dealShipment_Re_Loc.MODIFY();
        END
    end;


    procedure FNC_SetBRNo(DealShipmentID_Co_Par: Code[20]; BRNo_Co_Par: Code[20])
    var
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
    begin
        IF dealShipment_Re_Loc.GET(DealShipmentID_Co_Par) THEN BEGIN
            dealShipment_Re_Loc."BR No." := BRNo_Co_Par;
            dealShipment_Re_Loc.MODIFY();
        END
    end;
}

