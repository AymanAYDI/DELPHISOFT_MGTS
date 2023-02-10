pageextension 50039 "DEL SalesInvoice" extends "Sales Invoice" //43
{
    layout
    {
        addafter("Your Reference")
        {
            field("DEL Fiscal Repr."; Rec."DEL Fiscal Repr.")
            {

            }
        }
    }

    actions
    {
        addafter("Move Negative Lines")
        {

            Action(ReverseProvision)
            {
                Caption = 'Applied entries for reverse';
                Image = SelectLineToApply;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Rec.ShowSelectedEntriesForReverse();
                end;
            }
        }

        addafter("Co&mments")
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
                    dealShipmentSelection_Re_Loc.SETRANGE("Document Type", dealShipmentSelection_Re_Loc."Document Type"::"Sales Invoice Header");
                    dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
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
                                    dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::"Sales Invoice Header";
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
                    dealShipmentSelection_Form_Loc.RUN()
                end;



            }
        }
        addafter(Post)
        {
            action("DEL PostAndPrint")
            {
                Caption = 'Post and &Print';
                Ellipsis = true;
                Image = PostPrint;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F9';

                trigger OnAction()
                var
                begin

                    // PostDocument(CODEUNIT::"Sales-Post + Print", NavigateAfterPost::Nowhere); TODO: procedure local 'PostDocument'
                end;
            }
        }
    }
}

