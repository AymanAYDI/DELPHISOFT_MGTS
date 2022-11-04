
page 50080 "DEL Manual Deal Invoice Link."
{


    Caption = 'Manual Deal Invoice Linking';
    PageType = Card;
    SourceTable = "DEL Manual Deal Inv. Linking";

    layout
    {
        area(content)
        {
            field("Entry No."; Rec."Entry No.")
            {

                trigger OnValidate()
                begin
                    EntryNoOnAfterValidate();
                end;
            }
            field("Document No."; Rec."Document No.")
            {
                Editable = false;
            }
            field("Account No."; Rec."Account No.")
            {
                Editable = false;
            }
            field("Shipment Selection"; Rec."Shipment Selection")
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
        area(navigation)
        {
            group(Post)
            {
                Caption = 'Post';
                action(Post1)
                {
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var
                        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
                        dss_Re_Loc: Record "DEL Deal Shipment Selection";
                        element_Re_Loc: Record "DEL Element";
                        element_ID_Co_Loc: Code[20];
                        myTab: array[100] of Code[20];
                        myUpdateRequests: array[100] of Code[20];
                        nextEntry: Code[20];
                        elementConnectionSplitIndex: Integer;
                        i: Integer;
                        splittIndex: Integer;
                        ConnectionType_Op_Par: Enum "Element/Shipment";
                    begin
                        IF Rec."Shipment Selection" = 0 THEN
                            ERROR('Veuillez sélectionner au moins 1 livraison !');


                        element_Re_Loc.RESET();
                        element_Re_Loc.SETCURRENTKEY("Entry No.", ID);
                        element_Re_Loc.SETRANGE("Entry No.", Rec."Entry No.");
                        IF element_Re_Loc.FIND('-') THEN
                            REPEAT
                                Element_Cu.FNC_Delete_Element(element_Re_Loc.ID);
                            UNTIL (element_Re_Loc.NEXT() = 0);


                        nextEntry := '';
                        element_ID_Co_Loc := '';
                        i := 1;
                        CLEAR(myTab);

                        splittIndex := 1;


                        dealShipmentSelection_Re_Loc.RESET();
                        dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
                        dealShipmentSelection_Re_Loc.SETRANGE("Account Entry No.", Rec."Entry No.");
                        dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
                        IF dealShipmentSelection_Re_Loc.FIND('-') THEN
                            REPEAT

                                element_ID_Co_Loc := Element_Cu.FNC_Add_New_Invoice(dealShipmentSelection_Re_Loc, splittIndex);
                                splittIndex += 1;

                                IF element_ID_Co_Loc <> '' THEN
                                    Element_Cu.FNC_Add_New_Invoice_Connection(element_ID_Co_Loc, dealShipmentSelection_Re_Loc, ConnectionType_Op_Par::Shipment,
                              0)
                                ELSE
                                    ERROR('element id vide !');


                                elementConnectionSplitIndex := 1;
                                dss_Re_Loc.RESET();
                                dss_Re_Loc.SETRANGE(USER_ID, USERID);
                                dss_Re_Loc.SETRANGE("Account Entry No.", Rec."Entry No.");
                                dss_Re_Loc.SETRANGE(Checked, TRUE);
                                IF dss_Re_Loc.FIND('-') THEN
                                    REPEAT

                                        Element_Cu.FNC_Add_New_Invoice_Connection(
                                          element_ID_Co_Loc, dss_Re_Loc, ConnectionType_Op_Par::Element, elementConnectionSplitIndex);
                                        elementConnectionSplitIndex += 1;


                                    UNTIL (dss_Re_Loc.NEXT() = 0);


                                IF nextEntry <> dealShipmentSelection_Re_Loc.Deal_ID THEN BEGIN

                                    myTab[i] := dealShipmentSelection_Re_Loc.Deal_ID;


                                    myUpdateRequests[i] := UpdateRequestManager_Cu.FNC_Add_Request(
                                      dealShipmentSelection_Re_Loc.Deal_ID,
                                      dealShipmentSelection_Re_Loc."Document Type",
                                      dealShipmentSelection_Re_Loc."Document No.",
                                      CURRENTDATETIME
                                    );

                                    i += 1;
                                END;

                                nextEntry := dealShipmentSelection_Re_Loc.Deal_ID;

                            UNTIL (dealShipmentSelection_Re_Loc.NEXT() = 0);


                        dealShipmentSelection_Re_Loc.DELETEALL();



                        Rec.DELETE();

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.DELETEALL();
        Rec.FILTERGROUP(3);
        Rec.SETFILTER("User ID Filter", USERID);
        Rec.FILTERGROUP(0);
    end;

    var
        Element_Cu: Codeunit "DEL Element";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";


    procedure FNC_ShipmentLookup()
    var
        deal_Re_Loc: Record "DEL Deal";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        dealShipmentSelection_page_Loc: Page "DEL Deal Shipment Selection";
    begin


        IF Rec."Entry No." = 0 THEN
            ERROR('Choisir un document !');

        dealShipmentSelection_Re_Loc.SETCURRENTKEY("Account Entry No.");
        dealShipmentSelection_Re_Loc.SETRANGE("Account Entry No.", Rec."Entry No.");
        dealShipmentSelection_Re_Loc.SETRANGE(dealShipmentSelection_Re_Loc.USER_ID, USERID);
        dealShipmentSelection_Re_Loc.DELETEALL();


        deal_Re_Loc.RESET();
        deal_Re_Loc.SETFILTER(Status, '<>%1', deal_Re_Loc.Status::Closed);
        IF deal_Re_Loc.FINDFIRST() THEN
            REPEAT
                dealShipment_Re_Loc.RESET();
                dealShipment_Re_Loc.SETRANGE(Deal_ID, deal_Re_Loc.ID);
                IF dealShipment_Re_Loc.FINDFIRST() THEN
                    REPEAT

                        dealShipmentSelection_Re_Loc.INIT();
                        dealShipmentSelection_Re_Loc."Document Type" := dealShipmentSelection_Re_Loc."Document Type"::Invoice;
                        dealShipmentSelection_Re_Loc."Document No." := Rec."Document No.";
                        dealShipmentSelection_Re_Loc."Account No." := Rec."Account No.";
                        dealShipmentSelection_Re_Loc."Account Entry No." := Rec."Entry No.";
                        dealShipmentSelection_Re_Loc.Deal_ID := deal_Re_Loc.ID;
                        dealShipmentSelection_Re_Loc."Shipment No." := dealShipment_Re_Loc.ID;
                        dealShipmentSelection_Re_Loc.USER_ID := USERID;


                        dealShipmentSelection_Re_Loc."BR No." := dealShipment_Re_Loc."BR No.";


                        dealShipmentSelection_Re_Loc."Purchase Invoice No." := dealShipment_Re_Loc."Purchase Invoice No.";


                        dealShipmentSelection_Re_Loc."Sales Invoice No." := dealShipment_Re_Loc."Sales Invoice No.";


                        IF ((dealShipmentSelection_Re_Loc."BR No." <> '') OR (dealShipmentSelection_Re_Loc."Purchase Invoice No." <> '')) THEN
                            dealShipmentSelection_Re_Loc.INSERT();

                    UNTIL (dealShipment_Re_Loc.NEXT() = 0);

            UNTIL (deal_Re_Loc.NEXT() = 0);

        CLEAR(dealShipmentSelection_page_Loc);

        dealShipmentSelection_page_Loc.SETTABLEVIEW(dealShipmentSelection_Re_Loc);
        dealShipmentSelection_page_Loc.SETRECORD(dealShipmentSelection_Re_Loc);

        dealShipmentSelection_page_Loc.RUN()

    end;

    local procedure EntryNoOnAfterValidate()
    var
        GLEntry_Re_Loc: Record "G/L Entry";
    begin
        GLEntry_Re_Loc.GET(Rec."Entry No.");
        Rec."Document No." := GLEntry_Re_Loc."Document No.";
        Rec."Account No." := GLEntry_Re_Loc."G/L Account No.";
    end;
}



