codeunit 50018 "Create Purch. EDI Launcher"
{
    // MGTSEDI10.00.00.23 | 21.05.2021 | EDI Management : Create codeunit


    trigger OnRun()
    begin
        //CASE Rec."Parameter String" OF
        //  'CREATEREQWORKSHEET':CreateReqWorkSheet;
        //  'CREATEPURCHDEAL':CreatePurchDeal;
        //END;

        CreateReqWorkSheet;
        CreatePurchDeal;
    end;

    var
        Param: Option " ",CreateAndValidateReqWorksheet,CreateDeal;

    local procedure CreateReqWorkSheet()
    var
        CreatePurchEDI: Codeunit "50019";
        SalesHeader: Record "36";
        TypeOrderEDI: Record "50079";
    begin
        SalesHeader.SETRANGE("To Create Purchase Order", TRUE);
        SalesHeader.SETRANGE("Error Purch. Order Create", FALSE);
        SalesHeader.SETRANGE("Has Spec. Purch. Order", FALSE);
        IF SalesHeader.FINDSET THEN
            REPEAT
                IF TypeOrderEDI.GET(SalesHeader."Type Order EDI") AND TypeOrderEDI."Automatic ACO" THEN BEGIN
                    CLEAR(CreatePurchEDI);
                    COMMIT;
                    CreatePurchEDI.SetParam(Param::CreateAndValidateReqWorksheet, SalesHeader."No.");
                    IF NOT CreatePurchEDI.RUN THEN BEGIN
                        SalesHeader."Status Purchase Order Create" := SalesHeader."Status Purchase Order Create"::"Create Req. Worksheet";
                        SalesHeader."Error Purch. Order Create" := TRUE;
                        SalesHeader."Error Text Purch. Order Create" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                        SalesHeader."To Create Purchase Order" := FALSE;
                        SalesHeader.MODIFY;
                    END;
                END
                ELSE BEGIN
                    SalesHeader."To Create Purchase Order" := FALSE;
                    SalesHeader.MODIFY;
                END;
            UNTIL SalesHeader.NEXT = 0;

    end;

    local procedure CreatePurchDeal()
    var
        CreatePurchEDI: Codeunit "50019";
        SalesHeader: Record "36";
    begin
        SalesHeader.SETRANGE("Status Purchase Order Create", SalesHeader."Status Purchase Order Create"::"Create Deal");
        IF SalesHeader.FINDSET THEN
            REPEAT
                CLEAR(CreatePurchEDI);
                COMMIT;
                CreatePurchEDI.SetParam(Param::CreateDeal, SalesHeader."No.");
                IF NOT CreatePurchEDI.RUN THEN BEGIN
                    SalesHeader."Status Purchase Order Create" := SalesHeader."Status Purchase Order Create"::"Create Deal";
                    SalesHeader."Error Purch. Order Create" := TRUE;
                    SalesHeader."Error Text Purch. Order Create" := COPYSTR(GETLASTERRORTEXT, 1, 250);
                    SalesHeader.MODIFY;
                END ELSE BEGIN
                    SalesHeader."Status Purchase Order Create" := SalesHeader."Status Purchase Order Create"::Created;
                    SalesHeader."Error Text Purch. Order Create" := '';
                    SalesHeader.MODIFY;
                END;
            UNTIL SalesHeader.NEXT = 0;
    end;
}

