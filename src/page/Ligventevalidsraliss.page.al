page 50008 "DEL Lig vente validés/réalisés"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Sales Invoice Line";
    SourceTableView = ORDER(Ascending)
                      WHERE(Type = CONST(Item));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Caption = 'Sell-to Customer No.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field("Line No."; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    Caption = 'Posting Group';
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    Caption = 'Shipment Date';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Description 2"; Rec."Description 2")
                {
                    Caption = 'Description 2';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    Caption = 'Unit of Measure';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    Caption = 'Unit Cost (LCY)';
                }
                field("VAT %"; Rec."VAT %")
                {
                    Caption = 'VAT %';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    Caption = 'Line Discount %';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    Caption = 'Line Discount Amount';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    Caption = 'Amount Including VAT';
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    Caption = 'Allow Invoice Disc.';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Caption = 'Gross Weight';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Caption = 'Net Weight';
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    Caption = 'Units per Parcel';
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    Caption = 'Unit Volume';
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    Caption = 'Appl.-to Item Entry';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field("Customer Price Group"; Rec."Customer Price Group")
                {
                    Caption = 'Customer Price Group';
                }
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    Caption = 'Work Type Code';
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    Caption = 'Shipment No.';
                }
                field("Shipment Line No."; Rec."Shipment Line No.")
                {
                    Caption = 'Shipment Line No.';
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount';
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    Caption = 'Drop Shipment';
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Caption = 'Gen. Bus. Posting Group';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'Gen. Prod. Posting Group';
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    Caption = 'VAT Calculation Type';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Caption = 'Transaction Type';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    Caption = 'Transport Method';
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    Caption = 'Attached to Line No.';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    Caption = 'Exit Point';
                }
                //TODO         field("Area"; Area)
                // {
                // }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    Caption = 'Transaction Specification';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    Caption = 'Tax Area Code';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    Caption = 'Tax Liable';
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    Caption = 'Tax Group Code';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    Caption = 'Blanket Order No.';
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    Caption = 'Blanket Order Line No.';
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    Caption = 'VAT Base Amount';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    Caption = 'System-Created Entry';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    Caption = 'VAT Difference';
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                    Caption = 'VAT Identifier';
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    Caption = 'IC Partner Ref. Type';
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    Caption = 'IC Partner Reference';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    Caption = 'Bin Code';
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    Caption = 'Qty. per Unit of Measure';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    Caption = 'Unit of Measure Code';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    Caption = 'Quantity (Base)';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date';
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    Caption = 'Duplicate in Depreciation Book';
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    Caption = 'Use Duplication List';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    Caption = 'Cross-Reference No.';
                }
                field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure (Cross Ref.)")
                {
                    Caption = 'Unit of Measure (Cross Ref.)';
                }
                field("Cross-Reference Type"; Rec."Cross-Reference Type")
                {
                    Caption = 'Cross-Reference Type';
                }
                field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
                {
                    Caption = 'Cross-Reference Type No.';
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';
                }
                field(Nonstock; Rec.Nonstock)
                {
                    Caption = 'Catalog';
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    Caption = 'Purchasing Code';
                }
                //TODO field("Product Group Code"; Rec."Product Group Code")
                // {
                // }
                field("Appl.-from Item Entry"; Rec."Appl.-from Item Entry")
                {
                    Caption = 'Appl.-from Item Entry';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
                field("Allow Line Disc."; Rec."Allow Line Disc.")
                {
                    Caption = 'Allow Line Disc.';
                }
                field("Customer Disc. Group"; Rec."Customer Disc. Group")
                {
                    Caption = 'Customer Disc. Group';
                }
                field("Quote-Level"; Rec."Quote-Level")
                {
                    Caption = 'Quote-Level';
                }
                field(Position; Rec.Position)
                {
                    Caption = 'Position';
                }
                field("Subtotal net"; Rec."Subtotal net")
                {
                    Caption = 'Subtotal net';
                }
                field("Subtotal gross"; Rec."Subtotal gross")
                {
                    Caption = 'Subtotal gross';
                }
                field("Title No."; Rec."Title No.")
                {
                    Caption = 'Title No.';
                }
                field(Classification; Rec.Classification)
                {
                    Caption = 'Classification';
                }
                field("Order No."; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    Caption = 'Order Line No.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
            }
        }
    }

    actions
    {
    }
}

