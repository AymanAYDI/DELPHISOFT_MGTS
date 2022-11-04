page 50061 "DEL Correct Purch. Inv Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Purch. Inv. Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }


    procedure ShowDimensions()
    begin
        Rec.ShowDimensions();
    end;


    procedure ShowItemTrackingLines()
    begin
        Rec.ShowItemTrackingLines();
    end;


    procedure ShowItemReceiptLines()
    begin
        IF NOT (Rec.Type IN [Rec.Type::Item, Rec.Type::"Charge (Item)"]) THEN
            Rec.TESTFIELD(Type);
        Rec.ShowItemReceiptLines();
    end;


    procedure ShowLineComments()
    begin
        Rec.ShowLineComments();
    end;

    //TODO:"Document Lines Tracking" n'existe pas
    // procedure ShowDocumentLineTracking()
    // var
    //     DocumentLineTracking: Page "Document Lines Tracking";
    // begin
    //     CLEAR(DocumentLineTracking);
    //     DocumentLineTracking.SetDoc(7, "Document No.", "Line No.", "Blanket Order No.", "Blanket Order Line No.", "Order No.", "Order Line No.");
    //     DocumentLineTracking.RUNMODAL;
    // end;
}

