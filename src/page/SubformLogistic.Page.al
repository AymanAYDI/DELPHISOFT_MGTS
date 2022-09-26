page 50037 "Subform Logistic"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = Table50030;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID; ID)
                {
                }
                field(Deal_ID; Deal_ID)
                {
                    Visible = false;
                }
                field(Date; Date)
                {
                }
                field("BR No."; "BR No.")
                {
                    Editable = false;
                }
                field(PI; PI)
                {
                }
                field("A facturer"; "A facturer")
                {
                }
                field("Depart shipment"; "Depart shipment")
                {
                }
                field("Arrival ship"; "Arrival ship")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Create)
            {
                Caption = 'Create';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    DealShipment_Cu.FNC_Insert(Deal_ID_Co, 0D, '');
                end;
            }
            action(Card)
            {
                Caption = 'Card';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    FNC_OpenLogisticCard();
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        deal_Re_Loc: Record "50020";
    begin
        VALIDATE(ID, DealShipment_Cu.FNC_GetNextShipmentNo(Deal_ID_Co));
        VALIDATE(Deal_ID, Deal_ID_Co);
        VALIDATE(Date, TODAY);
    end;

    var
        Deal_ID_Co: Code[20];
        AlertMgt: Codeunit "50028";
        DealShipment_Cu: Codeunit "50029";

    [Scope('Internal')]
    procedure FNC_Set_Deal_ID(Deal_ID_Co_Par: Code[20])
    begin
        Deal_ID_Co := Deal_ID_Co_Par;
    end;

    [Scope('Internal')]
    procedure FNC_OpenLogisticCard()
    var
        Logistic_Re_Loc: Record "50034";
    begin
        Logistic_Re_Loc.SETRANGE(ID, ID);
        Logistic_Re_Loc.SETRANGE(Deal_ID, Deal_ID);
        //Logistic_Re_Loc.SETRANGE("BR No.","BR No.");

        IF Logistic_Re_Loc.ISEMPTY THEN BEGIN
            Logistic_Re_Loc.INIT();
            Logistic_Re_Loc.ID := ID;
            Logistic_Re_Loc.Deal_ID := Deal_ID;
            Logistic_Re_Loc."BR No." := "BR No.";
            Logistic_Re_Loc.FNC_GetInfo(Logistic_Re_Loc);

        END;
        Logistic_Re_Loc.SETRANGE(ID, ID);
        Logistic_Re_Loc.SETRANGE(Deal_ID, Deal_ID);
        //Logistic_Re_Loc.SETrange("BR No.","BR No.");
        Logistic_Re_Loc.FINDFIRST;

        IF "BR No." <> '' THEN BEGIN
            Logistic_Re_Loc."BR No." := "BR No.";
            Logistic_Re_Loc.FNC_PackEstim(Logistic_Re_Loc);
        END;
        //test ou récup les valeures par défault !
        Logistic_Re_Loc.FNC_DateValidate;
        COMMIT();
        Logistic_Re_Loc.RESET();
        Logistic_Re_Loc.FILTERGROUP(6);
        Logistic_Re_Loc.SETRANGE(ID, ID);
        Logistic_Re_Loc.SETRANGE(Deal_ID, Deal_ID);
        Logistic_Re_Loc.SETRANGE("BR No.", "BR No.");
        Logistic_Re_Loc.FILTERGROUP(0);

        IF PAGE.RUNMODAL(50044, Logistic_Re_Loc) = ACTION::LookupOK THEN;
    end;
}

