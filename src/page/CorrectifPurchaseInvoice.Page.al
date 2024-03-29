page 50060 "DEL Correctif Purchase Invoice"
{
    Caption = 'Posted Purchase Invoice';
    InsertAllowed = false;
    PageType = Document;
    Permissions = TableData "Purch. Inv. Header" = rimd,
                  TableData "Purch. Inv. Line" = rimd;
    RefreshOnActivate = true;
    SourceTable = "Purch. Inv. Header";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Buy-from Contact No."; Rec."Buy-from Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Address 2"; Rec."Buy-from Address 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Contact"; Rec."Buy-from Contact")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Order No."; Rec."Vendor Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Importance = Promoted;
                }
                field("Order Address Code"; Rec."Order Address Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
            part(PurchInvLines; "DEL Correct Purch. Inv Subform")
            {
                ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
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
                ApplicationArea = All;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(PurchInvHeader);
                    PurchInvHeader.PrintRecords(TRUE);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = All;
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
                ApplicationArea = All;
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
                       urm_Re_Loc.Requested_By_Type::CUSTOM.AsInteger(),
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
