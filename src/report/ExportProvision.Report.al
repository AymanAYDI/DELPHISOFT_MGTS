report 50015 "DEL Export Provision"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ExportProvision.rdlc';

    dataset
    {
        dataitem("DEL Shipment Provision Select."; "DEL Shipment Provision Select.")
        {
            DataItemTableView = SORTING(Deal_ID, Deal_Shipment_ID, Fee_ID, USER_ID)
                                ORDER(Ascending)
                                WHERE("Provision Amount" = FILTER(> 0));
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column("USERID"; USERID)
            {
            }
            column(period_Te; period_Te)
            {
            }
            column(FeeDescriptionArray_1_; FeeDescriptionArray[1])
            {
            }
            column(FeeTotalArray_1_; FeeTotalArray[1])
            {
            }
            column(FeeDescriptionArray_2_; FeeDescriptionArray[2])
            {
            }
            column(FeeDescriptionArray_3_; FeeDescriptionArray[3])
            {
            }
            column(FeeDescriptionArray_4_; FeeDescriptionArray[4])
            {
            }
            column(FeeDescriptionArray_5_; FeeDescriptionArray[5])
            {
            }
            column(FeeTotalArray_2_; FeeTotalArray[2])
            {
            }
            column(FeeTotalArray_3_; FeeTotalArray[3])
            {
            }
            column(FeeTotalArray_4_; FeeTotalArray[4])
            {
            }
            column(FeeTotalArray_5_; FeeTotalArray[5])
            {
            }
            column(FeeDescriptionArray_10_; FeeDescriptionArray[10])
            {
            }
            column(FeeDescriptionArray_9_; FeeDescriptionArray[9])
            {
            }
            column(FeeDescriptionArray_8_; FeeDescriptionArray[8])
            {
            }
            column(FeeDescriptionArray_7_; FeeDescriptionArray[7])
            {
            }
            column(FeeDescriptionArray_6_; FeeDescriptionArray[6])
            {
            }
            column(FeeTotalArray_10_; FeeTotalArray[10])
            {
            }
            column(FeeTotalArray_9_; FeeTotalArray[9])
            {
            }
            column(FeeTotalArray_8_; FeeTotalArray[8])
            {
            }
            column(FeeTotalArray_7_; FeeTotalArray[7])
            {
            }
            column(FeeTotalArray_6_; FeeTotalArray[6])
            {
            }
            column(FeeDescriptionArray_11_; FeeDescriptionArray[11])
            {
            }
            column(FeeTotalArray_11_; FeeTotalArray[11])
            {
            }
            column(Shipment_Provision_Selection_Deal_ID; Deal_ID)
            {
            }
            column(Shipment_Provision_Selection_Deal_ID_Control1000000011; Deal_ID)
            {
            }
            column(Shipment_Provision_Selection_Deal_Shipment_ID; Deal_Shipment_ID)
            {
            }
            column(Shipment_Provision_Selection_Fee_ID; Fee_ID)
            {
            }
            column(Shipment_Provision_Selection__Fee_Description_; "Fee Description")
            {
            }
            column(Shipment_Provision_Selection__Planned_Amount_; "Planned Amount")
            {
            }
            column(Shipment_Provision_Selection__Real_Amount_; "Real Amount")
            {
            }
            column(Shipment_Provision_Selection_Delta; Delta)
            {
            }
            column(Shipment_Provision_Selection__Provision_Amount_; "Provision Amount")
            {
            }
            column(Shipment_Provision_Selection_Period; Period)
            {
            }
            column(Shipment_Provision_SelectionCaption; Shipment_Provision_SelectionCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Period__Caption; Period__CaptionLbl)
            {
            }
            column(Shipment_Provision_Selection_Deal_ID_Control1000000011Caption; FIELDCAPTION(Deal_ID))
            {
            }
            column(Shipment_Provision_Selection_Deal_Shipment_IDCaption; FIELDCAPTION(Deal_Shipment_ID))
            {
            }
            column(Shipment_Provision_Selection_Fee_IDCaption; FIELDCAPTION(Fee_ID))
            {
            }
            column(Shipment_Provision_Selection__Fee_Description_Caption; FIELDCAPTION("Fee Description"))
            {
            }
            column(Shipment_Provision_Selection__Planned_Amount_Caption; FIELDCAPTION("Planned Amount"))
            {
            }
            column(Shipment_Provision_Selection__Real_Amount_Caption; FIELDCAPTION("Real Amount"))
            {
            }
            column(Shipment_Provision_Selection_DeltaCaption; FIELDCAPTION(Delta))
            {
            }
            column(Shipment_Provision_Selection__Provision_Amount_Caption; FIELDCAPTION("Provision Amount"))
            {
            }
            column(Shipment_Provision_Selection_PeriodCaption; FIELDCAPTION(Period))
            {
            }
            column(Shipment_Provision_Selection_Deal_IDCaption; FIELDCAPTION(Deal_ID))
            {
            }
            column(Shipment_Provision_Selection_USER_ID; USER_ID)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "DEL Shipment Provision Select.".USER_ID <> USERID THEN
                    CurrReport.SKIP
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO(Deal_ID);
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

    trigger OnPostReport()
    begin
        IF Export2Excel_Bo THEN
            REPORT.RUNMODAL(Report::"DEL Import commande vente");
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Export2Excel_Bo: Boolean;
        Provision_Cu: Codeunit "DEL Provision";
        TempSPS_Re: Record "DEL Shipment Provision Select." temporary;
        FeeDescriptionArray: array[20] of Text[100];
        FeeTotalArray: array[20] of Text[100];
        i: Integer;
        period_Da: Date;
        period_Te: Text[50];
        "v------PROGRESS BAR------v": Integer;
        intProgressI: array[10] of Integer;
        diaProgress: array[10] of Dialog;
        intProgress: array[10] of Integer;
        intProgressTotal: array[10] of Integer;
        intProgressStep: array[10] of Integer;
        intNextProgressStep: array[10] of Integer;
        timProgress: array[10] of Time;
        interval: array[10] of Integer;
        Shipment_Provision_SelectionCaptionLbl: Label 'Shipment Provision Selection';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Period__CaptionLbl: Label 'Period :';

    procedure FNC_Add2TempSPS(sps_Re_Par: Record "DEL Shipment Provision Select.")
    begin

        TempSPS_Re.RESET();
        TempSPS_Re.SETRANGE(Fee_ID, sps_Re_Par.Fee_ID);
        IF TempSPS_Re.FIND('-') THEN BEGIN
            TempSPS_Re."Provision Amount" += sps_Re_Par."Provision Amount";
            TempSPS_Re.MODIFY();
        END
        ELSE BEGIN
            TempSPS_Re.INIT();
            TempSPS_Re.Deal_ID := '';
            TempSPS_Re.Deal_Shipment_ID := '';
            TempSPS_Re.VALIDATE(Fee_ID, sps_Re_Par.Fee_ID);
            TempSPS_Re.USER_ID := sps_Re_Par.USER_ID;
            TempSPS_Re."Provision Amount" := sps_Re_Par."Provision Amount";
            IF NOT TempSPS_Re.INSERT() THEN
                ERROR('erreur dans R50015');
        END;

    end;

    procedure FNC_GetTempSPSTotal() tot: Decimal
    begin

        tot := 0;

        TempSPS_Re.RESET();
        IF TempSPS_Re.FIND('-') THEN
            REPEAT
                tot += TempSPS_Re."Provision Amount";
            UNTIL (TempSPS_Re.NEXT() = 0);
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
        timProgress[index_Int_Par] := TIME;

    end;

    procedure FNC_ProgressBar_Update(index_Int_Par: Integer)
    begin
        intProgressI[index_Int_Par] += 1;

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

