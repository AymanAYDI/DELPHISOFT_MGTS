pageextension 50024 "DEL PurchaseJournal" extends "Purchase Journal"
{
    layout
    {


        addafter(Control1)
        {
            field("DEL Payment Reference"; Rec."Payment Reference")
            {
                ApplicationArea = Basic, Suite;
                //TODO  // Editable = NOT "Swiss QRBill";
                ToolTip = 'Specifies the payment reference number.';
            }
        }
        addafter("Control1")
        {
            field("DEL Shipment Selection"; Rec."DEL Shipment Selection")
            {
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action("DEL Linked Shipment")
            {
                Caption = 'Linked Shipment';
                Ellipsis = true;
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()

                begin
                    FNC_ShipmentLookup();
                    CurrPage.UPDATE();
                end;
            }
        }
        addafter("P&osting")
        {
            group("DEL Swiss QR-Bill")
            {
                Caption = 'QR-Bill';
                action("DEL Swiss QR-Bill Scan")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Scan QR-Bill';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Create a new line from the scanning of QR-bill with an input scanner, or from manual (copy/paste) of the decoded QR-Code text value into a field.';
                    //TODO
                    // trigger OnAction()
                    // begin
                    //     SwissQRBillPurchases.NewPurchaseJournalLineFromQRCode(Rec, FALSE);
                    // end;
                }
                action("DEL Swiss QR-Bill Import")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Scanned QR-Bill File';
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Creates a new line by importing a scanned QR-bill that is saved as a text file.';
                    //TODO
                    // trigger OnAction()
                    // begin
                    //     SwissQRBillPurchases.NewPurchaseJournalLineFromQRCode(Rec, TRUE);
                    // end;
                }
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
        /*_
        1. On recherche des sélections ont été générées pour cette ligne de facture achat et si oui -> on les supprime
        2. On génère des sélections pour cette ligne de facture. On crée une ligne par livraison pour toutes les affaire non terminées
           -> Plus il y a d'affaires non terminées, plus le nombre de ligne est grand. Attention aux performances !
        _*/

        IF Rec."Document No." = '' THEN
            ERROR('Document No. vide !');

        IF Rec."Account No." = '' THEN
            ERROR('Account No. vide !');

        IF Rec."Line No." = 0 THEN
            ERROR('Line No. vide !');

        IF (Rec."Document Type" <> Rec."Document Type"::Invoice) THEN
            IF (Rec."Document Type" <> Rec."Document Type"::"Credit Memo") THEN
                ERROR('Le type de documument doit être Facture ou Avoir !');

        //on cherche si des lignes ont déjà été générées pour cette facture et on les efface !
        dealShipmentSelection_Re_Loc.RESET();
        dealShipmentSelection_Re_Loc.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Template Name", Rec."Journal Template Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
        dealShipmentSelection_Re_Loc.SETRANGE("Line No.", Rec."Line No.");
        dealShipmentSelection_Re_Loc.DELETEALL();

        //Lister les deal, puis les livraisons qui y sont rattachées
        deal_Re_Loc.RESET();
        deal_Re_Loc.SETFILTER(Status, '<>%1', deal_Re_Loc.Status::Closed);
        IF deal_Re_Loc.FindSet() THEN
            REPEAT
                dealShipment_Re_Loc.RESET();
                dealShipment_Re_Loc.SETRANGE(Deal_ID, deal_Re_Loc.ID);
                IF dealShipment_Re_Loc.FindSet() THEN
                    REPEAT

                        dealShipmentSelection_Re_Loc.INIT();
                        dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::Invoice;
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
        dealShipmentSelection_Page_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
        dealShipmentSelection_Page_Loc.SETRECORD(dealShipmentSelection_Re_Loc);

        PAGE.RUN(Page::"DEL Deal Shipment Selection", dealShipmentSelection_Re_Loc);

    end;
}

