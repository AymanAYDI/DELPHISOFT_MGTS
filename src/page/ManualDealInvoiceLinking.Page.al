#pragma implicitwith disable
page 50080 "Manual Deal Invoice Linking"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 02.03.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            02.03.09   created page
    // CHG02                            06.04.09   adapté l'appel de fonction de création de l'affaire
    // CHG03                            06.04.09   added requestUpdateManagement handling
    // CHG04                            22.07.10   Ajouté code pour supprimer les éléments existants associés à une facture qu'on veut
    //                                             répartir à nouveau.

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
                        dealShipment_Re_Loc: Record "DEL Deal Shipment";
                        feeConnection_Re_Loc: Record "DEL Fee Connection";
                        Add_Variant_Op_Loc: Option New,Existing;
                        nextEntry: Code[20];
                        myTab: array[100] of Code[20];
                        dss_Re_Loc: Record "DEL Deal Shipment Selection";
                        element_ID_Co_Loc: Code[20];
                        i: Integer;
                        splittIndex: Integer;
                        elementConnectionSplitIndex: Integer;
                        ConnectionType_Op_Par: Option Element,Shipment;
                        myUpdateRequests: array[100] of Code[20];
                        element_Re_Loc: Record "DEL Element";
                    begin
                        IF Rec."Shipment Selection" = 0 THEN
                            ERROR('Veuillez sélectionner au moins 1 livraison !');

                        //START CHG04
                        //On supprime les Elements existants associés à la facture qu'on veut répartir à nouveau
                        element_Re_Loc.RESET();
                        element_Re_Loc.SETCURRENTKEY("Entry No.", ID);
                        element_Re_Loc.SETRANGE("Entry No.", Rec."Entry No.");
                        IF element_Re_Loc.FIND('-') THEN
                            REPEAT
                                Element_Cu.FNC_Delete_Element(element_Re_Loc.ID);
                            UNTIL (element_Re_Loc.NEXT() = 0);
                        //STOP CHG04

                        nextEntry := '';
                        element_ID_Co_Loc := '';
                        i := 1;
                        CLEAR(myTab);
                        /*
                        SPLITTINDEX INFORMATION :
                        Si une facture est liée à 3 livraisons, 3 éléments de type "Invoice" sont créés.
                        Splitt Index indique le numéro de la facture partielle de l'élément et est utilisé pour définir la proportion du montant
                        lors de la création des positions.
                        */
                        splittIndex := 1;

                        //On cherche quelles livraisons ont été sélectionnées pour la facture
                        dealShipmentSelection_Re_Loc.RESET();
                        dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
                        dealShipmentSelection_Re_Loc.SETRANGE("Account Entry No.", Rec."Entry No.");
                        dealShipmentSelection_Re_Loc.SETRANGE(Checked, TRUE);
                        IF dealShipmentSelection_Re_Loc.FIND('-') THEN
                            REPEAT

                                //on ajoute la facture à l'affaire
                                element_ID_Co_Loc := Element_Cu.FNC_Add_New_Invoice(dealShipmentSelection_Re_Loc, splittIndex);
                                splittIndex += 1;

                                //ajouter une shipment connection
                                IF element_ID_Co_Loc <> '' THEN
                                    Element_Cu.FNC_Add_New_Invoice_Connection(element_ID_Co_Loc, dealShipmentSelection_Re_Loc, ConnectionType_Op_Par::Shipment,
                              0)
                                ELSE
                                    ERROR('element id vide !');

                                //ajouter les elements connections
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
                                    //MESSAGE('insert invoice connection ok');

                                    UNTIL (dss_Re_Loc.NEXT() = 0);

                                //si l'élément fait partie d'une nouvelle affaire, on crée une nouvelle update request
                                IF nextEntry <> dealShipmentSelection_Re_Loc.Deal_ID THEN BEGIN

                                    myTab[i] := dealShipmentSelection_Re_Loc.Deal_ID;

                                    //START CHG03
                                    myUpdateRequests[i] := UpdateRequestManager_Cu.FNC_Add_Request(
                                      dealShipmentSelection_Re_Loc.Deal_ID,
                                      dealShipmentSelection_Re_Loc."Document Type",
                                      dealShipmentSelection_Re_Loc."Document No.",
                                      CURRENTDATETIME
                                    );
                                    //STOP CHG03

                                    //MESSAGE('update for ' + myTab[i]);
                                    i += 1;
                                END;

                                nextEntry := dealShipmentSelection_Re_Loc.Deal_ID;

                            UNTIL (dealShipmentSelection_Re_Loc.NEXT() = 0);

                        //deleteall
                        dealShipmentSelection_Re_Loc.DELETEALL();

                        /*
                        i := 1;
                        WHILE i <= 100 DO BEGIN
                        
                          //START CHG02
                          IF myTab[i] <> '' THEN
                            Deal_Cu.FNC_Reinit_Deal(myTab[i],TRUE,FALSE);
                          //STOP CHG02
                        
                          //START CHG03
                          IF myUpdateRequests[i] <> '' THEN
                            UpdateRequestManager_Cu.FNC_Validate_Request(myUpdateRequests[i]);
                          //STOP CHG03
                        
                          i += 1;
                        
                        END;
                        */

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
        // Element_Cu: Codeunit "50021";
        // Deal_Cu: Codeunit "50020";
        // UpdateRequestManager_Cu: Codeunit "50032"; TODO:
        Text19022230: Label 'M A N U A L   L I N K I N G';


    procedure FNC_ShipmentLookup()
    var
        deal_Re_Loc: Record "DEL Deal";
        dealShipment_Re_Loc: Record "DEL Deal Shipment";
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
        dealShipmentSelection_page_Loc: Page "DEL Deal Shipment Selection";
    begin
        /*_
        1. On recherche des sélections ont été générées pour cette ligne de facture achat et si oui -> on les supprime
        2. On génère des sélections pour cette ligne de facture. On crée une ligne par livraison pour toutes les affaire non terminées
           -> Plus il y a d'affaires non terminées, plus le nombre de ligne est grand. Attention aux perpageances !
        _*/

        IF Rec."Entry No." = 0 THEN
            ERROR('Choisir un document !');

        dealShipmentSelection_Re_Loc.SETCURRENTKEY("Account Entry No.");
        dealShipmentSelection_Re_Loc.SETRANGE("Account Entry No.", Rec."Entry No.");
        dealShipmentSelection_Re_Loc.SETRANGE(dealShipmentSelection_Re_Loc.USER_ID, USERID);
        dealShipmentSelection_Re_Loc.DELETEALL();

        //Lister les deal, puis les livraisons qui y sont rattachées
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
        //dealShipmentSelection_page_Loc.FNC_SetGenJnlLine(Rec);
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

#pragma implicitwith restore

