page 50024 "DEL Fee"
{

    Caption = 'Fee';
    PageType = List;
    SourceTable = "DEL Fee";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(ID; Rec.ID)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("No compte"; Rec."No compte")
                {
                }
                field("Amount Type"; Rec."Amount Type")
                {

                    trigger OnValidate()
                    begin
                        AmountTypeOnAfterValidate();
                    end;
                }
                field("Ventilation Element"; Rec."Ventilation Element")
                {
                }
                field("Ventilation Position"; Rec."Ventilation Position")
                {
                }
                field(FormCurrency; Rec.Currency)
                {
                    Caption = 'Currency';
                    Enabled = FormCurrencyEnable;
                }
                field(FormAmount; Rec.Amount)
                {
                    Caption = 'Default Amount';
                    Enabled = FormAmountEnable;
                }
                field(FormField; Rec.Field)
                {
                    Caption = 'Field';
                    Enabled = FormFieldEnable;

                    trigger OnValidate()
                    var
                    begin
                        IF Rec.Field = Rec.Field::Douane THEN
                            FormCurrencyEnable := FALSE
                        ELSE
                            FormCurrencyEnable := TRUE;
                    end;
                }
                field(FormFactor; Rec.Factor)
                {
                    Caption = 'Default Factor';
                    Enabled = FormFactorEnable;
                }
                field("Factor by date"; Rec."Factor by date")
                {
                    Editable = false;
                }
                field(Destination; Rec.Destination)
                {
                }
                field(Axe; Rec.Axe)
                {
                }
                field("Used For Import"; Rec."Used For Import")
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
                RunObject = Page "DEL Fee Factor";
                // RunPageLink = Fee_ID = FIELD(ID);
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnInit()
    begin
        FormCurrencyEnable := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OnAfterGetCurrRecord();
    end;

    trigger OnOpenPage()
    begin

        Rec.UpdateFactor();

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
        IF Rec."Amount Type" = Rec."Amount Type"::fixed THEN BEGIN
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
        IF Rec."Amount Type" = Rec."Amount Type"::fixed THEN BEGIN

            FormAmountEnable := TRUE;
            FormFieldEnable := FALSE;
            FormFactorEnable := FALSE;

        END ELSE BEGIN

            FormAmountEnable := FALSE;
            FormFieldEnable := TRUE;
            FormFactorEnable := TRUE;


        END;

        IF rec.Field = rec.Field::Douane THEN
            FormCurrencyEnable := FALSE
        ELSE
            FormCurrencyEnable := TRUE;
    end;
}

