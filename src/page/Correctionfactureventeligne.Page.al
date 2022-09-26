page 50014 "Correction facture vente ligne"
{
    // <changelog>
    //   <add id="CH2500" dev="SRYSER" request="CH-START-370" date="2004-02-25" area="QU"
    //   releaseversion="CH3.70A">New Fields Position,Title No,Classification (all invisible) /
    //   Code Description,Line Amount,Amount incl. VAT OnFormat, Line Amount HorizAlign changed</add>
    //   <remove id="CH1910" dev="SRYSER" request="CH-START-400" date="2004-09-15" area="SWS91"
    //     baseversion="CH3.70A" releaseversion="CH4.00">layout changes</remove>
    //   <add id="dach0001"
    //        dev="mnommens"
    //        date="2004-08-01"
    //        area="ENHARCHDOC"
    //        releaseversion="DACH4.00"
    //        request="DACH-START-40">
    //        Enhanced Arch. Doc Mgmt.
    //   </add>
    // </changelog>

    AutoSplitKey = true;
    Caption = 'Posted Sales Invoice Subform';
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    Permissions = TableData 113 = rim;
    SourceTable = Table113;

    layout
    {
        area(content)
        {
            repeater()
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
                    BlankZero = true;
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
        DescriptionOnFormat;
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
        DocumentLineTracking: Page "5005399";

    [Scope('Internal')]
    procedure ShowDimensions()
    begin
        Rec.ShowDimensions;
    end;

    [Scope('Internal')]
    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines;
    end;

    [Scope('Internal')]
    procedure ShowDocumentLineTracking()
    begin
        // dach0001.begin
        CLEAR(DocumentLineTracking);
        DocumentLineTracking.SetDoc(6, "Document No.", "Line No.", "Blanket Order No.", "Blanket Order Line No.", "Order No.", "Order Line No.")
        ;
        DocumentLineTracking.RUNMODAL;
        // dach001.end
    end;

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

