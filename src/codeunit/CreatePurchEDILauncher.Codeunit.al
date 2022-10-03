codeunit 50018 "DEL Create Purch. EDI Launcher"
{
    trigger OnRun()
    begin
        //CASE Rec."Parameter String" OF
        //  'CREATEREQWORKSHEET':CreateReqWorkSheet;
        //  'CREATEPURCHDEAL':CreatePurchDeal;
        //END;

        CreateReqWorkSheet();
        CreatePurchDeal();
    end;

    var
        Param: Option " ",CreateAndValidateReqWorksheet,CreateDeal;

    local procedure CreateReqWorkSheet()
    var
        SalesHeader: Record "Sales Header";
        TypeOrderEDI: Record "DEL Type Order EDI";
        CreatePurchEDI: Codeunit "DEL Create Purch. EDI";
    begin
        SalesHeader.SETRANGE("DEL To Create Purchase Order", TRUE);
        SalesHeader.SETRANGE("DEL Error Purch. Order Create", FALSE);
        SalesHeader.SETRANGE("DEL Has Spec. Purch. Order", FALSE);
        IF SalesHeader.FINDSET() THEN
            REPEAT
                IF TypeOrderEDI.GET(SalesHeader."DEL Type Order EDI") AND TypeOrderEDI."Automatic ACO" THEN BEGIN
                    CLEAR(CreatePurchEDI);
                    COMMIT();
                    CreatePurchEDI.SetParam(Param::CreateAndValidateReqWorksheet, SalesHeader."No.");
                    IF NOT CreatePurchEDI.RUN() THEN BEGIN
                        SalesHeader."Status Purchase Order Create" := SalesHeader."Status Purchase Order Create"::"Create Req. Worksheet";
                        SalesHeader."DEL Error Purch. Order Create" := TRUE;
                        SalesHeader."DEL Error Text Purch. Order Create" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                        SalesHeader."DEL To Create Purchase Order" := FALSE;
                        SalesHeader.MODIFY();
                    END;
                END
                ELSE BEGIN
                    SalesHeader."DEL To Create Purchase Order" := FALSE;
                    SalesHeader.MODIFY();
                END;
            UNTIL SalesHeader.NEXT() = 0;

    end;

    local procedure CreatePurchDeal()
    var
        SalesHeader: Record "Sales Header";
        CreatePurchEDI: Codeunit "DEL Create Purch. EDI";
    begin
        SalesHeader.SETRANGE("Status Purchase Order Create", SalesHeader."Status Purchase Order Create"::"Create Deal");
        IF SalesHeader.FINDSET() THEN
            REPEAT
                CLEAR(CreatePurchEDI);
                COMMIT();
                CreatePurchEDI.SetParam(Param::CreateDeal, SalesHeader."No.");
                IF NOT CreatePurchEDI.RUN() THEN BEGIN
                    SalesHeader."Status Purchase Order Create" := SalesHeader."Status Purchase Order Create"::"Create Deal";
                    SalesHeader."DEL Error Purch. Order Create" := TRUE;
                    SalesHeader."DEL Error Text Purch. Order Create" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                    SalesHeader.MODIFY();
                END ELSE BEGIN
                    SalesHeader."Status Purchase Order Create" := SalesHeader."Status Purchase Order Create"::Created;
                    SalesHeader."DEL Error Text Purch. Order Create" := '';
                    SalesHeader.MODIFY();
                END;
            UNTIL SalesHeader.NEXT() = 0;
    end;
}

