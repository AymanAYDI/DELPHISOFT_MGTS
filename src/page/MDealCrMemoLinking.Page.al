page 50082 "M Deal Cr. Memo Linking"
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
    // CHG04                            26.09.11   adapted deal update function with "updatePlanned" parameter

    Caption = 'Manual Deal Cr. Memo Linking';
    PageType = Card;
    Permissions = TableData 114 = rimd,
                  TableData 115 = rimd,
                  TableData 359 = rimd;
    SourceTable = Table50040;

    layout
    {
        area(content)
        {
            field("Sales Cr. Memo No."; "Sales Cr. Memo No.")
            {
                Caption = 'Note de crédit vente';
            }
            field("Deal ID"; "Deal ID")
            {
                Caption = 'Deal ID destination';
            }
            field("Shipment Selection"; "Shipment Selection")
            {
                Caption = 'Deal ID origine';
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
                        salesCrMemoHeader_Re_Loc: Record "114";
                        add_Variant_Op_Loc: Option New,Existing;
                        requestID_Co_Loc: Code[20];
                        urm_Re_Loc: Record "50039";
                        ACOElement_Re_Loc: Record "50021";
                    begin


                        IF "Shipment Selection" = '' THEN
                            ERROR('Veuillez sélectionner au moins 1 livraison !')
                        ELSE BEGIN

                            //changer la référence sur l'ACO dans l'entete de la note de crédit (champ code achat) et sur les lignes
                            //Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, "Shipment Selection");
                            ChangeCodeAchat_FNC();

                            //Créer un élément Note de crédit achat pour la nouvelle affaire
                            salesCrMemoHeader_Re_Loc.GET("Sales Cr. Memo No.");

                            Element_Cu.FNC_Add_Sales_Cr_Memo(
                              "Deal ID",
                              salesCrMemoHeader_Re_Loc,
                              "Shipment Selection",
                              add_Variant_Op_Loc::New);

                            Position_CU.FNC_Add_SalesCrMemo_Position("Deal ID", FALSE);

                            //mettre l'affaire à jour
                            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                              "Deal ID",
                              urm_Re_Loc.Requested_By_Type::"Sales Cr. Memo",
                              "Sales Cr. Memo No.",
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
        SalesCreditMemoLine_Re_Loc: Record "115";
        PostedLine_Re_Loc: Record "359";
        ACOConnection_Rec_Loc: Record "50026";
        NewCodeAchatNo_Co_Par: Code[20];
        DealShipment_Rec_Loc: Record "50030";
        SalesCreditMemoHeader_Re_Loc: Record "114";
    begin

        ACOConnection_Rec_Loc.SETRANGE(Deal_ID, "Deal ID");
        IF ACOConnection_Rec_Loc.FINDFIRST THEN
            NewCodeAchatNo_Co_Par := ACOConnection_Rec_Loc."ACO No.";




        IF SalesCreditMemoHeader_Re_Loc.GET("Sales Cr. Memo No.") THEN BEGIN
            SalesCreditMemoHeader_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
            SalesCreditMemoHeader_Re_Loc.MODIFY();
        END;

        SalesCreditMemoLine_Re_Loc.RESET();
        SalesCreditMemoLine_Re_Loc.SETRANGE("Document No.", "Sales Cr. Memo No.");
        IF SalesCreditMemoLine_Re_Loc.FINDFIRST THEN
            REPEAT
                SalesCreditMemoLine_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
                SalesCreditMemoLine_Re_Loc.MODIFY();
            UNTIL SalesCreditMemoLine_Re_Loc.NEXT = 0;

        PostedLine_Re_Loc.RESET();
        PostedLine_Re_Loc.SETFILTER("Table ID", '%1|%2', 114, 115);
        PostedLine_Re_Loc.SETRANGE("Document No.", "Sales Cr. Memo No.");
        PostedLine_Re_Loc.SETRANGE("Dimension Code", 'ACHAT');
        IF PostedLine_Re_Loc.FINDFIRST THEN
            REPEAT
                PostedLine_Re_Loc."Dimension Value Code" := NewCodeAchatNo_Co_Par;
                PostedLine_Re_Loc.MODIFY();
            UNTIL PostedLine_Re_Loc.NEXT = 0;
    end;
}

