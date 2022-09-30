page 50083 "M Deal Purcha Cr. Memo Linking"
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 02.03.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            02.03.09   created form
    // CHG02                            06.04.09   adapté l'appel de fonction de création de l'affaire
    // CHG03                            06.04.09   added requestUpdateManagement handling

    Caption = 'Manual Deal Cr. Memo Linking';
    ModifyAllowed = true;
    PageType = Card;
    Permissions = TableData 115 = rimd,
                  TableData 124 = rimd,
                  TableData 125 = rimd;
    SourceTable = Table50048;

    layout
    {
        area(content)
        {
            field("Purch Cr. Memo No."; "Purch Cr. Memo No.")
            {
                Caption = 'Note de crédit achat';
            }
            field("Deal ID"; "Deal ID")
            {
                Caption = 'Deal ID destination';
            }
            field("Shipment Selection"; "Shipment Selection")
            {
                Caption = 'Deal ID origine';
            }
            label()
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
            group(Post)
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
                        element_Re_Loc: Record "50021";
                        element_ID_Loc: Code[20];
                        dealShipmentSelection_Re_Loc: Record "50031";
                        salesInvLine_Re_Loc: Record "113";
                        salesInvHeader_Re_Loc: Record "112";
                        last: Code[20];
                        shipmentID_Co_Loc: Code[20];
                        salesInvID_Co_Loc: Code[20];
                        PurchCrMemoHeader_Re_Loc: Record "124";
                        add_Variant_Op_Loc: Option New,Existing;
                        requestID_Co_Loc: Code[20];
                        urm_Re_Loc: Record "50039";
                        ACOElement_Re_Loc: Record "50021";
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
        Element_Cu: Codeunit "50021";
        Deal_Cu: Codeunit "50020";
        UpdateRequestManager_Cu: Codeunit "50032";
        DealShipment_Cu: Codeunit "50029";
        ShipmentConnection_Cu: Codeunit "50027";
        Position_CU: Codeunit "50022";
        Text19022230: Label 'M A N U A L   L I N K I N G';


    procedure ChangeCodeAchat_FNC()
    var
        PurchCreditMemoLine_Re_Loc: Record "125";
        PostedLine_Re_Loc: Record "359";
        ACOConnection_Rec_Loc: Record "50026";
        NewCodeAchatNo_Co_Par: Code[20];
        DealShipment_Rec_Loc: Record "50030";
        PurchCreditMemoHeader_Re_Loc: Record "124";
    begin

        ACOConnection_Rec_Loc.SETRANGE(Deal_ID, "Deal ID");
        IF ACOConnection_Rec_Loc.FINDFIRST THEN
            NewCodeAchatNo_Co_Par := ACOConnection_Rec_Loc."ACO No.";




        IF PurchCreditMemoHeader_Re_Loc.GET("Purch Cr. Memo No.") THEN BEGIN
            PurchCreditMemoHeader_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
            PurchCreditMemoHeader_Re_Loc.MODIFY();
        END;

        PurchCreditMemoLine_Re_Loc.RESET();
        PurchCreditMemoLine_Re_Loc.SETRANGE("Document No.", "Purch Cr. Memo No.");
        IF PurchCreditMemoLine_Re_Loc.FINDFIRST THEN
            REPEAT
                PurchCreditMemoLine_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
                PurchCreditMemoLine_Re_Loc.MODIFY();
            UNTIL PurchCreditMemoLine_Re_Loc.NEXT = 0;

        PostedLine_Re_Loc.RESET();
        PostedLine_Re_Loc.SETFILTER("Table ID", '%1|%2', 124, 125);
        PostedLine_Re_Loc.SETRANGE("Document No.", "Purch Cr. Memo No.");
        PostedLine_Re_Loc.SETRANGE("Dimension Code", 'ACHAT');
        IF PostedLine_Re_Loc.FINDFIRST THEN
            REPEAT
                PostedLine_Re_Loc."Dimension Value Code" := NewCodeAchatNo_Co_Par;
                PostedLine_Re_Loc.MODIFY();
            UNTIL PostedLine_Re_Loc.NEXT = 0;
    end;
}

