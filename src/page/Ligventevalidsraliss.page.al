page 50008 "DEL Lig vente validés/réalisés"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = ORDER(Ascending)
                      WHERE(Type = CONST(Item));
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Item Reference Unit of Measure"; Rec."Item Reference Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Item Reference Type"; Rec."Item Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Item Reference Type No."; Rec."Item Reference Type No.")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                }
                //TODO field("Product Group Code"; Rec."Product Group Code")
                // {
                // }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    ApplicationArea = All;
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    ApplicationArea = All;
                }
                field("Quote-Level"; Rec."Quote-Level")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Subtotal net"; Rec."Subtotal net")
                {
                    ApplicationArea = All;
                }
                field("Subtotal gross"; Rec."Subtotal gross")
                {
                    ApplicationArea = All;
                }
                field("Title No."; Rec."Title No.")
                {
                    ApplicationArea = All;
                }
                field(Classification; Rec.Classification)
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

