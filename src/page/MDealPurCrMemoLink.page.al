page 50083 "DEL M Deal Pur. Cr. Memo Link"
{

    Caption = 'Manual Deal Cr. Memo Linking';
    ModifyAllowed = true;
    PageType = Card;
    Permissions = TableData "Sales Cr.Memo Line" = rimd,
                  TableData "Purch. Cr. Memo Hdr." = rimd,
                  TableData "Purch. Cr. Memo Line" = rimd;
    SourceTable = "DEL Manual Purch. Cr. Memo L";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            field("Purch Cr. Memo No."; Rec."Purch Cr. Memo No.")
            {
                Caption = 'Note de crédit achat';
                ApplicationArea = All;
            }
            field("Deal ID"; Rec."Deal ID")
            {
                Caption = 'Deal ID destination';
                ApplicationArea = All;
            }
            field("Shipment Selection"; Rec."Shipment Selection")
            {
                Caption = 'Deal ID origine';
                ApplicationArea = All;
            }
            label(General)
            {
                CaptionClass = Text19022230;
                Style = Standard;
                StyleExpr = TRUE;
                ApplicationArea = All;
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
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ACOElement_Re_Loc: Record "DEL Element";
                        urm_Re_Loc: Record "DEL Update Request Manager";
                        PurchCrMemoHeader_Re_Loc: Record "Purch. Cr. Memo Hdr.";
                        requestID_Co_Loc: Code[20];
                        add_Variant_Op_Loc: Option New,Existing;


                    begin


                        IF Rec."Shipment Selection" = '' THEN
                            ERROR('Veuillez sélectionner au moins 1 livraison !')
                        ELSE BEGIN


                            Deal_Cu.FNC_Get_ACO(ACOElement_Re_Loc, Rec."Shipment Selection");
                            ChangeCodeAchat_FNC();

                            PurchCrMemoHeader_Re_Loc.GET(Rec."Purch Cr. Memo No.");

                            Element_Cu.FNC_Add_Purch_Cr_Memo(
                               Rec."Deal ID",
                               PurchCrMemoHeader_Re_Loc,
                               Rec."Shipment Selection",
                               add_Variant_Op_Loc::New);

                            Position_CU.FNC_Add_PurchCrMemo_Position(Rec."Deal ID", FALSE);

                            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                              Rec."Deal ID",
                              urm_Re_Loc.Requested_By_Type::"Purch. Cr. Memo",
                              Rec."Purch Cr. Memo No.",
                              CURRENTDATETIME
                            );

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

        Deal_Cu: Codeunit "DEL Deal";
        Element_Cu: Codeunit "DEL Element";
        Position_CU: Codeunit "DEL Position";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
        Text19022230: Label 'M A N U A L   L I N K I N G';


    procedure ChangeCodeAchat_FNC()
    var

        ACOConnection_Rec_Loc: Record "DEL ACO Connection";
        //---j'ai changé le record 359 par le record 480 => à vérifier---//
        // PostedLine_Re_Loc: Record 359;
        PostedLine_Re_Loc: Record "Dimension Set Entry";
        PurchCreditMemoHeader_Re_Loc: Record "Purch. Cr. Memo Hdr.";
        PurchCreditMemoLine_Re_Loc: Record "Purch. Cr. Memo Line";
        NewCodeAchatNo_Co_Par: Code[20];

    begin

        ACOConnection_Rec_Loc.SETRANGE(Deal_ID, Rec."Deal ID");
        IF ACOConnection_Rec_Loc.FINDFIRST() THEN
            NewCodeAchatNo_Co_Par := ACOConnection_Rec_Loc."ACO No.";




        IF PurchCreditMemoHeader_Re_Loc.GET(Rec."Purch Cr. Memo No.") THEN BEGIN
            PurchCreditMemoHeader_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
            PurchCreditMemoHeader_Re_Loc.MODIFY();
        END;

        PurchCreditMemoLine_Re_Loc.RESET();
        PurchCreditMemoLine_Re_Loc.SETRANGE("Document No.", Rec."Purch Cr. Memo No.");
        IF PurchCreditMemoLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                PurchCreditMemoLine_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
                PurchCreditMemoLine_Re_Loc.MODIFY();
            UNTIL PurchCreditMemoLine_Re_Loc.NEXT() = 0;

        PostedLine_Re_Loc.RESET();
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

