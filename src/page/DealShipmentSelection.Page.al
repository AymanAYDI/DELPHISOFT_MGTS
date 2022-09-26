page 50038 "Deal Shipment Selection"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = Table50031;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Document Type"; "Document Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Deal_ID; Deal_ID)
                {
                    Editable = false;
                }
                field("Shipment No."; "Shipment No.")
                {
                    Editable = false;
                }
                field("BR No."; "BR No.")
                {
                    Editable = false;
                }
                field("Purchase Invoice No."; "Purchase Invoice No.")
                {
                    Editable = false;
                }
                field("Sales Invoice No."; "Sales Invoice No.")
                {
                    Editable = false;
                }
                field("Fee Connection"; "Fee Connection")
                {
                    Enabled = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        FNC_FeeConnectionLookup();
                    end;
                }
                field("Connected Fee Description"; "Connected Fee Description")
                {
                    Editable = false;
                }
                field(Checked; Checked)
                {

                    trigger OnValidate()
                    var
                        FeeConnectionID_Co_Loc: Code[20];
                        ErrorMsg_Te_Loc: Text[250];
                    begin
                        //if field "checked" changes from true to false
                        IF xRec.Checked AND NOT Rec.Checked THEN BEGIN

                            //reset fee connection field
                            Rec."Fee Connection" := '';
                            Rec."Connected Fee Description" := '';

                            //if field "checked" changes from false to true
                        END ELSE BEGIN

                            IF (("Document Type" = "Document Type"::Invoice) OR ("Document Type" = "Document Type"::Payment)) THEN BEGIN

                                //find the fee connection for a deal according to an account no
                                IF FindFeeConnection_FNC(FeeConnectionID_Co_Loc, FeeDescription_Te, ErrorMsg_Te_Loc) THEN BEGIN
                                    Rec."Fee Connection" := FeeConnectionID_Co_Loc;
                                    Rec."Connected Fee Description" := FeeDescription_Te;
                                END ELSE
                                    ERROR(ErrorMsg_Te_Loc);

                                //should never happend cause an error is thrown if fee connection can't be found..
                                IF "Fee Connection" = '' THEN BEGIN
                                    Checked := FALSE;
                                    MODIFY();
                                    ERROR('Fee Connection vide !');
                                END

                            END

                        END
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    var
        dealShipmentSelection_Re_Loc: Record "50031";
    begin
        //on supprime tous les deal shipment selection qui sont pas flagée et qui ont été créé par l'user id actuel
        dealShipmentSelection_Re_Loc.RESET();
        dealShipmentSelection_Re_Loc.SETRANGE(Checked, FALSE);
        dealShipmentSelection_Re_Loc.SETRANGE(USER_ID, USERID);
        dealShipmentSelection_Re_Loc.DELETEALL();
    end;

    trigger OnInit()
    begin
        CurrPage.LOOKUPMODE := TRUE;
    end;

    var
        openerType_Op: Option Invoice,"Purchase Header","Sales Header";
        OpenerNo_Co: Code[20];
        GenJnlLine_Re: Record "81";
        FeeDescription_Te: Text[50];

    [Scope('Internal')]
    procedure FNC_OpenedBy(openerType_Op_Par: Option Invoice,"Purchase Header","Sales Header"; openerNo_Co_Par: Code[20])
    begin
        openerType_Op := openerType_Op_Par;
        OpenerNo_Co := openerNo_Co_Par;
    end;

    [Scope('Internal')]
    procedure FNC_SetGenJnlLine(GenJnlLine_Re_Par: Record "81")
    begin
        GenJnlLine_Re := GenJnlLine_Re_Par
    end;

    [Scope('Internal')]
    procedure FNC_FeeConnectionLookup()
    var
        feeConnection_Re_Loc: Record "50025";
        genJournalLine_Re_Loc: Record "81";
        fee_Re_Loc: Record "50024";
        element_Re_Loc: Record "50021";
        feeConnection_page_Loc: Page "50025";
        element_page_Loc: Page "50021";
    begin
        element_Re_Loc.RESET;
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Deal_ID);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        element_page_Loc.SETTABLEVIEW(element_Re_Loc);
        element_page_Loc.SETRECORD(element_Re_Loc);
        element_page_Loc.LOOKUPMODE(TRUE);
        IF element_page_Loc.RUNMODAL = ACTION::LookupOK THEN BEGIN
            element_page_Loc.GETRECORD(element_Re_Loc);
            "Fee Connection" := element_Re_Loc.Fee_Connection_ID;
            MODIFY;
        END;
    end;

    [Scope('Internal')]
    procedure FindFeeConnection_FNC(var FeeConnectionID_Co_Par: Code[20]; var FeeDescription_Te_Par: Text[50]; var ErrorMsg_Te_Par: Text[250]): Boolean
    var
        fee_Re_Loc: Record "50024";
        element_Re_Loc: Record "50021";
        findFeeConnectionError_Loc: Label 'No planned fee for this shipment is in relation with account no. %1.';
    begin
        element_Re_Loc.RESET;
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Rec.Deal_ID);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST THEN
            REPEAT

                fee_Re_Loc.RESET();
                fee_Re_Loc.SETRANGE(ID, element_Re_Loc.Fee_ID);
                fee_Re_Loc.SETRANGE(fee_Re_Loc."No compte", Rec."Account No.");
                fee_Re_Loc.SETRANGE("Used For Import", FALSE);
                IF fee_Re_Loc.FINDFIRST THEN BEGIN
                    FeeConnectionID_Co_Par := element_Re_Loc.Fee_Connection_ID;
                    FeeDescription_Te_Par := fee_Re_Loc.Description;
                    EXIT(TRUE);
                END;

            UNTIL (element_Re_Loc.NEXT() = 0);

        ErrorMsg_Te_Par := STRSUBSTNO(findFeeConnectionError_Loc, Rec."Account No.");
        EXIT(FALSE);
    end;
}

