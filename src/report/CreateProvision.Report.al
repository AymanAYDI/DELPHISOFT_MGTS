report 50014 "DEL Create Provision"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("DEL Deal"; "DEL Deal")
        {
            DataItemTableView = SORTING(ID)
                                ORDER(Ascending)
                                WHERE(Status = FILTER("In progress" | Invoiced));
            dataitem("DEL Deal Shipment"; "DEL Deal Shipment")
            {
                DataItemLink = Deal_ID = FIELD(ID);
                DataItemTableView = SORTING(ID);
                dataitem("DEL Element"; "DEL Element")
                {
                    DataItemLink = Deal_ID = FIELD(Deal_ID);
                    DataItemTableView = SORTING(Deal_ID, Type)
                                        ORDER(Ascending)
                                        WHERE(Type = CONST(Fee),
                                              Instance = CONST(planned));

                    trigger OnAfterGetRecord()
                    var
                        currExRate_Re_loc: Record "Currency Exchange Rate";
                        rate_Dec_Loc: Decimal;
                        element_Re_Loc: Record "DEL Element";
                        dsc_Re_Loc: Record "DEL Deal Shipment Connection";
                    begin
                        IF NOT skip THEN BEGIN

                            IF Element.Deal_ID <> lastDealID THEN BEGIN
                                lastDealID := Element.Deal_ID;
                                isColored := NOT isColored;
                            END;

                            sps_Re.RESET();
                            sps_Re.INIT();

                            sps_Re.VALIDATE(Deal_ID, Deal.ID);
                            sps_Re.VALIDATE(Deal_Shipment_ID, "Deal Shipment".ID);
                            sps_Re.VALIDATE(Fee_Connection_ID, Element.Fee_Connection_ID);
                            rate_Dec_Loc := 1 / currExRate_Re_loc.ExchangeRate(Deal.Date, Element_Cu.FNC_Get_Currency(Element.ID));
                            sps_Re.VALIDATE("Planned Amount",
                              ROUND(Fee_Cu.FNC_Get_Amount_From_Pos(Element.ID, "Deal Shipment".ID, TRUE) * -1 * rate_Dec_Loc, 0.01));

                            sps_Re.VALIDATE("Real Amount", ROUND(FNC_RealAmountForPlannedFee(Element) * -1, 0.01));

                            sps_Re.Period := CALCDATE('<-CM>', salesInvoiceElement_Re.Date);
                            element_Re_Loc.RESET();
                            element_Re_Loc.SETRANGE(Deal_ID, Element.Deal_ID);
                            element_Re_Loc.SETRANGE("Customer/Vendor", Element.Type::Provision);
                            element_Re_Loc.SETRANGE(Period, CALCDATE('<-CM>', date_Da));
                            element_Re_Loc.SETRANGE(Fee_ID, Element.Fee_ID);
                            element_Re_Loc.SETRANGE(Fee_Connection_ID, Element.Fee_Connection_ID);
                            IF element_Re_Loc.FINDFIRST THEN
                                REPEAT

                                    IF dsc_Re_Loc.GET(element_Re_Loc.Deal_ID, "Deal Shipment".ID, element_Re_Loc.ID) THEN BEGIN

                                        element_Re_Loc.CALCFIELDS(element_Re_Loc.Amount);

                                        IF element_Re_Loc.Amount < 0 THEN
                                            sps_Re."Provision Amount" += ROUND(element_Re_Loc.Amount, 0.01);

                                    END;

                                UNTIL (element_Re_Loc.NEXT() = 0);

                            IF sps_Re."Provision Amount" < 0 THEN
                                sps_Re."Provision Amount" := 0;

                            sps_Re."BR No." := "Deal Shipment"."BR No.";
                            sps_Re."Purchase Invoice No." := "Deal Shipment"."Purchase Invoice No.";

                            sps_Re.USER_ID := USERID;
                            sps_Re.IsColored := isColored;

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

                    salesInvoice_Co_Loc := DealShipment_Cu.FNC_GetSalesInvoiceElementID("Deal Shipment".ID);

                    IF salesInvoice_Co_Loc <> '' THEN BEGIN

                        Element_Cu.FNC_Set_Element(salesInvoiceElement_Re, salesInvoice_Co_Loc);

                        IF currentPeriod_Bo THEN BEGIN

                            IF Element_Cu.FNC_Get_Period(salesInvoice_Co_Loc) <> (FORMAT(date_Da, 0, '<Month>') + FORMAT(date_Da, 0, '<Year4>')) THEN
                                skip := TRUE;

                        END ELSE BEGIN

                            maDate := CALCDATE('<-CM>', date_Da);

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
                field(date_Da; date_Da)
                {
                    Caption = 'Date';
                }
                field(FORMAT(date_Da,0,'<Month Text>');FORMAT(date_Da,0,'<Month Text>'))
                {
                    Caption = 'Mois';
                }
                field(DATE2DMY(date_Da,3);DATE2DMY(date_Da,3))
                {
                    Caption = 'Année';
                }
                field(currentPeriod_Bo; currentPeriod_Bo)
                {
                    Caption = 'Periode en cours';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        date_Da := TODAY;

        monthLastWorkingDay := Deal_Cu.FNC_GetMonthLastWorkDay(date_Da);

        monthFirstWorkingDay := Deal_Cu.FNC_GetMonthFirstWorkDay(CALCDATE('<+1M>', date_Da));

        currentPeriod_Bo := TRUE;
    end;

    trigger OnPostReport()
    var
        flowFields_Re_Loc: Record 50044;
        spsp_Re_Loc: Record 50045;
    begin
        FNC_ProgressBar_Close(1);

        spsp_Re_Loc.FNC_Define(date_Da, currentPeriod_Bo);
    end;

    trigger OnPreReport()
    var
        deal_Re_Loc: Record 50020;
    begin
        deal_Re_Loc.RESET();
        deal_Re_Loc.SETRANGE(deal_Re_Loc.Status, deal_Re_Loc.Status::Invoiced);

        FNC_ProgressBar_Init(1, 1000, 500, 'Calcul des provisions en cours...', deal_Re_Loc.COUNT());

        sps_Re.RESET();
        sps_Re.SETFILTER(USER_ID, USERID);
        sps_Re.DELETEALL();

        lastDealID := '';
        isColored := TRUE;
        skip := FALSE;
    end;

    var
        sps_Re: Record 50042;
        Element_Cu: Codeunit 50021;
        isColored: Boolean;
        lastDealID: Code[20];
        Fee_Cu: Codeunit 50023;
        PeriodMonth: Option Janvier,"Février",Mars,Avril,Mai,Juin,Juillet,Aout,Septembre,Octobre,Novembre,"Décembre";
        PeriodYear: Option;
        date_Da: Date;
        Deal_Cu: Codeunit 50020;
        monthFirstWorkingDay: Date;
        monthLastWorkingDay: Date;
        skip: Boolean;
        currentPeriod_Bo: Boolean;
        DealShipment_Cu: Codeunit 50029;
        salesInvoiceElement_Re: Record 50021 ;
        "v------PROGRESS BAR------v": Integer;
        intProgressI: array [10] of Integer;
        diaProgress: array [10] of Dialog;
        intProgress: array [10] of Integer;
        intProgressTotal: array [10] of Integer;
        intProgressStep: array [10] of Integer;
        intNextProgressStep: array [10] of Integer;
        timProgress: array [10] of Time;
        interval: array [10] of Integer;

    procedure FNC_RealAmountForPlannedFee(plannedElement_Re_Par: Record "50021") amount_Dec_Ret: Decimal
    var
        realElement_Re_Loc: Record 50021;
        position_Re_Loc: Record 50022;
        dealShipmentConnection_Re_Loc: Record 50032;
        rate_Dec_Loc: Decimal;
        currExRate_Re_loc: Record 330;
    begin
        realElement_Re_Loc.RESET();
        realElement_Re_Loc.SETCURRENTKEY(Deal_ID, Type);
        realElement_Re_Loc.SETRANGE(Deal_ID, Deal.ID);
        realElement_Re_Loc.SETRANGE(Type, realElement_Re_Loc.Type::Invoice); 
        realElement_Re_Loc.SETRANGE(Fee_ID, plannedElement_Re_Par.Fee_ID);
        realElement_Re_Loc.SETRANGE(Fee_Connection_ID, plannedElement_Re_Par.Fee_Connection_ID);
        IF realElement_Re_Loc.FINDFIRST THEN
          REPEAT

            //filtre sur les positions avec element id correspondant
            position_Re_Loc.RESET();
            position_Re_Loc.SETRANGE(Deal_ID, Deal.ID);
            position_Re_Loc.SETRANGE(Element_ID, realElement_Re_Loc.ID);
            IF position_Re_Loc.FINDFIRST THEN
              REPEAT

                IF dealShipmentConnection_Re_Loc.GET(Deal.ID, "Deal Shipment".ID, position_Re_Loc."Sub Element_ID") THEN BEGIN
                  //PLLogistic_Re_Temp."Real Element ID" := realElement_Re_Loc.ID;

                  //si la position est déjà en DS on la garde
                  IF position_Re_Loc.Currency = '' THEN
                    amount_Dec_Ret += position_Re_Loc."Line Amount"
                  //si elle est en devise étrangère, on la ramène à la DS
                  ELSE BEGIN
                    rate_Dec_Loc := 1 / currExRate_Re_loc.ExchangeRate(realElement_Re_Loc.Date, position_Re_Loc.Currency);
                    amount_Dec_Ret += position_Re_Loc."Line Amount" * rate_Dec_Loc;
                  END;
                END

              UNTIL(position_Re_Loc.NEXT() = 0);

          UNTIL(realElement_Re_Loc.NEXT()=0);
    end;

    procedure FNC_ProgressBar_Init(index_Int_Par: Integer;interval_Int_Par: Integer;stepProgress_Int_Par: Integer;text_Te_Par: Text[50];total_Int_Par: Integer)
    begin
        intProgress[index_Int_Par] := 0;
        interval[index_Int_Par] := interval_Int_Par; //en milisecondes
        intProgressStep[index_Int_Par] := stepProgress_Int_Par; //update si au moins 5% d'avancé (échelle : 10% = 1000)
        intNextProgressStep[index_Int_Par] := intProgressStep[index_Int_Par];
        intProgressI[index_Int_Par] := 0;
        diaProgress[index_Int_Par].OPEN(
          text_Te_Par + '\@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\', intProgress[index_Int_Par]);
        intProgressTotal[index_Int_Par] := total_Int_Par;
        timProgress[index_Int_Par] := TIME;

    end;

    procedure FNC_ProgressBar_Update(index_Int_Par: Integer)
    begin
        intProgressI[index_Int_Par] += 1;

        //toutes les x milisecondes (paramètre interval)
        IF timProgress[index_Int_Par] < TIME - interval[index_Int_Par] THEN BEGIN

          //calcul le pourcentage d'avancement
          intProgress[index_Int_Par] := ROUND(intProgressI[index_Int_Par] / intProgressTotal[index_Int_Par] * 10000, 1);

          //si le pourcentage d'avancement a avancé de x pourcent (paramètre intProgressStep)
          IF intProgress[index_Int_Par] > intNextProgressStep[index_Int_Par] THEN BEGIN

            //définition du prochain niveau de progression
            intNextProgressStep[index_Int_Par] += intProgressStep[index_Int_Par];

            //mise à jour du temps
            timProgress[index_Int_Par] := TIME;

            //mise à jour de la barre
            diaProgress[index_Int_Par].UPDATE;

          END;

        END;
    end;
    procedure FNC_ProgressBar_Close(index_Int_Par: Integer)
    begin
        diaProgress[index_Int_Par].CLOSE;
    end;
}

