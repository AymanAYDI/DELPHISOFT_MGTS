page 50014 "DEL Corr. facture vente ligne"
{
    AutoSplitKey = true;
    Caption = 'Posted Sales Invoice Subform';
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    Permissions = TableData 113 = rim;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                field(Type; Type)
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Position; Position)
                {
                    Caption = 'Pos';
                    Editable = false;
                    Visible = false;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Return Reason Code"; "Return Reason Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Bin Code"; "Bin Code")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Quantity; Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Unit Price"; "Unit Price")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field(LineAmountText; LineAmountText)
                {
                    //TODO    // BlankZero = true;
                    CaptionClass = FIELDCAPTION("Line Amount");
                    Editable = false;
                }
                field(AmountIncludingVATText; AmountIncludingVATText)
                {
                    CaptionClass = FIELDCAPTION("Amount Including VAT");
                    Editable = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Job No."; "Job No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Title No."; "Title No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Quote-Level"; "Quote-Level")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Classification; Classification)
                {
                    Editable = false;
                    Visible = false;
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Visible = true;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DescriptionIndent := 0;
        //TODO   DescriptionOnFormat;
        LineAmountText := FORMAT("Line Amount");
        LineAmountTextOnFormat(LineAmountText);
        AmountIncludingVATText := FORMAT("Amount Including VAT");
        AmountIncludingVATTextOnFormat(AmountIncludingVATText);
    end;

    var
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        DescriptionIndent: Integer;
        [InDataSet]
        "Line AmountEmphasize": Boolean;
        [InDataSet]
        LineAmountText: Text[1024];
        [InDataSet]
        "Amount Including VATEmphasize": Boolean;
        [InDataSet]
        AmountIncludingVATText: Text[1024];
    //TODO //  DocumentLineTracking: Page "5005399";


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;


    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;


    //TODO 
    // procedure ShowDocumentLineTracking()
    // begin
    //     // dach0001.begin
    //     CLEAR(DocumentLineTracking);
    //     DocumentLineTracking.SetDoc(6, "Document No.", "Line No.", "Blanket Order No.", "Blanket Order Line No.", "Order No.", "Order Line No.")
    //     ;
    //     DocumentLineTracking.RUNMODAL;
    //     // dach001.end
    // end;

    local procedure DescriptionOnFormat()
    begin
        // CH2500.begin
        IF "Quote-Level" > 0 THEN
            DescriptionIndent := "Quote-Level" - 1;

        IF Type IN [Type::Title, Type::"Begin-Total", Type::"End-Total"] THEN
            DescriptionEmphasize := TRUE
        // CH2500.end
    end;

    local procedure LineAmountTextOnFormat(var Text: Text[1024])
    begin
        // CH2500.begin
        IF (Type = Type::"End-Total") AND ("Subtotal net" <> 0) THEN BEGIN
            Text := FORMAT("Subtotal net", 0, '<Sign><Integer Thousand><Decimals,3>');
            "Line AmountEmphasize" := TRUE;
        END;
        // CH2500.end
    end;

    local procedure AmountIncludingVATTextOnFormat(var Text: Text[1024])
    begin
        // CH2500.begin
        IF (Type = Type::"End-Total") AND ("Subtotal gross" <> 0) THEN BEGIN
            Text := FORMAT("Subtotal gross", 0, '<Sign><Integer Thousand><Decimals,3>');
            "Amount Including VATEmphasize" := TRUE;
        END;
        // CH2500.end
    end;
}

