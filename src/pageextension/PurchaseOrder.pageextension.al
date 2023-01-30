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
                    PAGE.RUN(50030, Deal_Re);
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
            field("DEL PI delivery date"; Rec."Expected Receipt Date") { }
            field("DEL Requested Receipt Date"; Rec."Requested Receipt Date") { }
            field("DEL Promised Receipt Date"; Rec."Promised Receipt Date") { }
            field("DEL Requested Delivery Date"; Rec."DEL Requested Delivery Date") { }
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
                    PurchaseFunctionMgt: Codeunit 50089;
                begin
                    PurchaseFunctionMgt.UpdatePurchaseOrderPrices(Rec);
                    CurrPage.UPDATE;
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
                    affaireNo_Co_Loc := Deal_Cu.FNC_New_Deal("No.");

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
                    UpdateSalesLinePurchaseLine: Codeunit 50000;
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
                    PurchaseHeader: Record 38;
                    ExportPurchaseOrder: Report 50053;
                begin
                    PurchaseHeader.RESET;
                    PurchaseHeader.SETRANGE("Document Type", "Document Type");
                    PurchaseHeader.SETRANGE("No.", "No.");

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
                    PurchPost: Codeunit 91;
                    PurchaseHeader: Record 38;
                    InstructionMgt: Codeunit 1330;
                    ApprovalsMgmt: Codeunit 1535;
                    PrepaymentMgt: Codeunit 441;
                    Text50000: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ ''%1'' mit der Nummer %2 sind ungebuchte Vorauszahlungsbetr„ge vorhanden.;ITS=Sono presenti importi di pagamenti anticipati non registrati nel documento di tipo %1 con il numero %2.;FRS=Il existe des montants acompte non valid‚s sur le document de type %1 portant le num‚ro %2.';
                    Text50001: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ %1 mit der Nummer %2 sind unbezahlte Vorauszahlungsrechnungen vorhanden.;ITS=Sono presenti fatture pagamenti anticipati non pagate correlate al documento di tipo %1 con il numero %2.;FRS=Il existe des factures d''acompte impay‚es li‚es au document de type %1 portant le num‚ro %2.';
                begin

                    IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
                        IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text50000, "Document Type", "No."));
                        IF PrepaymentMgt.TestPurchasePayment(Rec) THEN
                            IF NOT CONFIRM(STRSUBSTNO(Text50001, "Document Type", "No."), TRUE) THEN
                                EXIT;
                    END;

                    CLEAR(PurchPost);
                    PurchPost.SetSpecOrderPosting(TRUE);
                    PurchPost.RUN(Rec);

                    PurchPost.GetSpecialOrderBuffer(gTempSpecialSHBuffer);
                    gSpecialPosting := TRUE;

                    DocumentIsPosted := NOT PurchaseHeader.GET("Document Type", "No.");

                    IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
                        CurrPage.CLOSE;

                    CurrPage.UPDATE(FALSE);

                    IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                        ShowPostedConfirmationMessage;
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
                    PurchPostPrint: Codeunit 92;
                    PurchaseHeader: Record 38;
                    InstructionMgt: Codeunit 1330;
                    ApprovalsMgmt: Codeunit 1535;
                    PrepaymentMgt: Codeunit 441;
                    Text50000: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ ''%1'' mit der Nummer %2 sind ungebuchte Vorauszahlungsbetr„ge vorhanden.;ITS=Sono presenti importi di pagamenti anticipati non registrati nel documento di tipo %1 con il numero %2.;FRS=Il existe des montants acompte non valid‚s sur le document de type %1 portant le num‚ro %2.';
                    Text50001: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.;DES=Fr den Beleg vom Typ %1 mit der Nummer %2 sind unbezahlte Vorauszahlungsrechnungen vorhanden.;ITS=Sono presenti fatture pagamenti anticipati non pagate correlate al documento di tipo %1 con il numero %2.;FRS=Il existe des factures d''acompte impay‚es li‚es au document de type %1 portant le num‚ro %2.';
                begin
                    IF ApprovalsMgmt.PrePostApprovalCheckPurch(Rec) THEN BEGIN
                        IF PrepaymentMgt.TestPurchasePrepayment(Rec) THEN
                            ERROR(STRSUBSTNO(Text50000, "Document Type", "No."));
                        IF PrepaymentMgt.TestPurchasePayment(Rec) THEN
                            IF NOT CONFIRM(STRSUBSTNO(Text50001, "Document Type", "No."), TRUE) THEN
                                EXIT;
                    END;

                    CLEAR(PurchPostPrint);
                    PurchPostPrint.SetSpecOrderPosting(TRUE);
                    PurchPostPrint.RUN(Rec);

                    PurchPostPrint.GetSpecialOrderBuffer(gTempSpecialSHBuffer);
                    gSpecialPosting := TRUE;

                    DocumentIsPosted := NOT PurchaseHeader.GET("Document Type", "No.");

                    IF "Job Queue Status" = "Job Queue Status"::"Scheduled for Posting" THEN
                        CurrPage.CLOSE;

                    CurrPage.UPDATE(FALSE);

                    IF InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) THEN
                        ShowPostedConfirmationMessage;
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
                    lUsage: Enum "DEL Usage DocMatrix Selection";
                    lcuDocumentMatrixMgt: Codeunit 50015;
                    ProcessType: Enum "DEL Process Type";
                    lrecDocMatrixSelection: Record 50071;
                begin
                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Buy-from Vendor No.", ProcessType::Manual, lUsage::"P.Order", lrecDocMatrixSelection, FALSE) THEN
                        lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"P.Order", ProcessType::Manual, Rec, Rec.FIELDNO("Buy-from Vendor No."), Rec.FIELDNO("No."), lrecDocMatrixSelection, Rec.FIELDNO("Purchaser Code"));
                end;
            }
        }
        addafter(Send)
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
                    SwissQRBillPurchases.UpdatePurchDocFromQRCode(Rec, FALSE);
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
                    SwissQRBillPurchases.UpdatePurchDocFromQRCode(Rec, TRUE);
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
                    SwissQRBillPurchases.VoidPurchDocQRBill(Rec);
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
                    PurchaseHeader: Record 38;
                    CduLMinimizingClicksNGTS: Codeunit 50012;
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
                    PurchaseHeader: Record 38;
                    CduLMinimizingClicksNGTS: Codeunit 50012;
                    ReportSelection: Record 77;
                    StandardPurchaseOrder: Report 1322;
                begin
                    PurchaseHeader := Rec;
                    PurchaseHeader.SETRECFILTER;
                    StandardPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                    StandardPurchaseOrder.RUNMODAL;
                end;
            }
        }
    }
}


