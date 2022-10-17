pageextension 50050 "DEL PurchaseCreditMemo" extends "Purchase Credit Memo"
{
    layout
    {

        addafter("Buy-from")
        {
            field("DEL Due Date Calculation"; Rec."DEL Due Date Calculation")
            {
            }
        }
        addafter("Buy-from")
        {
            field("DEL Type Order EDI"; Rec."DEL Type Order EDI")
            {
                Editable = false;
            }
            field("DEL Type Order EDI Description"; Rec."DEL Type Order EDI Description")
            {
            }
        }
    }
    actions
    {


        addafter(Action132)
        {
            action("Livraison Liée")
            {
                Caption = 'Livraison Liée';
                Image = Links;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
                    element_Re_Loc: Record "DEL Element";
                    deal_Re_Loc: Record "DEL Deal";
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                    dealShipmentConnection_Re_Loc: Record "DEL Deal Shipment Connection";
                    dealShipmentSelection_Page_Loc: Page "DEL Deal Shipment Selection";
                    deal_ID_Co_Loc: Code[20];
                begin

                    //on cherche si des lignes ont déjà été générée pour cette facture
                    dealShipmentSelection_Re_Loc.RESET();
                    dealShipmentSelection_Re_Loc.SETRANGE(dealShipmentSelection_Re_Loc."Document No.", Rec."No.");
                    dealShipmentSelection_Re_Loc.SETRANGE("Document Type", dealShipmentSelection_Re_Loc."Document Type"::"Purch. Cr. Memo");
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
                                    dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::"Purch. Cr. Memo";
                                    dealShipmentSelection_Re_Loc."Document No." := Rec."No.";
                                    dealShipmentSelection_Re_Loc.Deal_ID := deal_Re_Loc.ID;
                                    dealShipmentSelection_Re_Loc."Shipment No." := dealShipment_Re_Loc.ID;
                                    dealShipmentSelection_Re_Loc.USER_ID := USERID;

                                    //dealShipmentSelection_Re_Loc."BR No."              := DealShipment_Cu.FNC_GetBRNo(dealShipment_Re_Loc.ID);
                                    dealShipmentSelection_Re_Loc."BR No." := dealShipment_Re_Loc."BR No.";

                                    //dealShipmentSelection_Re_Loc."Purchase Invoice No.":= DealShipment_Cu.FNC_GetPurchaseInvoiceNo(dealShipment_Re_Loc.ID);
                                    dealShipmentSelection_Re_Loc."Purchase Invoice No." := dealShipment_Re_Loc."Purchase Invoice No.";

                                    //dealShipmentSelection_Re_Loc."Sales Invoice No."   := DealShipment_Cu.FNC_GetSalesInvoiceNo(dealShipment_Re_Loc.ID);
                                    dealShipmentSelection_Re_Loc."Sales Invoice No." := dealShipment_Re_Loc."Sales Invoice No.";

                                    dealShipmentSelection_Re_Loc.INSERT();

                                UNTIL (dealShipment_Re_Loc.NEXT() = 0);

                        UNTIL (deal_Re_Loc.NEXT() = 0);

                    CLEAR(dealShipmentSelection_Page_Loc);
                    dealShipmentSelection_Page_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
                    dealShipmentSelection_Page_Loc.SETRECORD(dealShipmentSelection_Re_Loc);
                    dealShipmentSelection_Page_Loc.RUN();
                end;
            }
        }
    }
}

