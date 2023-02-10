report 50014 "DEL Create Provision"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Deal"; "DEL Deal")
        {
            DataItemTableView = sorting(ID)
                                ORDER(Ascending)
                                where(Status = filter("In progress" | Invoiced));
            dataitem("DEL Deal Shipment"; "DEL Deal Shipment")
            {
                DataItemLink = Deal_ID = field(ID);
                DataItemTableView = sorting(ID);
                dataitem("DEL Element"; "DEL Element")
                {
                    DataItemLink = Deal_ID = field(Deal_ID);
                    DataItemTableView = sorting(Deal_ID, Type)
                                        ORDER(Ascending)
                                        where(Type = const(Fee),
                                              Instance = const(planned));

                    trigger OnAfterGetRecord()
                    var
                        currExRate_Re_loc: Record "Currency Exchange Rate";
                        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
                        element_Re_Loc: Record "DEL Element";
                        rate_Dec_Loc: Decimal;
                    begin
                        IF NOT skip THEN BEGIN

                            IF "DEL Element".Deal_ID <> lastDealID THEN BEGIN
                                lastDealID := "DEL Element".Deal_ID;
                                isColored := NOT isColored;
                            END;

                            sps_Re.RESET();
                            sps_Re.INIT();

                            sps_Re.VALIDATE(Deal_ID, "DEL Deal".ID);
                            sps_Re.VALIDATE(Deal_Shipment_ID, "DEL Deal Shipment".ID);
                            sps_Re.VALIDATE(Fee_Connection_ID, "DEL Element".Fee_Connection_ID);
                            rate_Dec_Loc := 1 / currExRate_Re_loc.ExchangeRate("DEL Deal".Date, Element_Cu.FNC_Get_Currency("DEL Element".ID));
                            sps_Re.VALIDATE("Planned Amount",
                              ROUND(Fee_Cu.FNC_Get_Amount_From_Pos("DEL Element".ID, "DEL Deal Shipment".ID, TRUE) * -1 * rate_Dec_Loc, 0.01));

                            sps_Re.VALIDATE("Real Amount", ROUND(FNC_RealAmountForPlannedFee("DEL Element") * -1, 0.01));

                            sps_Re.Period := CALCDATE('<-CM>', salesInvoiceElement_Re.Date);
                            element_Re_Loc.RESET();
                            element_Re_Loc.SETRANGE(Deal_ID, "DEL Element".Deal_ID);
                            element_Re_Loc.SETRANGE(Type, "DEL Element".Type::Provision);
                            element_Re_Loc.SETRANGE(Period, CALCDATE('<-CM>', date_DA));
                            element_Re_Loc.SETRANGE(Fee_ID, "DEL Element".Fee_ID);
                            element_Re_Loc.SETRANGE(Fee_Connection_ID, "DEL Element".Fee_Connection_ID);
                            IF element_Re_Loc.FINDFIRST() THEN
                                REPEAT

                                    //si la provision fait partie de la livraison en cours
                                    IF dsc_Re_Loc.GET(element_Re_Loc.Deal_ID, "DEL Deal Shipment".ID, element_Re_Loc.ID) THEN BEGIN

                                        //on diminue le montant proposé du montant déjà provisionné
                                        element_Re_Loc.CALCFIELDS(element_Re_Loc.Amount);

                                        //on prend les provisions dont le montant est négatif
                                        IF element_Re_Loc.Amount < 0 THEN
                                            sps_Re."Provision Amount" += ROUND(element_Re_Loc.Amount, 0.01);
                                        //MESSAGE('%1', element_Re_Loc.Amount)

                                    END;

                                UNTIL (element_Re_Loc.NEXT() = 0);

                            //si le montant de la provision est plus petit que zéro, alors on affiche zéro
                            IF sps_Re."Provision Amount" < 0 THEN
                                sps_Re."Provision Amount" := 0;

                            sps_Re."BR No." := "DEL Deal Shipment"."BR No.";
                            sps_Re."Purchase Invoice No." := "DEL Deal Shipment"."Purchase Invoice No.";

                            sps_Re.USER_ID := USERID;
                            sps_Re.IsColored := isColored; //true->la ligne sera en couleur

                            IF NOT sps_Re.INSERT() THEN
                                ERROR('Problème à l''insertion dans la table ''Shipment Provision Selection''!');



                        END
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    salesInvoice_Co_Loc: Code[20];
                    maDate: Date;
                begin
                    skip := FALSE;
                    salesInvoice_Co_Loc := '';

                    salesInvoice_Co_Loc := DealShipment_Cu.FNC_GetSalesInvoiceElementID("DEL Deal Shipment".ID);

                    IF salesInvoice_Co_Loc <> '' THEN BEGIN

                        Element_Cu.FNC_Set_Element(salesInvoiceElement_Re, salesInvoice_Co_Loc);

                        IF currentPeriod_Bo THEN BEGIN

                            IF Element_Cu.FNC_Get_Period(salesInvoice_Co_Loc) <> (FORMAT(date_DA, 0, '<Month>') + FORMAT(date_DA, 0, '<Year4>')) THEN
                                skip := TRUE;

                        END ELSE BEGIN

                            maDate := CALCDATE('<-CM>', date_DA);

                            IF salesInvoiceElement_Re.Period >= maDate THEN
                                skip := TRUE;


                        END

                    END ELSE
                        skip := TRUE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                FNC_ProgressBar_Update(1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(date_Da; date_DA)
                {
                    Caption = 'Date';
                }
                field(DATEDA; Format(date_DA, 0, '<Month Text>'))
                {
                    Caption = 'Mois';
                }
                field(DATEDAA; DATE2DMY(date_DA, 3))
                {
                    Caption = 'Année';
                }
                field(currentPeriod_Bo; currentPeriod_Bo)
                {
                    Caption = 'Periode en cours';
                }
            }
        }


    }

    trigger OnInitReport()
    begin
        date_DA := TODAY;

        monthLastWorkingDay := Deal_Cu.FNC_GetMonthLastWorkDay(date_DA);
        monthFirstWorkingDay := Deal_Cu.FNC_GetMonthFirstWorkDay(CALCDATE('<+1M>', date_DA));

        currentPeriod_Bo := true;
    end;

    trigger OnPostReport()
    var

        spsp_Re_Loc: Record "DEL Ship. Prov. Sele. Params";
    begin
        FNC_ProgressBar_Close(1);
        spsp_Re_Loc.FNC_Define(date_DA, currentPeriod_Bo);
    end;

    trigger OnPreReport()
    var
        deal_Re_Loc: Record "DEL Deal";
    begin
        deal_Re_Loc.Reset();
        deal_Re_Loc.SetRange(deal_Re_Loc.Status, deal_Re_Loc.Status::Invoiced);

        FNC_ProgressBar_Init(1, 1000, 500, 'Calcul des provisions en cours...', deal_Re_Loc.Count());

        sps_Re.Reset();
        sps_Re.SetFilter(USER_ID, UserId());
        sps_Re.DeleteAll();

        lastDealID := '';
        isColored := true;
        Skip := false;
    end;


    var
        salesInvoiceElement_Re: Record "DEL Element";
        sps_Re: Record "DEL Shipment Provision Select.";
        Deal_Cu: Codeunit "DEL Deal";
        DealShipment_Cu: Codeunit "DEL Deal Shipment";
        Element_Cu: Codeunit "DEL Element";
        Fee_Cu: Codeunit "DEL Fee";
        currentPeriod_Bo: Boolean;
        isColored: Boolean;
        Skip: Boolean;
        lastDealID: Code[20];
        date_DA: Date;
        monthFirstWorkingDay: Date;
        monthLastWorkingDay: Date;
        diaProgress: array[10] of Dialog;
        interval: array[10] of Integer;
        intNextProgressStep: array[10] of Integer;
        intProgress: array[10] of Integer;
        intProgressI: array[10] of Integer;
        intProgressStep: array[10] of Integer;
        intProgressTotal: array[10] of Integer;
        timProgress: array[10] of Time;

    procedure FNC_RealAmountForPlannedFee(plannedElement_Re_Par: Record "DEL Element") amount_Dec_Ret: Decimal
    var
        currExRate_Re_loc: Record "Currency Exchange Rate";
        dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
        realElement_Re_Loc: Record "DEL Element";
        position_Re_Loc: Record "DEL Position";
        rate_Dec_Loc: Decimal;
    begin
        //calcule le montant de frais réel pour un frais prévu

        //on cherche les éléments réalisés pour un élément prévu
        realElement_Re_Loc.Reset();
        realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        realElement_Re_Loc.SetRange(Deal_ID, "DEL Deal".ID);
        realElement_Re_Loc.SetRange(Type, realElement_Re_Loc.Type::Invoice); //CHG-DEV-PROVISION filter sur invoice|provision
        realElement_Re_Loc.SetRange(Fee_ID, plannedElement_Re_Par.Fee_ID);
        realElement_Re_Loc.SetRange(Fee_Connection_ID, plannedElement_Re_Par.Fee_Connection_ID);
        //on boucle sur tous les elements de type Fee
        if realElement_Re_Loc.FindSet() then
            repeat

                //filtre sur les positions avec element id correspondant
                position_Re_Loc.Reset();
                position_Re_Loc.SetRange(Deal_ID, "DEL Deal".ID);
                position_Re_Loc.SetRange(Element_ID, realElement_Re_Loc.ID);
                if position_Re_Loc.FindSET() then
                    repeat

                        if dealShipmentConnection_Re_Loc.Get("DEL Deal".ID, "DEL Deal Shipment".ID, position_Re_Loc."Sub Element_ID") then
                            if position_Re_Loc.Currency = '' then
                                amount_Dec_Ret += position_Re_Loc."Line Amount"

                            else begin
                                rate_Dec_Loc := 1 / currExRate_Re_loc.ExchangeRate(realElement_Re_Loc.Date, position_Re_Loc.Currency);
                                amount_Dec_Ret += position_Re_Loc."Line Amount" * rate_Dec_Loc;
                            end;


                    until (position_Re_Loc.Next() = 0);

            until (realElement_Re_Loc.Next() = 0);
    end;


    procedure FNC_ProgressBar_Init(index_Int_Par: Integer; interval_Int_Par: Integer; stepProgress_Int_Par: Integer; text_Te_Par: Text[50]; total_Int_Par: Integer)
    begin

        intProgress[index_Int_Par] := 0;
        interval[index_Int_Par] := interval_Int_Par;
        intProgressStep[index_Int_Par] := stepProgress_Int_Par;
        intNextProgressStep[index_Int_Par] := intProgressStep[index_Int_Par];
        intProgressI[index_Int_Par] := 0;
        diaProgress[index_Int_Par].OPEN(
          text_Te_Par + '\@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\', intProgress[index_Int_Par]);
        intProgressTotal[index_Int_Par] := total_Int_Par;
        timProgress[index_Int_Par] := Time;

    end;


    procedure FNC_ProgressBar_Update(index_Int_Par: Integer)
    begin
        intProgressI[index_Int_Par] += 1;

        if timProgress[index_Int_Par] < Time - interval[index_Int_Par] then begin

            intProgress[index_Int_Par] := Round(intProgressI[index_Int_Par] / intProgressTotal[index_Int_Par] * 10000, 1);

            if intProgress[index_Int_Par] > intNextProgressStep[index_Int_Par] then begin

                intNextProgressStep[index_Int_Par] += intProgressStep[index_Int_Par];

                timProgress[index_Int_Par] := Time;

                diaProgress[index_Int_Par].Update();

            end;

        end;
    end;


    procedure FNC_ProgressBar_Close(index_Int_Par: Integer)
    begin
        diaProgress[index_Int_Par].Close();
    end;


}