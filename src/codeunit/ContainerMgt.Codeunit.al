codeunit 50060 "DEL Container Mgt"
{

    TableNo = "DEL Container List";

    trigger OnRun()
    begin
        RunCode(Rec);
    end;

    var
        OrderNotExist: Label 'Order No. %1 not exist.';
        ItemNotExist: Label 'Item No. %1 not exist.';
        QtyToReceive: Label 'You cannot receive more than %1 units.';
        NothingToPostErr: Label 'There is nothing to post.';
        Confirmed: Boolean;
        ConfirmQst: Label 'Do you want to post the container list ?';
        HideValidationDialog: Boolean;
        PostProgress: Label 'Container #1####\\Order     #2####\\';
        DealShipmentErr: Label 'Il faut choisir exactement 1 livraison liée pour la commande %1 !';
        ConfirmInvQst: Label 'Do you want to invoice the container list ?';
        DocumentType: Option Invoice,"Purchase Header","Sales Header","Sales Cr. Memo","Purch. Cr. Memo",Payment,"Purchase Invoice Header","Sales Invoice Header",Provision;

    procedure CheckContainerLine(var ContainerLine: Record "DEL Container List")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        ContainerLine.Warnning := '';
        IF NOT PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, ContainerLine."Order No.") THEN
            ContainerLine.Warnning := STRSUBSTNO(OrderNotExist, ContainerLine."Order No.");

        IF ContainerLine.Warnning = '' THEN BEGIN
            PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
            PurchaseLine.SETRANGE("Document No.", ContainerLine."Order No.");
            PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
            PurchaseLine.SETRANGE("No.", ContainerLine."Item No.");
            IF NOT PurchaseLine.FINDFIRST THEN
                ContainerLine.Warnning := STRSUBSTNO(ItemNotExist, ContainerLine."Item No.")
            ELSE BEGIN
                IF (((ContainerLine.Pieces < 0) XOR (PurchaseLine.Quantity < 0)) AND (PurchaseLine.Quantity <> 0) AND (ContainerLine.Pieces <> 0)) OR
               (ABS(ContainerLine.Pieces) > ABS(PurchaseLine."Outstanding Quantity")) OR
               (((PurchaseLine.Quantity < 0) XOR (PurchaseLine."Outstanding Quantity" < 0)) AND (PurchaseLine.Quantity <> 0) AND (PurchaseLine."Outstanding Quantity" <> 0)) THEN
                    ContainerLine.Warnning := STRSUBSTNO(QtyToReceive, PurchaseLine."Outstanding Quantity");
            END;
        END;

        IF ContainerLine.Warnning <> '' THEN
            ContainerLine.MODIFY;
    end;

    local procedure RunCode(var _ContainerLine: Record "DEL Container List")
    var
        ContainerLine: Record "DEL Container List";
        ContainerLevel1: Record "DEL Container List";
        Window: Dialog;
        TotalDoc: Integer;
        DocNumber: Integer;
        IsToPost: Boolean;
    begin
        IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
        ELSE
            Confirmed := CONFIRM(ConfirmQst, FALSE);
        IF NOT Confirmed THEN
            EXIT;

        ContainerLine.COPY(_ContainerLine);
        IF ContainerLine.ISEMPTY THEN
            ERROR(NothingToPostErr);

        //Vérification des quantités restantes à réceptionner et les Quantités restantes à expédier

        ContainerLevel1.COPY(_ContainerLine);
        ContainerLevel1.SETRANGE(Level, 1);
        IF NOT ContainerLevel1.ISEMPTY THEN BEGIN
            IF GUIALLOWED THEN
                Window.OPEN(PostProgress + '@3@@@@@@@@@@@@@@@@@@@@@@@@@\');
            TotalDoc := ContainerLevel1.COUNT;
            ContainerLevel1.FINDSET;
            REPEAT
                DocNumber += 1;
                IF GUIALLOWED THEN BEGIN
                    Window.UPDATE(1, ContainerLevel1."Container No.");
                    Window.UPDATE(2, ContainerLevel1."Order No.");
                    Window.UPDATE(3, ROUND(DocNumber / TotalDoc * 10000, 1));
                END;
                //Initialiser les quantités à réceptionner et les Quantités à expédier
                InitPurchaseAndSalesQuantities(ContainerLevel1);

                //Mettre à jour les champs container et les quantités à réceptionner
                IsToPost := FillPurchaseAndSalesFields(ContainerLevel1);

                //Réceptionner et facturer les achats. - Expédier les ventes
                IF IsToPost THEN
                    PostPurchaseAndSalesOrder(ContainerLevel1."Order No.");

                //Archive liste des conteneurs
                ArchivePostedContainerList(ContainerLevel1."Container No.", ContainerLevel1."Order No.", IsToPost);
            UNTIL ContainerLevel1.NEXT = 0;
            IF GUIALLOWED THEN
                Window.CLOSE;
        END;

        _ContainerLine := ContainerLine;
    end;

    local procedure InitPurchaseAndSalesQuantities(var _ContainerLine: Record "DEL Container List")
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        NewSpecialOrder: Boolean;
    begin
        IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, _ContainerLine."Order No.") THEN BEGIN
            NewSpecialOrder := TRUE;
            PurchaseLine.SETRANGE("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SETRANGE("Document No.", PurchaseHeader."No.");
            PurchaseLine.SETFILTER(Type, '>0');
            IF NOT PurchaseLine.ISEMPTY THEN BEGIN
                PurchaseLine.FINDSET;
                REPEAT
                    PurchaseLine.VALIDATE("Qty. to Receive", 0);
                    PurchaseLine.VALIDATE("Qty. to Invoice", 0);
                    PurchaseLine.MODIFY;
                    IF (PurchaseLine."Special Order Sales No." <> '') AND NewSpecialOrder THEN BEGIN
                        InitSpecialSalesOrderQuantities(PurchaseLine."Special Order Sales No.", FALSE);
                        NewSpecialOrder := FALSE;
                    END;
                UNTIL PurchaseLine.NEXT = 0;
            END;
        END;
    end;

    local procedure InitSpecialSalesOrderQuantities(_SpecialOrderNo: Code[20]; OnlyQtyToInv: Boolean)
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        IF SalesHeader.GET(SalesHeader."Document Type"::Order, _SpecialOrderNo) THEN BEGIN
            SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
            SalesLine.SETRANGE("Document No.", SalesHeader."No.");
            SalesLine.SETFILTER(Type, '>0');
            IF NOT SalesLine.ISEMPTY THEN BEGIN
                SalesLine.FINDSET;
                REPEAT
                    IF NOT OnlyQtyToInv THEN
                        SalesLine.VALIDATE("Qty. to Ship", 0);
                    SalesLine.VALIDATE("Qty. to Invoice", 0);
                    SalesLine.MODIFY;
                UNTIL SalesLine.NEXT = 0;
            END;
        END;
    end;

    local procedure FillPurchaseAndSalesFields(var _ContainerLine: Record "DEL Container List") IsToPost: Boolean
    var
        ContainerLevel2: Record "DEL Container List";
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        ContainerLevel2.SETRANGE("Container No.", _ContainerLine."Container No.");
        ContainerLevel2.SETRANGE("Order No.", _ContainerLine."Order No.");
        ContainerLevel2.SETRANGE(Level, 2);
        IF NOT ContainerLevel2.ISEMPTY THEN BEGIN
            ContainerLevel2.FINDSET;
            REPEAT
                IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, ContainerLevel2."Order No.") THEN BEGIN
                    //TODO PurchaseHeader."DEL Container No." := ContainerLevel2."Container No.";
                    PurchaseHeader.MODIFY;

                    IF PurchaseLine.GET(PurchaseHeader."Document Type", PurchaseHeader."No.", ContainerLevel2."Order Line No.") THEN BEGIN
                        IF (ABS(ContainerLevel2.Pieces) <= ABS(PurchaseLine."Outstanding Quantity")) THEN BEGIN
                            PurchaseLine.VALIDATE("Qty. to Receive", ContainerLevel2.Pieces);
                            PurchaseLine.MODIFY(TRUE);
                            IsToPost := TRUE;
                        END;

                        IF (PurchaseLine."Special Order Sales No." <> '') AND (PurchaseLine."Special Order Sales Line No." <> 0) THEN
                            IF SalesHeader.GET(SalesHeader."Document Type"::Order, PurchaseLine."Special Order Sales No.") THEN BEGIN
                                //TODO  SalesHeader."DEL Container No." := ContainerLevel2."Container No.";
                                SalesHeader.MODIFY;

                                IF SalesLine.GET(SalesLine."Document Type"::Order, PurchaseLine."Special Order Sales No.", PurchaseLine."Special Order Sales Line No.") THEN
                                    IF (ABS(ContainerLevel2.Pieces) <= ABS(SalesLine."Outstanding Quantity")) THEN BEGIN
                                        SalesLine.VALIDATE("Qty. to Ship", ContainerLevel2.Pieces);
                                        SalesLine.MODIFY(TRUE);
                                    END;
                            END;
                    END;
                END;
            UNTIL ContainerLevel2.NEXT = 0;
        END;
    end;

    procedure SetHideValidationDialog(NewHideValidationDialog: Boolean)
    begin
        HideValidationDialog := NewHideValidationDialog;
    end;

    local procedure PostPurchaseAndSalesOrder(_OrderNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        DealShipmentSelection: Record "DEL Deal Shipment Selection";
        UpdateRequestID: Code[20];
        UpdateRequestManager: Codeunit "DEL Update Request Manager";
        ShipmentSelected: Boolean;
        Deal: Codeunit "DEL Deal";
        ACOConnection: Record "DEL ACO Connection";
        PurchPost: Codeunit "Purch.-Post";
        FctMgt: Codeunit "DEL MGTS_FctMgt";
        GetSetCDU: Codeunit "DEL MGTS Set/Get Functions";
    begin
        PurchaseHeader.SETRANGE("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.SETRANGE("No.", _OrderNo);
        IF NOT PurchaseHeader.FINDFIRST THEN
            EXIT;

        DealShipmentSelection.RESET();
        DealShipmentSelection.SETRANGE("Document No.", PurchaseHeader."No.");
        DealShipmentSelection.SETRANGE(Checked, TRUE);
        DealShipmentSelection.SETRANGE(USER_ID, USERID);
        IF DealShipmentSelection.FINDFIRST THEN
            ShipmentSelected := TRUE
        ELSE BEGIN
            ShipmentSelected := GetDealLinkedShipment(PurchaseHeader."No.", DocumentType::"Purchase Header", DealShipmentSelection);
            IF NOT ShipmentSelected THEN
                ERROR(DealShipmentErr, PurchaseHeader."No.");
        END;

        IF ShipmentSelected THEN BEGIN
            //pour les commandes il faut exactement 1 livraison liée
            IF DealShipmentSelection.COUNT() > 1 THEN
                ERROR(DealShipmentErr, PurchaseHeader."No.");

            //On crée une updateRequest, comme ca, si NAV plante plus loin, on sait ce qui n'a pas été updaté comme il faut
            UpdateRequestID := UpdateRequestManager.FNC_Add_Request(
              DealShipmentSelection.Deal_ID,
              DealShipmentSelection."Document Type",
              DealShipmentSelection."Document No.",
              CURRENTDATETIME);
        END;

        PurchaseHeader.Receive := TRUE;
        PurchaseHeader.Invoice := TRUE;
        PurchaseHeader."Print Posted Documents" := FALSE;

        ACOConnection.RESET();
        ACOConnection.SETCURRENTKEY("ACO No.");
        ACOConnection.SETRANGE("ACO No.", PurchaseHeader."No.");
        IF ACOConnection.FIND('-') THEN
            Deal.FNC_Reinit_Deal(ACOConnection.Deal_ID, FALSE, TRUE);

        CLEAR(PurchPost);
        FctMgt.SetSpecOrderPosting(TRUE);
        GetSetCDU.SetNotInvoiceSpecOrderPosting(TRUE);
        PurchPost.RUN(PurchaseHeader);

        IF ShipmentSelected THEN BEGIN
            //La facture a été associée à une et une seule livraison et donc, on réinitialise l'affaire qui appartient à cette livraison
            Deal.FNC_Reinit_Deal(DealShipmentSelection.Deal_ID, FALSE, TRUE);

            //Le deal a été réinitialisé, on peut valider l'updateRequest
            UpdateRequestManager.FNC_Validate_Request(UpdateRequestID);

            //On vide la table Deal Shipment Selection pour qu'elle soit mise à jour lors de la prochaine ouverture..
            DealShipmentSelection.RESET();
            DealShipmentSelection.SETRANGE("Document No.", PurchaseHeader."No.");
            DealShipmentSelection.SETRANGE(USER_ID, USERID);
            DealShipmentSelection.DELETEALL();
        END;
    end;

    local procedure ArchivePostedContainerList(ContainerNo: Code[20]; OrderNo: Code[20]; UpdatePost: Boolean): Boolean
    var
        ContainerList: Record "DEL Container List";
        PostedContainerList: Record "DEL Posted Container List";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        PurchaseHeaderArchive: Record "Purchase Header Archive";
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        ContainerList.SETCURRENTKEY("Container No.", "Order No.");
        ContainerList.SETRANGE("Container No.", ContainerNo);
        ContainerList.SETRANGE("Order No.", OrderNo);
        IF NOT ContainerList.ISEMPTY THEN BEGIN
            ContainerList.FINDSET;
            REPEAT
                PostedContainerList.INIT;
                PostedContainerList.TRANSFERFIELDS(ContainerList);
                IF (ContainerList.Level = 2) AND UpdatePost THEN BEGIN
                    IF PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, OrderNo) THEN BEGIN
                        PostedContainerList."Receipt No." := PurchaseHeader."Last Receiving No.";
                        PostedContainerList."Purchase Invoice No." := PurchaseHeader."Last Posting No.";
                    END
                    ELSE BEGIN
                        PurchaseHeaderArchive.SETRANGE("Document Type", PurchaseHeaderArchive."Document Type"::Order);
                        PurchaseHeaderArchive.SETRANGE("No.", OrderNo);
                        IF PurchaseHeaderArchive.FINDLAST THEN BEGIN
                            PostedContainerList."Receipt No." := PurchaseHeaderArchive."Last Receiving No.";
                            PostedContainerList."Purchase Invoice No." := PurchaseHeaderArchive."Last Posting No.";
                        END;
                    END;

                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, ContainerList."Special Order Sales No.") THEN BEGIN
                        PostedContainerList."Shipment No." := SalesHeader."Last Shipping No.";
                        //PostedContainerList."Sales Invoice No." := SalesHeader."Last Posting No.";
                    END
                    ELSE BEGIN
                        SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                        SalesHeaderArchive.SETRANGE("No.", ContainerList."Special Order Sales No.");
                        IF SalesHeaderArchive.FINDLAST THEN BEGIN
                            PostedContainerList."Shipment No." := SalesHeaderArchive."Last Shipping No.";
                            //PostedContainerList."Sales Invoice No." := SalesHeaderArchive."Last Posting No.";
                        END;
                    END;
                END;

                IF UpdatePost THEN
                    PostedContainerList."Invoice Status" := PostedContainerList."Invoice Status"::"Awaiting Invoicing"
                ELSE
                    PostedContainerList."Invoice Status" := PostedContainerList."Invoice Status"::Invoiced;

                PostedContainerList.INSERT;
                ContainerList.DELETE;
            UNTIL ContainerList.NEXT = 0;
        END
    end;

    local procedure GetDealLinkedShipment(_OrderNo: Code[20]; DocType: Option Invoice,"Purchase Header","Sales Header","Sales Cr. Memo","Purch. Cr. Memo",Payment,"Purchase Invoice Header","Sales Invoice Header",Provision; var DealShipmentSelection: Record "DEL Deal Shipment Selection"): Boolean
    var
        Element: Record "DEL Element";
        Deal: Record "DEL Deal";
        DealShipment: Record "DEL Deal Shipment";
        Affaire_Co: Code[20];
        DealShipmentSelected: Boolean;
    begin
        //on cherche si des lignes ont déjà été générée pour cette facture
        CLEAR(DealShipmentSelection);
        DealShipmentSelection.SETRANGE(DealShipmentSelection."Document Type", DocType);
        DealShipmentSelection.SETRANGE(DealShipmentSelection."Document No.", _OrderNo);
        DealShipmentSelection.DELETEALL();

        Affaire_Co := '';
        Element.SETRANGE("Type No.", _OrderNo);
        IF Element.FINDFIRST THEN
            Affaire_Co := Element.Deal_ID;

        //Lister les deal, puis les livraisons qui y sont rattachées
        Deal.RESET();
        Deal.SETFILTER(Status, '<>%1', Deal.Status::Closed);
        IF Affaire_Co <> '' THEN
            Deal.SETRANGE(ID, Affaire_Co);

        IF Deal.ISEMPTY THEN
            Deal.SETRANGE(ID);

        IF NOT Deal.ISEMPTY THEN BEGIN
            Deal.FINDSET;
            REPEAT
                DealShipment.RESET();
                DealShipment.SETRANGE(Deal_ID, Deal.ID);
                IF NOT DealShipment.ISEMPTY THEN BEGIN
                    DealShipment.FINDSET;
                    REPEAT
                        DealShipmentSelection.INIT();
                        DealShipmentSelection."Document Type" := DocType;
                        DealShipmentSelection."Document No." := _OrderNo;
                        DealShipmentSelection.Deal_ID := Deal.ID;
                        DealShipmentSelection."Shipment No." := DealShipment.ID;
                        DealShipmentSelection.USER_ID := USERID;
                        DealShipmentSelection."BR No." := DealShipment."BR No.";
                        DealShipmentSelection."Purchase Invoice No." := DealShipment."Purchase Invoice No.";
                        DealShipmentSelection."Sales Invoice No." := DealShipment."Sales Invoice No.";
                        IF Deal.GETFILTER(ID) <> '' THEN
                            DealShipmentSelected := TRUE
                        ELSE
                            IF (DealShipmentSelection."BR No." <> '') AND (DealShipmentSelection."Purchase Invoice No." <> '') AND (DealShipmentSelection."Sales Invoice No." <> '') THEN
                                DealShipmentSelected := TRUE
                    UNTIL ((DealShipment.NEXT() = 0) OR DealShipmentSelected);
                    DealShipmentSelection.Checked := TRUE;
                    DealShipmentSelection.INSERT();
                    EXIT(TRUE);
                END;
            UNTIL (Deal.NEXT() = 0);
        END;
    end;

    procedure Invoice(var _PostedContainer: Record "DEL Posted Container List")
    var
        PostedContainerLine: Record "DEL Posted Container List";
        PostedContainerLevel1: Record "DEL Posted Container List";
        Window: Dialog;
        TotalDoc: Integer;
        DocNumber: Integer;
        IsToPost: Boolean;
    begin
        IF HideValidationDialog OR NOT GUIALLOWED THEN
            Confirmed := TRUE
        ELSE
            Confirmed := CONFIRM(ConfirmInvQst, FALSE);
        IF NOT Confirmed THEN
            EXIT;

        PostedContainerLine.COPY(_PostedContainer);
        IF PostedContainerLine.ISEMPTY THEN
            ERROR(NothingToPostErr);

        PostedContainerLevel1.COPY(_PostedContainer);
        PostedContainerLevel1.SETRANGE(Level, 1);
        IF NOT PostedContainerLevel1.ISEMPTY THEN BEGIN
            IF GUIALLOWED THEN
                Window.OPEN(PostProgress + '@3@@@@@@@@@@@@@@@@@@@@@@@@@\');
            TotalDoc := PostedContainerLevel1.COUNT;
            PostedContainerLevel1.FINDSET;
            REPEAT
                DocNumber += 1;
                IF GUIALLOWED THEN BEGIN
                    Window.UPDATE(1, PostedContainerLevel1."Container No.");
                    Window.UPDATE(2, PostedContainerLevel1."Special Order Sales No.");
                    Window.UPDATE(3, ROUND(DocNumber / TotalDoc * 10000, 1));
                END;

                PostedContainerLevel1.TESTFIELD("Meeting Date");

                //Initialiser les quantités à facturer
                InitSpeciaSalesQtyToInvoice(PostedContainerLevel1);

                //Mettre à jour les champs container et les quantités à réceptionner
                IsToPost := FillSpecialSalesOrderQtyToInvoice(PostedContainerLevel1);

                //Facturer les ventes
                IF IsToPost THEN;
                PostSpecialSalesOrder(PostedContainerLevel1);

                //Archive liste des conteneurs
                UpdatePostedContainerList(PostedContainerLevel1."Container No.", PostedContainerLevel1."Order No.", IsToPost);
            UNTIL PostedContainerLevel1.NEXT = 0;
            IF GUIALLOWED THEN
                Window.CLOSE;
        END;
    end;

    local procedure InitSpeciaSalesQtyToInvoice(var _PostedContainerLine: Record "DEL Posted Container List")
    var
        PostedContainerLevel2: Record "DEL Posted Container List";
    begin
        PostedContainerLevel2.SETRANGE("Container No.", _PostedContainerLine."Container No.");
        PostedContainerLevel2.SETRANGE("Order No.", _PostedContainerLine."Order No.");
        PostedContainerLevel2.SETRANGE(Level, 2);
        IF NOT PostedContainerLevel2.ISEMPTY THEN BEGIN
            PostedContainerLevel2.FINDSET;
            REPEAT
                InitSpecialSalesOrderQuantities(PostedContainerLevel2."Special Order Sales No.", TRUE);
            UNTIL PostedContainerLevel2.NEXT = 0;
        END;
    end;

    local procedure FillSpecialSalesOrderQtyToInvoice(var _PostedContainerLine: Record "DEL Posted Container List") IsToPost: Boolean
    var
        PostedContainerLevel2: Record "DEL Posted Container List";
        SalesLine: Record "Sales Line";
    begin
        PostedContainerLevel2.SETRANGE("Container No.", _PostedContainerLine."Container No.");
        PostedContainerLevel2.SETRANGE("Order No.", _PostedContainerLine."Order No.");
        PostedContainerLevel2.SETRANGE(Level, 2);
        IF NOT PostedContainerLevel2.ISEMPTY THEN BEGIN
            PostedContainerLevel2.FINDSET;
            REPEAT
                IF SalesLine.GET(SalesLine."Document Type"::Order, PostedContainerLevel2."Special Order Sales No.", PostedContainerLevel2."Special Order Sales Line No.") THEN
                    IF (ABS(PostedContainerLevel2.Pieces) <= ABS(SalesLine.MaxQtyToInvoice)) THEN BEGIN
                        SalesLine.VALIDATE("Qty. to Invoice", PostedContainerLevel2.Pieces);
                        SalesLine.MODIFY(TRUE);
                        IsToPost := TRUE;
                    END;
            UNTIL PostedContainerLevel2.NEXT = 0;
        END;
    end;

    local procedure PostSpecialSalesOrder(var _PostedContainerLine: Record "DEL Posted Container List")
    var
        PostedContainerLevel2: Record "DEL Posted Container List";
        SalesHeader: Record "Sales Header";
        DealShipmentSelection: Record "DEL Deal Shipment Selection";
        UpdateRequestID: Code[20];
        UpdateRequestManager: Codeunit "DEL Update Request Manager";
        ShipmentSelected: Boolean;
        Deal: Codeunit "DEL Deal";
        ACOConnection: Record "DEL ACO Connection";
        SalesPost: Codeunit "Sales-Post";
    begin
        PostedContainerLevel2.SETRANGE("Container No.", _PostedContainerLine."Container No.");
        PostedContainerLevel2.SETRANGE("Order No.", _PostedContainerLine."Order No.");
        PostedContainerLevel2.SETRANGE(Level, 2);
        PostedContainerLevel2.SETFILTER("Special Order Sales No.", '<>%1', '');
        IF PostedContainerLevel2.FINDFIRST THEN BEGIN
            SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SETRANGE("No.", PostedContainerLevel2."Special Order Sales No.");
            IF NOT SalesHeader.FINDFIRST THEN
                EXIT;

            DealShipmentSelection.RESET();
            DealShipmentSelection.SETRANGE("Document No.", SalesHeader."No.");
            DealShipmentSelection.SETRANGE(Checked, TRUE);
            DealShipmentSelection.SETRANGE(USER_ID, USERID);
            IF DealShipmentSelection.FINDFIRST THEN
                ShipmentSelected := TRUE
            ELSE BEGIN
                ShipmentSelected := GetDealLinkedShipment(_PostedContainerLine."Order No.", DocumentType::"Sales Header", DealShipmentSelection);
                IF NOT ShipmentSelected THEN
                    ERROR(DealShipmentErr, SalesHeader."No.");
            END;

            IF ShipmentSelected THEN BEGIN
                //pour les commandes il faut exactement 1 livraison liée
                IF DealShipmentSelection.COUNT() > 1 THEN
                    ERROR(DealShipmentErr, SalesHeader."No.");

                //On crée une updateRequest, comme ca, si NAV plante plus loin, on sait ce qui n'a pas été updaté comme il faut
                UpdateRequestID := UpdateRequestManager.FNC_Add_Request(
                  DealShipmentSelection.Deal_ID,
                  DealShipmentSelection."Document Type",
                  DealShipmentSelection."Document No.",
                  CURRENTDATETIME);
            END;

            SalesHeader.Ship := TRUE;
            SalesHeader.Invoice := TRUE;
            SalesHeader."Print Posted Documents" := FALSE;

            CLEAR(SalesPost);
            SalesPost.RUN(SalesHeader);

            IF ShipmentSelected THEN BEGIN
                //La facture a été associée à une et une seule livraison et donc, on réinitialise l'affaire qui appartient à cette livraison
                Deal.FNC_Reinit_Deal(DealShipmentSelection.Deal_ID, FALSE, TRUE);

                //Le deal a été réinitialisé, on peut valider l'updateRequest
                UpdateRequestManager.FNC_Validate_Request(UpdateRequestID);

                //On vide la table Deal Shipment Selection pour qu'elle soit mise à jour lors de la prochaine ouverture..
                DealShipmentSelection.RESET();
                DealShipmentSelection.SETRANGE("Document No.", SalesHeader."No.");
                DealShipmentSelection.SETRANGE(USER_ID, USERID);
                DealShipmentSelection.DELETEALL();
            END;
        END;
    end;

    local procedure UpdatePostedContainerList(ContainerNo: Code[20]; OrderNo: Code[20]; UpdatePost: Boolean): Boolean
    var
        PostedContainerList: Record "DEL Posted Container List";
        SalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
    begin
        PostedContainerList.SETCURRENTKEY("Container No.", "Order No.");
        PostedContainerList.SETRANGE("Container No.", ContainerNo);
        PostedContainerList.SETRANGE("Order No.", OrderNo);
        IF NOT PostedContainerList.ISEMPTY THEN BEGIN
            PostedContainerList.FINDSET;
            REPEAT
                PostedContainerList."Invoice Status" := PostedContainerList."Invoice Status"::Invoiced;
                IF (PostedContainerList.Level = 2) AND UpdatePost THEN BEGIN
                    IF SalesHeader.GET(SalesHeader."Document Type"::Order, PostedContainerList."Special Order Sales No.") THEN BEGIN
                        PostedContainerList."Sales Invoice No." := SalesHeader."Last Posting No.";
                    END
                    ELSE BEGIN
                        SalesHeaderArchive.SETRANGE("Document Type", SalesHeaderArchive."Document Type"::Order);
                        SalesHeaderArchive.SETRANGE("No.", PostedContainerList."Special Order Sales No.");
                        IF SalesHeaderArchive.FINDLAST THEN BEGIN
                            PostedContainerList."Sales Invoice No." := SalesHeaderArchive."Last Posting No.";
                        END;
                    END;
                END;
                PostedContainerList.MODIFY;
            UNTIL PostedContainerList.NEXT = 0;
        END
    end;
}

