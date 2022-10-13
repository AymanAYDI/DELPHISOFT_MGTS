codeunit 50020 "DEL Deal"
{
    trigger OnRun()
    begin
    end;

    var

        Element_Cu: Codeunit "DEL Element";
        Position_Cu: Codeunit "DEL Position";
        Fee_Cu: Codeunit "DEL Fee";
        NoSeriesMgt_Cu: Codeunit NoSeriesManagement;

        DealShipment_Cu: Codeunit "DEL Deal Shipment";
        ERROR_TXT: Label 'ERREUR\Source : %1\Function : %2\Reason : %3';
        Setup: Record "DEL General Setup";
        DealItem_Cu: Codeunit "DEL Deal Item";
        Currency_Exchange_Re: Record "DEL Currency Exchange";


    procedure FNC_New_Deal(ACO_No_Co_Par: Code[20]) deal_ID_Co_Ret: Code[20]
    var
        purchaseHeader_Re_Loc: Record "Purchase Header";
        purchaseHeaderArchive_Re_Loc: Record "Purchase Header Archive";
    begin

        IF purchaseHeader_Re_Loc.GET(purchaseHeader_Re_Loc."Document Type"::Order, ACO_No_Co_Par) THEN BEGIN

            deal_ID_Co_Ret :=
              FNC_Insert_Deal(
                'AFF' + COPYSTR(ACO_No_Co_Par, STRPOS(ACO_No_Co_Par, '-')),
                purchaseHeader_Re_Loc."Purchaser Code",
                purchaseHeader_Re_Loc."Document Date"
              );

            FNC_Attach_ACO(deal_ID_Co_Ret, ACO_No_Co_Par);

        END ELSE BEGIN
            purchaseHeaderArchive_Re_Loc.SETRANGE("Document Type", purchaseHeaderArchive_Re_Loc."Document Type"::Order);
            purchaseHeaderArchive_Re_Loc.SETRANGE("No.", ACO_No_Co_Par);
            IF purchaseHeaderArchive_Re_Loc.FINDLAST THEN BEGIN
                deal_ID_Co_Ret :=
                  FNC_Insert_Deal(
                    'AFF' + COPYSTR(ACO_No_Co_Par, STRPOS(ACO_No_Co_Par, '-')),
                    purchaseHeaderArchive_Re_Loc."Purchaser Code",
                    purchaseHeaderArchive_Re_Loc."Document Date"
                  );

                FNC_Attach_ACO(deal_ID_Co_Ret, ACO_No_Co_Par);
            END;
        END;

    end;


    procedure FNC_Init_Deal(Deal_ID_Co_Par: Code[20]; Update_Planned_Bo_Par: Boolean; Update_Silently_Bo_Par: Boolean)
    var
        intProgressI: Integer;
        diaProgress: Dialog;
        intProgress: Integer;
        intProgressTotal: Integer;
        success_Bo_Loc: Boolean;
        "-MGTS10.00-": Integer;
        APIOrdersTrackRecordsMgt: Codeunit "DEL API Orders Track Rec. Mgt.";
    begin

        Element_Cu.FNC_Add_Planned_Elements(Deal_ID_Co_Par, Update_Planned_Bo_Par);
        Element_Cu.FNC_Add_Real_Elements(Deal_ID_Co_Par);
        Position_Cu.FNC_Add_Positions(Deal_ID_Co_Par, Update_Planned_Bo_Par, Update_Silently_Bo_Par);
        APIOrdersTrackRecordsMgt.UpdateOrderAPIRecordTracking(Deal_ID_Co_Par);

    end;


    procedure FNC_Reinit_Deal(Deal_ID_Co_Par: Code[20]; Update_Planned_Par: Boolean; Update_Silently_Par: Boolean)
    var
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        deal_Item_Re_Loc: Record "DEL Deal Item";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        ACO_Re_Loc: Record "Purchase Header";
        VCO_Re_Loc: Record "Sales Header";
        update_planned: Boolean;
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
    begin
        IF Update_Planned_Par THEN BEGIN

            update_planned := TRUE;

        END ELSE BEGIN
            update_planned := FALSE;

            element_Re_Loc.RESET();
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Instance, position_Re_Loc.Instance::Real);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice", element_Re_Loc.Type::"Sales Invoice");
            IF NOT element_Re_Loc.FINDFIRST THEN
                update_planned := TRUE;

        END;

        IF update_planned THEN BEGIN

            position_Re_Loc.RESET();
            position_Re_Loc.SETCURRENTKEY(Deal_ID);
            position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            position_Re_Loc.SETRANGE(Instance, position_Re_Loc.Instance::Planned);
            position_Re_Loc.DELETEALL();

            elementConnection_Re_Loc.RESET();
            elementConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            elementConnection_Re_Loc.SETRANGE(Instance, elementConnection_Re_Loc.Instance::planned);
            elementConnection_Re_Loc.DELETEALL();

            element_Re_Loc.RESET();
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Instance, position_Re_Loc.Instance::Planned);
            element_Re_Loc.DELETEALL();

            FNC_Init_Deal(Deal_ID_Co_Par, TRUE, Update_Silently_Par);

            FNC_UpdatePurchaserCode(Deal_ID_Co_Par);

        END ELSE BEGIN

            FNC_Init_Deal(Deal_ID_Co_Par, FALSE, Update_Silently_Par);

        END;

        FNC_UpdateStatus(Deal_ID_Co_Par);

        FNC_Set_LastUpdate_DateTime(Deal_ID_Co_Par);
        FNC_UpdatePeriod(Deal_ID_Co_Par);

        IF NOT Update_Silently_Par THEN
            MESSAGE('Affaire %1 mise à jour avec succès !', Deal_ID_Co_Par);

    end;


    procedure FNC_Reinit_Silently_Deal(Deal_ID_Co_Par: Code[20]; UpdatePlanned_Bo_Par: Boolean)
    begin
        FNC_Reinit_Deal(Deal_ID_Co_Par, UpdatePlanned_Bo_Par, TRUE);
    end;


    procedure FNC_Delete(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
        dealItem_Re_Loc: Record "DEL Deal Item";
        deal_Re_Loc: Record "DEL Deal";
        currencyExchange_Re_Loc: Record "DEL Currency Exchange";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        logistic_Re_Loc: Record "DEL Logistic";
        sps_Re_Loc: Record "DEL Shipment Provision Select.";
    begin

        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT
                Element_Cu.FNC_Delete_Element(element_Re_Loc.ID)
            UNTIL (element_Re_Loc.NEXT() = 0);

        ACOConnection_Re_Loc.RESET();
        ACOConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        ACOConnection_Re_Loc.DELETEALL();

        dealItem_Re_Loc.RESET();
        dealItem_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        dealItem_Re_Loc.DELETEALL();

        currencyExchange_Re_Loc.RESET();
        currencyExchange_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        currencyExchange_Re_Loc.DELETEALL();

        dealShipment_Re_Loc.RESET();
        dealShipment_Re_Loc.SETCURRENTKEY(Deal_ID);
        dealShipment_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        dealShipment_Re_Loc.DELETEALL();

        dealShipmentSelection_Re_Loc.RESET();
        dealShipmentSelection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        dealShipmentSelection_Re_Loc.DELETEALL();

        sps_Re_Loc.RESET();
        sps_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        sps_Re_Loc.DELETEALL();

        logistic_Re_Loc.RESET();
        logistic_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
        logistic_Re_Loc.DELETEALL();

        deal_Re_Loc.RESET();
        deal_Re_Loc.SETRANGE(ID, Deal_ID_Co_Par);
        deal_Re_Loc.DELETEALL();

    end;


    procedure FNC_Insert_Deal(Deal_ID_Co_Par: Code[20]; PurchaserCode_Co_Par: Code[10]; ACODocumentDate_Da_Par: Date) deal_ID_Co_Ret: Code[20]
    var
        deal_Re_Loc: Record "DEL Deal";
    begin

        IF NOT deal_Re_Loc.GET(Deal_ID_Co_Par) THEN BEGIN

            deal_ID_Co_Ret := Deal_ID_Co_Par;

            deal_Re_Loc.INIT();
            deal_Re_Loc.ID := deal_ID_Co_Ret;
            deal_Re_Loc.Status := deal_Re_Loc.Status::"In order";
            deal_Re_Loc.Date := TODAY;
            deal_Re_Loc.VALIDATE("Purchaser Code", PurchaserCode_Co_Par);
            deal_Re_Loc."ACO Document Date" := ACODocumentDate_Da_Par;

            IF NOT deal_Re_Loc.INSERT() THEN
                ERROR(ERROR_TXT, 'Co 50020', 'FNC_Insert_New_Deal()', 'Insert() impossible dans la table Deal');

        END ELSE
            ERROR(ERROR_TXT, 'Co 50020', 'FNC_Insert_New_Deal()', 'Cette affaire est déjà existante !');

    end;


    procedure FNC_Set_Deal(var Deal_Re_Par: Record "DEL Deal"; Deal_ID_Co_Par: Code[20])
    begin

        IF NOT Deal_Re_Par.GET(Deal_ID_Co_Par) THEN
            ERROR(ERROR_TXT, 'Co 50020', 'FNC_Set_Deal()', FORMAT('GET() impossible avec Deal.ID >' + Deal_ID_Co_Par + '<'));

    end;




    procedure FNC_Get_ACO(var element_Re_Par: Record "DEL Element"; dealID_Co_Par: Code[20])
    begin
        element_Re_Par.RESET();
        element_Re_Par.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Par.SETRANGE(Deal_ID, dealID_Co_Par);
        element_Re_Par.SETRANGE(Type, element_Re_Par.Type::ACO);
        element_Re_Par.SETRANGE(Instance, element_Re_Par.Instance::planned);

    end;


    procedure FNC_UpdateStatus(Deal_ID_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "DEL Deal";
        element_Re_Loc: Record "DEL Element";
        isInvoiced_Bo_Loc: Boolean;
        purchHeader_Re_Loc: Record "Purchase Header";
        salesHeader_Re_Loc: Record "Sales Header";
    begin

        FNC_Set_Deal(deal_Re_Loc, Deal_ID_Co_Par);

        IF ((deal_Re_Loc.Status <> deal_Re_Loc.Status::Closed) AND (deal_Re_Loc.Status <> deal_Re_Loc.Status::Canceled)) THEN BEGIN

            deal_Re_Loc.Status := deal_Re_Loc.Status::"In order";

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::BR);
            IF element_Re_Loc.FINDFIRST THEN
                deal_Re_Loc.Status := deal_Re_Loc.Status::"In progress";


            isInvoiced_Bo_Loc := TRUE;

            FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    IF purchHeader_Re_Loc.GET(purchHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN
                        isInvoiced_Bo_Loc := FALSE;
                UNTIL (element_Re_Loc.NEXT() = 0);

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    IF salesHeader_Re_Loc.GET(salesHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN
                        isInvoiced_Bo_Loc := FALSE;
                UNTIL (element_Re_Loc.NEXT() = 0);

            IF isInvoiced_Bo_Loc THEN
                deal_Re_Loc.Status := deal_Re_Loc.Status::Invoiced;

            deal_Re_Loc.MODIFY();

        END

    end;


    procedure FNC_UpdatePurchaserCode(Deal_ID_Co_Par: Code[20])
    var
        element_Re_Loc: Record "DEL Element";
        purchaseHeader_Re_Loc: Record "Purchase Header";
        deal_Re_Loc: Record "DEL Deal";
    begin
        FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
        IF element_Re_Loc.FINDFIRST THEN BEGIN
            IF purchaseHeader_Re_Loc.GET(
              purchaseHeader_Re_Loc."Document Type"::Order, element_Re_Loc."Type No.") THEN BEGIN
                IF deal_Re_Loc.GET(Deal_ID_Co_Par) THEN BEGIN
                    deal_Re_Loc.VALIDATE("Purchaser Code", purchaseHeader_Re_Loc."Purchaser Code");
                    deal_Re_Loc.MODIFY();
                END
            END
        END
    end;


    procedure FNC_Set_LastUpdate_DateTime(Deal_ID_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "DEL Deal";
    begin
        FNC_Set_Deal(deal_Re_Loc, Deal_ID_Co_Par);
        deal_Re_Loc."Last Update" := CURRENTDATETIME;
        deal_Re_Loc.MODIFY();
    end;

    procedure FNC_UpdatePeriod(Deal_ID_Co_Par: Code[20])
    var
        deal_Re_Loc: Record "DEL Deal";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
        element_Re_Loc: Record "DEL Element";
        period_Da_Loc: Date;
    begin

        FNC_Set_Deal(deal_Re_Loc, Deal_ID_Co_Par);

        IF ((deal_Re_Loc.Status <> deal_Re_Loc.Status::Closed) AND (deal_Re_Loc.Status <> deal_Re_Loc.Status::Canceled)) THEN BEGIN

            dealShipment_Re_Loc.RESET();
            dealShipment_Re_Loc.SETCURRENTKEY(Deal_ID);
            dealShipment_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            IF dealShipment_Re_Loc.FINDFIRST THEN BEGIN
                REPEAT
                    period_Da_Loc := DealShipment_Cu.FNC_GetSalesInvoicePeriod(dealShipment_Re_Loc.ID);

                    IF period_Da_Loc <> 0D THEN BEGIN

                        dsc_Re_Loc.RESET();
                        dsc_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                        dsc_Re_Loc.SETRANGE(Shipment_ID, dealShipment_Re_Loc.ID);
                        IF dsc_Re_Loc.FINDFIRST THEN BEGIN
                            REPEAT
                                IF element_Re_Loc.GET(dsc_Re_Loc.Element_ID) THEN BEGIN

                                    IF element_Re_Loc.Period <> period_Da_Loc THEN BEGIN
                                        element_Re_Loc.Period := period_Da_Loc;
                                        element_Re_Loc.MODIFY();
                                    END;

                                END;

                            UNTIL (dsc_Re_Loc.NEXT() = 0);
                        END;

                    END;

                UNTIL (dealShipment_Re_Loc.NEXT() = 0);
            END;

        END

    end;


    procedure FNC_Attach_ACO(Deal_ID_Co_Par: Code[20]; ACO_ID_Co_Par: Code[20])
    var
        ACO_Connection_Re_Loc: Record "DEL ACO Connection";
        PurchaseHeader: Record "Purchase Header";
    begin
        ACO_Connection_Re_Loc.INIT();
        ACO_Connection_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
        ACO_Connection_Re_Loc.VALIDATE("ACO No.", ACO_ID_Co_Par);
        IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, ACO_ID_Co_Par) THEN
            ACO_Connection_Re_Loc."Vendor No." := PurchaseHeader."Buy-from Vendor No.";
        IF NOT ACO_Connection_Re_Loc.INSERT() THEN
            ERROR(ERROR_TXT, 'Co 50020', 'FNC_Attach_ACO', 'Insert() impossible dans la table ''ACO Connection''');

    end;


    procedure FNC_Get_ACO_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        dealItem_Re_Loc: Record "DEL Deal Item";
        position_Re_Loc: Record "DEL Position";
        BRNo_Co_Ret: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN
            FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            IF element_Re_Loc.FINDFIRST THEN
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

        END ELSE BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::ACO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::dispatched);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    IF dsc_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, element_Re_Loc.ID) THEN
                        Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

        END;

    end;

    procedure FNC_Get_VCO_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        dealItem_Re_Loc: Record "DEL Deal Item";
        position_Re_Loc: Record "DEL Position";
        BRNo_Co_Ret: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0)

        END ELSE BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::dispatched);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    IF dsc_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, element_Re_Loc.ID) THEN
                        Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);
        END;

    end;


    procedure FNC_Get_Fee_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

        END ELSE BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::dispatched);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    IF dsc_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, element_Re_Loc.ID) THEN
                        Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

        END

    end;


    procedure FNC_Get_PurchInvoice_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "DEL Element";
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purchase Invoice");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0)

        END ELSE BEGIN

            element_ID_Co_Loc := DealShipment_Cu.FNC_GetPurchInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;


    procedure FNC_Get_PurchCrMemo_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "DEL Element";
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Purch. Cr. Memo");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0)

        END ELSE BEGIN

            element_ID_Co_Loc := DealShipment_Cu.FNC_GetPurchCrMemoElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;


    procedure FNC_Get_SalesInvoice_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "DEL Element";
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Invoice");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0);

        END ELSE BEGIN

            element_ID_Co_Loc := DealShipment_Cu.FNC_GetSalesInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;


    procedure FNC_Get_SalesCrMemo_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        element_ID_Co_Loc: Code[20];
        targetElement_Re_Loc: Record "DEL Element";
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::"Sales Cr. Memo");
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);
                UNTIL (element_Re_Loc.NEXT() = 0);

        END ELSE BEGIN

            element_ID_Co_Loc := DealShipment_Cu.FNC_GetSalesCrMemoElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;


    procedure FNC_Get_Invoice_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        dealShipCon_Re_Loc: Record "DEL Deal Shipment Connection";
        position_Re_Loc: Record "DEL Position";
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Invoice);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    Amount_Dec_Ret += Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                UNTIL (element_Re_Loc.NEXT() = 0);

        END ELSE BEGIN

            dealShipmentConnection_Re_Loc.RESET();
            dealShipmentConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipment_No_Co_Par);
            IF dealShipmentConnection_Re_Loc.FINDFIRST THEN
                REPEAT

                    Element_Cu.FNC_Set_Element(element_Re_Loc, dealShipmentConnection_Re_Loc.Element_ID);

                    IF element_Re_Loc.Type = element_Re_Loc.Type::Invoice THEN BEGIN

                        IF element_Re_Loc."Splitt Index" = 0 THEN BEGIN

                            elementConnection_Re_Loc.RESET();
                            elementConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                            elementConnection_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                            IF elementConnection_Re_Loc.FINDFIRST THEN
                                REPEAT
                                    IF dealShipCon_Re_Loc.GET(Deal_ID_Co_Par, DealShipment_No_Co_Par, elementConnection_Re_Loc."Apply To") THEN BEGIN

                                        position_Re_Loc.RESET();
                                        position_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
                                        position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                                        position_Re_Loc.SETRANGE("Sub Element_ID", elementConnection_Re_Loc."Apply To");
                                        IF position_Re_Loc.FINDFIRST THEN
                                            REPEAT
                                                Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                                            UNTIL (position_Re_Loc.NEXT() = 0);

                                    END
                                UNTIL (elementConnection_Re_Loc.NEXT() = 0);
                        END ELSE BEGIN

                            position_Re_Loc.RESET();
                            position_Re_Loc.SETRANGE(Element_ID, element_Re_Loc.ID);
                            IF position_Re_Loc.FINDFIRST THEN
                                REPEAT
                                    Amount_Dec_Ret += Position_Cu.FNC_Get_Amount(position_Re_Loc.ID)
                                UNTIL (position_Re_Loc.NEXT() = 0);

                        END;

                    END;

                UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);

        END;
    end;


    procedure FNC_Get_ProSales_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        targetElement_Re_Loc: Record "DEL Element";
        element_ID_Co_Loc: Code[20];
        planned_Amount_Dec_Loc: Decimal;
        real_Amount_Dec_Loc: Decimal;
        BRNo_Co_Ret: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
    begin
        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::VCO);
            element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    planned_Amount_Dec_Loc := 0;
                    real_Amount_Dec_Loc := 0;

                    planned_Amount_Dec_Loc := Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE("Apply To", element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN
                        REPEAT
                            Element_Cu.FNC_Set_Element(targetElement_Re_Loc, elementConnection_Re_Loc.Element_ID);
                            IF (
                              (targetElement_Re_Loc.Type = targetElement_Re_Loc.Type::"Sales Invoice")
                              OR
                              (targetElement_Re_Loc.Type = targetElement_Re_Loc.Type::"Sales Cr. Memo")
                              ) THEN
                                real_Amount_Dec_Loc += Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
                        UNTIL (elementConnection_Re_Loc.NEXT() = 0);

                    IF real_Amount_Dec_Loc <> 0 THEN
                        Amount_Dec_Ret += real_Amount_Dec_Loc
                    ELSE
                        Amount_Dec_Ret += planned_Amount_Dec_Loc;

                UNTIL (element_Re_Loc.NEXT() = 0)

        END ELSE BEGIN

            BRNo_Co_Ret := DealShipment_Cu.FNC_GetBRNo(DealShipment_No_Co_Par);

            purchRcptLine_Re_Loc.RESET();
            purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Ret);
            purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
            purchRcptLine_Re_Loc.SETFILTER(Quantity, '>0');
            IF purchRcptLine_Re_Loc.FINDFIRST THEN
                REPEAT
                    qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                    amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Price(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(Deal_ID_Co_Par, curr_Co_Loc, 'EUR');
                    Amount_Dec_Ret += qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

            element_ID_Co_Loc := DealShipment_Cu.FNC_GetSalesInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;


    procedure FNC_Get_ProPurch_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        elementConnection_Re_Loc: Record "DEL Element Connection";
        targetElement_Re_Loc: Record "DEL Element";
        element_ID_Co_Loc: Code[20];
        planned_Amount_Dec_Loc: Decimal;
        real_Amount_Dec_Loc: Decimal;
        BRNo_Co_Loc: Code[20];
        qty_Dec_Loc: Decimal;
        curr_Co_Loc: Code[10];
        rate_Dec_Loc: Decimal;
        amount_Dec_Loc: Decimal;
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
    begin
        Amount_Dec_Ret := 0;
        IF DealShipment_No_Co_Par = '' THEN BEGIN


            FNC_Get_ACO(element_Re_Loc, Deal_ID_Co_Par);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT

                    planned_Amount_Dec_Loc := 0;
                    real_Amount_Dec_Loc := 0;

                    planned_Amount_Dec_Loc := Element_Cu.FNC_Get_Amount_From_Positions(element_Re_Loc.ID);

                    elementConnection_Re_Loc.RESET();
                    elementConnection_Re_Loc.SETRANGE(Deal_ID, element_Re_Loc.Deal_ID);
                    elementConnection_Re_Loc.SETRANGE("Apply To", element_Re_Loc.ID);
                    IF elementConnection_Re_Loc.FINDFIRST THEN
                        REPEAT
                            Element_Cu.FNC_Set_Element(targetElement_Re_Loc, elementConnection_Re_Loc.Element_ID);
                            IF targetElement_Re_Loc.Type = targetElement_Re_Loc.Type::"Purchase Invoice" THEN
                                real_Amount_Dec_Loc += Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
                        UNTIL (elementConnection_Re_Loc.NEXT() = 0);

                    IF real_Amount_Dec_Loc <> 0 THEN
                        Amount_Dec_Ret += real_Amount_Dec_Loc
                    ELSE
                        Amount_Dec_Ret += planned_Amount_Dec_Loc;

                UNTIL (element_Re_Loc.NEXT() = 0)

        END ELSE BEGIN

            BRNo_Co_Loc := DealShipment_Cu.FNC_GetBRNo(DealShipment_No_Co_Par);

            purchRcptLine_Re_Loc.RESET();
            purchRcptLine_Re_Loc.SETRANGE("Document No.", BRNo_Co_Loc);
            purchRcptLine_Re_Loc.SETRANGE(Type, purchRcptLine_Re_Loc.Type::Item);
            purchRcptLine_Re_Loc.SETFILTER(Quantity, '>%1', 0);
            IF purchRcptLine_Re_Loc.FINDFIRST THEN
                REPEAT
                    qty_Dec_Loc := purchRcptLine_Re_Loc.Quantity;
                    amount_Dec_Loc := DealItem_Cu.FNC_Get_Unit_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    curr_Co_Loc := DealItem_Cu.FNC_Get_Currency_Cost(Deal_ID_Co_Par, purchRcptLine_Re_Loc."No.");
                    rate_Dec_Loc := Currency_Exchange_Re.FNC_Get_Rate(Deal_ID_Co_Par, curr_Co_Loc, 'EUR');
                    Amount_Dec_Ret -= qty_Dec_Loc * amount_Dec_Loc * rate_Dec_Loc;
                UNTIL (purchRcptLine_Re_Loc.NEXT() = 0);

            element_ID_Co_Loc := DealShipment_Cu.FNC_GetPurchInvoiceElementID(DealShipment_No_Co_Par);
            IF element_ID_Co_Loc <> '' THEN BEGIN
                Element_Cu.FNC_Set_Element(targetElement_Re_Loc, element_ID_Co_Loc);
                Amount_Dec_Ret := Element_Cu.FNC_Get_Amount_From_Positions(targetElement_Re_Loc.ID);
            END;

        END;
    end;


    procedure FNC_Get_ProLog_Amount(Deal_ID_Co_Par: Code[20]; DealShipment_No_Co_Par: Code[20]) Amount_Dec_Ret: Decimal
    var
        element_Re_Loc: Record "DEL Element";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        invoiceElement_Re_Loc: Record "DEL Element";
        planned_Amount_Dec_Loc: Decimal;
        real_Amount_Dec_Loc: Decimal;
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        BR_Header_Re_Loc: Record "Purch. Rcpt. Header";
        purchRcptLine_Re_Loc: Record "Purch. Rcpt. Line";
        position_Re_Loc: Record "DEL Position";
        BRNo_Co_Loc: Code[20];
    begin

        Amount_Dec_Ret := 0;

        IF DealShipment_No_Co_Par = '' THEN BEGIN

            element_Re_Loc.RESET();
            element_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
            element_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            element_Re_Loc.SETFILTER(Type, '%1|%2', element_Re_Loc.Type::Invoice, element_Re_Loc.Type::Provision);
            IF element_Re_Loc.FINDFIRST THEN
                REPEAT
                    element_Re_Loc.CALCFIELDS("Amount(EUR)");

                    IF element_Re_Loc."Amount(EUR)" < 0 THEN
                        Amount_Dec_Ret += element_Re_Loc."Amount(EUR)";

                UNTIL (element_Re_Loc.NEXT() = 0)

        END ELSE BEGIN

            dealShipmentConnection_Re_Loc.RESET();
            dealShipmentConnection_Re_Loc.SETRANGE(Deal_ID, Deal_ID_Co_Par);
            dealShipmentConnection_Re_Loc.SETRANGE(Shipment_ID, DealShipment_No_Co_Par);
            IF dealShipmentConnection_Re_Loc.FINDFIRST THEN
                REPEAT

                    Element_Cu.FNC_Set_Element(element_Re_Loc, dealShipmentConnection_Re_Loc.Element_ID);
                    IF ((element_Re_Loc.Type = element_Re_Loc.Type::Invoice) OR (element_Re_Loc.Type = element_Re_Loc.Type::Provision)) THEN BEGIN

                        element_Re_Loc.CALCFIELDS("Amount(EUR)");

                        IF element_Re_Loc."Amount(EUR)" < 0 THEN
                            Amount_Dec_Ret += element_Re_Loc."Amount(EUR)";

                    END;

                UNTIL (dealShipmentConnection_Re_Loc.NEXT() = 0);

        END;


    end;

    procedure FNC_GetMonthFirstWorkDay(date_Par: Date) date: Date
    begin
        date := CALCDATE('<-CM>', date_Par);

        IF ((FORMAT(date, 0, '<Weekday>') = '6') OR (FORMAT(date, 0, '<Weekday>') = '7')) THEN
            REPEAT
                date := CALCDATE('<+1D>', date);

            UNTIL (FORMAT(date, 0, '<Weekday>') = '1');

        EXIT(date);

    end;


    procedure FNC_GetMonthLastWorkDay(date_Par: Date) date: Date
    begin
        date := CALCDATE('<CM>', date_Par);

        IF ((FORMAT(date, 0, '<Weekday>') = '6') OR (FORMAT(date, 0, '<Weekday>') = '7')) THEN
            REPEAT
                date := CALCDATE('<-1D>', date);

            UNTIL (FORMAT(date, 0, '<Weekday>') = '5');

        EXIT(date);

    end;
}

