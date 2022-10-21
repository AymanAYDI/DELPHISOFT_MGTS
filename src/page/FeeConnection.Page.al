page 50025 "DEL Fee Connection"
{
    Caption = 'Fee connection';
    PageType = List;
    SourceTable = "DEL Fee Connection";

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
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Deal ID"; Rec."Deal ID")
                {
                    Caption = 'Deal ID';
                }
                field("Fee ID"; Rec."Fee ID")
                {
                    Caption = 'Fee ID';

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
                    Caption = 'Désignation';
                }
                field(FormAmount; Rec."Default Amount")
                {
                    Caption = 'Specific amount';
                    Enabled = FormAmountEnable;
                }
                field(FormFactor; Rec."Default Factor")
                {
                    Caption = 'Specific factor';
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
        Type_Op: Enum "DEL Type Fee Connection";
        No_Co: Code[20];
        [InDataSet]
        FormAmountEnable: Boolean;
        [InDataSet]
        FormFactorEnable: Boolean;


    procedure FNC_Set_Type(Type_Op_Par: Enum "DEL Type Fee Connection"; No_Co_Par: Code[20])
    begin
        Type_Op := Type_Op_Par;
        No_Co := No_Co_Par
    end;
}

