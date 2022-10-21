report 50000 "DEL CreateSalesOrderFromWeb"
{

    ProcessingOnly = true;

    dataset
    {
        dataitem(Web_Order_Line; "DEL Web_Order_Line")
        {
            DataItemTableView = SORTING(Contact);
            RequestFilterFields = Item, Contact;

            trigger OnAfterGetRecord()
            begin
                IF Web_Order_Line.OrderCreated THEN
                    CurrReport.SKIP();
                TempDate := 0D;
                IF EVALUATE(TempDate, Max_Date) THEN BEGIN
                    IF (TempDate > CALCDATE('<-1D>', TODAY)) OR
                      (TempDate < CALCDATE('<-3M>', TODAY)) THEN
                        CurrReport.SKIP();
                END ELSE
                    MESSAGE('False Max_date: %1', Web_Order_Line.Max_Date);
                IF GUIALLOWED THEN BEGIN
                    i := i + 1;
                    d.UPDATE(1, i);
                END;


                IF ActualContact <> Contact THEN BEGIN
                    ActualContact := Contact;
                    NextLineNo := 0;
                    SH.RESET();
                    SH.INIT();
                    SH."Document Type" := SH."Document Type"::Order;
                    SH."No." := '';
                    SH.INSERT(TRUE);
                    SH.VALIDATE("Sell-to Contact No.", Contact);
                    SH.VALIDATE("Posting Date", TODAY);
                    SH.MODIFY(TRUE);
                END;

                SL.INIT();
                NextLineNo := NextLineNo + 10000;
                SL."Document Type" := SL."Document Type"::Order;
                SL."Document No." := SH."No.";
                SL."Line No." := NextLineNo;
                SL."Sell-to Customer No." := SH."Sell-to Customer No.";
                SL.Type := SL.Type::Item;
                SL.VALIDATE("No.", Item);
                SL."DEL Campaign Code" := Web_Order_Line.CampaignCode;
                SL.VALIDATE(Quantity, Web_Order_Line.Qty_Commande);
                SL.VALIDATE("Unit Price", Web_Order_Line.Price);
                SL."DEL Customer line reference2" := End_Customer;
                SL."DEL Qty. Init. Client" := Web_Order_Line.Qty;
                IF Web_Order_Line.CampaignCode <> '' THEN BEGIN
                    SH."Campaign No." := Web_Order_Line.CampaignCode;
                    SH.MODIFY(TRUE);
                END;
                SL.INSERT(TRUE);

                DateOrderCreated := TODAY;
                OrderCreated := TRUE;
                "Invoice No" := SH."No.";
                MODIFY();

            end;

            trigger OnPreDataItem()
            begin
                NextLineNo := 0;
                ActualContact := '';

                IF GUIALLOWED THEN
                    d.OPEN(TXT_001);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        IF GUIALLOWED THEN
            d.CLOSE();
    end;

    trigger OnPreReport()
    begin
        UpdateDate();
    end;

    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        ActualContact: Code[20];
        TempDate: Date;
        d: Dialog;
        i: Integer;
        NextLineNo: Integer;
        TXT_001: Label 'Task running #1###';


    procedure UpdateDate()
    var
        m_WOL: Record "DEL Web_Order_Line";
    begin
        m_WOL.SETRANGE(OrderCreated, FALSE);

        IF m_WOL.FIND('-') THEN
            REPEAT
                IF (m_WOL.Date_Date = 0D) OR (m_WOL.Date_Date < 20101120D) THEN BEGIN
                    //TODO: verify the date 01 01 19 20D 
                    EVALUATE(m_WOL.Date_Date, m_WOL.Date);
                    m_WOL.MODIFY(TRUE);
                END;

            UNTIL m_WOL.NEXT() = 0;
        COMMIT();
    end;
}

