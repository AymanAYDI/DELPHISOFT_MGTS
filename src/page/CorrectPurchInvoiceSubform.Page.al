page 50061 "Correct Purch. Invoice Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = Table123;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Type; Type)
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Cross-Reference No."; "Cross-Reference No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Location Code"; "Location Code")
                {
                    Editable = false;
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
                field("Direct Unit Cost"; "Direct Unit Cost")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Line Amount"; "Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Line Discount %"; "Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }

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
    procedure ShowItemReceiptLines()
    begin
        IF NOT (Type IN [Type::Item, Type::"Charge (Item)"]) THEN
            TESTFIELD(Type);
        Rec.ShowItemReceiptLines;
    end;

    [Scope('Internal')]
    procedure ShowLineComments()
    begin
        Rec.ShowLineComments;
    end;

    [Scope('Internal')]
    procedure ShowDocumentLineTracking()
    var
        DocumentLineTracking: Page "5005399";
    begin
        CLEAR(DocumentLineTracking);
        DocumentLineTracking.SetDoc(7, "Document No.", "Line No.", "Blanket Order No.", "Blanket Order Line No.", "Order No.", "Order Line No.");
        DocumentLineTracking.RUNMODAL;
    end;
}

