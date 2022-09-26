page 50025 "Fee Connection"
{
    Caption = 'Fee connection';
    PageType = List;
    SourceTable = Table50025;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(ID; ID)
                {
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Deal ID"; "Deal ID")
                {
                    Caption = 'Deal ID';
                }
                field("Fee ID"; "Fee ID")
                {
                    Caption = 'Fee ID';

                    trigger OnValidate()
                    var
                        fee_Re_Loc: Record "50024";
                    begin
                        IF (("Fee ID" <> '') AND (fee_Re_Loc.GET("Fee ID"))) THEN BEGIN
                            "Fee Description" := fee_Re_Loc.Description;
                            MODIFY;
                        END
                    end;
                }
                field("Fee Description"; "Fee Description")
                {
                    Caption = 'Désignation';
                }
                field(FormAmount; "Default Amount")
                {
                    Caption = 'Specific amount';
                    Enabled = FormAmountEnable;
                }
                field(FormFactor; "Default Factor")
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
        fee_Re_Loc: Record "50024";
    begin
        /*
        FeeDescription_Te := '';
        IF (("Fee ID" <> '') AND (fee_Re_Loc.GET("Fee ID"))) THEN
          FeeDescription_Te := fee_Re_Loc.Description
        */

        IF (("Fee ID" <> '') AND (fee_Re_Loc.GET("Fee ID"))) THEN BEGIN
            IF fee_Re_Loc."Amount Type" = fee_Re_Loc."Amount Type"::fixed THEN BEGIN
                FormAmountEnable := TRUE;
                FormFactorEnable := FALSE;
            END ELSE BEGIN
                FormAmountEnable := FALSE;
                FormFactorEnable := TRUE;
            END;
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
            VALIDATE(Type, Type_Op);

        IF No_Co <> '' THEN
            VALIDATE("No.", No_Co);
    end;

    var
        Type_Op: Option Vendor,Customer;
        No_Co: Code[20];
        [InDataSet]
        FormAmountEnable: Boolean;
        [InDataSet]
        FormFactorEnable: Boolean;

    [Scope('Internal')]
    procedure FNC_Set_Type(Type_Op_Par: Option Vendor,Customer; No_Co_Par: Code[20])
    begin
        Type_Op := Type_Op_Par;
        No_Co := No_Co_Par
    end;
}

