page 50024 Fee
{
    // +-------------------------------------------------------------------------------+
    // | Logico SA - Logiciels & Conseils                                              |
    // | Stand: 16.03.09                                                               |
    // |                                                                               |
    // +-------------------------------------------------------------------------------+
    // 
    // ID     Version     Story-Card    Date       Description
    // ---------------------------------------------------------------------------------
    // CHG01                            16.03.09   Renommé le label du champ 'Used for import' selon DEV13
    // CHG02                            16.06.09   Ajout bouton "Facteur"
    // GRC                              20.07.09   code onOpenForm

    Caption = 'Fee';
    PageType = List;
    SourceTable = Table50024;

    layout
    {
        area(content)
        {
            repeater()
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
                        IF Field = Field::Douane THEN BEGIN
                            FormCurrencyEnable := FALSE;
                        END ELSE BEGIN
                            FormCurrencyEnable := TRUE;
                        END;
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
                RunPageLink = Fee_ID = FIELD (ID);
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

    [Scope('Internal')]
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

