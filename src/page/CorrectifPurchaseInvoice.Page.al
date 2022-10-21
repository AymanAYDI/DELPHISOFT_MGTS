page 50060 "DEL Correctif Purchase Invoice"
{


    Caption = 'Posted Purchase Invoice';
    InsertAllowed = false;
    PageType = Document;
    Permissions = TableData "Purch. Inv. Header" = rimd,
                  TableData "Purch. Inv. Line" = rimd;
    RefreshOnActivate = true;
    SourceTable = "Purch. Inv. Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    Caption = 'No.';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    Caption = 'Buy-from Vendor No.';
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    Editable = false;
                    Caption = 'Buy-from Contact No.';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Editable = false;
                    Caption = 'Buy-from Vendor Name';
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Editable = false;
                    Caption = 'Buy-from Address';
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    Editable = false;
                    Caption = 'Buy-from Address 2';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Editable = false;
                    Caption = 'Buy-from Post Code';
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Editable = false;
                    Caption = 'Buy-from City';
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    Editable = false;
                    Caption = 'Buy-from Contact';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    Editable = false;
                    Caption = 'No. Printed';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                    Importance = Promoted;
                    Caption = 'Posting Date';
                }
                field("Document Date"; Rec."Document Date")
                {
                    Editable = false;
                    Caption = 'Document Date';
                }
                field("Quote No."; Rec."Quote No.")
                {
                    Caption = 'Quote No.';
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    Caption = 'Order No.';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    Editable = false;
                    Caption = 'Pre-Assigned No.';
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    Editable = false;
                    Caption = 'Vendor Order No.';
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    Editable = false;
                    Importance = Promoted;
                    Caption = 'Vendor Invoice No.';
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    Editable = false;
                    Caption = 'Order Address Code';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    Editable = false;
                    Caption = 'Purchaser Code';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Editable = false;
                    Caption = 'Responsibility Center';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
            }
            part(PurchInvLines; "DEL Correct Purch. Inv Subform")
            {
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Purchase Invoice Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
            }
        }
        area(processing)
        {
            action("&Print")
            {
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                    PurchInvHeader.PrintRecords(TRUE);
                end;
            }
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.Navigate();
                end;
            }
            action("Mise à jour affaire")
            {
                Caption = 'Mise à jour affaire';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    urm_Re_Loc: Record "DEL Update Request Manager";

                    UpdateRequestManager_Cu: Codeunit "DEL Update Request Manager";
                    ID_num: Code[20];
                    requestID_Co_Loc: Code[20];
                    Text: Text;
                begin

                    PurchInvLine.SETRANGE(PurchInvLine."Document No.", Rec."No.");
                    IF PurchInvLine.FINDFIRST() THEN
                        REPEAT
                            PurchInvLine."Shortcut Dimension 1 Code" := Rec."Shortcut Dimension 1 Code";
                            PurchInvLine.MODIFY();
                        UNTIL PurchInvLine.NEXT() = 0;

                    Text := COPYSTR(Rec."Shortcut Dimension 1 Code", STRPOS(Rec."Shortcut Dimension 1 Code", '-'), 20);
                    Text := 'AFF' + Text;

                    ID_num := Text;
                    requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                       ID_num,
                       urm_Re_Loc.Requested_By_Type::CUSTOM,
                       USERID,
                       CURRENTDATETIME
                     );

                    urm_Re_Loc.GET(requestID_Co_Loc);



                    UpdateRequestManager_Cu.FNC_Process_RequestsDeal(urm_Re_Loc, FALSE, FALSE, TRUE, requestID_Co_Loc);
                    urm_Re_Loc.SETRANGE(urm_Re_Loc.ID, requestID_Co_Loc);
                    IF urm_Re_Loc.FINDFIRST() THEN
                        urm_Re_Loc.DELETE();



                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
    end;

    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchInvLine: Record "Purch. Inv. Line";
}

