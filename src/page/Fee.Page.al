page 50024 "DEL Fee"
{

    Caption = 'Fee';
    PageType = List;
    SourceTable = "DEL Fee";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                field(ID; ID)
                {
                }
                field(Description; Description)
                {
                }
                field("No compte"; "No compte")
                {
                }
                field("Amount Type"; "Amount Type")
                {

                    trigger OnValidate()
                    begin
                        AmountTypeOnAfterValidate;
                    end;
                }
                field("Ventilation Element"; "Ventilation Element")
                {
                }
                field("Ventilation Position"; "Ventilation Position")
                {
                }
                field(FormCurrency; Currency)
                {
                    Caption = 'Currency';
                    Enabled = FormCurrencyEnable;
                }
                field(FormAmount; Amount)
                {
                    Caption = 'Default Amount';
                    Enabled = FormAmountEnable;
                }
                field(FormField; Field)
                {
                    Caption = 'Field';
                    Enabled = FormFieldEnable;

                    trigger OnValidate()
                    begin
                        IF Field = Field::Douane THEN
                            FormCurrencyEnable := FALSE
                        ELSE
                            FormCurrencyEnable := TRUE;

                    end;
                }
                field(FormFactor; Factor)
                {
                    Caption = 'Default Factor';
                    Enabled = FormFactorEnable;
                }
                field("Factor by date"; "Factor by date")
                {
                    Editable = false;
                }
                field(Destination; Destination)
                {
                }
                field(Axe; Axe)
                {
                }
                field("Used For Import"; "Used For Import")
                {
                    Caption = 'Used for import / Contrôle feuille comptable';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Factor)
            {
                Caption = 'Factor';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page 50049;
                //TODO // RunPageLink = Fee_ID = FIELD(ID);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        FormCurrencyEnable := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord;
    end;

    trigger OnOpenPage()
    begin
        //GRC begin
        UpdateFactor();
        //GRC end
    end;

    var
        [InDataSet]
        FormAmountEnable: Boolean;
        [InDataSet]
        FormFieldEnable: Boolean;
        [InDataSet]
        FormFactorEnable: Boolean;
        [InDataSet]
        FormCurrencyEnable: Boolean;


    procedure UpdateForm()
    begin
    end;

    local procedure AmountTypeOnAfterValidate()
    begin
        IF "Amount Type" = "Amount Type"::fixed THEN BEGIN
            FormAmountEnable := TRUE;
            FormFieldEnable := FALSE;
            FormFactorEnable := FALSE;
        END ELSE BEGIN
            FormAmountEnable := FALSE;
            FormFieldEnable := TRUE;
            FormFactorEnable := TRUE;
        END;
    end;

    local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
        IF "Amount Type" = "Amount Type"::fixed THEN BEGIN

            FormAmountEnable := TRUE;
            FormFieldEnable := FALSE;
            FormFactorEnable := FALSE;

        END ELSE BEGIN

            FormAmountEnable := FALSE;
            FormFieldEnable := TRUE;
            FormFactorEnable := TRUE;


        END;

        IF Field = Field::Douane THEN BEGIN
            FormCurrencyEnable := FALSE;
        END ELSE BEGIN
            FormCurrencyEnable := TRUE;
        END;
    end;
}

