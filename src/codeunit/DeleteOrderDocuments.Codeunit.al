codeunit 50059 "DEL Delete Order Documents"
{
    trigger OnRun()
    begin
    end;

    var
        ConfirmationMsg: Label 'Are you sure you want to delete the sales order: %1 ?';
        FinishMsg: Label 'Treatment finished !';
        ProgressMsg: Label 'Delete in progress...';
        Window: Dialog;
        StopDeleteErr: Label 'Cannot delete order %1.';

    procedure DeleteOrdersDocuments(SalesOrderHeader: Record "Sales Header")
    var
        SalesOrderLine: Record "Sales Line";
        TempPurchOrderHeader: Record "Purchase Header" temporary;
        PurchaseHeader: Record "Purchase Header";
    begin
        IF NOT CONFIRM(ConfirmationMsg, FALSE, SalesOrderHeader."No.") THEN
            EXIT;

        Window.OPEN(ProgressMsg);

        //Récupérer l'ensemble des commandes d'achat liées à la commande de vente
        SalesOrderLine.SETRANGE("Document Type", SalesOrderHeader."Document Type");
        SalesOrderLine.SETRANGE("Document No.", SalesOrderHeader."No.");
        SalesOrderLine.SETFILTER("Special Order Purchase No.", '<>''''');
        IF NOT SalesOrderLine.ISEMPTY THEN BEGIN
            SalesOrderLine.FINDSET;
            REPEAT
                TempPurchOrderHeader.RESET;
                TempPurchOrderHeader.SETRANGE("Document Type", TempPurchOrderHeader."Document Type"::Order);
                TempPurchOrderHeader.SETRANGE("No.", SalesOrderLine."Special Order Purchase No.");
                IF NOT TempPurchOrderHeader.FINDFIRST THEN BEGIN
                    TempPurchOrderHeader."Document Type" := TempPurchOrderHeader."Document Type"::Order;
                    TempPurchOrderHeader."No." := SalesOrderLine."Special Order Purchase No.";
                    TempPurchOrderHeader.INSERT;
                END;
            UNTIL SalesOrderLine.NEXT = 0;
        END;

        //Suppression de la commande de vente
        IF NOT DeleteSalesOrder(SalesOrderHeader) THEN
            ERROR(StopDeleteErr, SalesOrderHeader."No.");

        //Suppression des commandes d'achat
        TempPurchOrderHeader.RESET;
        IF NOT TempPurchOrderHeader.ISEMPTY THEN
            TempPurchOrderHeader.FINDSET;
        REPEAT
            IF PurchaseHeader.GET(TempPurchOrderHeader."Document Type", TempPurchOrderHeader."No.") THEN
                IF NOT DeletePurchaseOrder(PurchaseHeader) THEN
                    ERROR(StopDeleteErr, PurchaseHeader."No.");
        UNTIL TempPurchOrderHeader.NEXT = 0;

        Window.CLOSE;
        MESSAGE(FinishMsg);
    end;

    local procedure DeleteSalesOrder(var SalesOrderHeader: Record "Sales Header"): Boolean
    var
        SalesOrderLine: Record "Sales Line";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        PrepmtSalesInvHeader: Record "Sales Invoice Header";
        PrepmtSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCommentLine: Record "Sales Comment Line";
        ItemChargeAssgntSales: Record "Item Charge Assignment (Sales)";
        WhseRequest: Record "Warehouse Request";
        AllLinesDeleted: Boolean;
        SalesSetup: Record "Sales & Receivables Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
        ATOLink: Record "Assemble-to-Order Link";
        ReserveSalesLine: Codeunit "Sales Line-Reserve";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PostSalesDelete: Codeunit "PostSales-Delete";
    begin
        WITH SalesOrderHeader DO BEGIN
            AllLinesDeleted := TRUE;
            ItemChargeAssgntSales.RESET;
            ItemChargeAssgntSales.SETRANGE("Document Type", "Document Type");
            ItemChargeAssgntSales.SETRANGE("Document No.", "No.");
            SalesOrderLine.RESET;
            SalesOrderLine.SETRANGE("Document Type", "Document Type");
            SalesOrderLine.SETRANGE("Document No.", "No.");
            SalesOrderLine.SETFILTER("Quantity Invoiced", '<>0');
            IF SalesOrderLine.FINDFIRST THEN BEGIN
                SalesOrderLine.SETRANGE("Quantity Invoiced");
                //SalesOrderLine.SETFILTER("Outstanding Quantity",'<>0');
                //IF NOT SalesOrderLine.FINDFIRST THEN BEGIN
                //  SalesOrderLine.SETRANGE("Outstanding Quantity");
                SalesOrderLine.SETFILTER("Qty. Shipped Not Invoiced", '<>0');
                IF NOT SalesOrderLine.FINDFIRST THEN BEGIN
                    SalesOrderLine.LOCKTABLE;
                    IF NOT SalesOrderLine.FINDFIRST THEN BEGIN
                        SalesOrderLine.SETRANGE("Qty. Shipped Not Invoiced");

                        SalesSetup.GET;
                        // IF SalesSetup."Arch. Orders and Ret. Orders" THEN
                        //     ArchiveManagement.ArchSalesDocumentNoConfirm(SalesOrderHeader);

                        IF SalesOrderLine.FIND('-') THEN
                            REPEAT
                                SalesOrderLine.CALCFIELDS("Qty. Assigned");
                                IF (SalesOrderLine."Qty. Assigned" = SalesOrderLine."Quantity Invoiced") OR
                                   (SalesOrderLine.Type <> SalesOrderLine.Type::"Charge (Item)")
                                THEN BEGIN
                                    IF SalesOrderLine.Type = SalesOrderLine.Type::"Charge (Item)" THEN BEGIN
                                        ItemChargeAssgntSales.SETRANGE("Document Line No.", SalesOrderLine."Line No.");
                                        ItemChargeAssgntSales.DELETEALL;
                                    END;
                                    IF SalesOrderLine.Type = SalesOrderLine.Type::Item THEN
                                        ATOLink.DeleteAsmFromSalesLine(SalesOrderLine);
                                    IF SalesOrderLine.HASLINKS THEN
                                        SalesOrderLine.DELETELINKS;
                                    SalesOrderLine.DELETE;
                                END ELSE
                                    AllLinesDeleted := FALSE;
                            UNTIL SalesOrderLine.NEXT = 0;

                        IF AllLinesDeleted THEN BEGIN
                            PostSalesDelete.DeleteHeader(
                              SalesOrderHeader, SalesShptHeader, SalesInvHeader, SalesCrMemoHeader, ReturnRcptHeader,
                              PrepmtSalesInvHeader, PrepmtSalesCrMemoHeader);

                            ReserveSalesLine.DeleteInvoiceSpecFromHeader(SalesOrderHeader);

                            SalesCommentLine.SETRANGE("Document Type", "Document Type");
                            SalesCommentLine.SETRANGE("No.", "No.");
                            SalesCommentLine.DELETEALL;

                            WhseRequest.SETRANGE("Source Type", DATABASE::"Sales Line");
                            WhseRequest.SETRANGE("Source Subtype", "Document Type");
                            WhseRequest.SETRANGE("Source No.", "No.");
                            IF NOT WhseRequest.ISEMPTY THEN
                                WhseRequest.DELETEALL(TRUE);

                            ApprovalsMgmt.DeleteApprovalEntries(RECORDID);

                            IF HASLINKS THEN
                                DELETELINKS;
                            DELETE;
                            EXIT(TRUE);
                        END;
                    END;
                END;
            END;
        END;
    end;

    local procedure DeletePurchaseOrder(var PurchOrderHeader: Record "Purchase Header"): Boolean
    var
        PurchLine: Record "Purchase Line";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ReturnShptHeader: Record "Return Shipment Header";
        PrepmtPurchInvHeader: Record "Purch. Inv. Header";
        PrepmtPurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        PurchCommentLine: Record "Purch. Comment Line";
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
        WhseRequest: Record "Warehouse Request";
        AllLinesDeleted: Boolean;
        PurchSetup: Record "Purchases & Payables Setup";
        ArchiveManagement: Codeunit ArchiveManagement;
        ReservePurchLine: Codeunit "Purch. Line-Reserve";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PostPurchDelete: Codeunit "PostPurch-Delete";
    begin
        WITH PurchOrderHeader DO BEGIN
            AllLinesDeleted := TRUE;
            ItemChargeAssgntPurch.RESET;
            ItemChargeAssgntPurch.SETRANGE("Document Type", "Document Type");
            ItemChargeAssgntPurch.SETRANGE("Document No.", "No.");
            PurchLine.RESET;
            PurchLine.SETRANGE("Document Type", "Document Type");
            PurchLine.SETRANGE("Document No.", "No.");
            PurchLine.SETFILTER("Quantity Invoiced", '<>0');
            IF PurchLine.FIND('-') THEN BEGIN
                PurchLine.SETRANGE("Quantity Invoiced");
                PurchLine.SETFILTER("Qty. Rcd. Not Invoiced", '<>0');
                IF NOT PurchLine.FIND('-') THEN BEGIN
                    PurchLine.LOCKTABLE;
                    IF NOT PurchLine.FIND('-') THEN BEGIN
                        PurchLine.SETRANGE("Qty. Rcd. Not Invoiced");

                        PurchSetup.GET;
                        IF PurchSetup."Arch. Orders and Ret. Orders" THEN
                            ArchiveManagement.ArchPurchDocumentNoConfirm(PurchOrderHeader);

                        IF PurchLine.FIND('-') THEN
                            REPEAT
                                PurchLine.CALCFIELDS("Qty. Assigned");
                                IF (PurchLine."Qty. Assigned" = PurchLine."Quantity Invoiced") OR
                                   (PurchLine.Type <> PurchLine.Type::"Charge (Item)")
                                THEN BEGIN
                                    IF PurchLine.Type = PurchLine.Type::"Charge (Item)" THEN BEGIN
                                        ItemChargeAssgntPurch.SETRANGE("Document Line No.", PurchLine."Line No.");
                                        ItemChargeAssgntPurch.DELETEALL;
                                    END;
                                    IF PurchLine.HASLINKS THEN
                                        PurchLine.DELETELINKS;

                                    PurchLine.DELETE;
                                END ELSE
                                    AllLinesDeleted := FALSE;
                            UNTIL PurchLine.NEXT = 0;

                        IF AllLinesDeleted THEN BEGIN
                            PostPurchDelete.DeleteHeader(
                              PurchOrderHeader, PurchRcptHeader, PurchInvHeader, PurchCrMemoHeader,
                              ReturnShptHeader, PrepmtPurchInvHeader, PrepmtPurchCrMemoHeader);

                            ReservePurchLine.DeleteInvoiceSpecFromHeader(PurchOrderHeader);

                            PurchCommentLine.SETRANGE("Document Type", "Document Type");
                            PurchCommentLine.SETRANGE("No.", "No.");
                            PurchCommentLine.DELETEALL;

                            WhseRequest.SETRANGE("Source Type", DATABASE::"Purchase Line");
                            WhseRequest.SETRANGE("Source Subtype", "Document Type");
                            WhseRequest.SETRANGE("Source No.", "No.");
                            IF NOT WhseRequest.ISEMPTY THEN
                                WhseRequest.DELETEALL(TRUE);

                            ApprovalsMgmt.DeleteApprovalEntries(RECORDID);

                            IF HASLINKS THEN
                                DELETELINKS;

                            DELETE;
                            EXIT(TRUE);
                        END;
                    END;
                END;
            END;
        END;
    end;
}
