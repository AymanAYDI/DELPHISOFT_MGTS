codeunit 50099 "TEMP TOOLS 2"
{
    Permissions = TableData 112 = rimd;

    trigger OnRun()
    var
        SalesInvoiceHeader: Record "112";
        OrderAPIRecordTracking: Record "50074";
        PurchaseHeader: Record "38";
        PurchaseHeader2: Record "38";
        JSONRequestslog: Record "50073";
    begin
        //SalesInvoiceHeader.GET('0555691');
        //SalesInvoiceHeader."Order No." := 'VCO22607';
        //SalesInvoiceHeader.MODIFY;
        /*
        OrderAPIRecordTracking.SETRANGE("ACO Date",0D);
        OrderAPIRecordTracking.MODIFYALL("Sent Deal",TRUE);
        PurchaseHeader.SETRANGE("Order Date",0D);
        IF  NOT PurchaseHeader.ISEMPTY THEN
        BEGIN
          PurchaseHeader.FINDSET;
          REPEAT
            PurchaseHeader2.GET(PurchaseHeader."Document Type",PurchaseHeader."No.");
            PurchaseHeader2."Order Date" := PurchaseHeader2."Posting Date";
            PurchaseHeader2.MODIFY;
          UNTIL PurchaseHeader.NEXT = 0 ;
        END;
        */
        JSONRequestslog.SETRANGE(Error, TRUE);

        MESSAGE('%1', JSONRequestslog.COUNT);

    end;
}

