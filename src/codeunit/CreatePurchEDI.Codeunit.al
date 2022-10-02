codeunit 50019 "DEL Create Purch. EDI"
{
    // MGTSEDI10.00.00.23 | 21.05.2021 | EDI Management : Create codeunit


    trigger OnRun()
    begin
        CASE Param OF
            Param::CreateAndValidateReqWorksheet:
                CreateAndValidateReqWorksheet(DocNo);
            Param::CreateDeal:
                CreateDeal(DocNo);
        END;
    end;

    var
        Param: Option " ",CreateAndValidateReqWorksheet,CreateDeal;
        DocNo: Code[20];

    procedure SetParam(pParam: Option " ",CreateAndValidateReqWorksheet,CreateDeal; pDocNo: Code[20])
    begin
        Param := pParam;
        DocNo := pDocNo;
    end;

    procedure CreateAndValidateReqWorksheet(DocNo: Code[20])
    var
        RequisitionLine: Record "Requisition Line";
        GeneralSetup: Record "DEL General Setup";
        GetSalesOrder: Report "Get Sales Orders";
        PerformAction: Report "Carry Out Action Msg. - Req.";
    begin
        GeneralSetup.GET();
        GeneralSetup.TESTFIELD("Worksheet Template Name");
        GeneralSetup.TESTFIELD("Journal Batch Name");

        RequisitionLine.SETRANGE("Worksheet Template Name", GeneralSetup."Worksheet Template Name");
        RequisitionLine.SETRANGE("Journal Batch Name", GeneralSetup."Journal Batch Name");
        RequisitionLine.DELETEALL();

        RequisitionLine.INIT();
        RequisitionLine."Worksheet Template Name" := GeneralSetup."Worksheet Template Name";
        RequisitionLine."Journal Batch Name" := GeneralSetup."Journal Batch Name";

        //Extract Sales Line To Requisition Line
        CLEAR(GetSalesOrder);
        GetSalesOrder.SetSalesDocNo(DocNo);
        GetSalesOrder.SetReqWkshLine(RequisitionLine, 1);
        GetSalesOrder.USEREQUESTPAGE(FALSE);
        GetSalesOrder.RUNMODAL();

        //Validate Requisition Line
        CLEAR(PerformAction);
        PerformAction.SetReqWkshLine(RequisitionLine);
        PerformAction.SetHideDialog(TRUE);
        PerformAction.SetEdiParam(TRUE);
        PerformAction.USEREQUESTPAGE(FALSE);
        PerformAction.RUNMODAL();
    end;

    procedure CreateDeal(DocNo: Code[20])
    var
        PurchaseLine: Record "Purchase Line";
        Deal_Cu: Codeunit "DEL Deal";
        LastDocNo: Code[20];
        affaireNo_Co_Loc: Code[20];
    begin
        LastDocNo := '';
        PurchaseLine.SETRANGE("Special Order Sales No.", DocNo);
        IF PurchaseLine.FINDSET() THEN
            REPEAT
                IF PurchaseLine."Document No." <> LastDocNo THEN BEGIN
                    CLEAR(Deal_Cu);
                    CLEAR(LastDocNo);
                    LastDocNo := PurchaseLine."Document No.";

                    affaireNo_Co_Loc := Deal_Cu.FNC_New_Deal(PurchaseLine."Document No."); //MESSAGE('DEAL CREATION OK');
                    Deal_Cu.FNC_Init_Deal(affaireNo_Co_Loc, TRUE, FALSE); //MESSAGE('DEAL INIT OK');
                END;
            UNTIL PurchaseLine.NEXT() = 0;
    end;
}

