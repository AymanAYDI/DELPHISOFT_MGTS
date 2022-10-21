codeunit 50028 "DEL Alert and fee copy Mgt"
{





    var
        LogisticTmp_Re: Record "DEL Logistic" temporary;


    procedure FNC_GlobalCheck(Deal_ID: Code[20])
    var
        DealShip2_Re_Loc: Record "DEL Deal Shipment";
        DealShip_Re_Loc: Record "DEL Deal Shipment";
        Logistic_Re_Loc: Record "DEL Logistic";
    begin


        Logistic_Re_Loc.SETRANGE(Deal_ID, Deal_ID);
        IF Logistic_Re_Loc.FINDFIRST() THEN
            REPEAT
                LogisticTmp_Re.TRANSFERFIELDS(Logistic_Re_Loc);
                IF NOT LogisticTmp_Re.INSERT()
                  THEN
                    LogisticTmp_Re.MODIFY();
            UNTIL Logistic_Re_Loc.NEXT() = 0;

        DealShip_Re_Loc.SETFILTER(Deal_ID, Deal_ID);
        IF DealShip_Re_Loc.FINDFIRST() THEN
            REPEAT
                IF DealShip2_Re_Loc.GET(DealShip_Re_Loc.ID) THEN BEGIN
                    LogisticTmp_Re.SETFILTER(ID, DealShip2_Re_Loc.ID);
                    IF LogisticTmp_Re.FINDFIRST() THEN
                        FNC_Alert1(DealShip2_Re_Loc);
                    FNC_Alert2(DealShip2_Re_Loc);
                    FNC_Alert3(DealShip2_Re_Loc);
                    FNC_Alert4(DealShip2_Re_Loc);
                    DealShip2_Re_Loc.MODIFY();

                END;
            UNTIL DealShip_Re_Loc.NEXT() = 0;
    end;


    procedure FNC_Alert1(var DealShip_Re_Par: Record "DEL Deal Shipment")
    begin

        IF (LogisticTmp_Re."PI approval date" <> 0D) AND (LogisticTmp_Re."PI approved by" <> '') THEN
            DealShip_Re_Par.PI := DealShip_Re_Par.PI::OK
        ELSE
            DealShip_Re_Par.PI := DealShip_Re_Par.PI::"En cours";




    end;


    procedure FNC_Alert2(var DealShip_Re_Par: Record "DEL Deal Shipment")
    begin

        IF LogisticTmp_Re."Customer Delivery date" <> 0D THEN
            DealShip_Re_Par."A facturer" := DealShip_Re_Par."A facturer"::"A Facturer"
        ELSE
            DealShip_Re_Par."A facturer" := DealShip_Re_Par."A facturer"::"En cours";

    end;


    procedure FNC_Alert3(var DealShip_Re_Par: Record "DEL Deal Shipment")
    begin

        IF LogisticTmp_Re."Revised ETD" <> 0D THEN BEGIN
            IF (LogisticTmp_Re."Actual departure date" = 0D) AND (LogisticTmp_Re."Revised ETD" <= TODAY) THEN
                DealShip_Re_Par."Depart shipment" := TRUE
            ELSE
                DealShip_Re_Par."Depart shipment" := FALSE;
        END ELSE
            DealShip_Re_Par."Depart shipment" := FALSE;
    end;


    procedure FNC_Alert4(var DealShip_Re_Par: Record "DEL Deal Shipment")
    begin

        IF LogisticTmp_Re."ETA date" <> 0D THEN BEGIN
            IF (LogisticTmp_Re."ETA date" <= TODAY) AND (LogisticTmp_Re."Actual Arrival date" = 0D) THEN
                DealShip_Re_Par."Arrival ship" := TRUE
            ELSE
                DealShip_Re_Par."Arrival ship" := FALSE;
        END ELSE
            DealShip_Re_Par."Arrival ship" := FALSE;
    end;


    procedure FNC_FeeCopy(Type_Op_Par: Option Customer,Vendor; No_Co_Par: Code[20]; OriNo_Co_Par: Code[20])
    var
        ConnectionFee_Re_Loc: Record "DEL Fee Connection";
        ConnectionFeeIns_Re_Loc: Record "DEL Fee Connection";
    begin

        IF No_Co_Par = OriNo_Co_Par THEN EXIT;

        ConnectionFee_Re_Loc.SETRANGE("No.", No_Co_Par);

        IF Type_Op_Par = Type_Op_Par::Customer THEN
            ConnectionFee_Re_Loc.SETRANGE(Type, ConnectionFee_Re_Loc.Type::Customer)
        ELSE
            ConnectionFee_Re_Loc.SETRANGE(Type, ConnectionFee_Re_Loc.Type::Vendor);

        IF ConnectionFee_Re_Loc.FINDFIRST() THEN
            REPEAT
                ConnectionFeeIns_Re_Loc.TRANSFERFIELDS(ConnectionFee_Re_Loc);
                ConnectionFeeIns_Re_Loc."No." := OriNo_Co_Par;
                CLEAR(ConnectionFeeIns_Re_Loc.ID);
                ConnectionFeeIns_Re_Loc.INSERT(TRUE);
            UNTIL ConnectionFee_Re_Loc.NEXT() = 0;
    end;


    procedure FNC_LogisticCopy(DealID_Co_Par: Code[20]; ID_Co_Par: Code[20])
    var
        DealShip_Re_loc: Record "DEL Deal Shipment";
        Logistic_Re_Loc: Record "DEL Logistic";
        LogisticINSERT_Re_Loc: Record "DEL Logistic";
    begin

        DealShip_Re_loc.SETRANGE(Deal_ID, DealID_Co_Par);
        IF DealShip_Re_loc.FINDFIRST() THEN
            IF Logistic_Re_Loc.GET(DealShip_Re_loc.ID, DealShip_Re_loc.Deal_ID) THEN BEGIN
                LogisticINSERT_Re_Loc.ID := ID_Co_Par;
                LogisticINSERT_Re_Loc.Deal_ID := DealID_Co_Par;
                LogisticINSERT_Re_Loc."Supplier Name" := Logistic_Re_Loc."Supplier Name";
                LogisticINSERT_Re_Loc."N° PI" := Logistic_Re_Loc."N° PI";
                LogisticINSERT_Re_Loc."Date PI" := Logistic_Re_Loc."Date PI";
                LogisticINSERT_Re_Loc."PI approved by" := Logistic_Re_Loc."PI approved by";
                LogisticINSERT_Re_Loc."PI approval date" := Logistic_Re_Loc."PI approval date";
                LogisticINSERT_Re_Loc."Payment Terms Code" := Logistic_Re_Loc."Payment Terms Code";
                LogisticINSERT_Re_Loc."LC expiry date" := Logistic_Re_Loc."LC expiry date";
                LogisticINSERT_Re_Loc."Forwarder Name" := Logistic_Re_Loc."Forwarder Name";
                LogisticINSERT_Re_Loc."C.Clearance Co.Name" := Logistic_Re_Loc."C.Clearance Co.Name";
                LogisticINSERT_Re_Loc.Applicable := Logistic_Re_Loc.Applicable;
                LogisticINSERT_Re_Loc."Company Name" := Logistic_Re_Loc."Company Name";
                LogisticINSERT_Re_Loc."Quality Company" := Logistic_Re_Loc."Quality Company";
                LogisticINSERT_Re_Loc."Shipment mode" := Logistic_Re_Loc."Shipment mode";
                LogisticINSERT_Re_Loc."Departure Port" := Logistic_Re_Loc."Departure Port";
                LogisticINSERT_Re_Loc."ETD Requested" := Logistic_Re_Loc."ETD Requested";

                LogisticINSERT_Re_Loc."ACO No." := Logistic_Re_Loc."ACO No.";

                LogisticINSERT_Re_Loc.INSERT();
            END;
    end;
}

