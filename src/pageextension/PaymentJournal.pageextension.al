pageextension 50026 "DEL PaymentJournal" extends "Payment Journal" //256
{
    PromotedActionCategories = 'New,Process,Report,Bank,DTA,Prepare,Approve';
    layout
    {


        addafter(Control1)
        {
            field("DEL Shipment Selection"; "DEL Shipment Selection")
            {

                trigger OnDrillDown()
                begin

                    FNC_ShipmentLookup();
                end;
            }
        }
        addafter("Applied (Yes/No)")
        {
            field("DEL Debit Bank"; "Debit Bank")
            {
            }
        }
    }
    actions
    {

        addafter("Print Payment Journal")
        {
            action("DEL Print Payment Journal Detail")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Payment Journal Detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin

                    RunReportWithCurrentRec(REPORT::"DTA Payment Journal detail");
                end;
            }
        }
        addafter("&Print Payment Ad&vice")
        {
            action("DEL &Print Payment Ad&vice detail")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print Payment Ad&vice detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    SRVendorPaymentAdviceDetai: Report "SR Vendor Payment Advice Detai";
                begin
                    CLEAR(SRVendorPaymentAdviceDetai);
                    SRVendorPaymentAdviceDetai.DefineJourBatch(Rec); //TODO : just to check if DefineJourBatch(Rec) works 
                    SRVendorPaymentAdviceDetai.RUNMODAL;
                end;
            }
            action("DEL Send Payment Advice Detail")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send Payment Advice Detail';
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    VendorPaymentAdviceMgt: Codeunit "DEL Vendor Payment Advice Mgt.";
                begin

                    VendorPaymentAdviceMgt.SendPaymentAdvice(Rec."Journal Template Name", Rec."Journal Batch Name");

                end;
            }
        }
        addafter(CreditTransferRegisters)
        {
            action("DEL UpdateLine")
            {
                Caption = 'Update Lines';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    GenJnlLine: Record "Gen. Journal Line";
                begin

                    GenJnlLine.RESET;
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", "Journal Template Name");
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", "Journal Batch Name");
                    REPORT.RUN(Report::"Update feuille paiement", TRUE, TRUE, GenJnlLine);

                end;
            }
        }
    }
    procedure RunReportWithCurrentRec(ReportID: Integer)
    var
        TempGenJnlLine: Record "Gen. Journal Line";
    begin
        TempGenJnlLine.Copy(Rec);
        TempGenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
        TempGenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
        REPORT.Run(ReportID, true, false, TempGenJnlLine);
    end;

    procedure FNC_ShipmentLookup()
    var
        deal_Re_Loc: Record "DEL Deal";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        dealShipmentSelection_Form_Loc: Page "DEL Deal Shipment Selection";
    begin
        /*_
        1. On recherche des sélections ont été générées pour cette ligne de facture achat et si oui -> on les supprime
        2. On génère des sélections pour cette ligne de facture. On crée une ligne par livraison pour toutes les affaire non terminées
           -> Plus il y a d'affaires non terminées, plus le nombre de ligne est grand. Attention aux performances !
        _*/

        IF "Document No." = '' THEN
            ERROR('Document No. vide !');

        IF "Account No." = '' THEN
            ERROR('Account No. vide !');

        IF "Line No." = 0 THEN
            ERROR('Line No. vide !');

        IF "Document Type" <> "Document Type"::Payment THEN
            ERROR('Document Type doit être Payment');

        dealShipmentSelection_Re_Loc.RESET();

        dealShipmentSelection_Re_Loc.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", "Journal Template Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", "Journal Batch Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", "Line No.");
        dealShipmentSelection_Re_Loc.DELETEALL();

        deal_Re_Loc.RESET();
        deal_Re_Loc.SETFILTER(Status, '<>%1', deal_Re_Loc.Status::Closed);
        IF deal_Re_Loc.FIND('-') THEN
            REPEAT
                dealShipment_Re_Loc.RESET();
                dealShipment_Re_Loc.SETRANGE(Deal_ID, deal_Re_Loc.ID);
                IF dealShipment_Re_Loc.FIND('-') THEN
                    REPEAT

                        dealShipmentSelection_Re_Loc.INIT();
                        dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::Payment;
                        dealShipmentSelection_Re_Loc."Document No." := "Document No.";
                        dealShipmentSelection_Re_Loc."Account Type" := "Account Type";
                        dealShipmentSelection_Re_Loc."Account No." := "Account No.";
                        dealShipmentSelection_Re_Loc."Document No." := "Document No.";
                        dealShipmentSelection_Re_Loc.Deal_ID := deal_Re_Loc.ID;
                        dealShipmentSelection_Re_Loc."Shipment No." := dealShipment_Re_Loc.ID;
                        dealShipmentSelection_Re_Loc."Journal Template Name" := "Journal Template Name";
                        dealShipmentSelection_Re_Loc."Journal Batch Name" := "Journal Batch Name";
                        dealShipmentSelection_Re_Loc."Line No." := "Line No.";
                        dealShipmentSelection_Re_Loc.USER_ID := USERID;

                        //dealShipmentSelection_Re_Loc."BR No."              := DealShipment_Cu.FNC_GetBRNo(dealShipment_Re_Loc.ID);
                        dealShipmentSelection_Re_Loc."BR No." := dealShipment_Re_Loc."BR No.";

                        //dealShipmentSelection_Re_Loc."Purchase Invoice No.":= DealShipment_Cu.FNC_GetPurchaseInvoiceNo(dealShipment_Re_Loc.ID);
                        dealShipmentSelection_Re_Loc."Purchase Invoice No." := dealShipment_Re_Loc."Purchase Invoice No.";

                        //dealShipmentSelection_Re_Loc."Sales Invoice No."   := DealShipment_Cu.FNC_GetSalesInvoiceNo(dealShipment_Re_Loc.ID);
                        dealShipmentSelection_Re_Loc."Sales Invoice No." := dealShipment_Re_Loc."Sales Invoice No.";

                        //START GRC01
                        IF ((dealShipmentSelection_Re_Loc."BR No." <> '') OR (dealShipmentSelection_Re_Loc."Purchase Invoice No." <> '')) THEN
                            //STOP GRC01
                            dealShipmentSelection_Re_Loc.INSERT();

                    UNTIL (dealShipment_Re_Loc.NEXT() = 0);

            UNTIL (deal_Re_Loc.NEXT() = 0);

        CLEAR(dealShipmentSelection_Form_Loc);
        dealShipmentSelection_Form_Loc.FNC_SetGenJnlLine(Rec);
        dealShipmentSelection_Form_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
        dealShipmentSelection_Form_Loc.SETRECORD(dealShipmentSelection_Re_Loc);

        dealShipmentSelection_Form_Loc.RUN

    end;
}

