codeunit 50019 "DEL Create Purch. EDI"
{
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
        DocNo: Code[20];
        Param: Option " ",CreateAndValidateReqWorksheet,CreateDeal;


    procedure SetParam(pParam: Option " ",CreateAndValidateReqWorksheet,CreateDeal; pDocNo: Code[20])
    begin
        Param := pParam;
        DocNo := pDocNo;
    end;

    procedure CreateAndValidateReqWorksheet(DocNo1: Code[20])
    var
        GeneralSetup: Record "DEL General Setup";
        RequisitionLine: Record "Requisition Line";
        PerformAction: Report "Carry Out Action Msg. - Req.";
        GetSalesOrder: Report "DEL Get Sales Orders";
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

        CLEAR(GetSalesOrder);
        GetSalesOrder.SetSalesDocNo(DocNo1);
        GetSalesOrder.SetReqWkshLine(RequisitionLine, 1);
        GetSalesOrder.USEREQUESTPAGE(FALSE);
        GetSalesOrder.RUNMODAL();

        CLEAR(PerformAction);
        PerformAction.SetReqWkshLine(RequisitionLine);
        PerformAction.SetHideDialog(TRUE);
        PerformAction.SetEdiParam(TRUE);
        PerformAction.USEREQUESTPAGE(FALSE);
        PerformAction.RUNMODAL();
    end;


    procedure CreateDeal(DocNo2: Code[20])
    var
        PurchaseLine: Record "Purchase Line";
        Deal_Cu: Codeunit "DEL Deal";
        affaireNo_Co_Loc: Code[20];
        LastDocNo: Code[20];

    begin
        LastDocNo := '';
        PurchaseLine.SETRANGE("Special Order Sales No.", DocNo2);
        IF PurchaseLine.FINDSET() THEN
            REPEAT
                IF PurchaseLine."Document No." <> LastDocNo THEN BEGIN
                    CLEAR(Deal_Cu);
                    CLEAR(LastDocNo);
                    LastDocNo := PurchaseLine."Document No.";

                    affaireNo_Co_Loc := Deal_Cu.FNC_New_Deal(PurchaseLine."Document No.");
                    Deal_Cu.FNC_Init_Deal(affaireNo_Co_Loc, TRUE, FALSE);
                END;
            UNTIL PurchaseLine.NEXT() = 0;
    end;
}

