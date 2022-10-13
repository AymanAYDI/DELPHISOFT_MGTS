pageextension 50026 pageextension50026 extends "Payment Journal"
{
    // 
    //             THM      31.05.13  added Shipment Selection
    // S160001_7   JUH      14.02.17  Add Field
    //             THM      08.09.17  MIG2017
    // P160049_4   JUH      13.10.17  SEPA Actions
    // DD-NAV-MGTS          13.06.18  Add function "Print Payment Journal Detail"
    // MGTS10.00.06.00    | 07.01.2022 | Send Payment Advice : List of changes:
    //                                              Add new Action "Send Payment Advice Detail"
    PromotedActionCategories = 'New,Process,Report,Bank,DTA,Prepare,Approve';
    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 7".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1906888707".

        addafter("Control 12")
        {
            field("Shipment Selection"; "Shipment Selection")
            {

                trigger OnDrillDown()
                begin

                    FNC_ShipmentLookup();
                end;
            }
        }
        addafter("Applied (Yes/No)")
        {
            field("Debit Bank"; "Debit Bank")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 1150116".


        //Unsupported feature: Property Modification (RunPageLink) on "PreviewCheck(Action 63)".

        addafter("Action 1150102")
        {
            action("Print Payment Journal Detail")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Print Payment Journal Detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                begin
                    //DD-NAV-MGTS 13.06.18
                    RunReportWithCurrentRec(REPORT::"DTA Payment Journal detail");
                end;
            }
        }
        addafter("Action 1150103")
        {
            action("&Print Payment Ad&vice detail")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print Payment Ad&vice detail';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    SRVendorPaymentAdviceDetai: Report "50035";
                begin
                    CLEAR(SRVendorPaymentAdviceDetai);
                    SRVendorPaymentAdviceDetai.DefineJourBatch(Rec);
                    SRVendorPaymentAdviceDetai.RUNMODAL;
                end;
            }
            action("Send Payment Advice Detail")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send Payment Advice Detail';
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = "Report";

                trigger OnAction()
                var
                    VendorPaymentAdviceMgt: Codeunit "50057";
                begin
                    //>>MGTS10.00.06.00
                    VendorPaymentAdviceMgt.SendPaymentAdvice(Rec."Journal Template Name", Rec."Journal Batch Name");
                    //<<MGTS10.00.06.00
                end;
            }
        }
        addafter(CreditTransferRegisters)
        {
            action(UpdateLine)
            {
                Caption = 'Update Lines';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //P160049_4 START
                    GenJnlLine.RESET;
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", "Journal Template Name");
                    GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", "Journal Batch Name");
                    REPORT.RUN(50050, TRUE, TRUE, GenJnlLine);
                    //P160049_4 END
                end;
            }
        }
    }

    procedure FNC_ShipmentLookup()
    var
        deal_Re_Loc: Record "50020";
        dealShipment_Re_Loc: Record "50030";
        dealShipmentSelection_Re_Loc: Record "50031";
        dealShipmentSelection_Form_Loc: Page "50038";
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

        //on cherche si des lignes ont déjà été générées pour cette facture et on les efface !
        dealShipmentSelection_Re_Loc.RESET();
        //START CHG01
        dealShipmentSelection_Re_Loc.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", "Journal Template Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", "Journal Batch Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", "Line No.");
        //STOP CHG01
        dealShipmentSelection_Re_Loc.DELETEALL();

        //Lister les deal, puis les livraisons qui y sont rattachées
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

