pageextension 50040 "DEL SalesCreditMemo" extends "Sales Credit Memo"
{
    layout
    {
        modify("Sell-to Customer No.")
        {
            Style = Strong;
            StyleExpr = true;
        }
        addafter("Your Reference")
        {
            field("DEL Fiscal Repr."; Rec."DEL Fiscal Repr.")
            {

            }
        }
        addfirst(Billing)
        {
            field("DEL Bill-to Customer No."; Rec."Bill-to Customer No.")
            {
                Style = Strong;
                StyleExpr = true;
            }
        }

        addafter("Applies-to ID")
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
        addafter(Approvals)
        {
            action("DEL Linked Shipment")
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    deal_Re_Loc: Record "DEL Deal";
                    dealShipment_Re_Loc: Record "DEL Deal Shipment";
                    dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
                    dealShipmentSelection_Form_Loc: Page "DEL Deal Shipment Selection";
                begin


                    //on cherche si des lignes ont d‚j… ‚t‚ g‚n‚r‚e pour cette facture
                    dealShipmentSelection_Re_Loc.RESET();
                    dealShipmentSelection_Re_Loc.SETRANGE(dealShipmentSelection_Re_Loc."Document No.", Rec."No.");
                    dealShipmentSelection_Re_Loc.SETRANGE("Document Type", dealShipmentSelection_Re_Loc."Document Type"::"Sales Cr. Memo");
                    dealShipmentSelection_Re_Loc.DELETEALL();

                    //Lister les deal, puis les livraisons qui y sont rattach‚es
                    deal_Re_Loc.RESET();
                    deal_Re_Loc.SETFILTER(Status, '<>%1', deal_Re_Loc.Status::Closed);
                    IF deal_Re_Loc.FIND('-') THEN
                        REPEAT
                            dealShipment_Re_Loc.RESET();
                            dealShipment_Re_Loc.SETRANGE(Deal_ID, deal_Re_Loc.ID);
                            IF dealShipment_Re_Loc.FIND('-') THEN
                                REPEAT

                                    dealShipmentSelection_Re_Loc.INIT();
                                    dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::"Sales Cr. Memo";
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

                    CLEAR(dealShipmentSelection_Form_Loc);
                    dealShipmentSelection_Form_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
                    dealShipmentSelection_Form_Loc.SETRECORD(dealShipmentSelection_Re_Loc);
                    dealShipmentSelection_Form_Loc.RUN();
                end;
            }
        }

        addafter(Post)
        {
            action("DEL PostAndPrint")
            {
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';

                trigger OnAction()
                begin
                    // PostDocument(CODEUNIT::"Sales-Post + Print", NavigateAfterPost::Nowhere); TODO: procedure local 'PostDocument'
                end;
            }

            action("DEL PostAndMatrixPrint")
            {
                ApplicationArea = Basic, Suite;
                Image = Post;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedOnly = true;

                trigger OnAction()
                var

                    lrecDocMatrixSelection: Record "DEL DocMatrix Selection";
                    lrecSalesCrMemoHeader: Record "Sales Cr.Memo Header";

                    lcuDocumentMatrixMgt: Codeunit "DEL DocMatrix Management";
                    lCustNo: Code[20];
                    lNo: Code[20];
                    ProcessType: enum "DEL Process Type";
                    lUsage: enum "DEL Usage DocMatrix Selection";
                    lFieldCustNo: Integer;
                    lFieldNo: Integer;
                begin
                    lNo := Rec."No.";
                    lCustNo := Rec."Sell-to Customer No.";
                    lFieldNo := lrecSalesCrMemoHeader.FIELDNO("No.");
                    lFieldCustNo := lrecSalesCrMemoHeader.FIELDNO("Sell-to Customer No.");

                    IF lcuDocumentMatrixMgt.ShowDocMatrixSelection(Rec."Sell-to Customer No.", ProcessType::Manual, lUsage::"S.Cr.Memo".AsInteger(), lrecDocMatrixSelection, FALSE) THEN

                        // check if post is configured in DocMatrixSelection
                        IF lrecDocMatrixSelection.Post = lrecDocMatrixSelection.Post::Yes THEN
                            // PostDocument(CODEUNIT::"Sales-Post") TODO: procedure local 'PostDocument'
                            // ELSE
                            // EXIT; relate to TODO:

                            // if the CrMemo was posted, then we should find the "Posted Sales Credit Memo" to be further processed
                            IF lcuDocumentMatrixMgt.GetPostedSalesCreditMemo(lNo, lCustNo, lrecSalesCrMemoHeader) THEN
                                lcuDocumentMatrixMgt.ProcessDocumentMatrix(lUsage::"S.Cr.Memo".AsInteger(), ProcessType::Manual, lrecSalesCrMemoHeader, lFieldCustNo, lFieldNo, lrecDocMatrixSelection, 0);
                end;
            }
        }
    }
}

