pageextension 50035 "DEL GeneralJournal" extends "General Journal" //39
{
    layout
    {
        addafter("Reason Code")
        {
            field("DEL Shipment Selection"; Rec."DEL Shipment Selection")
            {

            }
        }
        addafter("Direct Debit Mandate ID")
        {
            field("DEL Customer Provision"; Rec."DEL Customer Provision")
            {
                Caption = 'Customer Provision';
            }
        }
    }
    actions
    {
        addafter("Insert Conv. LCY Rndg. Lines")
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
    }


    procedure FNC_ShipmentLookup()
    var
        deal_Re_Loc: Record "DEL Deal";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        dealShipmentSelection_page_Loc: Page "DEL Deal Shipment Selection";
    begin


        IF Rec."Document No." = '' THEN
            ERROR('Document No. vide !');

        IF Rec."Account No." = '' THEN
            ERROR('Account No. vide !');

        IF Rec."Line No." = 0 THEN
            ERROR('Line No. vide !');

        IF (Rec."Document Type" <> Rec."Document Type"::Invoice) AND (Rec."Document Type" <> Rec."Document Type"::Payment) THEN
            ERROR('Document Type doit être Invoice ou Payment');

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
        IF deal_Re_Loc.FIND('-') THEN
            REPEAT
                dealShipment_Re_Loc.RESET();
                dealShipment_Re_Loc.SETRANGE(Deal_ID, deal_Re_Loc.ID);
                IF dealShipment_Re_Loc.FIND('-') THEN
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

        CLEAR(dealShipmentSelection_page_Loc);
        dealShipmentSelection_page_Loc.FNC_SetGenJnlLine(Rec);
        dealShipmentSelection_page_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
        dealShipmentSelection_page_Loc.SETRECORD(dealShipmentSelection_Re_Loc);

        dealShipmentSelection_page_Loc.RUN();

    end;
}

