page 50014 "DEL Corr. facture vente ligne"
{
    AutoSplitKey = true;
    Caption = 'Posted Sales Invoice Subform';
    Editable = true;
    InsertAllowed = false;
    PageType = ListPart;
    Permissions = TableData "Sales Invoice Line" = rim;
    SourceTable = "Sales Invoice Line";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                field(Type; Rec.Type)
                {
                    Editable = false;
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Caption = 'No.';
                }
                field(Position; Rec.Position)
                {
                    Caption = 'Pos';
                    Editable = false;
                    Visible = false;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Cross-Reference No.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Variant Code';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Caption = 'Description';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Return Reason Code';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Location Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Bin Code';
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    Caption = 'Quantity';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    Caption = 'Unit of Measure Code';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Unit of Measure';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Unit Cost (LCY)';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    BlankZero = true;
                    Editable = false;
                    Caption = 'Unit Price';
                }
                field(LineAmountText; LineAmountText)
                {
                    //TODO    // BlankZero = true;
                    CaptionClass = Rec.FIELDCAPTION("Line Amount");
                    Editable = false;
                    Caption = 'LineAmountText';
                }
                field(AmountIncludingVATText; AmountIncludingVATText)
                {
                    CaptionClass = Rec.FIELDCAPTION("Amount Including VAT");
                    Editable = false;
                    Caption = 'AmountIncludingVATText';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                    Caption = 'Line Discount %';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Line Discount Amount';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Allow Invoice Disc.';
                }
                field("Job No."; Rec."Job No.")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Job No.';
                }
                field("Title No."; Rec."Title No.")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Title No.';
                }
                field("Quote-Level"; Rec."Quote-Level")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Quote-Level';
                }
                field(Classification; Rec.Classification)
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Classification';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Appl.-to Item Entry';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = true;
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Editable = false;
                    Visible = false;
                    Caption = 'Shortcut Dimension 2 Code';
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
        LineAmountText := FORMAT(Rec."Line Amount");
        LineAmountTextOnFormat(LineAmountText);
        AmountIncludingVATText := FORMAT(Rec."Amount Including VAT");
        AmountIncludingVATTextOnFormat(AmountIncludingVATText);
    end;

    var
        [InDataSet]
        "Amount Including VATEmphasize": Boolean;
        [InDataSet]
        DescriptionEmphasize: Boolean;
        [InDataSet]
        "Line AmountEmphasize": Boolean;
        [InDataSet]
        DescriptionIndent: Integer;
        [InDataSet]
        AmountIncludingVATText: Text[1024];
        [InDataSet]
        LineAmountText: Text[1024];
    //TODO //  DocumentLineTracking: Page "5005399";


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;


    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines();
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

        IF Rec."Quote-Level" > 0 THEN
            DescriptionIndent := Rec."Quote-Level" - 1;

        IF Rec.Type IN [Rec.Type::Title, Rec.Type::"Begin-Total", Rec.Type::"End-Total"] THEN
            DescriptionEmphasize := TRUE

    end;

    local procedure LineAmountTextOnFormat(var Text: Text[1024])
    begin

        IF (Rec.Type = Rec.Type::"End-Total") AND (Rec."Subtotal net" <> 0) THEN BEGIN
            Text := FORMAT(Rec."Subtotal net", 0, '<Sign><Integer Thousand><Decimals,3>');
            "Line AmountEmphasize" := TRUE;
        END;

    end;

    local procedure AmountIncludingVATTextOnFormat(var Text: Text[1024])
    begin

        IF (Rec.Type = Rec.Type::"End-Total") AND (Rec."Subtotal gross" <> 0) THEN BEGIN
            Text := FORMAT(Rec."Subtotal gross", 0, '<Sign><Integer Thousand><Decimals,3>');
            "Amount Including VATEmphasize" := TRUE;
        END;

    end;
}

