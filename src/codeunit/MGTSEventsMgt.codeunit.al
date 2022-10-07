codeunit 50100 "DEL MGTS_EventsMgt"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure T18_OnAfterModifyEvent_Customer(var Rec: Record Customer; RunTrigger: Boolean)

    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        IF Rec."DEL Last Accounting Date" <> 0D THEN BEGIN
            IF Rec."DEL Fréquence de facturation" = "DEL Fréquence de facturation"::"12 mois" THEN
                Rec."DEL Date de proch. fact." := CALCDATE('<+12M>', Rec."DEL Last Accounting Date");
            IF Rec."DEL Fréquence de facturation" = "DEL Fréquence de facturation"::"6 mois" THEN
                Rec."DEL Date de proch. fact." := CALCDATE('<+6M>', Rec."DEL Last Accounting Date");
            IF Rec."DEL Fréquence de facturation" = "DEL Fréquence de facturation"::"4 mois" THEN
                Rec."DEL Date de proch. fact." := CALCDATE('<+4M>', Rec."DEL Last Accounting Date");
            IF Rec."DEL Fréquence de facturation" = "DEL Fréquence de facturation"::"3 mois" THEN
                Rec."DEL Date de proch. fact." := CALCDATE('<+3M>', Rec."DEL Last Accounting Date");
            IF Rec."DEL Fréquence de facturation" = "DEL Fréquence de facturation"::" " THEN
                Rec."DEL Date de proch. fact." := CALCDATE('<+0M>', Rec."DEL Last Accounting Date");
            rec."DEL Nbr jr avant proch. fact." := Rec."DEL Date de proch. fact." - TODAY;
        END;
        Rec.Modify();
    end;
    //--TAB111--
    [EventSubscriber(ObjectType::Table, Database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', false, false)]
    local procedure T111_OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine_SalesShptLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line"; var NextLineNo: Integer; var Handled: Boolean; TempSalesLine: Record "Sales Line" temporary; SalesInvHeader: Record "Sales Header")
    var
        SalesShipHead: Record "Sales Shipment Header";
        Text50000: Label 'Order NGTS N %1, y/reference %2';
        Text50001: Label 'ENU=%1 - %2 %3';
    begin
        Handled := true;
        SalesLine.INSERT();
        NextLineNo := NextLineNo + 10000;
        SalesLine.INIT();
        SalesLine."Line No." := NextLineNo;
        SalesLine."Document Type" := TempSalesLine."Document Type";
        SalesLine."Document No." := TempSalesLine."Document No.";

        SalesShipHead.GET(SalesShptLine."Document No.");
        SalesLine.Description := COPYSTR((STRSUBSTNO(Text50000, SalesShptLine."Order No.", SalesShipHead."External Document No.")), 1, 50);

        SalesLine.INSERT();
        NextLineNo := NextLineNo + 10000;

        SalesLine.INIT();
        SalesLine."Line No." := NextLineNo;
        SalesLine."Document Type" := TempSalesLine."Document Type";
        SalesLine."Document No." := TempSalesLine."Document No.";

        SalesShipHead.GET(SalesShptLine."Document No.");
        SalesLine.Description := COPYSTR((STRSUBSTNO(Text50001, SalesShipHead."Sell-to Contact",
        SalesShipHead."Sell-to Customer Name", SalesShipHead."Sell-to City")), 1, 50);

        SalesLine.INSERT();
        NextLineNo := NextLineNo + 10000;
    end;

    //7002
    [EventSubscriber(ObjectType::Table, Database::"Sales Price", 'OnBeforeItemNoOnValidate', '', false, false)]
    local procedure T7002_OnBeforeItemNoOnValidate_SalesPrice(var SalesPrice: Record "Sales Price"; var xSalesPrice: Record "Sales Price"; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        IF SalesPrice."Item No." <> xSalesPrice."Item No." THEN BEGIN
            Item.GET(SalesPrice."Item No.");
            SalesPrice."DEL Vendor No." := Item."Vendor No.";
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T81_OnAfterDeleteEvent_GenJournalLine(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        dealShipmentSelection_Re_Loc.RESET();
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", Rec."Line No.");
        dealShipmentSelection_Re_Loc.DELETEALL();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterInitNewLine', '', false, false)]
    local procedure T81_OnAfterInitNewLine_GenJournalLine(var GenJournalLine: Record "Gen. Journal Line")
    begin
        UpdateAllShortDimFromDimSetID(GenJournalLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCreateDim', '', false, false)]
    local procedure T81_OnAfterCreateDim_GenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        UpdateAllShortDimFromDimSetID(GenJournalLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateShortcutDimCode', '', false, false)]
    local procedure T81_OnAfterValidateShortcutDimCode_GenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; var xGenJournalLine: Record "Gen. Journal Line"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        UpdateAllShortDimFromDimSetID(GenJournalLine);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnBeforeShowDimensions', '', false, false)]
    local procedure T81_OnBeforeShowDimensions__GenJournalLine(var GenJournalLine: Record "Gen. Journal Line"; xGenJournalLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    begin
        UpdateAllShortDimFromDimSetID(GenJournalLine);
    end;


    local procedure UpdateAllShortDimFromDimSetID(var Rec: Record "Gen. Journal Line")
    var
        DimMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        DimMgt.UpdateAllShortDimFromDimSetID(Rec."Dimension Set ID", Rec."DEL Shortcut Dim 3 Code", Rec."DEL Shortcut Dim 4 Code", Rec."DEL Shortcut Dim 5 Code",
                                                Rec."DEL Shortcut Dim 6 Code", Rec."DEL Shortcut Dim 7 Code", Rec."DEL Shortcut Dim 8 Code");
    end;
    ///////////////////////////////////////////////////////////////
    // [EventSubscriber(ObjectType::Table, Database::"Sales Price", 'OnBeforeItemNoOnValidate', '', false, false)]
    // local procedure OnAfterCheckSellToCust(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)
    // begin
    // end;
    ////// tab 97
    [EventSubscriber(ObjectType::Table, Database::"Comment Line", 'OnAfterSetUpNewLine', '', false, false)]

    local procedure OnAfterSetUpNewLine(var CommentLineRec: Record "Comment Line"; var CommentLineFilter: Record "Comment Line")
    begin
        CommentLineRec."DEL User ID" := USERID;

    end;

    //// tab 27 

    [EventSubscriber(ObjectType::Table, database::Item, 'OnBeforeValidateEvent', 'Item Category Code', false, false)]
    local procedure T27_OnBeforeValidateEvent_Item_ItemCategoryCode(var Rec: Record Item; var xRec: Record Item; CurrFieldNo: Integer)
    begin

        xRec.TESTFIELD("Item Category Code");

        Rec.ModifCategory(Rec."Item Category Code");

    end;
    // proc TryGetItemNoOpenCardWithView tab 27

    // [EventSubscriber(ObjectType::Table, database::Item, 'OnTryGetItemNoOpenCardWithViewOnBeforeShowCreateItemOption', '', false, false)]
    // local procedure OnTryGetItemNoOpenCardWithViewOnBeforeShowCreateItemOption(var Item: Record Item)
    // var
    //     FoundRecordCount: Integer;
    //     SelectItemErr: Label 'You must select an existing item.';
    // begin

    //     IF FoundRecordCount = 0 THEN
    //         ERROR(SelectItemErr);

    // end;





    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure T38_OnAfterInsertEvent_PurchaseHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        Rec."DEL Create By" := USERID;
        Rec."DEL Create Date" := TODAY;
        Rec."DEL Create Time" := TIME;
        Rec.NTO_SetPurchDim();
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure T38_OnAfterDeleteEvent_PurchaseHeader(var Rec: Record "Purchase Header"; RunTrigger: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        SalesLine.SETRANGE("Shortcut Dimension 1 Code", Rec."No.");
        IF SalesLine.FIND('-') THEN
            REPEAT
                SalesLine.VALIDATE("Shortcut Dimension 1 Code", '');
                SalesLine.MODIFY();
            UNTIL SalesLine.NEXT() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateShipToCode', '', false, false)]
    local procedure T38_OnAfterValidateShipToCode_PurchaseHeader(var PurchHeader: Record "Purchase Header"; Cust: Record Customer; ShipToAddr: Record "Ship-to Address")
    begin
        PurchHeader."Shipment Method Code" := ShipToAddr."DEL Purch Shipment Method Code";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeUpdateCurrencyFactor', '', false, false)]
    local procedure T38_OnBeforeUpdateCurrencyFactor_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var Updated: Boolean; var CurrencyExchangeRate: Record "Currency Exchange Rate"; CurrentFieldNo: Integer)
    begin
        PurchaseHeader.SetHideValidationDialog(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterUpdateCurrencyFactor', '', false, false)]
    local procedure T38_OnAfterUpdateCurrencyFactor_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; HideValidationDialog: Boolean)
    begin
        IF PurchaseHeader."Currency Factor" <> 0 THEN
            PurchaseHeader.VALIDATE(PurchaseHeader."DEL Relational Exch. Rate Amount", 1 / PurchaseHeader."Currency Factor");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePaymentTermsCodeOnBeforeValidateDueDate', '', false, false)]
    local procedure T38_OnValidatePaymentTermsCodeOnBeforeValidateDueDate_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
            PurchaseHeader.VALIDATE("Due Date", PurchaseHeader."DEL Due Date Calculation");
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePaymentTermsCodeOnBeforeCalcDueDate', '', false, false)]
    local procedure T38_OnValidatePaymentTermsCodeOnBeforeCalcDueDate_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        PaymentTerms: Record "Payment Terms";
    begin
        PaymentTerms.GET(PurchaseHeader."Payment Terms Code");
        IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
            PurchaseHeader."Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseHeader."DEL Due Date Calculation");
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePaymentTermsCodeOnBeforeValidateDueDateWhenBlank', '', false, false)]
    local procedure T38_OnValidatePaymentTermsCodeOnBeforeValidateDueDateWhenBlank_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
            PurchaseHeader.VALIDATE("Due Date", PurchaseHeader."DEL Due Date Calculation");
            IsHandled := true;
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterUpdateInboundWhseHandlingTime', '', false, false)]
    local procedure T38_OnAfterUpdateInboundWhseHandlingTime_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; CurrentFieldNo: Integer)
    begin
        PurchaseHeader.NTO_UpdateForwardingAgent();
    end;



    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnAfterValidateEvent', 'Currency Code', false, false)]
    local procedure T38_OnAfterValidateEvent_PurchaseHeader(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        IF Rec."Currency Factor" <> 0 THEN begin
            Rec.VALIDATE(Rec."DEL Relational Exch. Rate Amount", 1 / Rec."Currency Factor");
            Rec.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeUpdatePurchLinesByFieldNo', '', false, false)]
    local procedure T38_OnBeforeUpdatePurchLinesByFieldNo_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; ChangedFieldNo: Integer; var AskQuestion: Boolean; var IsHandled: Boolean)
    begin
        AskQuestion := false;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePrepmtPaymentTermsCodeOnCaseIfOnBeforeValidatePrepaymentDueDate', '', false, false)]
    local procedure T38_OnValidatePrepmtPaymentTermsCodeOnCaseIfOnBeforeValidatePrepaymentDueDate_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CurrFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
            PurchaseHeader.VALIDATE("Prepayment Due Date", PurchaseHeader."DEL Due Date Calculation");
            IsHandled := true;
        end;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePaymentTermsCodeOnBeforeCalcDueDate', '', false, false)]
    // local procedure T38_OnValidatePaymentTermsCodeOnBeforeCalcDueDate_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var xPurchaseHeader: Record "Purchase Header"; CalledByFieldNo: Integer; CallingFieldNo: Integer; var IsHandled: Boolean)
    // var 
    //     PaymentTerms: Record "Payment Terms";
    // begin
    //     PaymentTerms.GET(PurchaseHeader."Payment Terms Code");
    //     IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
    //         PurchaseHeader."Prepayment Due Date" := CALCDATE(PaymentTerms."Due Date Calculation", PurchaseHeader."DEL Due Date Calculation");
    //         IsHandled := true;
    //     end
    // end; TODO: used

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePrepmtPaymentTermsCodeOnCaseElseOnBeforeValidatePrepaymentDueDate', '', false, false)]
    local procedure T38_OnValidatePrepmtPaymentTermsCodeOnCaseElseOnBeforeValidatePrepaymentDueDate_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CurrFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
            PurchaseHeader.VALIDATE(PurchaseHeader."Prepayment Due Date", PurchaseHeader."DEL Due Date Calculation");
            IsHandled := true;
        end
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnRecreatePurchLinesOnBeforeConfirm', '', false, false)]
    local procedure T38_OnRecreatePurchLinesOnBeforeConfirm_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; ChangedFieldName: Text[100]; HideValidationDialog: Boolean; var Confirmed: Boolean; var IsHandled: Boolean)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
        ConfirmManagement: Codeunit "Confirm Management";
        ConfirmText: Text;
        ResetItemChargeAssignMsg: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\The amount of the item charge assignment will be reset to 0.\\Do you want to continue?', Comment = '%1: FieldCaption';
        RecreatePurchLinesMsg: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\Do you want to continue?', Comment = '%1: FieldCaption';

    begin
        IsHandled := true;
        if PurchaseHeader.GetHideValidationDialog() then
            Confirmed := true
        else begin
            if MGTSFactMgt.HasItemChargeAssignment(PurchaseHeader) then
                ConfirmText := ResetItemChargeAssignMsg
            else
                ConfirmText := RecreatePurchLinesMsg;
            IF ChangedFieldName = PurchaseHeader.FIELDCAPTION("VAT Bus. Posting Group") THEN
                Confirmed := TRUE;
            Confirmed := ConfirmManagement.GetResponseOrDefault(StrSubstNo(ConfirmText, ChangedFieldName), true);
        end;
    end;

}
