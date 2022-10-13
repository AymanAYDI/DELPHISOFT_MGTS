pageextension 50050 pageextension50050 extends "Purchase Credit Memo"
{
    // 
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // |                                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG                              11.05.09   added ShipmentSelection link
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.024
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.024       09.02.21    mhh     List of changes:
    //                                             Added new field: "Due Date Calculation"
    // ------------------------------------------------------------------------------------------
    layout
    {

        //Unsupported feature: Property Modification (SubPageLink) on "Control 15".


        //Unsupported feature: Property Modification (SubPageLink) on "Control 5".

        addafter("Control 39")
        {
            field("Due Date Calculation"; "Due Date Calculation")
            {
            }
        }
        addafter("Control 101")
        {
            field("Type Order EDI"; "Type Order EDI")
            {
                Editable = false;
            }
            field("Type Order EDI Description"; "Type Order EDI Description")
            {
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 51".

        addafter("Action 132")
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
                    dealShipmentSelection_Re_Loc: Record "50031";
                    element_Re_Loc: Record "50021";
                    deal_ID_Co_Loc: Code[20];
                    deal_Re_Loc: Record "50020";
                    dealShipment_Re_Loc: Record "50030";
                    dealShipmentConnection_Re_Loc: Record "50032";
                    dealShipmentSelection_Page_Loc: Page "50038";
                begin

                    //on cherche si des lignes ont déjà été générée pour cette facture
                    dealShipmentSelection_Re_Loc.RESET();
                    dealShipmentSelection_Re_Loc.SETRANGE(dealShipmentSelection_Re_Loc."Document No.", "No.");
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
                                    dealShipmentSelection_Re_Loc."Document No." := "No.";
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
                    dealShipmentSelection_Page_Loc.RUN
                end;
            }
        }
    }
}

