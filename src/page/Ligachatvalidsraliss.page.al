page 50007 "DEL Lig achat validés/réalisés"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = ORDER(Ascending)
                      WHERE(Type = CONST(Item));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("No."; Rec."No.")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Posting Group"; Rec."Posting Group")
                {
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description 2"; Rec."Description 2")
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                }
                field("VAT %"; Rec."VAT %")
                {
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Net Weight"; Rec."Net Weight")
                {
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                }
                field("Job No."; Rec."Job No.")
                {
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                }
                field("Transport Method"; Rec."Transport Method")
                {
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                }
                field("Exit Point"; Rec."Exit Point")
                {
                }
                field("Area"; Rec.Area)
                {
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Bin Code"; Rec."Bin Code")
                {
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                }
                //corss- Reference
                field("Item Reference No."; Rec."Item Reference No.")
                {
                }
                //Unit of Measure (Cross Ref.)
                field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure")
                {
                }
                field("Item Reference Type"; Rec."Item Reference Type")
                {
                }
                field("Item Reference Type No."; Rec."Item Reference Type No.")
                {
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field(Nonstock; Rec.Nonstock)
                {
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                }
                //TODO field("Product Group Code"; Rec."Product Group Code")
                // {
                // }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                }
                field("Quote-Level"; Rec."Quote-Level")
                {
                }
                field(Position; Rec.Position)
                {
                }
                field("Subtotal net"; Rec."Subtotal net")
                {
                }
                field("Subtotal gross"; Rec."Subtotal gross")
                {
                }
                field("Title No."; Rec."Title No.")
                {
                }
                field(Classification; Rec.Classification)
                {
                }
                field("Order No."; Rec."Order No.")
                {
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                }
                field("Posting Date"; Rec."Posting Date")
                {
                }
            }
        }
    }


}

