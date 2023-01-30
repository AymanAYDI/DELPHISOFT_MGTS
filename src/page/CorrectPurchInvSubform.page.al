page 50061 "DEL Correct Purch. Inv Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    Editable = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Purch. Inv. Line";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Type; Rec.Type)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Item Reference No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    BlankZero = true;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

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
