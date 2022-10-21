page 50052 "DEL M Deal Sales Inv. linking"
{

    Caption = 'Manual Deal Cr. Memo Linking';
    PageType = Card;
    Permissions = TableData "Sales Invoice Header" = rimd,
                  TableData "Sales Invoice Line" = rimd,
                  TableData "Dimension Set Entry" = rimd;   //  changement du table 350 --> 480
    SourceTable = "DEL Manual Deal Sales Inv. L";

    layout
    {
        area(content)
        {
            field("Sales Invoice No."; Rec."Sales Invoice No.")
            {
                Caption = 'Facture vente';
            }
            field("Deal ID"; Rec."Deal ID")
            {
                Caption = 'Deal ID destination';
            }
            field("Shipment Selection"; Rec."Shipment Selection")
            {
                Caption = 'Deal ID origine';
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Posts)
            {
                Caption = 'Post';
                action(Post)
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
                        ACOElement_Re_Loc: Record "DEL Element";
                        element_Re_Loc: Record "DEL Element";
                        urm_Re_Loc: Record "DEL Update Request Manager";
                        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
                        salesInvoiceHeader_Re_Loc: Record "Sales Invoice Header";
                        salesInvLine_Re_Loc: Record "Sales Invoice Line";
                        element_ID_Loc: Code[20];
                        last: Code[20];
                        requestID_Co_Loc: Code[20];
                        salesInvID_Co_Loc: Code[20];
                        shipmentID_Co_Loc: Code[20];
                        add_Variant_Op_Loc: Option New,Existing;
                    begin


                        IF Rec."Shipment Selection" = '' THEN
                            ERROR('Veuillez sélectionner au moins 1 livraison !')
                        ELSE BEGIN

                            //changer la référence sur l'ACO dans l'entete de la note de crédit (champ code achat) et sur les lignes
                            ChangeCodeAchat_FNC();

                            //Créer un élément facture vente pour la nouvelle affaire
                            salesInvoiceHeader_Re_Loc.GET(Rec."Sales Invoice No.");

                            Element_Cu.FNC_Add_Sales_Invoice(
                           Rec."Deal ID",
                             salesInvoiceHeader_Re_Loc,
                             Rec."Shipment Selection",
                             add_Variant_Op_Loc::New);
                            Position_CU.FNC_Add_SalesInvoice_Position(Rec."Deal ID", FALSE);
                            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                           Rec."Deal ID",
                             urm_Re_Loc.Requested_By_Type::Invoice,
                             Rec."Sales Invoice No.",
                             CURRENTDATETIME
                           );
                            urm_Re_Loc.GET(requestID_Co_Loc);
                            UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc, FALSE, FALSE, TRUE);
                            Rec.DELETE();
                        END;
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
        Deal_Cu: Codeunit "DEL Deal";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        DealShipment_Cu: Codeunit "DEL Deal Shipment";
        ShipmentConnection_Cu: Codeunit "DEL Deal Shipment Connection";
        Position_CU: Codeunit "DEL Position";
        Text19022230: Label 'M A N U A L   L I N K I N G';


    procedure ChangeCodeAchat_FNC()
    var

        //TODO PostedLine_Re_Loc: Record "Posted Document Dimension";
        PostedLine_Re_Loc: Record "Dimension Set Entry";   //  changement du table 359 --> 480  //Posted Document Dimension
        ACOConnection_Rec_Loc: Record "DEL ACO Connection";
        SalesInvoiceHeader_Re_Loc: Record "Sales Invoice Header";
        SalesInvoiceLine_Re_Loc: Record "Sales Invoice Line";
        NewCodeAchatNo_Co_Par: Code[20];
    begin
        ACOConnection_Rec_Loc.SETRANGE(Deal_ID, Rec."Deal ID");
        IF ACOConnection_Rec_Loc.FINDFIRST() THEN
            NewCodeAchatNo_Co_Par := ACOConnection_Rec_Loc."ACO No.";
        IF SalesInvoiceHeader_Re_Loc.GET(Rec."Sales Invoice No.") THEN BEGIN
            SalesInvoiceHeader_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
            SalesInvoiceHeader_Re_Loc.MODIFY();
        END;
        SalesInvoiceLine_Re_Loc.RESET();
        SalesInvoiceLine_Re_Loc.SETRANGE("Document No.", Rec."Sales Invoice No.");
        IF SalesInvoiceLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                SalesInvoiceLine_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
                SalesInvoiceLine_Re_Loc.MODIFY();
            UNTIL SalesInvoiceLine_Re_Loc.NEXT() = 0;
        //TODO //tab 480
        // PostedLine_Re_Loc.RESET();
        // PostedLine_Re_Loc.SETFILTER("Table ID", '%1|%2', 112, 113);
        // PostedLine_Re_Loc.SETRANGE("Document No.", Rec."Sales Invoice No.");
        // PostedLine_Re_Loc.SETRANGE("Dimension Code", 'ACHAT');
        //TODO: à tester dans le cronus
        PostedLine_Re_Loc.SETFILTER("Dimension Set ID", '%1|%2', 112, 113);
        PostedLine_Re_Loc.SetRange("Dimension Code", 'ACHAT');



        IF PostedLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                PostedLine_Re_Loc."Dimension Value Code" := NewCodeAchatNo_Co_Par;
                PostedLine_Re_Loc.MODIFY();
            UNTIL PostedLine_Re_Loc.NEXT() = 0;
    end;
}


