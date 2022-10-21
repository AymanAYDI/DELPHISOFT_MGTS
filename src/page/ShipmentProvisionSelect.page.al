
page 50050 "DEL Shipment Provision Select."
{

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "DEL Shipment Provision Select.";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                // field(lineNumber; "lineNumber") // TODO: these fields are missing in the source table
                // {
                //     Caption = 'Nombre de lignes';
                //     Editable = false;
                // }
                // field(Periodeencours; isCurrentPeriod_Te)
                // {
                //     Caption = 'Période en cours';
                //     Editable = false;
                // }
                // field(FORMAT(date_Da,0,'<Month Text>');FORMAT(date_Da,0,'<Month Text>'))
                // {
                //     Caption = 'Month';
                //     Editable = false;
                // }
                // field(DATE2DMY(date_Da,3);DATE2DMY(date_Da,3))
                // {
                //     Caption = 'Year';
                //     Editable = false;
                // }
                field(monthLastWorkingDay; monthLastWorkingDay)
                {
                    Caption = 'Last Working Day';
                }
                field(monthFirstWorkingDay; monthFirstWorkingDay)
                {
                    Caption = 'First Working Day';
                }
                field(totalPlannedAmount; totalPlannedAmount)
                {
                    Caption = 'Total Planned Amount';
                    Editable = false;
                }
                field(totalRealAmount; totalRealAmount)
                {
                    Caption = 'Total Real Amount';
                    Editable = false;
                }
                field(totalProvisionAmount; totalProvisionAmount)
                {
                    Caption = 'Total Provision Amount';
                    Editable = false;
                }
                field("totalPlannedAmount - totalRealAmount"; totalPlannedAmount - totalRealAmount)
                {
                    Caption = 'Total Delta';
                    Editable = false;
                }
            }
            repeater("table")
            {
                field(Period; Rec.Period)
                {
                    Editable = false;
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                    Editable = false;
                }
                field(Deal_Shipment_ID; Rec.Deal_Shipment_ID)
                {
                    Editable = false;
                }
                field(Fee_ID; Rec.Fee_ID)
                {
                    Editable = false;
                }
                field("Fee Description"; Rec."Fee Description")
                {
                    Editable = false;
                }
                field("Planned Amount"; Rec."Planned Amount")
                {
                    Editable = false;
                }
                field("Real Amount"; Rec."Real Amount")
                {
                    Editable = false;
                }
                field(Delta; Rec.Delta)
                {
                    Editable = false;
                }
                field("Provision Amount"; Rec."Provision Amount")
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
                        provision_Report: Report "DEL Create Provision";
                    begin
                        provision_Report.RUNMODAL();


                        FNC_SetPeriod();

                        FNC_UpdateTotals();
                    end;
                }
                separator(sep2)
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
                    begin
                        totalProvisionAmount := Rec."Total Provision Amount";
                        IF totalProvisionAmount > 0 THEN
                            Provision_Cu.FNC_TransferToJournal(monthLastWorkingDay, monthFirstWorkingDay, isCurrentPeriod_Bo)
                        ELSE
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
                        REPORT.RUNMODAL(Report::"DEL Export Provision");
                    end;
                }
                action("Exporter Excel")
                {
                    Caption = 'Exporter Excel';

                    trigger OnAction()
                    begin
                        REPORT.RUNMODAL(Report::"DEL Import commande vente");
                    end;
                }
                separator(Sep)
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
                separator(sep1)
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
        Rec.Delta := Rec."Planned Amount" - Rec."Real Amount";
    end;

    trigger OnInit()
    begin
        FNC_InitVars();
    end;

    trigger OnOpenPage()
    begin
        FNC_UpdateTotals();


        Rec.SETRANGE(USER_ID, USERID);


        FNC_SetPeriod();

        monthLastWorkingDay := Deal_Cu.FNC_GetMonthLastWorkDay(date_Da);

        monthFirstWorkingDay := Deal_Cu.FNC_GetMonthFirstWorkDay(CALCDATE('<+1M>', date_Da));
    end;

    var
        flowFields_Re: Record "DEL FlowFields";
        Deal_Cu: Codeunit "DEL Deal";
        Provision_Cu: Codeunit "DEL Provision";
        isCurrentPeriod_Bo: Boolean;
        isCurrentPeriod_Te: Boolean;

        "Provision AmountEmphasize": Boolean;
        date_Da: Date;
        monthFirstWorkingDay: Date;
        monthLastWorkingDay: Date;
        totalPlannedAmount: Decimal;
        totalProvisionAmount: Decimal;
        totalRealAmount: Decimal;
        color: Integer;
        lineNumber: Integer;


    procedure FNC_UpdateTotals()
    begin
        FNC_InitVars();

        flowFields_Re.GET('KEY');
        flowFields_Re.USER_ID := USERID;

        flowFields_Re.CALCFIELDS("Provision Planned Amount", "Provision Real Amount", "Provision Amount");

        totalPlannedAmount := flowFields_Re."Provision Planned Amount";
        totalRealAmount := flowFields_Re."Provision Real Amount";
        totalProvisionAmount := flowFields_Re."Provision Amount";

        IF totalPlannedAmount < 0 THEN totalPlannedAmount := 0;
        IF totalRealAmount < 0 THEN totalRealAmount := 0;
        IF totalProvisionAmount < 0 THEN totalProvisionAmount := 0;

        lineNumber := Rec.COUNT;


    end;


    procedure FNC_InitVars()
    begin
        totalPlannedAmount := 0;
        totalRealAmount := 0;
        totalProvisionAmount := 0;
        lineNumber := 0;
        color := 8421376;
    end;


    procedure FNC_SetPeriod()
    var
        spsp_Re_Loc: Record "DEL Ship. Prov. Sele. Params";
    begin
        date_Da := TODAY;
        isCurrentPeriod_Te := FALSE;
        isCurrentPeriod_Bo := TRUE;


        IF spsp_Re_Loc.GET(USERID) THEN BEGIN

            date_Da := spsp_Re_Loc.period;

            IF spsp_Re_Loc.isCurrentPeriod THEN BEGIN


                isCurrentPeriod_Te := TRUE;
                isCurrentPeriod_Bo := TRUE;
                Rec.SETCURRENTKEY(Deal_ID, Deal_Shipment_ID, Fee_ID, USER_ID);

            END ELSE BEGIN

                isCurrentPeriod_Te := FALSE;
                isCurrentPeriod_Bo := FALSE;
                Rec.SETCURRENTKEY(Period, Deal_ID, Deal_Shipment_ID);

            END;

        END;


        monthLastWorkingDay := Deal_Cu.FNC_GetMonthLastWorkDay(date_Da);

        monthFirstWorkingDay := Deal_Cu.FNC_GetMonthFirstWorkDay(CALCDATE('<+1M>', date_Da));

    end;


    local procedure ProvisionAmountOnFormat()
    begin

        "Provision AmountEmphasize" := TRUE;
    end;
}



