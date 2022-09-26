page 50060 "Correctif Purchase Invoice"
{
    // 
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 06.04.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            06.04.09   adapté l'appel de fonction de création de l'affaire

    Caption = 'Posted Purchase Invoice';
    InsertAllowed = false;
    PageType = Document;
    Permissions = TableData 122 = rimd,
                  TableData 123 = rimd;
    RefreshOnActivate = true;
    SourceTable = Table122;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Buy-from Contact No."; "Buy-from Contact No.")
                {
                    Editable = false;
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    Editable = false;
                }
                field("Buy-from Address"; "Buy-from Address")
                {
                    Editable = false;
                }
                field("Buy-from Address 2"; "Buy-from Address 2")
                {
                    Editable = false;
                }
                field("Buy-from Post Code"; "Buy-from Post Code")
                {
                    Editable = false;
                }
                field("Buy-from City"; "Buy-from City")
                {
                    Editable = false;
                }
                field("Buy-from Contact"; "Buy-from Contact")
                {
                    Editable = false;
                }
                field("No. Printed"; "No. Printed")
                {
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Document Date"; "Document Date")
                {
                    Editable = false;
                }
                field("Quote No."; "Quote No.")
                {
                }
                field("Order No."; "Order No.")
                {
                    Editable = false;
                }
                field("Pre-Assigned No."; "Pre-Assigned No.")
                {
                    Editable = false;
                }
                field("Vendor Order No."; "Vendor Order No.")
                {
                    Editable = false;
                }
                field("Vendor Invoice No."; "Vendor Invoice No.")
                {
                    Editable = false;
                    Importance = Promoted;
                }
                field("Order Address Code"; "Order Address Code")
                {
                    Editable = false;
                }
                field("Purchaser Code"; "Purchaser Code")
                {
                    Editable = false;
                }
                field("Responsibility Center"; "Responsibility Center")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
            }
            part(PurchInvLines; 50061)
            {
                SubPageLink = Document No.=FIELD(No.);
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
                    RunObject = Page 400;
                    RunPageLink = No.=FIELD(No.);
                    ShortCutKey = 'F7';
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 66;
                                    RunPageLink = Document Type=CONST(Posted Invoice),
                                  No.=FIELD(No.),
                                  Document Line No.=CONST(0);
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';

                    trigger OnAction()
                    begin
                        ShowDimensions;
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
                    Navigate;
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
                    element_Re_Loc: Record "50021";
                    Setup: Record "50000";
                    NoSeriesMgt_Cu: Codeunit "396";
                    element_ID_Ret: Code[20];
                    requestID_Co_Loc: Code[20];
                    urm_Re_Loc: Record "50039";
                    UpdateRequestManager_Cu: Codeunit "50032";
                    ID_num: Code[20];
                    Text: Text;
                begin
                    //MESSAGE ('Ok');
                    PurchInvLine.SETRANGE(PurchInvLine."Document No.","No.");
                    IF PurchInvLine.FINDFIRST THEN
                    REPEAT
                      PurchInvLine."Shortcut Dimension 1 Code":="Shortcut Dimension 1 Code";
                      PurchInvLine.MODIFY;
                    UNTIL PurchInvLine.NEXT=0;
                    
                    Text:=COPYSTR("Shortcut Dimension 1 Code",STRPOS("Shortcut Dimension 1 Code",'-'),20);
                    Text:='AFF'+Text;
                    //ERROR(Text);
                    ID_num:=Text;
                    requestID_Co_Loc := UpdateRequestManager_Cu.FNC_Add_Request(
                      ID_num,
                      urm_Re_Loc.Requested_By_Type::CUSTOM,
                      USERID,
                      CURRENTDATETIME
                    );
                    
                    urm_Re_Loc.GET(requestID_Co_Loc);
                    
                    //begin THM optimisation
                      //UpdateRequestManager_Cu.FNC_Process_Requests(urm_Re_Loc,FALSE,FALSE,TRUE);
                    
                      UpdateRequestManager_Cu.FNC_Process_RequestsDeal(urm_Re_Loc,FALSE,FALSE,TRUE,requestID_Co_Loc);
                      urm_Re_Loc.SETRANGE(urm_Re_Loc.ID,requestID_Co_Loc);
                      IF urm_Re_Loc.FINDFIRST THEN
                      urm_Re_Loc.DELETE;
                    
                    
                    
                    /*
                      Setup.GET();
                      element_ID_Ret := NoSeriesMgt_Cu.GetNextNo(Setup."Element Nos.", TODAY, TRUE);
                      element_Re_Loc.INIT();
                      element_Re_Loc.ID := element_ID_Ret;
                      element_Re_Loc.VALIDATE(Deal_ID, Deal_ID_Co_Par);
                      element_Re_Loc.VALIDATE(Instance, Instance_Op_Par);
                      element_Re_Loc.VALIDATE(Type, Type_Op_Par);
                      element_Re_Loc.VALIDATE("Type No.", "No._Co_Par");
                      element_Re_Loc.VALIDATE("Subject No.", SubjectNo_Co_Par);
                      element_Re_Loc.VALIDATE("Subject Type", SubjectType_Op_Par);
                      element_Re_Loc.VALIDATE(Fee_ID, Fee_ID_Co_Par);
                      element_Re_Loc.VALIDATE(Fee_Connection_ID, Fee_Connection_ID_Co_Par);
                      element_Re_Loc.Date := Element_Date_Par;
                      element_Re_Loc.VALIDATE("Entry No.", EntryNo_Int_Par);
                      element_Re_Loc.VALIDATE("Bill-to Customer No.", BillToCustomerNo_Co_Par);
                      element_Re_Loc."Add DateTime" := CURRENTDATETIME;
                      element_Re_Loc.Period := Period_Da_Par;
                      element_Re_Loc."Splitt Index" := SplittIndex_Int_Par;
                      element_Re_Loc.INSERT();
                    */

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetSecurityFilterOnRespCenter;
    end;

    var
        PurchInvHeader: Record "122";
        ChangeExchangeRate: Page "511";
                                Deal_Cu: Codeunit "50020";
                                PurchInvLine: Record "123";
}

