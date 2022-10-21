page 50037 "DEL Subform Logistic"
{
    Editable = false;
    PageType = ListPart;
    SourceTable = "DEL Deal Shipment";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                    Visible = false;
                    Caption = 'Deal_ID';
                }
                field("Date"; Rec.Date)
                {
                    Caption = 'Date';
                }
                field("BR No."; Rec."BR No.")
                {
                    Editable = false;
                    Caption = 'BR No.';
                }
                field(PI; Rec.PI)
                {
                    Caption = 'PI';
                }
                field("A facturer"; Rec."A facturer")
                {
                    Caption = 'A facturer';
                }
                field("Depart shipment"; Rec."Depart shipment")
                {
                    Caption = 'Depart shipment';
                }
                field("Arrival ship"; Rec."Arrival ship")
                {
                    Editable = false;
                    Caption = 'Arrival ship';
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

    begin

        Rec.VALIDATE(ID, DealShipment_Cu.FNC_GetNextShipmentNo(Deal_ID_Co));
        Rec.VALIDATE(Deal_ID, Deal_ID_Co);
        Rec.VALIDATE(Date, TODAY);
    end;

    var



        DealShipment_Cu: Codeunit "DEL Deal Shipment";
        Deal_ID_Co: Code[20];


    procedure FNC_Set_Deal_ID(Deal_ID_Co_Par: Code[20])
    begin
        Deal_ID_Co := Deal_ID_Co_Par;
    end;


    procedure FNC_OpenLogisticCard()
    var
        Logistic_Re_Loc: Record "DEL Logistic";
    begin
        Logistic_Re_Loc.SETRANGE(ID, Rec.ID);
        Logistic_Re_Loc.SETRANGE(Deal_ID, Rec.Deal_ID);


        IF Logistic_Re_Loc.ISEMPTY THEN BEGIN
            Logistic_Re_Loc.INIT();
            Logistic_Re_Loc.ID := Rec.ID;
            Logistic_Re_Loc.Deal_ID := Rec.Deal_ID;
            Logistic_Re_Loc."BR No." := Rec."BR No.";
            Logistic_Re_Loc.FNC_GetInfo(Logistic_Re_Loc);

        END;
        Logistic_Re_Loc.SETRANGE(ID, Rec.ID);
        Logistic_Re_Loc.SETRANGE(Deal_ID, Rec.Deal_ID);

        Logistic_Re_Loc.FINDFIRST();

        IF Rec."BR No." <> '' THEN BEGIN
            Logistic_Re_Loc."BR No." := Rec."BR No.";
            Logistic_Re_Loc.FNC_PackEstim(Logistic_Re_Loc);
        END;

        Logistic_Re_Loc.FNC_DateValidate();
        COMMIT();
        Logistic_Re_Loc.RESET();
        Logistic_Re_Loc.FILTERGROUP(6);
        Logistic_Re_Loc.SETRANGE(ID, Rec.ID);
        Logistic_Re_Loc.SETRANGE(Deal_ID, Rec.Deal_ID);
        Logistic_Re_Loc.SETRANGE("BR No.", Rec."BR No.");
        Logistic_Re_Loc.FILTERGROUP(0);

        IF PAGE.RUNMODAL(Page::"DEL Logistic", Logistic_Re_Loc) = ACTION::LookupOK THEN;
    end;
}

