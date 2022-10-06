page 50083 "DEL M Deal Pur. Cr. Memo Link"
{

    Caption = 'Manual Deal Cr. Memo Linking';
    ModifyAllowed = true;
    PageType = Card;
    Permissions = TableData "Sales Cr.Memo Line" = rimd,
                  TableData "Purch. Cr. Memo Hdr." = rimd,
                  TableData "Purch. Cr. Memo Line" = rimd;
    SourceTable = "DEL Manual Purch. Cr. Memo L";

    layout
    {
        area(content)
        {
            field("Purch Cr. Memo No."; Rec."Purch Cr. Memo No.")
            {
                Caption = 'Note de crédit achat';
            }
            field("Deal ID"; Rec."Deal ID")
            {
                Caption = 'Deal ID destination';
            }
            field("Shipment Selection"; Rec."Shipment Selection")
            {
                Caption = 'Deal ID origine';
            }
            label(General)
            {
                CaptionClass = Text19022230;
                Style = Standard;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(MgtsPost)
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
                        element_Re_Loc: Record "DEL Element";
                        element_ID_Loc: Code[20];
                        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
                        salesInvLine_Re_Loc: Record "Sales Invoice Line";
                        salesInvHeader_Re_Loc: Record "Sales Invoice Header";
                        last: Code[20];
                        shipmentID_Co_Loc: Code[20];
                        salesInvID_Co_Loc: Code[20];
                        PurchCrMemoHeader_Re_Loc: Record "Purch. Cr. Memo Hdr.";
                        add_Variant_Op_Loc: Option New,Existing;
                        requestID_Co_Loc: Code[20];
                        urm_Re_Loc: Record "DEL Update Request Manager";
                        ACOElement_Re_Loc: Record "DEL Element";
                    begin


                        IF "Shipment Selection" = '' THEN
                            ERROR('Veuillez sélectionner au moins 1 livraison !')
                        ELSE BEGIN

                            //changer la référence sur l'ACO dans l'entete de la note de crédit (champ code achat) et sur les lignes
                            Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, "Shipment Selection");
                            ChangeCodeAchat_FNC();

                            //Créer un élément Note de crédit achat pour la nouvelle affaire
                            PurchCrMemoHeader_Re_Loc.GET("Purch Cr. Memo No.");

                            Element_Cu.FNC_Add_Purch_Cr_Memo(
                               "Deal ID",
                               PurchCrMemoHeader_Re_Loc,
                               "Shipment Selection",
                               add_Variant_Op_Loc::New);

                            Position_CU.FNC_Add_PurchCrMemo_Position("Deal ID", FALSE);

                            //mettre l'affaire à jour
                            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                              "Deal ID",
                              urm_Re_Loc.Requested_By_Type::"Purch. Cr. Memo",
                              "Purch Cr. Memo No.",
                              CURRENTDATETIME
                            );



                            // urm_Re_Loc.GET(requestID_Co_Loc);
                            // UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,TRUE);

                            Rec.DELETE();

                        END;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        DELETEALL();
        FILTERGROUP(3);
        SETFILTER("User ID Filter", USERID);
        FILTERGROUP(0);
    end;

    var
        //TODO: until we get codeunits
        Element_Cu: Codeunit "DEL Element";
        Deal_Cu: Codeunit "DEL Deal";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        DealShipment_Cu: Codeunit "DEL Deal Shipment";
        ShipmentConnection_Cu: Codeunit "DEL Deal Shipment Connection";
        Position_CU: Codeunit "DEL Position";
        Text19022230: Label 'M A N U A L   L I N K I N G';


    procedure ChangeCodeAchat_FNC()
    var
        DealShipment_Rec_Loc: Record "DEL Deal Shipment";
        PurchCreditMemoHeader_Re_Loc: Record "Purch. Cr. Memo Hdr.";
        PurchCreditMemoLine_Re_Loc: Record "Purch. Cr. Memo Line";
        //PostedLine_Re_Loc: Record 359;
        PostedLine_Re_Loc: Record "Dimension Set Entry";
        ACOConnection_Rec_Loc: Record "DEL ACO Connection";
        NewCodeAchatNo_Co_Par: Code[20];

    begin

        ACOConnection_Rec_Loc.SETRANGE(Deal_ID, "Deal ID");
        IF ACOConnection_Rec_Loc.FINDFIRST() THEN
            NewCodeAchatNo_Co_Par := ACOConnection_Rec_Loc."ACO No.";




        IF PurchCreditMemoHeader_Re_Loc.GET("Purch Cr. Memo No.") THEN BEGIN
            PurchCreditMemoHeader_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
            PurchCreditMemoHeader_Re_Loc.MODIFY();
        END;

        PurchCreditMemoLine_Re_Loc.RESET();
        PurchCreditMemoLine_Re_Loc.SETRANGE("Document No.", "Purch Cr. Memo No.");
        IF PurchCreditMemoLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                PurchCreditMemoLine_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
                PurchCreditMemoLine_Re_Loc.MODIFY();
            UNTIL PurchCreditMemoLine_Re_Loc.NEXT() = 0;

        PostedLine_Re_Loc.RESET();
        //à voir PostedLine_Re_Loc.SETFILTER("Table ID", '%1|%2', 124, 125);
        PostedLine_Re_Loc.SETFILTER("Dimension Set ID", '%1|%2', 124, 125);
        //TODO PostedLine_Re_Loc.SETRANGE("Document No.", "Purch Cr. Memo No.");
        PostedLine_Re_Loc.SETRANGE("Dimension Code", 'ACHAT');
        IF PostedLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                PostedLine_Re_Loc."Dimension Value Code" := NewCodeAchatNo_Co_Par;
                PostedLine_Re_Loc.MODIFY();
            UNTIL PostedLine_Re_Loc.NEXT() = 0;
    end;
}

