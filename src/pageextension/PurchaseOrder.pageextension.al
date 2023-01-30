pageextension 50053 "DEL PurchaseOrder" extends "Purchase Order" //50 
{
    layout
    {
        addafter("Posting Date")
        {
            field("DEL Due Date Calculation"; Rec."DEL Due Date Calculation") { }
        }
        addafter("Vendor Shipment No.")
        {
            field("DEL Vendor Shipment Date"; Rec."DEL Vendor Shipment Date") { }
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
            field("DEL affaire_c"; "Affaire_Co")
            {
                Caption = 'Deal No.';
                Editable = FAlse;
                trigger OnDrillDown()
                begin
                    Deal_Re.SETRANGE(ID, Affaire_Co);
                    PAGE.RUN(Page::"DEL Deal Mainboard", Deal_Re);
                end;
            }
            field("DEL Type Order EDI"; Rec."DEL Type Order EDI")
            {
                Editable = false;
            }
            field("DEL Type Order EDI Description"; Rec."DEL Type Order EDI Description")
            {
                Visible = false;
            }
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        addafter("Expected Receipt Date")
        {
            field("DEL Relational Exch. Rate Amount"; Rec."DEL Rel. Exch. Rate Amount") { }
        }
        modify("Requested Receipt Date")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        addafter("Ship-to Contact")
        {
            field("DEL PI delivery date"; Rec."Expected Receipt Date")
            {
                Caption = 'PI delivery date';
                ApplicationArea = Suite;
            }
            field("DEL Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                Caption = 'PO delivery date';
            }
            field("DEL Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                Caption = 'Real delivery date';

            }
            field("DEL Requested Delivery Date"; Rec."DEL Requested Delivery Date")
            {
                Caption = 'Customer delivery date';
            }
        }
        addafter("Your Reference")
        {
            group("DEL EDI")
            {

                field("DEL Ship Per"; Rec."DEL Ship Per") { }
                field("DEL Forwarding Agent Code"; Rec."DEL Forwarding Agent Code") { }
                field("Port de départ"; Rec."DEL Port de départ") { }
                field("Code événement"; Rec."DEL Code événement") { }
                field("DEL Récépissé transitaire"; Rec."DEL Récépissé transitaire") { }
                field("Port d'arrivée"; Rec."DEL Port d'arrivée") { }

            }
        }
        addafter("Vendor Cr. Memo No.")
        {
            // TODO: specifique SUISS
            //group("DEL Swiss QR-Bill")
            // {
            //     field("DEL Swiss QRBill IBAN"; "Swiss QRBill IBAN")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         trigger OnDrillDown()
            //         var
            //             SwissQRBillIncomingDoc: Codeunit 11516;
            //         begin
            //             SwissQRBillIncomingDoc.DrillDownVendorIBAN("Swiss QRBill IBAN");
            //         end;
            //     }
            //     field("DEL Swiss QRBill Amount"; "Swiss QRBill Amount")
            //     {
            //         Importance = Promoted;
            //         ApplicationArea = Basic, Suite;

            //     }
            //     field("DEL Swiss QRBill Currency"; "Swiss QRBill Currency")
            //     {
            //         Importance = Promoted;
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("DEL Swiss QRBill Unstr. Message"; "Swiss QRBill Unstr. Message")
            //     {
            //         Importance = Additional;
            //         ApplicationArea = Basic, Suite;

            //     }
            //     field("DEL Swiss QRBill Bill Info"; "Swiss QRBill Bill Info")
            //     {
            //         Importance = Additional;
            //         trigger OnDrillDown()
            //         var
            //             SwissQRBillBillingInfo: Codeunit 11519;
            //         begin
            //             SwissQRBillBillingInfo.DrillDownBillingInfo("Swiss QRBill Bill Info");
            //         end;
            //     }

            // }
        }

    }
    actions
    {
        addafter(PostedPrepaymentCrMemos)
        {
            action("DEL UpdateOrderPrices")
            {
                Caption = 'Update Prices';
                Promoted = true;
                PromotedIsBig = true;
                Image = UpdateUnitCost;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    PurchaseFunctionMgt: Codeunit "DEL PurchaseFunction Mgt";
                begin
                    PurchaseFunctionMgt.UpdatePurchaseOrderPrices(Rec);
                    CurrPage.UPDATE();
                end;
            }
        }
        addafter("CopyDocument")
        {
            action("DEL Create Deal")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = CreateWhseLoc;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    affaireNo_Co_Loc: Code[20];
                begin
                    affaireNo_Co_Loc := Deal_Cu.FNC_New_Deal(Rec."No.");

                    Deal_Cu.FNC_Init_Deal(affaireNo_Co_Loc, TRUE, FALSE);
                end;
            }
        }
        addafter(MoveNegativeLines)
        {
            action("DEL Set to 0 Qty to Receive")
            {
                Promoted = true;
                PromotedIsBig = true;
                Image = UpdateShipment;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    UpdateSalesLinePurchaseLine: Codeunit "Update SalesLine/PurchaseLine";
                begin
                    UpdateSalesLinePurchaseLine.UpdatePurchaseLine(Rec."No.");
                end;
            }
            action("DEL Export excel MGTS")
            {
                RunPageOnRec = true;
                Promoted = true;
                PromotedIsBig = true;
                Image = Export;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    ExportPurchaseOrder: Report "DEL Export Purchase Order";
                begin
                    PurchaseHeader.RESET();
                    PurchaseHeader.SETRANGE("Document Type", Rec."Document Type");
                    PurchaseHeader.SETRANGE("No.", Rec."No.");

                    CLEAR(ExportPurchaseOrder);
                    ExportPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                    ExportPurchaseOrder.RUNMODAL();
                end;
            }
        }
        addafter(Post)
        {
            action("DEL PostSpecOrder")
            {
                ShortCutKey = F9;
                Ellipsis = true;
                Caption = 'Post special order';
                ApplicationArea = Suite;
                Promoted = true;
                PromotedIsBig = true;
                Image = PostOrder;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    InstructionMgt: Codeunit "Instruction Mgt.";
                    PrepaymentMgt: Codeunit "Prepayment Mgt.";
                    MGTSFCT: Codeunit "DEL MGTS_FctMgt";
                    PurchPost: Codeunit "Purch.-Post (Yes/No)";
                    Text50000: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ ''%1'' mit der Nummer %2 sind ungebuchte Vorauszahlungsbetr„ge vorhanden.;ITS=Sono presenti importi di pagamenti anticipati non registrati nel documento di tipo %1 con il numero %2.;FRS=Il existe des montants acompte non valid‚s sur le document de type %1 portant le num‚ro %2.';
                    Text50001: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ %1 mit der Nummer %2 sind unbezahlte Vorauszahlungsrechnungen vorhanden.;ITS=Sono presenti fatture pagamenti anticipati non pagate correlate al documento di tipo %1 con il numero %2.;FRS=Il existe des factures d''acompte impay‚es li‚es au document de type %1 portant le num‚ro %2.';
                begin

                    IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
                        IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text50000, Rec."Document Type", Rec."No."));
                        IF PrepaymentMgt.TestPurchasePayment(Rec) THEN
                            IF NOT CONFIRM(STRSUBSTNO(Text50001, Rec."Document Type", Rec."No."), TRUE) THEN
                                EXIT;
                    END;

                    CLEAR(PurchPost);
                    //PurchPost.SetSpecOrderPosting(TRUE);
                    MGTSFCT.SetSpecOrderPosting(TRUE);
                    PurchPost.RUN(Rec);

                    MGTSFCT.GetSpecialOrderBuffer(TEMPgSpecialSHBuffer);
                    gSpecialPosting := TRUE;

                    //TODO DocumentIsPosted := NOT PurchaseHeader.GET("Document Type", "No.");

                    IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
                        CurrPage.CLOSE();

                    CurrPage.UPDATE(FALSE);

                    IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) THEN
                        ShowPostedConfirmationMessage();
                end;
            }
        }
        addafter("Post and &Print")
        {
            action("DEL PostPrintSpecOrder")
            {
                ShortCutKey = 'Shift+F9';
                Ellipsis = true;
                Caption = 'Post and Print special order';
                ApplicationArea = Suite;
                Promoted = true;
                PromotedIsBig = true;
                Image = PostPrint;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    InstructionMgt: Codeunit "Instruction Mgt.";
                    PrepaymentMgt: Codeunit "Prepayment Mgt.";
                    PurchPostPrint: Codeunit "Purch.-Post + Print";
                    MGTSFCT: Codeunit "DEL MGTS_FctMgt";
                    Text50000: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ ''%1'' mit der Nummer %2 sind ungebuchte Vorauszahlungsbetr„ge vorhanden.;ITS=Sono presenti importi di pagamenti anticipati non registrati nel documento di tipo %1 con il numero %2.;FRS=Il existe des montants acompte non valid‚s sur le document de type %1 portant le num‚ro %2.';
                    Text50001: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ %1 mit der Nummer %2 sind unbezahlte Vorauszahlungsrechnungen vorhanden.;ITS=Sono presenti fatture pagamenti anticipati non pagate correlate al documento di tipo %1 con il numero %2.;FRS=Il existe des factures d''acompte impay‚es li‚es au document de type %1 portant le num‚ro %2.';
                begin
                    IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
                        IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text50000, Rec."Document Type", Rec."No."));
                        IF PrepaymentMgt.TestPurchasePayment(Rec) THEN
                            IF NOT CONFIRM(STRSUBSTNO(Text50001, Rec."Document Type", Rec."No."), TRUE) THEN
                                EXIT;
                    END;

                    CLEAR(PurchPostPrint);
                    //PurchPostPrint.SetSpecOrderPosting(TRUE);
                    MGTSFCT.SetSpecOrderPosting(TRUE);
                    PurchPostPrint.RUN(Rec);

                    MGTSFCT.GetSpecialOrderBuffer(TEMPgSpecialSHBuffer);
                    gSpecialPosting := TRUE;

                    //TODO DocumentIsPosted := NOT PurchaseHeader.GET(Rec."Document Type", Rec."No.");

                    IF Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting" THEN
                        CurrPage.CLOSE();

                    CurrPage.UPDATE(FALSE);

                    IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode()) THEN
                        ShowPostedConfirmationMessage();
                end;
            }

        }
        addafter("&Print")
        {
            action("DEL Matrix Print")
            {
                Caption = 'Matrix Print';
                ApplicationArea = Suite;
                Promoted = true;
                Image = Print;
                PromotedCategory = Category10;
                PromotedOnly = true;

                trigger OnAction()
                var
                    lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
                    lcuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
                    ProcessType: Enum "DEL Process Type";
                    lUsage: Enum "DEL Usage DocMatrix Selection";
                begin
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Buy-from Vendor No.", ProcessType::Manual, lUsage::"P.Order", lrecDocMatrixSelection, FALSE) THEN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"P.Order", ProcessType::Manual, Rec, Rec.FIELDNO("Buy-from Vendor No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, Rec.FIELDNO("Purchaser Code"));
                end;
            }
        }
        addafter(SendCustom)
        {
            action("DEL Swiss QR-Bill")
            {
                Caption = 'QR-Bill';
            }
            action("DEL Swiss QR-Bill Scan")
            {
                Caption = 'Scan QR-Bill';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                Image = Import;
                PromotedCategory = Process;
                trigger OnAction()
                var
                begin
                    // SwissQRBillPurchases.UpdatePurchDocFromQRCode(Rec, FALSE);
                end;
            }
            action("DEL Swiss QR-Bill Import")
            {
                Caption = 'Import Scanned QR-Bill File';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                Image = Import;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    // SwissQRBillPurchases.UpdatePurchDocFromQRCode(Rec, TRUE);
                end;
            }
            action("DEL Swiss QR-Bill Void")
            {
                Caption = 'Void the imported QR-Bill';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                //TODOVisible="Swiss QRBill";
                Image = VoidCheck;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    //SwissQRBillPurchases.VoidPurchDocQRBill(Rec);
                end;
            }
            action("DEL Print MGTS")
            {
                Caption = '&Print MGTS';
                ApplicationArea = Suite;
                Promoted = true;
                Image = Print;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    CduLMinimizingClicksNGTS: Codeunit "DEL Minimizing Clicks - MGTS";
                begin
                    PurchaseHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                    PurchaseHeader.PrintRecords(TRUE);
                    CduLMinimizingClicksNGTS.FctSendMailPurchOrder(Rec);
                end;
            }
            action("DEL Print Dossier")
            {
                Caption = '&Print Dossier';
                ApplicationArea = Suite;
                RunPageOnRec = false;
                Promoted = true;
                Image = Print;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    ReportSelection: Record "Report Selections";
                    StandardPurchaseOrder: Report "Standard Purchase - Order";
                    CduLMinimizingClicksNGTS: Codeunit "DEL Minimizing Clicks - MGTS";
                begin
                    PurchaseHeader := Rec;
                    PurchaseHeader.SETRECFILTER();
                    StandardPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                    StandardPurchaseOrder.RUNMODAL();
                end;
            }
        }
    }
    var
        Deal_Re: Record "DEL Deal";
        TEMPgSpecialSHBuffer: Record "Sales Header" TEMPORARY;
        Deal_Cu: Codeunit "DEL Deal";
        gSpecialPosting: Boolean;
        Affaire_Co: Code[20];
    //TODO SwissQRBillPurchases: Codeunit 11502;

    //Dupliquée
    LOCAL PROCEDURE ShowPostedConfirmationMessage();
    VAR
        lSIH: Record "Sales Invoice Header";
        lMessage: Text;
    BEGIN
        IF gSpecialPosting THEN BEGIN
            lMessage := '';
            TEMPgSpecialSHBuffer.RESET();
            IF TEMPgSpecialSHBuffer.FINDSET() THEN
                REPEAT
                    IF TEMPgSpecialSHBuffer.Invoice THEN
                        IF lSIH.GET(TEMPgSpecialSHBuffer."Last Posting No.") THEN BEGIN
                            IF lMessage <> '' THEN
                                lMessage := lMessage + ',';
                            lMessage := lMessage + lSIH."No.";
                        END;
                UNTIL TEMPgSpecialSHBuffer.NEXT() = 0;
        END;
    end;

}


