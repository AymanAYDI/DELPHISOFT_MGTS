pageextension 50058 "DEL PurchaseInvoice" extends "Purchase Invoice" //51
{
    layout
    {
        addafter("Posting Date")
        {
            field("DEL Due Date Calculation"; Rec."DEL Due Date Calculation") { }
        }
        addafter("Entry Point")
        {
            // TODO: specifique SUISS
            //group("DEL Swiss QR-Bill")
            // {
            //     field("DEL Swiss QRBill IBAN"; "Swiss QRBill IBAN")
            //     {
            //         ApplicationArea = Basic, Suite;
            //         trigger OnDrillDown()
            //         var
            //             SwissQRBillIncomingDoc: Codeunit 11516;
            //         begin
            //             SwissQRBillIncomingDoc.DrillDownVendorIBAN("Swiss QRBill IBAN");
            //         end;
            //     }
            //     field("DEL Swiss QRBill Amount"; "Swiss QRBill Amount")
            //     {
            //         Importance = Promoted;
            //         ApplicationArea = Basic, Suite;

            //     }
            //     field("DEL Swiss QRBill Currency"; "Swiss QRBill Currency")
            //     {
            //         Importance = Promoted;
            //         ApplicationArea = Basic, Suite;
            //     }
            //     field("DEL Swiss QRBill Unstr. Message"; "Swiss QRBill Unstr. Message")
            //     {
            //         Importance = Additional;
            //         ApplicationArea = Basic, Suite;

            //     }
            //     field("DEL Swiss QRBill Bill Info"; "Swiss QRBill Bill Info")
            //     {
            //         Importance = Additional;
            //         trigger OnDrillDown()
            //         var
            //             SwissQRBillBillingInfo: Codeunit 11519;
            //         begin
            //             SwissQRBillBillingInfo.DrillDownBillingInfo("Swiss QRBill Bill Info");
            //         end;
            //     }

            // }

        }
    }
    actions
    {
        addafter(RemoveFromJobQueue)
        {
            action("DEL Shipment Selection link")
            {
                Caption = 'Shipment Selection link';
                Promoted = true;
                PromotedIsBig = true;
                Image = Links;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    dealShipmentSelection_Re_Loc: Record 50031;
                    element_Re_Loc: Record 50021;
                    deal_ID_Co_Loc: Code[20];
                    deal_Re_Loc: Record 50020;
                    dealShipment_Re_Loc: Record 50030;
                    dealShipmentConnection_Re_Loc: Record 50032;
                    dealShipmentSelection_Page_Loc: Page 50038;
                begin
                    //on cherche si des lignes ont d‚j… ‚t‚ g‚n‚r‚e pour cette facture
                    dealShipmentSelection_Re_Loc.RESET();
                    dealShipmentSelection_Re_Loc.SETRANGE(dealShipmentSelection_Re_Loc."Document No.", "No.");
                    dealShipmentSelection_Re_Loc.SETRANGE("Document Type", dealShipmentSelection_Re_Loc."Document Type"::"Purchase Invoice Header");
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
                                    dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::"Purchase Invoice Header";
                                    dealShipmentSelection_Re_Loc."Document No." := "No.";
                                    dealShipmentSelection_Re_Loc.Deal_ID := deal_Re_Loc.ID;
                                    dealShipmentSelection_Re_Loc."Shipment No." := dealShipment_Re_Loc.ID;
                                    dealShipmentSelection_Re_Loc.USER_ID := USERID;

                                    dealShipmentSelection_Re_Loc."BR No." := dealShipment_Re_Loc."BR No.";

                                    dealShipmentSelection_Re_Loc."Purchase Invoice No." := dealShipment_Re_Loc."Purchase Invoice No.";

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

            group("DEL Swiss QR-Bill")
            {
                Caption = 'QR-Bill';
                action("DEL Swiss QR-Bill Scan")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    Image = Import;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        //TODOSwissQRBillPurchases.UpdatePurchDocFromQRCode(Rec, FALSE);
                    end;
                }
                action("DEL Swiss QR-Bill Import")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Scanned QR-Bill File';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;

                    trigger OnAction()
                    begin
                        //TODO SwissQRBillPurchases.UpdatePurchDocFromQRCode(Rec, TRUE);
                    end;
                }
                action("DEL Swiss QR-Bill Void")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    Image = VoidCheck;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        //TODO SwissQRBillPurchases.VoidPurchDocQRBill(Rec);
                    end;
                }

            }
        }
    }
    var
    //TODO SwissQRBillPurchases : Codeunit 11502;

}

