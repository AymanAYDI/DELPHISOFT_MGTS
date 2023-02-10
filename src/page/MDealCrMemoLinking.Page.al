
page 50082 "DEL M Deal Cr. Memo Linking"
{


    Caption = 'Manual Deal Cr. Memo Linking';
    PageType = Card;
    Permissions = TableData "Sales Cr.Memo Header" = rimd,
                  TableData "Sales Cr.Memo Line" = rimd,
                   //TODOTableData 359 = rimd;
                   TableData "Dimension Set Entry" = rimd;
    SourceTable = "DEL Manual Deal Cr. Memo Link.";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            field("Sales Cr. Memo No."; Rec."Sales Cr. Memo No.")
            {
                ApplicationArea = All;
                Caption = 'Note de crédit vente';
            }
            field("Deal ID"; Rec."Deal ID")
            {
                ApplicationArea = All;
                Caption = 'Deal ID destination';
            }
            field("Shipment Selection"; Rec."Shipment Selection")
            {
                ApplicationArea = All;
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
                action(Post1)
                {
                    ApplicationArea = All;
                    Caption = 'Post';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';

                    trigger OnAction()
                    var


                        urm_Re_Loc: Record "DEL Update Request Manager";

                        salesCrMemoHeader_Re_Loc: Record "Sales Cr.Memo Header";
                        requestID_Co_Loc: Code[20];
                        add_Variant_Op_Loc: Option New,Existing;


                    begin


                        IF Rec."Shipment Selection" = '' THEN
                            ERROR('Veuillez sélectionner au moins 1 livraison !')
                        ELSE BEGIN


                            ChangeCodeAchat_FNC();


                            salesCrMemoHeader_Re_Loc.GET(Rec."Sales Cr. Memo No.");

                            Element_Cu.FNC_Add_Sales_Cr_Memo(
                              Rec."Deal ID",
                              salesCrMemoHeader_Re_Loc,
                              Rec."Shipment Selection",
                              add_Variant_Op_Loc::New);

                            Position_CU.FNC_Add_SalesCrMemo_Position(Rec."Deal ID", FALSE);


                            requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                              Rec."Deal ID",
                              urm_Re_Loc.Requested_By_Type::"Sales Cr. Memo".AsInteger(),
                              Rec."Sales Cr. Memo No.",
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
        Position_CU: Codeunit "DEL Position";
        UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";


    procedure ChangeCodeAchat_FNC()
    var
        ACOConnection_Rec_Loc: Record "DEL ACO Connection";
        // PostedLine_Re_Loc: Record "359"; TODO: I CHANGED 359 TO 480..
        PostedLine_Re_Loc: Record "Dimension Set Entry";
        SalesCreditMemoHeader_Re_Loc: Record "Sales Cr.Memo Header";
        SalesCreditMemoLine_Re_Loc: Record "Sales Cr.Memo Line";
        NewCodeAchatNo_Co_Par: Code[20];
    begin

        ACOConnection_Rec_Loc.SETRANGE(Deal_ID, Rec."Deal ID");
        IF ACOConnection_Rec_Loc.FINDFIRST() THEN
            NewCodeAchatNo_Co_Par := ACOConnection_Rec_Loc."ACO No.";




        IF SalesCreditMemoHeader_Re_Loc.GET(Rec."Sales Cr. Memo No.") THEN BEGIN
            SalesCreditMemoHeader_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
            SalesCreditMemoHeader_Re_Loc.MODIFY();
        END;

        SalesCreditMemoLine_Re_Loc.RESET();
        SalesCreditMemoLine_Re_Loc.SETRANGE("Document No.", Rec."Sales Cr. Memo No.");
        IF SalesCreditMemoLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                SalesCreditMemoLine_Re_Loc."Shortcut Dimension 1 Code" := NewCodeAchatNo_Co_Par;
                SalesCreditMemoLine_Re_Loc.MODIFY();
            UNTIL SalesCreditMemoLine_Re_Loc.NEXT() = 0;

        PostedLine_Re_Loc.RESET();
        PostedLine_Re_Loc.SETFILTER("Dimension Set ID", '%1|%2', 114, 115);
        //TODO PostedLine_Re_Loc.SETRANGE("Document No.", Rec."Sales Cr. Memo No.");
        PostedLine_Re_Loc.SETRANGE("Dimension Code", 'ACHAT');
        IF PostedLine_Re_Loc.FINDFIRST() THEN
            REPEAT
                PostedLine_Re_Loc."Dimension Value Code" := NewCodeAchatNo_Co_Par;
                PostedLine_Re_Loc.MODIFY();
            UNTIL PostedLine_Re_Loc.NEXT() = 0;
    end;
}


