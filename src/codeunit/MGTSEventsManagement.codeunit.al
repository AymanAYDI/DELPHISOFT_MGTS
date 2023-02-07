codeunit 50100 "DEL MGTS_Events Management"
{
    //tab18
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
        Text50001: Label '%1 - %2 %3';
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

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidatePostingDateOnBeforeResetInvoiceDiscountValue', '', false, false)]
    local procedure OnValidatePostingDateOnBeforeResetInvoiceDiscountValue(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    var
        GlobalsFunction: codeunit "DEL MGTS Set/Get Functions";
    begin
        IF SalesHeader."Currency Code" <> '' THEN
            GlobalsFunction.SetHideValidationDialog(true);
    end;

    //T81
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


    ////TAB 36 
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckSellToCust', '', false, false)]
    local procedure T36_OnAfterCheckSellToCust_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer)

    begin
        SalesHeader."DEL Fiscal Repr." := Customer."DEL Fiscal Repr.";
    end;
    ////
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckBillToCust', '', false, false)]

    local procedure T36_OnAfterCheckBillToCust_SalesHeader(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer)

    begin
        IF (Customer."DEL Fiscal Repr." <> '') THEN
            SalesHeader."DEL Fiscal Repr." := Customer."DEL Fiscal Repr.";
    end;
    /////
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidateShipToCodeOnBeforeCopyShipToAddress', '', false, false)]

    local procedure T36_OnValidateShipToCodeOnBeforeCopyShipToAddress_SalesHeader(var SalesHeader: Record "Sales Header"; var xSalesHeader: Record "Sales Header"; var CopyShipToAddress: Boolean)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.RESET();
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        IF SalesLine.FINDSET() THEN
            REPEAT
                SalesLine."DEL Ship-to Code" := SalesHeader."Ship-to Code";
                SalesLine."DEL Ship-to Name" := SalesHeader."Ship-to Name";
                SalesLine.MODIFY();
            UNTIL SalesLine.NEXT() = 0;
    end;
    /////
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor', '', false, false)]

    local procedure T36_OnValidatePostingDateOnBeforeCheckNeedUpdateCurrencyFactor_SalesHeader(var SalesHeader: Record "Sales Header"; var IsConfirmed: Boolean; var NeedUpdateCurrencyFactor: Boolean; xSalesHeader: Record "Sales Header")

    begin
        IF NeedUpdateCurrencyFactor THEN
            SalesHeader.SetHideValidationDialog(true);

    end;

    ///////

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnAfterValidateEvent', 'Campaign No.', false, false)]
    local procedure T36_OnAfterValidateEvent_SalesHeader_CompaignNo(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin

        IF Rec."Campaign No." <> xRec."Campaign No." THEN
            Rec.UpdateSalesLines(Rec.FIELDCAPTION(Rec."Campaign No."), CurrFieldNo <> 0);
    end;

    ///////

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnAfterOnInsert', '', false, false)]
    local procedure T36_OnAfterOnInsert(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."DEL Create By" := USERID;
        SalesHeader."DEL Create Date" := TODAY;
        SalesHeader."DEL Create Time" := TIME;
    end;
    //////

    [EventSubscriber(ObjectType::Table, DataBase::"Sales Header", 'OnAfterValidateEvent', 'Requested Delivery Date', false, false)]
    local procedure T36_OnAfterValidateEvent_SalesHeader_rqstDelivDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        rec.VALIDATE(Rec."DEL Estimated Delivery Date", Rec."Requested Delivery Date");
    end;


    //tab 97
    [EventSubscriber(ObjectType::Table, Database::"Comment Line", 'OnAfterSetUpNewLine', '', false, false)]

    local procedure OnAfterSetUpNewLine(var CommentLineRec: Record "Comment Line"; var CommentLineFilter: Record "Comment Line")
    begin
        CommentLineRec."DEL User ID" := USERID;
    end;

    //// tab 27 
    //TODO 
    // [EventSubscriber(ObjectType::Table, database::Item, 'OnAfterDeleteRelatedData', '', false, false)]
    // local procedure OnAfterDeleteRelatedData(Item: Record Item)
    // var
    //     gcouStammVerw: Codeunit 4006496;
    // begin
    //     gcouStammVerw.ArtikelOnDelete(Item);

    // end;

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
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateShipToCode', '', false, false)]
    local procedure T38_OnAfterValidateShipToCode_PurchaseHeader(var PurchHeader: Record "Purchase Header"; Cust: Record Customer; ShipToAddr: Record "Ship-to Address")
    begin
        PurchHeader."Shipment Method Code" := ShipToAddr."DEL Purch Shipment Method Code";
    end;
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeUpdateCurrencyFactor', '', false, false)]
    local procedure T38_OnBeforeUpdateCurrencyFactor_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var Updated: Boolean; var CurrencyExchangeRate: Record "Currency Exchange Rate"; CurrentFieldNo: Integer)
    begin
        PurchaseHeader.SetHideValidationDialog(true);
    end;
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterUpdateCurrencyFactor', '', false, false)]
    local procedure T38_OnAfterUpdateCurrencyFactor_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; HideValidationDialog: Boolean)
    begin
        IF PurchaseHeader."Currency Factor" <> 0 THEN
            PurchaseHeader.VALIDATE(PurchaseHeader."DEL Rel. Exch. Rate Amount", 1 / PurchaseHeader."Currency Factor");
    end;
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePaymentTermsCodeOnBeforeValidateDueDate', '', false, false)]
    local procedure T38_OnValidatePaymentTermsCodeOnBeforeValidateDueDate_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
            PurchaseHeader.VALIDATE("Due Date", PurchaseHeader."DEL Due Date Calculation");
            IsHandled := true;
        end;
    end;
    ////
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
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidatePaymentTermsCodeOnBeforeValidateDueDateWhenBlank', '', false, false)]
    local procedure T38_OnValidatePaymentTermsCodeOnBeforeValidateDueDateWhenBlank_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CurrentFieldNo: Integer; var IsHandled: Boolean)
    begin
        IF PurchaseHeader."DEL Due Date Calculation" <> 0D THEN begin
            PurchaseHeader.VALIDATE("Due Date", PurchaseHeader."DEL Due Date Calculation");
            IsHandled := true;
        end
    end;
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterUpdateInboundWhseHandlingTime', '', false, false)]
    local procedure T38_OnAfterUpdateInboundWhseHandlingTime_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; CurrentFieldNo: Integer)
    begin
        PurchaseHeader.NTO_UpdateForwardingAgent();
    end;
    ////
    [EventSubscriber(ObjectType::Table, DataBase::"Purchase Header", 'OnAfterValidateEvent', 'Currency Code', false, false)]
    local procedure T38_OnAfterValidateEvent_PurchaseHeader(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        IF Rec."Currency Factor" <> 0 THEN begin
            Rec.VALIDATE(Rec."DEL Rel. Exch. Rate Amount", 1 / Rec."Currency Factor");
            Rec.Modify();
        end;
    end;
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeUpdatePurchLinesByFieldNo', '', false, false)]
    local procedure T38_OnBeforeUpdatePurchLinesByFieldNo_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; ChangedFieldNo: Integer; var AskQuestion: Boolean; var IsHandled: Boolean)
    begin
        AskQuestion := false;
    end;
    ////
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

    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnRecreatePurchLinesOnBeforeConfirm', '', false, false)]
    local procedure T38_OnRecreatePurchLinesOnBeforeConfirm_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; ChangedFieldName: Text[100]; HideValidationDialog: Boolean; var Confirmed: Boolean; var IsHandled: Boolean)
    var
        SpecPurchLine: Record "Purchase Line";
        ConfirmManagement: Codeunit "Confirm Management";
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
        RecreatePurchLinesMsg: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\\Do you want to continue?', Comment = '%1: FieldCaption';
        ResetItemChargeAssignMsg: Label 'If you change %1, the existing purchase lines will be deleted and new purchase lines based on the new information in the header will be created.\The amount of the item charge assignment will be reset to 0.\\Do you want to continue?', Comment = '%1: FieldCaption';
        ConfirmText: Text;

    begin
        IsHandled := true;
        if PurchaseHeader.GetHideValidationDialog() then
            Confirmed := true
        else begin
            if MGTSFactMgt.HasItemChargeAssignment(PurchaseHeader) then
                ConfirmText := ResetItemChargeAssignMsg
            else
                ConfirmText := RecreatePurchLinesMsg;
            IF ChangedFieldName = PurchaseHeader.FIELDCAPTION("VAT Bus. Posting Group") THEN begin
                Confirmed := TRUE;
                SpecPurchLine.RESET();
                SpecPurchLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
                SpecPurchLine.SETRANGE("Document No.", PurchaseHeader."No.");
                IF SpecPurchLine.FINDSET() THEN
                    REPEAT
                        SpecPurchLine."Special Order Sales Line No." := 0;
                        SpecPurchLine.MODIFY();
                    UNTIL SpecPurchLine.NEXT() = 0;
            end;
            Confirmed := ConfirmManagement.GetResponseOrDefault(StrSubstNo(ConfirmText, ChangedFieldName), true);
        end;
    end;
    ////


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeTransferSavedFieldsSpecialOrder', '', false, false)]
    local procedure T38_OnBeforeTransferSavedFieldsSpecialOrder_PurchaseHeader(var DestinationPurchaseLine: Record "Purchase Line"; var SourcePurchaseLine: Record "Purchase Line"; var IsHandled: Boolean)
    var
        SalesLine: Record "Sales Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
    begin
        SalesLine.LOCKTABLE();
        IF SalesLine.GET(SalesLine."Document Type"::Order, SourcePurchaseLine."Special Order Sales No.", SourcePurchaseLine."Special Order Sales Line No.") THEN
            CopyDocMgt.TransfldsFromSalesToPurchLine(SalesLine, DestinationPurchaseLine);
        DestinationPurchaseLine."Special Order" := SourcePurchaseLine."Special Order";
        DestinationPurchaseLine."Purchasing Code" := SalesLine."Purchasing Code";
        DestinationPurchaseLine."Special Order Sales No." := SourcePurchaseLine."Special Order Sales No.";
        DestinationPurchaseLine."Special Order Sales Line No." := SourcePurchaseLine."Special Order Sales Line No.";
        DestinationPurchaseLine.Validate("Unit of Measure Code", SourcePurchaseLine."Unit of Measure Code");
        if SourcePurchaseLine.Quantity <> 0 then
            DestinationPurchaseLine.Validate(Quantity, SourcePurchaseLine.Quantity);

        IF SalesLine.GET(SalesLine."Document Type"::Order, SourcePurchaseLine."Special Order Sales No.", SourcePurchaseLine."Special Order Sales Line No.") THEN BEGIN
            SalesLine.Validate("Unit Cost (LCY)", DestinationPurchaseLine."Unit Cost (LCY)");
            SalesLine."Special Order Purchase No." := DestinationPurchaseLine."Document No.";
            SalesLine."Special Order Purch. Line No." := DestinationPurchaseLine."Line No.";
            SalesLine.Modify();
        END;
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorAddressFieldsFromVendor', '', false, false)]
    // local procedure T38_OnAfterCopyBuyFromVendorAddressFieldsFromVendor_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; BuyFromVendor: Record Vendor)
    // begin
    //     "Ship Per" := BuyFromVendor."Ship Per";   TODO: Check
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure T38_OnBeforeTestStatusOpen_PurchaseHeader(var PurchHeader: Record "Purchase Header"; xPurchHeader: Record "Purchase Header"; CallingFieldNo: Integer)
    var
        Vend: Record Vendor;
    begin
        IF Vend.GET(PurchHeader."Buy-from Vendor No.") THEN
            IF Vend."Vendor Posting Group" = 'MARCH' THEN
                IF (Vend."DEL Qualified vendor" = FALSE) AND (Vend."DEL Derogation" = false) THEN
                    Vend.TESTFIELD(Vend."DEL Qualified vendor", true);

        PurchHeader.SuspendStatusCheck(false);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont', '', false, false)]
    local procedure T38_OnValidateBuyFromVendorNoOnAfterUpdateBuyFromCont_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean)
    begin
        PurchaseHeader.NTO_UpdateForwardingAgent();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T39_OnAfterInsertEvent_PurchaseLine(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    VAR
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
        urm_Re_Loc: Record "DEL Update Request Manager";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        requestID_Co_Loc: Code[20];
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        ACOConnection_Re_Loc.RESET();
        ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
        ACOConnection_Re_Loc.SETRANGE("ACO No.", Rec."Document No.");
        IF ACOConnection_Re_Loc.FINDFIRST() THEN BEGIN

            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
              ACOConnection_Re_Loc.Deal_ID,
              urm_Re_Loc.Requested_By_Type::"Purchase Header",
              Rec."Document No.",
              CURRENTDATETIME
            );

            Rec.INSERT();

            urm_Re_Loc.GET(requestID_Co_Loc);
            UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc, FALSE, FALSE, TRUE);

            Rec.DELETE();

        END;
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeUpdateSpecialSalesOrderLineFromOnDelete', '', false, false)]
    local procedure T39_OnBeforeUpdateSpecialSalesOrderLineFromOnDelete_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var SalesOrderLine: Record "Sales Line"; var IsHandled: Boolean)
    begin
        IF PurchaseLine."Special Order Sales Line No." <> 0 THEN BEGIN
            PurchaseLine.LOCKTABLE();
            SalesOrderLine.LOCKTABLE();
            IF PurchaseLine."Document Type" = SalesOrderLine."Document Type"::Order THEN BEGIN
                SalesOrderLine.RESET();
                SalesOrderLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
                SalesOrderLine.SETRANGE("Special Order Purchase No.", PurchaseLine."Document No.");
                SalesOrderLine.SETRANGE("No.", PurchaseLine."No.");
                IF SalesOrderLine.FIND('-') THEN
                    REPEAT
                        SalesOrderLine."Special Order Purchase No." := '';
                        SalesOrderLine."Special Order Purch. Line No." := 0;
                        SalesOrderLine.MODIFY();
                    UNTIL SalesOrderLine.NEXT() = 0;
            END;
        END;
        IsHandled := true;
    end;

    ////COD 231
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure COD231_OnBeforeCode_GenJnlPost(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnBeforeCodeFct(GenJournalLine, HideDialog);
    end;

    /////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnCodeOnAfterGenJnlPostBatchRun', '', false, false)]
    local procedure COD231_OnCodeOnAfterGenJnlPostBatchRun_GenJnlPost(var GenJnlLine: Record "Gen. Journal Line")
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnCodeOnAfterGenJnlPostBatchRunfct(GenJnlLine);
    end;
    /////COD231

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnGenJnlLineSetFilter', '', false, false)]
    // local procedure COD231_OnGenJnlLineSetFilter_GenJnlPost(var GenJournalLine: Record "Gen. Journal Line")

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnGenJnlLineSetFilter', '', false, false)]
    local procedure COD231_OnGenJnlLineSetFilter_GenJnlPost(var GenJournalLine: Record "Gen. Journal Line")
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnGenJnlLineSetFilter_Fct(GenJournalLine);
    end;

    ////COD 232 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post+Print", 'OnBeforePostJournalBatch', '', false, false)]
    local procedure COD232_OnBeforePostJournalBatch_GenJnlPostPrint(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnBeforeCodeFct(GenJournalLine, HideDialog);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post+Print", 'OnAfterPostJournalBatch', '', false, false)]
    local procedure COD232_OnAfterPostJournalBatch_GenJnlPostPrint(var GenJournalLine: Record "Gen. Journal Line");
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnCodeOnAfterGenJnlPostBatchRunfct(GenJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post+Print", 'OnGenJnlLineSetFilter', '', false, false)]

    local procedure COD232_OnGenJnlLineSetFilter_GenJnlPostPrint(var GenJournalLine: Record "Gen. Journal Line")
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnGenJnlLineSetFilter_Fct(GenJournalLine);
    end;

    //// COD333
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnCodeOnBeforeFinalizeOrderHeader', '', false, false)]
    local procedure OnCodeOnBeforeFinalizeOrderHeader(PurchOrderHeader: Record "Purchase Header"; var ReqLine: Record "Requisition Line"; var IsHandled: Boolean)
    var
        ReleasePurchaseDocument: Codeunit "Release Purchase Document";
        ReqwkshMorder: Codeunit "Req. Wksh.-Make Order";
    begin
        IsHandled := true;
        if PurchOrderHeader."Buy-from Vendor No." <> '' then begin
            IF ReqLine."Action Message" = ReqLine."Action Message"::New THEN
                ReleasePurchaseDocument.ReleasePurchaseHeader(PurchOrderHeader, FALSE);
            ReqwkshMorder.FinalizeOrderHeader(PurchOrderHeader, ReqLine);
        end;

    end;
    //// COD333

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforeInitPurchOrderLineUpdateQuantity', '', false, false)]

    local procedure COD333_OnBeforeInitPurchOrderLineUpdateQuantity_ReqWeshMOrder(var PurchOrderLine: Record "Purchase Line"; var RequisitionLine: Record "Requisition Line"; var IsHandled: Boolean)
    var
        ReqLineTEMP: Record "Requisition Line";
        // Qty: Decimal;
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
    begin
        IsHandled := true;
        GlobalFunction.SetQty(RequisitionLine.Quantity);
        ReqLineTEMP.RESET();
        ReqLineTEMP.SETCURRENTKEY("Worksheet Template Name", "Journal Batch Name", Type, "No.", "Due Date");
        ReqLineTEMP.SETRANGE("Worksheet Template Name", RequisitionLine."Worksheet Template Name");
        ReqLineTEMP.SETRANGE("Journal Batch Name", RequisitionLine."Journal Batch Name");
        ReqLineTEMP.SETRANGE(Type, ReqLineTEMP.Type::Item);
        ReqLineTEMP.SETRANGE("No.", RequisitionLine."No.");
        ReqLineTEMP.SETRANGE("Location Code", RequisitionLine."Location Code");
        ReqLineTEMP.SETRANGE("DEL Requested Delivery Date", RequisitionLine."DEL Requested Delivery Date");
        ReqLineTEMP.SETFILTER("Line No.", '<>%1', RequisitionLine."Line No.");
        IF ReqLineTEMP.FIND('-') THEN
            REPEAT
                GlobalFunction.SetQty(GlobalFunction.GetQty() + ReqLineTEMP.Quantity);
            // Qty := Qty + ReqLineTEMP.Quantity;
            UNTIL ReqLineTEMP.NEXT() = 0;
        PurchOrderLine.Validate(Quantity, GlobalFunction.GetQty());
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnAfterCheckInsertFinalizePurchaseOrderHeader', '', false, false)]
    local procedure COD333_OnInsertPurchOrderLineOnAfterCheckInsertFinalizePurchOrderHeader_ReqWeshMOrder(var RequisitionLine: Record "Requisition Line"; var PurchaseHeader: Record "Purchase Header"; var NextLineNo: Integer)
    var
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";

    begin
        GlobalFunction.SetPrevLocationCode(RequisitionLine."Location Code");
        GlobalFunction.SetPrevReqDeliveryDate(RequisitionLine."DEL Requested Delivery Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnAfterTransferFromReqLineToPurchLine', '', false, false)]
    local procedure OnInsertPurchOrderLineOnAfterTransferFromReqLineToPurchLine(var PurchOrderLine: Record "Purchase Line"; RequisitionLine: Record "Requisition Line")
    var
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
    begin
        RequisitionLine.RESET;
        RequisitionLine.SETCURRENTKEY("Worksheet Template Name", "Journal Batch Name", Type, "No.", "Due Date");
        RequisitionLine.SETRANGE("Worksheet Template Name", RequisitionLine."Worksheet Template Name");
        RequisitionLine.SETRANGE("Journal Batch Name", RequisitionLine."Journal Batch Name");
        RequisitionLine.SETRANGE(Type, RequisitionLine.Type::Item);
        RequisitionLine.SETRANGE("No.", RequisitionLine."No.");
        RequisitionLine.SETRANGE("Location Code", RequisitionLine."Location Code");
        RequisitionLine.SETRANGE("DEL Requested Delivery Date", RequisitionLine."DEL Requested Delivery Date");
        RequisitionLine.SETFILTER("Line No.", '<>%1', RequisitionLine."Line No.");
        IF RequisitionLine.FIND('-') THEN BEGIN
            REPEAT
            // GlobalFunction.SetQty();
            //                 Qty := Qty + RequisitionLine.Quantity;
            UNTIL RequisitionLine.NEXT = 0;
        END;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInitPurchOrderLineOnAfterValidateLineDiscount', '', false, false)]
    local procedure COD333_OnInitPurchOrderLineOnAfterValidateLineDiscount_ReqWeshMOrder(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line")
    begin
        IF PurchOrderHeader."Expected Receipt Date" <> 0D THEN
            PurchOrderLine."Expected Receipt Date" := PurchOrderHeader."Expected Receipt Date"
        ELSE
            PurchOrderLine."Expected Receipt Date" := RequisitionLine."Due Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnInsertPurchOrderLineOnBeforeTransferReqLine', '', false, false)]
    //check line 535
    local procedure COD333_OnInsertPurchOrderLineOnBeforeTransferReqLine_ReqWeshMOrder(var PurchOrderHeader: Record "Purchase Header"; PurchOrderLine: Record "Purchase Line")
    var
        ItemReference: record "Item Reference";
        PurchasingCode: Record Purchasing;
    begin
        IF PurchasingCode.GET(PurchOrderLine."Purchasing Code") THEN
            IF PurchasingCode."Special Order" THEN BEGIN
                ItemReference.RESET();
                ItemReference.SETRANGE(ItemReference."Reference Type", ItemReference."Reference Type"::Customer);
                ItemReference.SETRANGE(ItemReference."Reference Type No.", PurchOrderHeader."Sell-to Customer No.");
                ItemReference.SETRANGE(ItemReference."Item No.", PurchOrderHeader."No.");
                IF ItemReference.FINDFIRST() THEN
                    PurchOrderLine."DEL External reference NGTS" := ItemReference."Reference No.";
            end
    end;

    //TODO:I suppose CommitIsSupressed say if the commit is suppressed (Skipped) during the posting


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnDeleteOnBeforePurchLineDeleteAll', '', false, false)]
    local procedure T39_OnDeleteOnBeforePurchLineDeleteAll_PurchaseLine(var PurchaseLine: Record "Purchase Line")
    var
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
        urm_Re_Loc: Record "DEL Update Request Manager";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        requestID_Co_Loc: Code[20];
    begin
        ACOConnection_Re_Loc.RESET();
        ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
        ACOConnection_Re_Loc.SETRANGE("ACO No.", PurchaseLine."Document No.");
        IF ACOConnection_Re_Loc.FIND('-') THEN BEGIN

            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
              ACOConnection_Re_Loc.Deal_ID,
              urm_Re_Loc.Requested_By_Type::"Purchase Header",
              PurchaseLine."Document No.",
              CURRENTDATETIME
            );

            urm_Re_Loc.GET(requestID_Co_Loc);
            UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc, FALSE, FALSE, TRUE);

            EXIT;
        END;
    end;
    ////
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeJobTaskIsSet', '', false, false)]
    local procedure T39_OnBeforeJobTaskIsSet_PurchaseLine(PurchLine: Record "Purchase Line"; var IsJobLine: Boolean)
    var
        Item_Rec: Record Item;
        ItemCrossReference: Record "Item Reference";
        SalesHeader_Rec: Record "Sales Header";
    begin
        PurchLine.Get();
        IF Item_Rec.GET(PurchLine."No.") THEN
            PurchLine.VALIDATE("DEL Total volume", (Item_Rec."DEL Vol cbm carton transport" * PurchLine.Quantity / Item_Rec."DEL PCB")
            );

        SalesHeader_Rec.SETRANGE("No.", PurchLine."Special Order Sales No.");
        SalesHeader_Rec.SETRANGE("Document Type", "Document Type"::Order);

        IF SalesHeader_Rec.FINDFIRST() THEN BEGIN
            ItemCrossReference.RESET();
            ItemCrossReference.SETRANGE(ItemCrossReference."Reference Type", ItemCrossReference."Reference Type"::Customer);
            ItemCrossReference.SETRANGE(ItemCrossReference."Reference Type No.", SalesHeader_Rec."Sell-to Customer No.");
            ItemCrossReference.SETRANGE(ItemCrossReference."Item No.", PurchLine."No.");
            IF ItemCrossReference.FINDFIRST() THEN
                PurchLine."DEL External reference NGTS" := ItemCrossReference."Reference No."
            ELSE
                PurchLine."DEL External reference NGTS" := '';
        END;
        IF PurchLine.Type = PurchLine.Type::Item THEN BEGIN
            IF PurchLine.ExistOldPurch(PurchLine."No.", PurchLine."Document No.") THEN
                PurchLine."DEL First Purch. Order" := TRUE;
            IF Item_Rec."DEL Risk Item" = TRUE THEN
                Item_Rec."DEL Risk Item" := TRUE
            ELSE
                Item_Rec."DEL Risk Item" := FALSE;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateLocationCodeOnBeforeSpecialOrderError', '', false, false)]
    local procedure T39_OnValidateLocationCodeOnBeforeSpecialOrderError_PurchaseLine(PurchaseLine: Record "Purchase Line"; var IsHandled: Boolean; CurrFieldNo: Integer)
    begin
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidatePlannedReceiptDateWithCustomCalendarChange', '', false, false)]
    // local procedure T39_OnBeforeValidatePlannedReceiptDateWithCustomCalendarChange_PurchaseLine(var PurchaseLine: Record "Purchase Line"; var xPurchaseLine: Record "Purchase Line"; var InHandled: Boolean);
    // var
    //     CalendarMgmt: Codeunit "Calendar Management";
    //     CalChange: Record "Customized Calendar Change";
    // begin
    //     // PurchaseLine.Validate(
    //     //     "Planned Receipt Date",
    //     //     CalendarMgmt.CalcDateBOC2(PurchaseLine.InternalLeadTimeDays(PurchaseLine."Expected Receipt Date"), PurchaseLine."Expected Receipt Date",
    //     //         CalChange."Source Type"::Location, PurchaseLine."Location Code", '',
    //     //         CalChange."Source Type"::Location, PurchaseLine."Location Code", '', FALSE));

    //     PurchaseLine.Validate(
    //         "Planned Receipt Date",
    //         CalendarMgmt.CalcDateBOC2(PurchaseLine.ReversedInternalLeadTimeDays(PurchaseLine."Expected Receipt Date"), PurchaseLine."Expected Receipt Date", CustomCalendarChange, false));

    //     IF NOT (xPurchaseLine."Expected Receipt Date" = PurchaseLine."Expected Receipt Date") THEN
    //         PurchaseLine.UpdateSalesEstimatedDelivery();
    // end;           TODO: check filed 10 : "Expected Receipt Date"


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnValidateQuantityOnAfterPlanPriceCalcByField', '', false, false)]
    local procedure T39_OnValidateQuantityOnAfterPlanPriceCalcByField_PurchaseLine(var PurchaseLine: Record "Purchase Line"; xPurchaseLine: Record "Purchase Line")
    var
        Item: Record Item; // TODO: check
        Item_Rec: Record Item;
    begin
        IF Item_Rec.GET(PurchaseLine."No.") THEN
            PurchaseLine.VALIDATE(PurchaseLine."DEL Total volume", (Item."DEL Vol cbm carton transport" * PurchaseLine.Quantity / Item."DEL PCB"));
    end;

    //COD 80
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure COD80_OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header";
     var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20];
      RetRcpHdrNo: Code[20];
      SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean;
      InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry";
       WhseShip: Boolean; WhseReceiv: Boolean)
    var
        Cust: Record Customer;
        MGTSEDIManagement: Codeunit "DEL MGTS EDI Management";
        Text50050: Label 'Do you want to export the invoice %2 from document No. %1 with EDI';

    begin
        IF SalesHeader.Invoice THEN BEGIN
            IF NOT Cust.GET(SalesHeader."Sell-to Customer No.") THEN
                Cust.INIT();

            IF Cust."DEL EDI" THEN
                IF CONFIRM(STRSUBSTNO(Text50050, SalesHeader."No.", SalesInvHdrNo)) THEN BEGIN
                    SalesHeader."DEL Export With EDI" := TRUE;
                    MGTSEDIManagement.GenerateSalesInvoiceEDIBuffer(SalesInvHdrNo, TRUE);
                END;
        END;

    end;
    //TODO COD80  // je n'ai pas trouvé un evenement qui appel la "SuppressCommit"
    // LOCAL PROCEDURE UpdateWhseDocuments();
    // BEGIN
    //   IF WhseReceive THEN BEGIN
    //     //MGTS0123; MHH; single
    //     WhsePostRcpt.SkipCUCommit(SkipCommit);
    //     WhsePostRcpt.PostUpdateWhseDocuments(WhseRcptHeader);
    //     TempWhseRcptHeader.DELETE;
    //   END;
    //   IF WhseShip THEN BEGIN
    //     //MGTS0123; MHH; single
    //     WhsePostShpt.SkipCUCommit(SkipCommit);
    //     WhsePostShpt.PostUpdateWhseDocuments(WhseShptHeader);
    //     TempWhseShptHeader.DELETE;
    //   END;
    // END;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertPostedHeaders', '', false, false)]
    local procedure COD80_OnAfterInsertPostedHeaders_SalesHeader(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHdr: Record "Sales Cr.Memo Header"; var ReceiptHeader: Record "Return Receipt Header")
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnAfterInsertPostedHeaders(SalesHeader, SalesShipmentHeader, SalesInvoiceHeader, SalesCrMemoHdr, ReceiptHeader);
    end;
    ////

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure COD80_OnBeforeDeleteAfterPosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SkipDelete: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line" temporary)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.ReverseProvisionEntries(SalesHeader);
    end;

    //CDU 81 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
    local procedure COD81_OnBeforeConfirmSalesPostFct_SalesHeader(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnBeforeConfirmSalesPostFct_SalesHeader(SalesHeader, HideDialog, IsHandled, DefaultOption, PostAndSend);
    end;
    ////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnAfterConfirmPost', '', false, false)]
    local procedure COD81_OnAfterConfirmPost(var SalesHeader: Record "Sales Header")
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnAfterConfirmPost(SalesHeader);
    end;
    ////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post (Yes/No)", 'OnConfirmPostOnBeforeSetSelection', '', false, false)]
    local procedure COD81_OnConfirmPostOnBeforeSetSelection(var SalesHeader: Record "Sales Header")
    var
        dealShipmentSelection_Re: Record "DEL Deal Shipment Selection";
        Deal_Cu: Codeunit "DEL Deal";
    begin
        IF (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) THEN
            Deal_Cu.FNC_Reinit_Deal(dealShipmentSelection_Re.Deal_ID, FALSE, FALSE);
    end;

    //----------CDU 82 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnBeforeConfirmPost', '', false, false)]
    local procedure COD82_OnBeforeConfirmPostFct(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var SendReportAsEmail: Boolean; var DefaultOption: Integer)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnBeforeConfirmPostFct_COD82(SalesHeader, HideDialog, IsHandled, SendReportAsEmail, DefaultOption);


    end;
    ///////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post + Print", 'OnAfterConfirmPost', '', false, false)]
    local procedure COD82_OnAfterConfirmPost(var SalesHeader: Record "Sales Header")
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        Deal_Cu: Codeunit "DEL Deal";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
        updateRequestID_Co_Loc: Code[20];

    begin
        // IF shipmentSelected_Bo_Loc THEN BEGIN
        IF GlobalFunction.GetshipmentSelected_Bo_Loc() THEN BEGIN
            Deal_Cu.FNC_Reinit_Deal(dealShipmentSelection_Re_Loc.Deal_ID, FALSE, FALSE);
            updateRequestManager_Cu.FNC_Validate_Request(updateRequestID_Co_Loc);
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", SalesHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            dealShipmentSelection_Re_Loc.DELETEALL();
        END;

    end;

    /////COD 333
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderLine', '', false, false)]

    local procedure OnAfterInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; var NextLineNo: Integer; var RequisitionLine: Record "Requisition Line"; var PurchOrderHeader: Record "Purchase Header")
    begin
        PurchOrderHeader.NTO_ReportPurchDim2SalesLines(PurchOrderHeader);
    end;
    ////COD 333 //TODO
    // local procedure OnBeforeInsertHeader(RequisitionLine: Record "Requisition Line"; PurchaseHeader: Record "Purchase Header"; var OrderDateReq: Date; var PostingDateReq: Date; var ReceiveDateReq: Date; var ReferenceReq: Text[35])
    // begin
    //     IF HideDialog THEN
    //         PurchaseHeader.SetHideValidationDialog(TRUE);
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderHeader', '', false, false)]

    local procedure OnAfterInsertPurchOrderHeader(var RequisitionLine: Record "Requisition Line"; var PurchaseOrderHeader: Record "Purchase Header"; CommitIsSuppressed: Boolean; SpecialOrder: Boolean)
    var

        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnAfterInsertPurchOrderHeaderFct(RequisitionLine, PurchaseOrderHeader, CommitIsSuppressed, SpecialOrder)
    end;


    //---------CDU 91
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPost', '', false, false)]
    local procedure COD91_OnBeforeConfirmPost_PurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnBeforeConfirmPostfct_PurchaseHeader(PurchaseHeader, HideDialog, IsHandled, DefaultOption);
    end;
    ////////
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnAfterPost', '', false, false)]
    local procedure COD91_OnAfterPost(var PurchaseHeader: Record "Purchase Header")
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        Deal_Cu: Codeunit "DEL Deal";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
    //updateRequestID_Co_Loc: Code[20];
    begin

        IF GlobalFunction.GetshipmentSelected_Bo_CDU90() THEN BEGIN
            Deal_Cu.FNC_Reinit_Deal(dealShipmentSelection_Re_Loc.Deal_ID, FALSE, FALSE);
            updateRequestManager_Cu.FNC_Validate_Request(GlobalFunction.GetupdateRequestID_Co_Loc());
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", PurchaseHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            dealShipmentSelection_Re_Loc.DELETEALL();
        END;
    end;
    ////////TODO CHECK
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeConfirmPostProcedure', '', false, false)]
    local procedure COD91_OnBeforeConfirmPostProcedure(var PurchaseHeader: Record "Purchase Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
        ConfirmManagement: Codeunit "Confirm Management";
        Deal_Cu: Codeunit "DEL Deal";
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
        PostConfirmQst: Label 'Do you want to post the %1?';

    begin
        IsHandled := true;
        if DefaultOption > 3 then
            DefaultOption := 3;
        if DefaultOption <= 0 then
            DefaultOption := 1;

        case PurchaseHeader."Document Type" of
            PurchaseHeader."Document Type"::Order:
                if not MGTSFactMgt.SelectPostOrderOption(PurchaseHeader, DefaultOption) then
                    exit; // when false 
            PurchaseHeader."Document Type"::"Return Order":
                if not MGTSFactMgt.SelectPostReturnOrderOption(PurchaseHeader, DefaultOption) then
                    exit; // when false 
            else
                if not ConfirmManagement.GetResponseOrDefault(
                     StrSubstNo(PostConfirmQst, Format(PurchaseHeader."Document Type")), true)
                then
                    exit;// when false 
        end;
        IF PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order THEN BEGIN
            ACOConnection_Re_Loc.RESET();
            ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
            ACOConnection_Re_Loc.SETRANGE("ACO No.", PurchaseHeader."No.");
            IF ACOConnection_Re_Loc.FindFirst() THEN
                Deal_Cu.FNC_Reinit_Deal(ACOConnection_Re_Loc.Deal_ID, FALSE, FALSE);
            PurchaseHeader."Print Posted Documents" := false;

        END;
    end;

    //TODO: the record is temporary "tempSpecialSHBuffer"///
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post (Yes/No)", 'OnBeforeRunPurchPost', '', false, false)]
    local procedure COD91_OnBeforeRunPurchPost(var PurchaseHeader: Record "Purchase Header")
    VAR
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
        PostPurchCU: Codeunit 90;
    begin
        //TODO 
        //MGTS0123; MHH; begin
        IF not GlobalFunction.GetSpecOrderPosting() THEN BEGIN
            CLEAR(PostPurchCU);
            GlobalFunction.SetSpecOrderPosting(TRUE);
            PostPurchCU.RUN(PurchaseHeader);
            //MGTS0123
            // PostPurchCU.GetSpecialOrderBuffer(tempSpecialSHBuffer);
        END;
    end;

    //----------CDU 92
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeConfirmPost', '', false, false)]

    local procedure COD92_OnBeforeConfirmPost(var PurchaseHeader: Record "Purchase Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer)
    var
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        MGTSFactMgt.OnBeforeConfirmPostfct_PurchaseHeader(PurchaseHeader, HideDialog, IsHandled, DefaultOption);

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnAfterPost', '', false, false)]

    local procedure COD92_OnAfterPost(var PurchaseHeader: Record "Purchase Header")
    var
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        Deal_Cu: Codeunit "DEL Deal";
        updateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        // shipmentSelected_Bo_Loc: Boolean;
        GlobalFunction: Codeunit "DEL MGTS Set/Get Functions";
        updateRequestID_Co_Loc: Code[20];
    begin
        IF GlobalFunction.GetshipmentSelected_Bo_Loc2() THEN BEGIN
            Deal_Cu.FNC_Reinit_Deal(dealShipmentSelection_Re_Loc.Deal_ID, FALSE, FALSE);
            updateRequestManager_Cu.FNC_Validate_Request(updateRequestID_Co_Loc);
            dealShipmentSelection_Re_Loc.RESET();
            dealShipmentSelection_Re_Loc.SETRANGE("Document No.", PurchaseHeader."No.");
            dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
            dealShipmentSelection_Re_Loc.DELETEALL();
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeConfirmPostProcedure', '', false, false)]

    local procedure COD92_OnBeforeConfirmPostProcedure(var PurchHeader: Record "Purchase Header"; var DefaultOption: Integer; var Result: Boolean; var IsHandled: Boolean)
    var
        ACOConnection_Re_Loc: Record "DEL ACO Connection";
        ConfirmManagement: Codeunit "Confirm Management";
        Deal_Cu: Codeunit "DEL Deal";
        MGTSFactMgt: Codeunit "DEL MGTS_FctMgt";
        PostAndPrintQst: Label 'Do you want to post and print the %1?';

    begin
        IsHandled := true;
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order:
                if not MGTSFactMgt.SelectPostOrderOption(PurchHeader, DefaultOption) then
                    exit; // when false 
            PurchHeader."Document Type"::"Return Order":
                if not MGTSFactMgt.SelectPostReturnOrderOption(PurchHeader, DefaultOption) then
                    exit; // when false 
            else
                if not ConfirmManagement.GetResponseOrDefault(
                     StrSubstNo(PostAndPrintQst, PurchHeader."Document Type"), true)
                then
                    exit; // when false 

                IF PurchHeader."Document Type" = PurchHeader."Document Type"::Order THEN BEGIN
                    ACOConnection_Re_Loc.RESET();
                    ACOConnection_Re_Loc.SETCURRENTKEY("ACO No.");
                    ACOConnection_Re_Loc.SETRANGE("ACO No.", PurchHeader."No.");
                    IF ACOConnection_Re_Loc.FindFirst() THEN
                        Deal_Cu.FNC_Reinit_Deal(ACOConnection_Re_Loc.Deal_ID, FALSE, FALSE);
                END;
        end;
    end;


    //TODO: les variables "tempSpecialSHBuffer" et "SpecOrderPost"sont globales.-----------------
    //TODO [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post + Print", 'OnBeforeRunPurchPost', '', false, false)]

    // local procedure COD92_OnBeforeRunPurchPost(var PurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    // var
    //     PostPurchCU: Codeunit "Purch.-Post + Print";
    // begin
    //     IF SpecOrderPost THEN BEGIN
    //         CLEAR(PostPurchCU);
    //         PostPurchCU.SetSpecOrderPosting(TRUE);
    //         PostPurchCU.RUN(PurchHeader);

    //         PostPurchCU.GetSpecialOrderBuffer(tempSpecialSHBuffer);


    //         GetReport(PurchHeader);

    //         PostPurchCU.GetSpecialOrderBuffer(lTempSHBuffer);
    //         IF lTempSHBuffer.FINDSET THEN
    //             REPEAT
    //                 lSalesPostPrint.GetReport(lTempSHBuffer);
    //             UNTIL lTempSHBuffer.NEXT = 0;


    //     end;

    ///// COD 90 : to be continued 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]

    local procedure COD90_OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean)
    begin

        //TODO IF SpecOrderPosting THEN BEGIN
        //     CLEARALL;
        //     SpecOrderPosting := TRUE;
        // END ELSE
        //     CLEARALL;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterCheckMandatoryFields', '', false, false)]
    local procedure COD90_OnAfterCheckMandatoryFields(var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean)
    begin
        //MGTS10.024; 003; mhh; begin //TODO: à vérifier l'Event
        IF PurchaseHeader.Invoice THEN
            PurchaseHeader.TESTFIELD("DEL Due Date Calculation");
        //MGTS10.024; 003; mhh; end
    end;
    //TODO: CHECK
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostCommitPurchaseDoc', '', false, false)]
    local procedure COD90_OnBeforePostCommitPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; ModifyHeader: Boolean; var CommitIsSupressed: Boolean; var TempPurchLineGlobal: Record "Purchase Line" temporary)
    var
        MGTSFctMgt: Codeunit "DEL MGTS_FctMgt";
    begin
        IF CommitIsSupressed THEN
            CommitIsSupressed := MGTSFctMgt.UpdateAssosSpecialOrderPostingNos(PurchaseHeader, PreviewMode)
        ELSE
            CommitIsSupressed := FALSE;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"GLN Calculator", 'OnBeforeIsValidCheckDigit', '', false, false)]
    procedure COD1607_OnBeforeIsValidCheckDigit(GLNValue: Code[20]; ExpectedSize: Integer; var IsValid: Boolean; var IsHandled: Boolean)
    var
        GLNCheckDigitErr: Label 'The GLN %1 is not valid.';
        GLNLengthErr: Label 'The GLN length should be %1 and not %2.';
    begin
        if GLNValue = '' then begin
            MESSAGE(GLNCheckDigitErr, GLNValue);
            IsValid := true;
            IsHandled := true;
        end else begin
            if StrLen(GLNValue) <> ExpectedSize then
                Error(GLNLengthErr, ExpectedSize, StrLen(GLNValue));

            if Format(StrCheckSum(CopyStr(GLNValue, 1, ExpectedSize - 1), '131313131313')) = Format(GLNValue[ExpectedSize]) then
                MESSAGE(GLNCheckDigitErr, GLNValue);
            IsValid := true;
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustVendBank-Update", 'OnAfterUpdateCustomer', '', false, false)]
    local procedure COD5055_OnAfterUpdateCustomer(var Customer: Record Customer; Contact: Record Contact; var ContBusRel: Record "Contact Business Relation")
    var
        CommentLine: Record "Comment Line";
        DocumentLine: Record "DEL Document Line";
        DocumentLine_Re: Record "DEL Document Line";
        NoteAuditSocial: Record "DEL Note Audit Social";
        NoteAuditSocial_Re: Record "DEL Note Audit Social";
        Var_recLink: Record "Record Link";
        Var_recLink2: Record "Record Link";
        RlshpMgtCommentLine: Record "Rlshp. Mgt. Comment Line";
        Vend: Record Vendor;
        Var_RecRef: RecordRef;
        Num_seq: Integer;
    begin
        NoteAuditSocial.RESET();
        NoteAuditSocial.SETRANGE(NoteAuditSocial.Type, NoteAuditSocial.Type::Contact);
        NoteAuditSocial.SETRANGE(NoteAuditSocial."Vendor/Contact No.", Contact."No.");
        IF NoteAuditSocial.FINDFIRST() THEN BEGIN
            REPEAT
                NoteAuditSocial_Re.INIT();
                NoteAuditSocial_Re."No." := NoteAuditSocial."No.";
                NoteAuditSocial_Re."Vendor/Contact No." := Vend."No.";
                NoteAuditSocial_Re.Type := NoteAuditSocial_Re.Type::Vendor;
                NoteAuditSocial_Re.Note := NoteAuditSocial.Note;
                NoteAuditSocial_Re.INSERT();
            UNTIL NoteAuditSocial.NEXT() = 0;
        END;

        DocumentLine.RESET();
        DocumentLine.SETRANGE(DocumentLine."Table Name", DocumentLine."Table Name"::Contact);
        DocumentLine.SETRANGE(DocumentLine."No.", Contact."No.");
        IF DocumentLine.FINDFIRST() THEN
            REPEAT
                DocumentLine_Re.INIT();
                DocumentLine_Re."Table Name" := DocumentLine_Re."Table Name"::Vendor;
                DocumentLine_Re."No." := Vend."No.";
                DocumentLine_Re."Comment Entry No." := DocumentLine."Comment Entry No.";
                DocumentLine_Re."Line No." := DocumentLine."Line No.";
                DocumentLine_Re."Insert Date" := DocumentLine."Insert Date";
                DocumentLine_Re."Insert Time" := DocumentLine."Insert Time";
                DocumentLine_Re."File Name" := DocumentLine."File Name";
                DocumentLine_Re.Path := DocumentLine.Path;
                DocumentLine_Re."User ID" := DocumentLine."User ID";
                DocumentLine_Re."Notation Type" := DocumentLine."Notation Type";
                DocumentLine_Re.Document := DocumentLine.Document;
                DocumentLine_Re.INSERT();
            UNTIL DocumentLine.NEXT() = 0;

        RlshpMgtCommentLine.RESET();
        RlshpMgtCommentLine.SETRANGE(RlshpMgtCommentLine."Table Name", RlshpMgtCommentLine."Table Name"::Contact);
        RlshpMgtCommentLine.SETRANGE(RlshpMgtCommentLine."No.", Contact."No.");
        IF RlshpMgtCommentLine.FINDFIRST() THEN
            REPEAT
                CommentLine.INIT();
                CommentLine."Table Name" := CommentLine."Table Name"::Vendor;
                CommentLine."No." := Vend."No.";
                CommentLine."Line No." := RlshpMgtCommentLine."Line No.";
                CommentLine.Date := RlshpMgtCommentLine.Date;
                CommentLine.Comment := RlshpMgtCommentLine.Comment;
                CommentLine.INSERT();
            UNTIL RlshpMgtCommentLine.NEXT() = 0;

        IF Var_recLink.FINDLAST() THEN
            Num_seq := Var_recLink."Link ID" + 1
        ELSE
            Num_seq := 1;

        Var_RecRef.GETTABLE(Contact);
        Var_recLink.RESET();
        Var_recLink.SETRANGE(Var_recLink."Record ID", Var_RecRef.RECORDID);

        IF Var_recLink.FINDFIRST() THEN BEGIN
            Var_RecRef.GETTABLE(Vend);
            REPEAT
                Var_recLink2.INIT();
                Var_recLink2."Link ID" := Num_seq;
                Var_recLink2."Record ID" := Var_RecRef.RECORDID;
                Var_recLink2.URL1 := Var_recLink.URL1;
                Var_recLink2.Description := Var_recLink.Description;
                Var_recLink2.Type := Var_recLink.Type;
                Var_recLink2.Note := Var_recLink.Note;
                Var_recLink2.Created := Var_recLink.Created;
                Var_recLink2."User ID" := Var_recLink."User ID";
                Var_recLink2.Company := Var_recLink.Company;
                Var_recLink2.Notify := Var_recLink.Notify;
                Var_recLink2."To User ID" := Var_recLink."To User ID";
                Var_recLink2.INSERT();
                Num_seq := Num_seq + 1;
            UNTIL Var_recLink.NEXT() = 0;
        END;
    end;
    //  Codeunit 7000
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnBeforeSalesLinePriceExists', '', false, false)]
    local procedure COD7000_OnBeforeSalesLinePriceExists(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var TempSalesPrice: Record "Sales Price" temporary; Currency: Record Currency; CurrencyFactor: Decimal; StartingDate: Date; Qty: Decimal; QtyPerUOM: Decimal; ShowAll: Boolean; var InHandled: Boolean)
    begin
        // SalesPriceCalcMgt.FindSalesPrice(
        //     TempSalesPrice,SalesLine."Bill-to Customer No.",SalesHeader."Bill-to Contact No.",
        //     SalesLine."Customer Price Group",SalesHeader."Campaign No.",
        //     SalesLine."No.",SalesLine."Variant Code",SalesLine."Unit of Measure Code",
        //     SalesHeader."Currency Code",SalesPriceCalcMgt.SalesHeaderStartDate(SalesHeader,DateCaption),ShowAll); TODO: variable global "DateCaption"
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"IC Outbox Export", 'OnBeforeRunOutboxTransactions', '', false, false)] TODO: procedure local
    // local procedure COD431_OnBeforeRunOutboxTransactions(var ICOutboxTransaction: Record "IC Outbox Transaction"; var IsHandled: Boolean)
    // var
    //     CopyICOutboxTransaction: Record "IC Outbox Transaction";
    //     CompanyInfo: Record "Company Information";
    //     TransitaireMgt: Codeunit "DEL TransitaireMgt";
    //     ICOutBoxTrans_Loc: Record "IC Outbox Transaction";
    //     ICOutBoxTrans: Record "IC Outbox Transaction";
    //     ICOutboxExport: Codeunit "IC Outbox Export";
    // begin
    //     CompanyInfo.Get();
    //     CopyICOutboxTransaction.Copy(ICOutboxTransaction);
    //     CopyICOutboxTransaction.SetRange("Line Action",
    //     CopyICOutboxTransaction."Line Action"::"Send to IC Partner");
    //         IF ICOutBoxTrans.FINDFIRST THEN
    //         REPEAT
    //         ICOutBoxTrans_Loc.SETRANGE(ICOutBoxTrans_Loc."Transaction No.",ICOutBoxTrans."Transaction No.");
    //         ICOutBoxTrans_Loc.SETRANGE(ICOutBoxTrans_Loc."IC Partner Code",ICOutBoxTrans."IC Partner Code");
    //         ICOutBoxTrans_Loc.SETRANGE(ICOutBoxTrans_Loc."Transaction Source",ICOutBoxTrans."Transaction Source");
    //         ICOutBoxTrans_Loc.SETRANGE(ICOutBoxTrans_Loc."Document Type",ICOutBoxTrans."Document Type");
    //         ICOutBoxTrans_Loc.SETRANGE(ICOutBoxTrans_Loc."Line Action","Line Action"::"Send to IC Partner");
    //         ICOutBoxTrans_Loc.SETRANGE(ICOutBoxTrans_Loc."Document No.",ICOutBoxTrans."Document No.");
    //         ICOutBoxTrans_Loc.FINDFIRST;
    //         ICOutboxExport.UpdateICStatus(ICOutBoxTrans_Loc);

    //         IF (ICOutBoxTrans_Loc."Source Type"::"Forwarding Document"= ICOutBoxTrans_Loc."Source Type") THEN BEGIN
    //           TransitaireMgt.SendToTransitairePartner(ICOutBoxTrans_Loc);
    //           ICOutboxExport.SendToExternalPartner(ICOutBoxTrans_Loc);
    //           SendToInternalPartner(ICOutBoxTrans_Loc);
    //         END ELSE BEGIN // LOCO
    //           SendToExternalPartner(ICOutBoxTrans_Loc);
    //           SendToInternalPartner(ICOutBoxTrans_Loc);
    //           ICOutBoxTrans_Loc.SETRANGE("Line Action","Line Action"::"Return to Inbox");
    //           ReturnToInbox(ICOutBoxTrans_Loc);
    //           CancelTrans(ICOutBoxTrans_Loc);
    //         END;
    //         UNTIL ICOutBoxTrans.NEXT=0;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnBeforeSendPurchDoc', '', false, false)]
    procedure OnBeforeSendPurchDoc(var PurchHeader: Record "Purchase Header"; var Post: Boolean; var IsHandled: Boolean)
    var
        ICOutboxTransaction_Rec: Record "IC Outbox Transaction";
        ICPartner: Record "IC Partner";
        PurchaseLine_Rec: Record "Purchase Line";
        MGTSFctMgt: Codeunit "DEL MGTS_FctMgt";
        ICInboxOutboxMgt: Codeunit ICInboxOutboxMgt;
        Qte: Decimal;
        Text002: Label 'You cannot send IC document because %1 %2 has %3 %4.';
    begin
        PurchHeader.TestField("Send IC Document");
        ICPartner.Get(PurchHeader."Buy-from IC Partner Code");
        if ICPartner."Inbox Type" = ICPartner."Inbox Type"::"No IC Transfer" then
            if Post then
                exit
            else
                Error(Text002, ICPartner.TableCaption, ICPartner.Code, ICPartner.FieldCaption("Inbox Type"), ICPartner."Inbox Type");

        ICPartner.TestField(Blocked, false);
        Qte := 0;
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document Type", PurchHeader."Document Type");
        PurchaseLine_Rec.SETRANGE("Document No.", PurchHeader."No.");
        PurchaseLine_Rec.SETFILTER(Type, '>0');
        IF PurchaseLine_Rec.FINDSET() THEN BEGIN
            REPEAT
                Qte := Qte + PurchaseLine_Rec.Quantity;
            UNTIL PurchaseLine_Rec.NEXT() = 0;
        END;

        MGTSFctMgt.CheckICPurchaseDocumentAlreadySent(PurchHeader);

        if not Post then
            IF Qte > 0 THEN
                CODEUNIT.Run(CODEUNIT::"Release Purchase Document", PurchHeader);
        ICInboxOutboxMgt.CreateOutboxPurchDocTrans(PurchHeader, false, Post);
        CLEAR(ICOutboxTransaction_Rec);
        ICOutboxTransaction_Rec.SETRANGE("Document Type", ICOutboxTransaction_Rec."Document Type"::Order);
        ICOutboxTransaction_Rec.SETRANGE("Document No.", PurchHeader."No.");
        IF ICOutboxTransaction_Rec.FINDFIRST() THEN BEGIN
            ICOutboxTransaction_Rec.VALIDATE("Line Action", ICOutboxTransaction_Rec."Line Action"::"Send to IC Partner");
            ICOutboxTransaction_Rec.MODIFY();
            MGTSFctMgt.SendTrans(ICOutboxTransaction_Rec);
        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnBeforeOpenSpecialPurchOrderForm', '', false, false)]
    local procedure P46_OnBeforeOpenSpecialPurchOrderForm_SalesOrderSubform(SalesOrderLine: Record "Sales Line"; var PageEditable: Boolean; var IsHandled: Boolean)
    begin
        PageEditable := true;
    end;

    //page ext 50030 
    //  [EventSubscriber(ObjectType::Codeunit, Codeunit::ReqJnlManagement, 'OnAfterGetDescriptionAndRcptName', '', false, false)]

    // local procedure OnAfterGetDescriptionAndRcptName(var ReqLine: Record "Requisition Line"; var Description: Text[100]; var BuyFromVendorName: Text[100]; var LastReqLine: Record "Requisition Line")
    // var
    //     ColoredPurchDueDate: Boolean; //TODO : a vérifier 
    // begin
    //     ColoredPurchDueDate := ReqLine."DEL Purchase Order Due Date" < TODAY;
    // end;

    [EventSubscriber(ObjectType::page, page::"Sales Invoice", 'OnPostOnAfterSetDocumentIsPosted', '', false, false)]
    local procedure P43_OnPostOnAfterSetDocumentIsPosted(SalesHeader: Record "Sales Header"; var IsScheduledPosting: Boolean; var DocumentIsPosted: Boolean)
    var
        NoSeries: Record 308;
        GLEntry: Record 17;
        Text50000: Label 'Please note that there is no related provision. Do you want to continue?;FRS=Attention il n''a pas de provision li‚e. Voulez-vous continuer ?';

    begin
        IF NOT NoSeries.GET(SalesHeader."No. Series") THEN
            NoSeries.INIT;

        IF NoSeries."DEL Check Entry For Reverse" THEN BEGIN
            GLEntry.RESET;
            GLEntry.SETRANGE("DEL Reverse With Doc. No.", SalesHeader."No.");
            IF NOT GLEntry.FINDSET THEN
                IF NOT CONFIRM(Text50000) THEN
                    EXIT;
        END;

    end;


}
