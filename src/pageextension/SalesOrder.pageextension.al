pageextension 50051 "DEL SalesOrder" extends "Sales Order" //42
{
    layout
    {
        addafter("No.")
        {
            field("DEL Sell-to Customer No."; Rec."Sell-to Customer No.") { }
        }
        addafter("Requested Delivery Date")
        {
            field("DEL Estimated Delivery Date"; Rec."DEL Estimated Delivery Date") { }
        }
        addafter("External Document No.")
        {
            field("DEL Event Code"; Rec."DEL Event Code") { }
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        addafter("Assigned User ID")
        {
            field("DEL Create By"; Rec."DEL Create By") { }
        }
        addafter("Job Queue Status")
        {
            field("DEL Fiscal Repr."; Rec."DEL Fiscal Repr.") { }
            field("DEL Your Reference"; Rec."Your Reference") { }
        }
        addafter(Status)
        {
            field("DEL Has Spec. Purch. Order"; Rec."DEL Has Spec. Purch. Order")
            {
                Editable = true;
                HideValue = FALSE;
            }
            field("DEL Purchase Order Create Date"; Rec."DEL Purchase Order Create Date") { }
            field("DEL Status Purchase Order Create"; Rec."DEL Status Purch. Order Create") { }
            field("DEL Error Purch. Order Create"; Rec."DEL Error Purch. Order Create") { }
            field("DEL Error Text Purch. Order Create"; Rec."DEL Err Text Pur. Order Create")
            {
                Style = Attention;
                StyleExpr = TRUE;
            }
            field("DEL Type Order EDI"; Rec."DEL Type Order EDI")
            {
                Editable = false;
            }
            field("DEL Type Order EDI Description"; Rec."DEL Type Order EDI Description") { }
            field("DEL Shipment No."; Rec."DEL Shipment No.") { }

        }
        addafter("Payment Method Code")
        {
            field("DEL Mention Under Total"; Rec."DEL Mention Under Total") { }
            field("DEL Amount Mention Under Total"; Rec."DEL Amount Mention Under Total") { }
        }
        addbefore("Bill-to Name")
        {
            field("DEL Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
        addafter("Late Order Shipping")
        {
            field("DEL GLN"; "DEL GLN") { }

        }

    }
    actions
    {
        addafter(AssemblyOrders)
        {
            action("DEL Linked Shipment filtred")
            {
                Caption = 'Linked Shipment filtred';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    deal_Re_Loc: Record "DEL Deal";
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                    dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
                    element_Re_Loc: Record "DEL Element";
                    SalesLine: Record "Sales Line";
                    dealShipmentSelection_Form_Loc: Page "DEL Deal Shipment Selection";
                    valueSpecial: Code[20];
                begin
                    //on cherche si des lignes ont d‚j… ‚t‚ g‚n‚r‚e pour cette facture
                    dealShipmentSelection_Re_Loc.RESET();
                    dealShipmentSelection_Re_Loc.SETRANGE(dealShipmentSelection_Re_Loc."Document No.", Rec."No.");
                    dealShipmentSelection_Re_Loc.SETRANGE("Document Type", dealShipmentSelection_Re_Loc."Document Type"::"Sales Header");
                    dealShipmentSelection_Re_Loc.DELETEALL();

                    //Lister les deal, puis les livraisons qui y sont rattach‚es
                    SalesLine.SETCURRENTKEY("Special Order Purchase No.");
                    SalesLine.ASCENDING(FALSE);
                    SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
                    SalesLine.SETRANGE("Document No.", Rec."No.");
                    SalesLine.SETFILTER("Special Order Purchase No.", '<>%1', '');
                    valueSpecial := '';

                    IF SalesLine.FIND('-') THEN
                        REPEAT
                            IF (valueSpecial <> SalesLine."Special Order Purchase No.") THEN BEGIN

                                element_Re_Loc.SETRANGE("Type No.", SalesLine."Special Order Purchase No.");
                                IF element_Re_Loc.FIND('-') THEN BEGIN

                                    deal_Re_Loc.RESET();
                                    deal_Re_Loc.SETRANGE(ID, element_Re_Loc.Deal_ID);
                                    deal_Re_Loc.SETFILTER(Status, '<>%1', deal_Re_Loc.Status::Closed);
                                    IF deal_Re_Loc.FIND('-') THEN
                                        REPEAT
                                            dealShipment_Re_Loc.RESET();
                                            dealShipment_Re_Loc.SETRANGE(Deal_ID, deal_Re_Loc.ID);
                                            IF dealShipment_Re_Loc.FIND('-') THEN
                                                REPEAT

                                                    dealShipmentSelection_Re_Loc.INIT();
                                                    dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::"Sales Header";
                                                    dealShipmentSelection_Re_Loc."Document No." := Rec."No.";
                                                    dealShipmentSelection_Re_Loc.Deal_ID := deal_Re_Loc.ID;
                                                    dealShipmentSelection_Re_Loc."Shipment No." := dealShipment_Re_Loc.ID;
                                                    dealShipmentSelection_Re_Loc.USER_ID := USERID;

                                                    dealShipmentSelection_Re_Loc."BR No." := dealShipment_Re_Loc."BR No.";

                                                    dealShipmentSelection_Re_Loc."Purchase Invoice No." := dealShipment_Re_Loc."Purchase Invoice No.";

                                                    dealShipmentSelection_Re_Loc."Sales Invoice No." := dealShipment_Re_Loc."Sales Invoice No.";

                                                    dealShipmentSelection_Re_Loc.INSERT();

                                                UNTIL (dealShipment_Re_Loc.NEXT() = 0);

                                        UNTIL (deal_Re_Loc.NEXT() = 0);
                                    valueSpecial := SalesLine."Special Order Purchase No.";
                                END;
                            END;
                        UNTIL SalesLine.NEXT() = 0;
                    CLEAR(dealShipmentSelection_Form_Loc);
                    dealShipmentSelection_Form_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
                    dealShipmentSelection_Form_Loc.SETRECORD(dealShipmentSelection_Re_Loc);
                    dealShipmentSelection_Form_Loc.RUN()
                end;
            }
        }
        addafter(Invoices)
        {
            action("Post + Matrix Print")
            {
                Caption = 'Post + Matrix Print';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger onaction()
                var
                    ApplicationAreaSetup: Record "Application Area Setup";
                    precDealShipmentSelection: Record "DEL Deal Shipment Selection";
                    lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
                    lrecSalesInvoiceHeader: Record "Sales Invoice Header";
                    Deal_Cu: Codeunit "DEL Deal";
                    lcuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
                    LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
                    lboSalesOrderConfirmation: Boolean;
                    pboShipmentSelected: Boolean;
                    lCustNo: Code[20];
                    lNo: Code[20];
                    pcdUpdateRequestID: Code[20];
                    ProcessType: Enum "DEL Process Type";
                    lUsage: Enum "DEL Usage DocMatrix Selection";
                    lFieldCustNo: Integer;
                    lFieldNo: Integer;
                begin
                    // init
                    lNo := Rec."No.";
                    lCustNo := Rec."Sell-to Customer No.";
                    lFieldNo := lrecSalesInvoiceHeader.FIELDNO("No.");
                    lFieldCustNo := lrecSalesInvoiceHeader.FIELDNO("Sell-to Customer No.");

                    lcuDocumentMatrixMgt.TestShipmentSelectionBeforeUptdateRequest(Rec, precDealShipmentSelection, pcdUpdateRequestID, pboShipmentSelected);

                    lboSalesOrderConfirmation := FALSE;
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(lCustNo, ProcessType::Manual, lUsage::"S.Order".AsInteger(), lrecDocMatrixSelection, lboSalesOrderConfirmation) THEN

                        // check if posted is configured
                        IF lrecDocMatrixSelection.Post <> lrecDocMatrixSelection.Post::" " THEN BEGIN

                            Deal_Cu.FNC_Reinit_Deal(pcdUpdateRequestID, FALSE, FALSE);

                            // check if posting is possible
                            IF ApplicationAreaSetup.IsFoundationEnabled() THEN
                                LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
                            IF NOT Rec.IsApprovedForPosting() THEN
                                EXIT;

                            // post the Sales Order acording user DocMatrixSelection
                            Rec.Invoice := lrecDocMatrixSelection.Post IN ["DEL Post DocMatrix"::Invoice, "DEL Post DocMatrix"::"Ship and Invoice"];
                            Rec.Ship := lrecDocMatrixSelection.Post IN ["DEL Post DocMatrix"::Ship, "DEL Post DocMatrix"::"Ship and Invoice"];
                            CODEUNIT.RUN(CODEUNIT::"Sales-Post", Rec);

                            lcuDocumentMatrixMgt.ManageRequestAfterPosting(lNo, pboShipmentSelected, pcdUpdateRequestID);

                            // check if the Sales Header is still available, if NOT, then it is posted and can be further processed as a "Posted Sales Invoice"
                            IF lcuDocumentMatrixMgt.GetPostedSalesInvoice(lNo, lCustNo, lrecSalesInvoiceHeader) THEN
                                lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"S.Invoice".AsInteger(), ProcessType::Manual, lrecSalesInvoiceHeader, lFieldCustNo, lFieldNo, lrecDocMatrixSelection, 0);

                        END;
                end;
            }

        }
        addafter("Send IC Sales Order")
        {
            action("DEL Update VAT")
            {
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    FormMAJ: Page "DEL Modification Taux tva";
                begin
                    FormMAJ.SETTABLEVIEW(Rec);
                    FormMAJ.SETRECORD(Rec);
                    FormMAJ.RUN();
                end;
            }
            action("DEL Set to 0 Qty to Ship")
            {
                Image = UpdateShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    UpdateSalesLinePurchaseLine: Codeunit "Update SalesLine/PurchaseLine";
                begin
                    UpdateSalesLinePurchaseLine.UpdateSalesLine(Rec."No.");
                end;
            }
            action("DEL CreateSpecPurchaseOrder")
            {
                Caption = 'Create Special Purchase Order';
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    RequisitionLine: Record "Requisition Line";
                    SalesSetup: Record "Sales & Receivables Setup";
                    SalesLine: Record "Sales Line";
                    GetSalesOrders: Report "Get Sales Orders";
                    ReqWorksheet: Page "Req. Worksheet";
                    NextWorksheetLineNo: Integer;
                begin
                    IF NOT SalesSetup.GET() THEN
                        SalesSetup.INIT();

                    SalesSetup.TESTFIELD("DEL Def.Req.Worksheet Temp");
                    SalesSetup.TESTFIELD("DEL Def. Req. Worksheet Batch");

                    RequisitionLine.RESET();
                    RequisitionLine.SETRANGE("Worksheet Template Name", SalesSetup."DEL Def.Req.Worksheet Temp");
                    RequisitionLine.SETRANGE("Journal Batch Name", SalesSetup."DEL Def. Req. Worksheet Batch");
                    IF RequisitionLine.FINDLAST() THEN
                        NextWorksheetLineNo := RequisitionLine."Line No."
                    ELSE
                        NextWorksheetLineNo := 0;

                    RequisitionLine.INIT();
                    RequisitionLine."Worksheet Template Name" := SalesSetup."DEL Def.Req.Worksheet Temp";
                    RequisitionLine."Journal Batch Name" := SalesSetup."DEL Def. Req. Worksheet Batch";
                    RequisitionLine."Line No." := NextWorksheetLineNo + 10000;
                    RequisitionLine.INSERT();

                    COMMIT();

                    SalesLine.RESET();
                    SalesLine.SETRANGE("Document Type", Rec."Document Type");
                    SalesLine.SETRANGE("Document No.", Rec."No.");

                    GetSalesOrders.SetReqWkshLine(RequisitionLine, 1);
                    GetSalesOrders.SETTABLEVIEW(SalesLine);
                    GetSalesOrders.RUNMODAL();
                    CLEAR(GetSalesOrders);

                    RequisitionLine.RESET();
                    RequisitionLine.SETRANGE("Worksheet Template Name", SalesSetup."DEL Def.Req.Worksheet Temp");
                    RequisitionLine.SETRANGE("Journal Batch Name", SalesSetup."DEL Def. Req. Worksheet Batch");
                    RequisitionLine.SETRANGE("Line No.", NextWorksheetLineNo + 10000);
                    RequisitionLine.DELETE();
                    COMMIT();

                    RequisitionLine.SETRANGE("Line No.");

                    CLEAR(ReqWorksheet);
                    ReqWorksheet.SETTABLEVIEW(RequisitionLine);
                    ReqWorksheet.RUNMODAL();
                end;

            }
            action("DEL PostAndPrint")
            {
                Caption = 'Post and &Print';
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //TODO : NavigateAfterPost doesn't exist 
                // trigger OnAction()
                // begin
                //     Codeunit.Run(CODEUNIT::"Sales-Post + Print", NavigateAfterPost::Nowhere); //POST
                // end;
            }
            action("DEL Facture Proforma")
            {
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    SalesHead.RESET();
                    SalesHead.GET("Document Type", "No.");
                    REPORT.RUN(50007, TRUE, TRUE, SalesHead);
                end;
            }
            action("DEL Print Confirmation MGTS")
            {
                ApplicationArea = Basic, Suite;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    CduLMinimizingClicksNGTS: Codeunit "DEL Minimizing Clicks - MGTS";
                begin
                    CduLMinimizingClicksNGTS.FctSalesOrderConfirmationPDFSave(Rec);
                    //TODO DocPrint.PrintSalesOrder(Rec, Usage::"Order Confirmation");
                end;
            }
        }

    }
    var
        SalesHead: Record "Sales Header";
        DocPrint: Codeunit "Document-Print";

}

