page 50050 "Shipment Provision Selection"
{
    // 
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // |                                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // T-00577                THM      16.08.13    Desactivé FILTERGROUP (BUG)

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = Table50042;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(lineNumber; lineNumber)
                {
                    Caption = 'Nombre de lignes';
                    Editable = false;
                }
                field(Periodeencours; isCurrentPeriod_Te)
                {
                    Caption = 'Période en cours';
                    Editable = false;
                }
                field(FORMAT(date_Da,0,'<Month Text>');FORMAT(date_Da,0,'<Month Text>'))
                {
                    Caption = 'Month';
                    Editable = false;
                }
                field(DATE2DMY(date_Da,3);DATE2DMY(date_Da,3))
                {
                    Caption = 'Year';
                    Editable = false;
                }
                field(monthLastWorkingDay;monthLastWorkingDay)
                {
                    Caption = 'Last Working Day';
                }
                field(monthFirstWorkingDay;monthFirstWorkingDay)
                {
                    Caption = 'First Working Day';
                }
                field(totalPlannedAmount;totalPlannedAmount)
                {
                    Caption = 'Total Planned Amount';
                    Editable = false;
                }
                field(totalRealAmount;totalRealAmount)
                {
                    Caption = 'Total Real Amount';
                    Editable = false;
                }
                field(totalProvisionAmount;totalProvisionAmount)
                {
                    Caption = 'Total Provision Amount';
                    Editable = false;
                }
                field(totalPlannedAmount - totalRealAmount;totalPlannedAmount - totalRealAmount)
                {
                    Caption = 'Total Delta';
                    Editable = false;
                }
            }
            repeater("table")
            {
                field(Period;Period)
                {
                    Editable = false;
                }
                field(Deal_ID;Deal_ID)
                {
                    Editable = false;
                }
                field(Deal_Shipment_ID;Deal_Shipment_ID)
                {
                    Editable = false;
                }
                field(Fee_ID;Fee_ID)
                {
                    Editable = false;
                }
                field("Fee Description";"Fee Description")
                {
                    Editable = false;
                }
                field("Planned Amount";"Planned Amount")
                {
                    Editable = false;
                }
                field("Real Amount";"Real Amount")
                {
                    Editable = false;
                }
                field(Delta;Delta)
                {
                    Editable = false;
                }
                field("Provision Amount";"Provision Amount")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Functions';
                action("Calculer...")
                {
                    Caption = 'Calculer...';
                    Image = CalculatePlan;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        provision_Report: Report "50014";
                    begin
                        //dans le report, on défini et enregistre dans une table la date de la période à traiter
                        provision_Report.RUNMODAL();

                        //quand on appelle cette fonction, elle va voir dans la table la période qui a été définie par le report
                        //et va l'appliquer au form
                        FNC_SetPeriod();

                        //mise à jour des totaux
                        FNC_UpdateTotals();
                    end;
                }
                separator()
                {
                }
                action(Comptabiliser)
                {
                    Caption = 'Comptabiliser';
                    Image = PostedPutAway;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        selected_Int_Loc: Integer;
                    begin
                         totalProvisionAmount:="Total Provision Amount";
                        IF totalProvisionAmount > 0 THEN BEGIN

                          // Sets the default to option 3
                          //selected_Int_Loc := DIALOG.STRMENU('a,b,c', 3);
                          Provision_Cu.FNC_TransferToJournal(monthLastWorkingDay, monthFirstWorkingDay, isCurrentPeriod_Bo)

                        END ELSE
                          ERROR('Le montant total à provisionner est égal à zéro !');
                    end;
                }
                action(Imprimer)
                {
                    Caption = 'Imprimer';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(50015);
                    end;
                }
                action("Exporter Excel")
                {
                    Caption = 'Exporter Excel';

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(50016);
                    end;
                }
                separator()
                {
                }
                action("Purger > 3 mois")
                {
                    Caption = 'Purger > 3 mois';

                    trigger OnAction()
                    begin
                         Provision_Cu.FNC_Prune();
                    end;
                }
                separator()
                {
                }
                action(Tester)
                {
                    Caption = 'Tester';
                    Image = TestReport;

                    trigger OnAction()
                    begin
                        Provision_Cu.FNC_RunTest();
                    end;
                }
                action("Supprimer toutes les provisions")
                {
                    Caption = 'Supprimer toutes les provisions';
                    Image = DeleteAllBreakpoints;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Provision_Cu.FNC_DeleteProvisions()
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin

        FNC_UpdateTotals();
        FNC_SetPeriod();
    end;

    trigger OnAfterGetRecord()
    begin
        Delta := "Planned Amount" - "Real Amount";
    end;

    trigger OnInit()
    begin
        FNC_InitVars();
    end;

    trigger OnOpenPage()
    begin
        FNC_UpdateTotals();

        //FILTERGROUP(6);
        SETRANGE(USER_ID, USERID);
        //FILTERGROUP(0);

        FNC_SetPeriod();

        //dernier jour de la période
        monthLastWorkingDay := Deal_Cu.FNC_GetMonthLastWorkDay(date_Da);

        //premier jour de la période suivante
        monthFirstWorkingDay := Deal_Cu.FNC_GetMonthFirstWorkDay(CALCDATE('<+1M>', date_Da));
    end;

    var
        totalPlannedAmount: Decimal;
        totalRealAmount: Decimal;
        totalProvisionAmount: Decimal;
        lineNumber: Integer;
        flowFields_Re: Record "50044";
        actual: Code[20];
        isColored: Boolean;
        color: Integer;
        stopColoring: Boolean;
        Provision_Cu: Codeunit "50033";
        date_Da: Date;
        monthLastWorkingDay: Date;
        monthFirstWorkingDay: Date;
        Deal_Cu: Codeunit "50020";
        isCurrentPeriod_Te: Boolean;
        isCurrentPeriod_Bo: Boolean;
        [InDataSet]
        "Provision AmountEmphasize": Boolean;
        Text19037295: Label 'P R O V I S I O N S';

    [Scope('Internal')]
    procedure FNC_UpdateTotals()
    var
        sps_Re_Loc: Record "50042";
    begin
        FNC_InitVars();

        flowFields_Re.GET('KEY');
        flowFields_Re.USER_ID := USERID;
        //flowFields_Re.MODIFY();
        flowFields_Re.CALCFIELDS("Provision Planned Amount", "Provision Real Amount", "Provision Amount");

        totalPlannedAmount   := flowFields_Re."Provision Planned Amount";
        totalRealAmount      := flowFields_Re."Provision Real Amount";
        totalProvisionAmount := flowFields_Re."Provision Amount";

        IF totalPlannedAmount   < 0 THEN totalPlannedAmount   := 0;
        IF totalRealAmount      < 0 THEN totalRealAmount      := 0;
        IF totalProvisionAmount < 0 THEN totalProvisionAmount := 0;

        lineNumber := COUNT;

        //CurrPage.totalPlannedAmountLabel.UPDATE();
        //CurrPage.totalRealAmountLabel.UPDATE();
        //CurrPage.totalProvisionAmountLabel.UPDATE();
        //CurrPage.lineNumber.UPDATE();
    end;

    [Scope('Internal')]
    procedure FNC_InitVars()
    begin
        totalPlannedAmount   := 0;
        totalRealAmount      := 0;
        totalProvisionAmount := 0;
        lineNumber           := 0;
        color                := 8421376;
    end;

    [Scope('Internal')]
    procedure FNC_SetPeriod()
    var
        spsp_Re_Loc: Record "50045";
    begin
        date_Da := TODAY;
        isCurrentPeriod_Te := FALSE;
        isCurrentPeriod_Bo := TRUE;
        
        /*
        flowFields_Re.GET('KEY');
        
        //si une date de période a été définie par le report 50014 alors cette date est la date à utiliser
        IF flowFields_Re.Date_Period <> 0D THEN BEGIN
          date_Da := flowFields_Re.Date_Period;
          flowFields_Re.Date_Period := 0D;
          flowFields_Re.MODIFY();
        END;
        */
        
        IF spsp_Re_Loc.GET(USERID) THEN BEGIN
        
          date_Da := spsp_Re_Loc.period;
        
          IF spsp_Re_Loc.isCurrentPeriod THEN BEGIN
        
           // isCurrentPeriod_Te := 'Oui';  // THM
            isCurrentPeriod_Te :=TRUE;
            isCurrentPeriod_Bo := TRUE;
            SETCURRENTKEY(Deal_ID, Deal_Shipment_ID, Fee_ID, USER_ID);
        
          END ELSE BEGIN
        
         //   isCurrentPeriod_Te := 'Non';  // THM
            isCurrentPeriod_Te :=FALSE;
            isCurrentPeriod_Bo := FALSE;
            SETCURRENTKEY(Period, Deal_ID, Deal_Shipment_ID);
        
          END;
        
        END;
        
        //dernier jour de la période
        monthLastWorkingDay := Deal_Cu.FNC_GetMonthLastWorkDay(date_Da);
        
        //premier jour de la période suivante
        monthFirstWorkingDay := Deal_Cu.FNC_GetMonthFirstWorkDay(CALCDATE('<+1M>', date_Da));

    end;

    local procedure PeriodOnFormat()
    begin
    end;

    local procedure DealIDOnFormat()
    begin
    end;

    local procedure DealShipmentIDOnFormat()
    begin
    end;

    local procedure FeeIDOnFormat()
    begin
    end;

    local procedure FeeDescriptionOnFormat()
    begin
    end;

    local procedure PlannedAmountOnFormat()
    begin
    end;

    local procedure RealAmountOnFormat()
    begin
    end;

    local procedure DeltaOnFormat()
    begin
    end;

    local procedure ProvisionAmountOnFormat()
    begin

        "Provision AmountEmphasize" := TRUE;
    end;
}

