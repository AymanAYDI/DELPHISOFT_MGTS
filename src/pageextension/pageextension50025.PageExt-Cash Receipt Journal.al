pageextension 50025 pageextension50025 extends "Cash Receipt Journal"
{
    //             THM     31.05.13  added Shipment Selection
    // P160049_4   JUH     13.10.17  SEPA actions
    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1906888607".

        addafter("Control 12")
        {
            field("Shipment Selection"; "Shipment Selection")
            {

                trigger OnDrillDown()
                begin

                    CurrPage.UPDATE();
                    FNC_ShipmentLookup();
                    CurrPage.UPDATE();
                end;
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 1000014".

        addafter("Action 60")
        {
            action("Linked Shipments")
            {
                Caption = 'Linked Shipments';
                Image = Links;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DealShipmentSelection_Page_Loc: Page "50038";
                begin

                    IF "Document No." = '' THEN
                        ERROR('Document No. vide !');

                    IF "Document Type" <> "Document Type"::Invoice THEN
                        ERROR('Document Type doit etre Invoice');

                    //DealShipmentSelection_Form_Loc.FNC_OpenedBy("Document No.");
                    DealShipmentSelection_Page_Loc.RUNMODAL
                end;
            }
        }
        addafter("Action 84")
        {
            action(ImportBankStatement)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Read SEPA File';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //P160049_4 START
                    CurrPage.UPDATE;
                    ImportBankStatement;
                    //P160049_4 END
                end;
            }
            action(UpdateLineCamt)
            {
                Caption = 'Update Line (CAMT054)';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    GenJournalLine_Loc: Record "81";
                begin
                    //P160049_4 START
                    GenJournalLine_Loc.RESET;
                    GenJournalLine_Loc.SETRANGE(GenJournalLine_Loc."Journal Template Name", "Journal Template Name");
                    GenJournalLine_Loc.SETRANGE(GenJournalLine_Loc."Journal Batch Name", "Journal Batch Name");
                    REPORT.RUN(REPORT::"Update lines CAMT054", FALSE, FALSE, GenJournalLine_Loc);
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
        dealShipmentSelection_Page_Loc: Page "50038";
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

        CLEAR(dealShipmentSelection_Page_Loc);
        dealShipmentSelection_Page_Loc.FNC_SetGenJnlLine(Rec);
        dealShipmentSelection_Page_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
        dealShipmentSelection_Page_Loc.SETRECORD(dealShipmentSelection_Re_Loc);

        dealShipmentSelection_Page_Loc.RUN

    end;
}

