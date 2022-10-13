report 50000 CreateSalesOrderFromWeb
{
    // NTO    15.08.05/LOCO/WIC- Ajout gestion affichage et appel du "request FORM"
    // NTO 2  06.02.07/LOCO/HAZ- Ajout une if
    // NTO 3  21.09.09/LOCO/MIK- CR (Change Request) Ne plus tenir compte de la condition "IF CampaignCode <>'')
    //                           et appliquer les mêmes critères d'extraction pour tous les articles
    //                           (ayant une campagne ou pas)

    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem2686; Table50003)
        {
            DataItemTableView = SORTING (Contact);
            RequestFilterFields = Item, Contact;

            trigger OnAfterGetRecord()
            begin
                // saute les commandes déjà transférées
                IF Web_Order_Line.OrderCreated THEN
                    CurrReport.SKIP;

                // Saute les articles dont "date commande" n'est pas encore atteinte
                TempDate := 0D;

                // NTO 3 - BEGIN
                /*
                IF (CampaignCode <> '')  THEN BEGIN
                */
                // NTO 3 - END

                IF EVALUATE(TempDate, Max_Date) THEN BEGIN
                    IF (TempDate > CALCDATE('<-1D>', TODAY)) OR
                      (TempDate < CALCDATE('<-3M>', TODAY)) THEN BEGIN
                        CurrReport.SKIP;
                    END;     //haz
                END ELSE BEGIN
                    MESSAGE('False Max_date: %1', Web_Order_Line.Max_Date);
                END;


                // NTO 3 - BEGIN
                /*
                END ELSE BEGIN //haz
                  //MESSAGE('campaing code leer');
                  Art.GET(Item);
                  IF (Art."Date prochaine commande" > CALCDATE('<-1D>',TODAY) ) OR
                    (Art."Date prochaine commande" < CALCDATE('<-3M>',TODAY))
                  THEN BEGIN
                    CurrReport.SKIP;
                  END;
                END; //haz
                */
                // NTO 3 - END

                IF GUIALLOWED THEN BEGIN
                    i := i + 1;
                    d.UPDATE(1, i);
                END;


                IF ActualContact <> Contact THEN BEGIN
                    ActualContact := Contact;
                    NextLineNo := 0;
                    SH.RESET;
                    SH.INIT;
                    SH."Document Type" := SH."Document Type"::Order;
                    SH."No." := '';
                    SH.INSERT(TRUE);
                    SH.VALIDATE("Sell-to Contact No.", Contact);
                    SH.VALIDATE("Posting Date", TODAY);
                    SH.MODIFY(TRUE);
                END;

                SL.INIT;
                NextLineNo := NextLineNo + 10000;
                SL."Document Type" := SL."Document Type"::Order;
                SL."Document No." := SH."No.";
                SL."Line No." := NextLineNo;
                SL."Sell-to Customer No." := SH."Sell-to Customer No.";
                SL.Type := SL.Type::Item;
                SL.VALIDATE("No.", Item);
                SL."Campaign Code" := Web_Order_Line.CampaignCode;
                //old SL.VALIDATE(Quantity,Web_Order_Line.Qty);
                SL.VALIDATE(Quantity, Web_Order_Line.Qty_Commande);
                SL.VALIDATE("Unit Price", Web_Order_Line.Price);
                SL."Customer line reference2" := End_Customer;
                SL."Qty. Init. Client" := Web_Order_Line.Qty;
                IF Web_Order_Line.CampaignCode <> '' THEN BEGIN
                    SH."Campaign No." := Web_Order_Line.CampaignCode;
                    SH.MODIFY(TRUE);
                END;
                SL.INSERT(TRUE);

                DateOrderCreated := TODAY;
                OrderCreated := TRUE;
                "Invoice No" := SH."No.";
                MODIFY;

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
        SH: Record "36";
        SL: Record "37";
        Art: Record "27";
        ActualContact: Code[10];
        NextLineNo: Integer;
        TXT_001: Label 'Task running #1###';
        d: Dialog;
        i: Integer;
        TempDate: Date;

    [Scope('Internal')]
    procedure UpdateDate()
    var
        m_WOL: Record "50003";
    begin
        m_WOL.SETRANGE(OrderCreated, FALSE);

        IF m_WOL.FIND('-') THEN
            REPEAT
                IF (m_WOL.Date_Date = 0D) OR (m_WOL.Date_Date < 01011920D) THEN BEGIN
                    EVALUATE(m_WOL.Date_Date, m_WOL.Date);
                    m_WOL.MODIFY(TRUE);
                END;

            UNTIL m_WOL.NEXT = 0;
        COMMIT;
    end;
}

