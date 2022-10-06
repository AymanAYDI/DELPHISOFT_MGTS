codeunit 50100 "DEL MGTS_EventsMgt"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure T18_OnAfterModifyEvent_Customer(var Rec: Record Customer; RunTrigger: Boolean)

    begin
        if not RunTrigger then //if (Runtrigger = false) then exit
            exit;
        if Rec.IsTemporary then
            exit;
        IF Rec."DEL Last Accounting Date" <> 0D THEN BEGIN
            //START T-00738
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
            //STOP T-00738
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

    [EventSubscriber(ObjectType::Table, database::Item, 'OnTryGetItemNoOpenCardWithViewOnBeforeShowCreateItemOption', '', false, false)]
    local procedure OnTryGetItemNoOpenCardWithViewOnBeforeShowCreateItemOption(var Item: Record Item)
    var
        FoundRecordCount: Integer;
        SelectItemErr: Label 'You must select an existing item.';
    begin

        IF FoundRecordCount = 0 THEN
            ERROR(SelectItemErr);

    end;
    

}
