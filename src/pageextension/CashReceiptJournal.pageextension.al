pageextension 50025 "DEL CashReceiptJournal" extends "Cash Receipt Journal" //255
{

    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 1906888607".

        addafter(Control1)
        {
            field("DEL Shipment Selection"; Rec."DEL Shipment Selection")
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

        addafter(Dimensions)
        {
            action("DEL Linked Shipments")
            {
                Caption = 'Linked Shipments';
                Image = Links;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DealShipmentSelection_Page_Loc: Page "DEL Deal Shipment Selection";
                begin

                    IF Rec."Document No." = '' THEN
                        ERROR('Document No. vide !');

                    IF Rec."Document Type" <> Rec."Document Type"::Invoice THEN
                        ERROR('Document Type doit etre Invoice');

                    //DealShipmentSelection_Form_Loc.FNC_OpenedBy("Document No.");
                    DealShipmentSelection_Page_Loc.RUNMODAL
                end;
            }
        }
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action("DEL ImportBankStatement")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Read SEPA File';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.UPDATE;
                    Rec.ImportBankStatement;
                end;
            }
            action("DEL UpdateLineCamt")
            {
                Caption = 'Update Line (CAMT054)';
                Image = UpdateDescription;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    GenJournalLine_Loc: Record "Gen. Journal Line";
                begin
                    GenJournalLine_Loc.RESET;
                    GenJournalLine_Loc.SETRANGE(GenJournalLine_Loc."Journal Template Name", Rec."Journal Template Name");
                    GenJournalLine_Loc.SETRANGE(GenJournalLine_Loc."Journal Batch Name", Rec."Journal Batch Name");
                    REPORT.RUN(REPORT::"Update lines CAMT054", FALSE, FALSE, GenJournalLine_Loc);
                end;
            }
        }
    }

    procedure FNC_ShipmentLookup()
    var
        deal_Re_Loc: Record "DEL Deal";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        dealShipmentSelection_Page_Loc: Page "DEL Deal Shipment Selection";
    begin
        IF Rec."Document No." = '' THEN
            ERROR('Document No. vide !');

        IF Rec."Account No." = '' THEN
            ERROR('Account No. vide !');

        IF Rec."Line No." = 0 THEN
            ERROR('Line No. vide !');

        IF Rec."Document Type" <> Rec."Document Type"::Payment THEN
            ERROR('Document Type doit être Payment');

        dealShipmentSelection_Re_Loc.RESET();
        dealShipmentSelection_Re_Loc.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", Rec."Line No.");
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
                        dealShipmentSelection_Re_Loc."Document No." := Rec."Document No.";
                        dealShipmentSelection_Re_Loc."Account Type" := Rec."Account Type";
                        dealShipmentSelection_Re_Loc."Account No." := Rec."Account No.";
                        dealShipmentSelection_Re_Loc."Document No." := Rec."Document No.";
                        dealShipmentSelection_Re_Loc.Deal_ID := deal_Re_Loc.ID;
                        dealShipmentSelection_Re_Loc."Shipment No." := dealShipment_Re_Loc.ID;
                        dealShipmentSelection_Re_Loc."Journal Template Name" := Rec."Journal Template Name";
                        dealShipmentSelection_Re_Loc."Journal Batch Name" := Rec."Journal Batch Name";
                        dealShipmentSelection_Re_Loc."Line No." := Rec."Line No.";
                        dealShipmentSelection_Re_Loc.USER_ID := USERID;

                        dealShipmentSelection_Re_Loc."BR No." := dealShipment_Re_Loc."BR No.";

                        dealShipmentSelection_Re_Loc."Purchase Invoice No." := dealShipment_Re_Loc."Purchase Invoice No.";

                        dealShipmentSelection_Re_Loc."Sales Invoice No." := dealShipment_Re_Loc."Sales Invoice No.";

                        IF ((dealShipmentSelection_Re_Loc."BR No." <> '') OR (dealShipmentSelection_Re_Loc."Purchase Invoice No." <> '')) THEN
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

