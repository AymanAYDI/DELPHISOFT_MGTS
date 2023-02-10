page 50025 "DEL Fee Connection"
{
    ApplicationArea = all;
    Caption = 'Fee connection';
    PageType = List;
    SourceTable = "DEL Fee Connection";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Deal ID"; Rec."Deal ID")
                {
                }
                field("Fee ID"; Rec."Fee ID")
                {

                    trigger OnValidate()
                    var
                        fee_Re_Loc: Record "DEL Fee";
                    begin
                        IF ((Rec."Fee ID" <> '') AND (fee_Re_Loc.GET(Rec."Fee ID"))) THEN BEGIN
                            Rec."Fee Description" := fee_Re_Loc.Description;
                            Rec.MODIFY();
                        END
                    end;
                }
                field("Fee Description"; Rec."Fee Description")
                {
                }
                field(FormAmount; Rec."Default Amount")
                {
                    Enabled = FormAmountEnable;
                }
                field(FormFactor; Rec."Default Factor")
                {
                    Enabled = FormFactorEnable;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    var
        fee_Re_Loc: Record "DEL Fee";
    begin


        IF ((Rec."Fee ID" <> '') AND (fee_Re_Loc.GET(Rec."Fee ID"))) THEN
            IF fee_Re_Loc."Amount Type" = fee_Re_Loc."Amount Type"::fixed THEN BEGIN
                FormAmountEnable := TRUE;
                FormFactorEnable := FALSE;
            END ELSE BEGIN
                FormAmountEnable := FALSE;
                FormFactorEnable := TRUE;
            END;

    end;

    trigger OnInit()
    begin
        FormFactorEnable := TRUE;
        FormAmountEnable := TRUE;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IF (Type_Op = Type_Op::Vendor) OR (Type_Op = Type_Op::Customer) THEN
            Rec.VALIDATE(Type, Type_Op);

        IF No_Co <> '' THEN
            Rec.VALIDATE("No.", No_Co);
    end;

    var
        [InDataSet]
        FormAmountEnable: Boolean;
        [InDataSet]
        FormFactorEnable: Boolean;
        No_Co: Code[20];
        Type_Op: Enum "Credit Transfer Account Type";


    procedure FNC_Set_Type(Type_Op_Par: Enum "Credit Transfer Account Type"; No_Co_Par: Code[20])
    begin
        Type_Op := Type_Op_Par;
        No_Co := No_Co_Par
    end;
}

