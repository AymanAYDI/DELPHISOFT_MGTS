page 50038 "DEL Deal Shipment Selection"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "DEL Deal Shipment Selection";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Document Type"; Rec."Document Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                    Editable = false;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    Editable = false;
                }
                field("BR No."; Rec."BR No.")
                {
                    Editable = false;
                }
                field("Purchase Invoice No."; Rec."Purchase Invoice No.")
                {
                    Editable = false;
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    Editable = false;
                }
                field("Fee Connection"; Rec."Fee Connection")
                {
                    Enabled = false;
                    Visible = false;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        FNC_FeeConnectionLookup();
                    end;
                }
                field("Connected Fee Description"; Rec."Connected Fee Description")
                {
                    Editable = false;
                }
                field(Checked; Rec.Checked)
                {
                    trigger OnValidate()
                    var
                        FeeConnectionID_Co_Loc: Code[20];
                        ErrorMsg_Te_Loc: Text[250];
                    begin

                        IF xRec.Checked AND NOT Rec.Checked THEN BEGIN

                            Rec."Fee Connection" := '';
                            Rec."Connected Fee Description" := '';

                        END ELSE BEGIN

                            IF ((Rec."Document Type" = Rec."Document Type"::Invoice) OR (Rec."Document Type" = Rec."Document Type"::Payment)) THEN
                                IF FindFeeConnection_FNC(FeeConnectionID_Co_Loc, FeeDescription_Te, ErrorMsg_Te_Loc) THEN BEGIN
                                    Rec."Fee Connection" := FeeConnectionID_Co_Loc;
                                    Rec."Connected Fee Description" := FeeDescription_Te;
                                END ELSE
                                    ERROR(ErrorMsg_Te_Loc);


                            IF Rec."Fee Connection" = '' THEN BEGIN
                                Rec.Checked := FALSE;
                                Rec.MODIFY();
                                ERROR('Fee Connection vide !');
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
        dealShipmentSelection_Re_Loc: Record "DEL Deal Shipment Selection";
    begin

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
        GenJnlLine_Re: Record "Gen. Journal Line";
        openerType_Op: Enum "DEL Document Type";
        FeeDescription_Te: Text[50];


    procedure FNC_OpenedBy(openerType_Op_Par: Enum "DEL Document Type"; openerNo_Co_Par: Code[20])
    begin
        openerType_Op := openerType_Op_Par;

    end;


    procedure FNC_SetGenJnlLine(GenJnlLine_Re_Par: Record "Gen. Journal Line")
    begin
        GenJnlLine_Re := GenJnlLine_Re_Par
    end;


    procedure FNC_FeeConnectionLookup()
    var

        element_Re_Loc: Record "DEL Element";

        element_page_Loc: Page "DEL Element";
    begin
        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Rec.Deal_ID);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        element_page_Loc.SETTABLEVIEW(element_Re_Loc);
        element_page_Loc.SETRECORD(element_Re_Loc);
        element_page_Loc.LOOKUPMODE(TRUE);
        IF element_page_Loc.RUNMODAL() = ACTION::LookupOK THEN BEGIN
            element_page_Loc.GETRECORD(element_Re_Loc);
            Rec."Fee Connection" := element_Re_Loc.Fee_Connection_ID;
            Rec.MODIFY();
        END;
    end;


    procedure FindFeeConnection_FNC(var FeeConnectionID_Co_Par: Code[20]; var FeeDescription_Te_Par: Text[50]; var ErrorMsg_Te_Par: Text[250]): Boolean
    var
        element_Re_Loc: Record "DEL Element";
        fee_Re_Loc: Record "DEL Fee";
        findFeeConnectionError_Loc: Label 'No planned fee for this shipment is in relation with account no. %1.';
    begin
        element_Re_Loc.RESET();
        element_Re_Loc.SETCURRENTKEY(Deal_ID, Type, Instance);
        element_Re_Loc.SETRANGE(Deal_ID, Rec.Deal_ID);
        element_Re_Loc.SETRANGE(Type, element_Re_Loc.Type::Fee);
        element_Re_Loc.SETRANGE(Instance, element_Re_Loc.Instance::planned);
        IF element_Re_Loc.FINDFIRST() THEN
            REPEAT

                fee_Re_Loc.RESET();
                fee_Re_Loc.SETRANGE(ID, element_Re_Loc.Fee_ID);
                fee_Re_Loc.SETRANGE(fee_Re_Loc."No compte", Rec."Account No.");
                fee_Re_Loc.SETRANGE("Used For Import", FALSE);
                IF fee_Re_Loc.FINDFIRST() THEN BEGIN
                    FeeConnectionID_Co_Par := element_Re_Loc.Fee_Connection_ID;
                    FeeDescription_Te_Par := fee_Re_Loc.Description;
                    EXIT(TRUE);
                END;

            UNTIL (element_Re_Loc.NEXT() = 0);

        ErrorMsg_Te_Par := STRSUBSTNO(findFeeConnectionError_Loc, Rec."Account No.");
        EXIT(FALSE);
    end;
}

