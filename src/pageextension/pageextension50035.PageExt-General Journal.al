pageextension 50035 pageextension50035 extends "General Journal"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.00.001
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version         Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001    MGTS10.00.001   18.12.19    mhh     List of changes:
    //                                             Added new field: "Customer Provision"
    // ------------------------------------------------------------------------------------------
    layout
    {

        //Unsupported feature: Property Modification (TableRelation) on "Control 300".


        //Unsupported feature: Property Modification (TableRelation) on "Control 302".


        //Unsupported feature: Property Modification (TableRelation) on "Control 304".


        //Unsupported feature: Property Modification (TableRelation) on "Control 306".


        //Unsupported feature: Property Modification (TableRelation) on "Control 308".


        //Unsupported feature: Property Modification (TableRelation) on "Control 310".

        addafter("Control 73")
        {
            field("Shipment Selection"; "Shipment Selection")
            {

                trigger OnDrillDown()
                begin

                    //CurrPage.UPDATE() ;
                    //FNC_ShipmentLookup();
                    //CurrPage.UPDATE();
                end;
            }
        }
        addafter("Control 38")
        {
            field("Customer Provision"; "Customer Provision")
            {
                Caption = 'Customer Provision';
            }
        }
    }
    actions
    {

        //Unsupported feature: Property Modification (RunPageLink) on "Action 1150010".


        //Unsupported feature: Property Modification (RunPageLink) on "ShowStatementLineDetails(Action 21)".

        addafter("Action 92")
        {
            action("Linked Shipment")
            {
                Caption = 'Linked Shipment';
                Ellipsis = true;
                Image = LinkAccount;
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
                    opener_Op_Loc: Option Invoice,"Purchase Header","Sales Header";
                begin
                    FNC_ShipmentLookup();
                    CurrPage.UPDATE;
                end;
            }
        }
    }

    var
        "Shipment Selection": Integer;
        DealShipment_Cu: Codeunit "50029";
        ElementConnection_Cu: Codeunit "50025";
        Element_Cu: Codeunit "50021";
        Deal_Cu: Codeunit "50020";

    procedure FNC_ShipmentLookup()
    var
        deal_Re_Loc: Record "50020";
        dealShipment_Re_Loc: Record "50030";
        dealShipmentSelection_Re_Loc: Record "50031";
        dealShipmentSelection_page_Loc: Page "50038";
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

        IF ("Document Type" <> "Document Type"::Invoice) AND ("Document Type" <> "Document Type"::Payment) THEN
            ERROR('Document Type doit être Invoice ou Payment');

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
                        dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::Invoice;
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

                        //dealShipmentSelection_Re_Loc."Purchase Invoice No."  := DealShipment_Cu.FNC_GetPurchaseInvoiceNo(dealShipment_Re_Loc.ID);
                        dealShipmentSelection_Re_Loc."Purchase Invoice No." := dealShipment_Re_Loc."Purchase Invoice No.";

                        //dealShipmentSelection_Re_Loc."Sales Invoice No."   := DealShipment_Cu.FNC_GetSalesInvoiceNo(dealShipment_Re_Loc.ID);
                        dealShipmentSelection_Re_Loc."Sales Invoice No." := dealShipment_Re_Loc."Sales Invoice No.";

                        //START GRC01
                        IF ((dealShipmentSelection_Re_Loc."BR No." <> '') OR (dealShipmentSelection_Re_Loc."Purchase Invoice No." <> '')) THEN
                            //STOP GRC01
                            dealShipmentSelection_Re_Loc.INSERT();

                    UNTIL (dealShipment_Re_Loc.NEXT() = 0);

            UNTIL (deal_Re_Loc.NEXT() = 0);

        CLEAR(dealShipmentSelection_page_Loc);
        dealShipmentSelection_page_Loc.FNC_SetGenJnlLine(Rec);
        dealShipmentSelection_page_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
        dealShipmentSelection_page_Loc.SETRECORD(dealShipmentSelection_Re_Loc);

        dealShipmentSelection_page_Loc.RUN

    end;
}

