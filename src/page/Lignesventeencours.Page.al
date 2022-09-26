page 50009 "Lignes vente en cours"
{
    Editable = false;
    PageType = List;
    SourceTable = Table37;
    SourceTableView = SORTING (Document Type, Document No., Line No.)
                      ORDER(Ascending)
                      WHERE (Type = CONST (Item));

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field("Document Type"; "Document Type")
                {
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("Line No."; "Line No.")
                {
                }
                field(Type; Type)
                {
                }
                field("No."; "No.")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Posting Group"; "Posting Group")
                {
                }
                field("Shipment Date"; "Shipment Date")
                {
                }
                field(Description; Description)
                {
                }
                field("Description 2"; "Description 2")
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                }
                field("Qty. to Invoice"; "Qty. to Invoice")
                {
                }
                field("Qty. to Ship"; "Qty. to Ship")
                {
                }
                field("Unit Price"; "Unit Price")
                {
                }
                field("Unit Cost (LCY)"; "Unit Cost (LCY)")
                {
                }
                field("VAT %"; "VAT %")
                {
                }
                field("Line Discount %"; "Line Discount %")
                {
                }
                field("Line Discount Amount"; "Line Discount Amount")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                }
                field("Allow Invoice Disc."; "Allow Invoice Disc.")
                {
                }
                field("Gross Weight"; "Gross Weight")
                {
                }
                field("Net Weight"; "Net Weight")
                {
                }
                field("Units per Parcel"; "Units per Parcel")
                {
                }
                field("Unit Volume"; "Unit Volume")
                {
                }
                field("Appl.-to Item Entry"; "Appl.-to Item Entry")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Customer Price Group"; "Customer Price Group")
                {
                }
                field("Job No."; "Job No.")
                {
                }
                field("Work Type Code"; "Work Type Code")
                {
                }
                field("Outstanding Amount"; "Outstanding Amount")
                {
                }
                field("Qty. Shipped Not Invoiced"; "Qty. Shipped Not Invoiced")
                {
                }
                field("Shipped Not Invoiced"; "Shipped Not Invoiced")
                {
                }
                field("Quantity Shipped"; "Quantity Shipped")
                {
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                }
                field("Shipment No."; "Shipment No.")
                {
                }
                field("Shipment Line No."; "Shipment Line No.")
                {
                }
                field("Profit %"; "Profit %")
                {
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                }
                field("Purchase Order No."; "Purchase Order No.")
                {
                }
                field("Purch. Order Line No."; "Purch. Order Line No.")
                {
                }
                field("Drop Shipment"; "Drop Shipment")
                {
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                }
                field("VAT Calculation Type"; "VAT Calculation Type")
                {
                }
                field("Transaction Type"; "Transaction Type")
                {
                }
                field("Transport Method"; "Transport Method")
                {
                }
                field("Attached to Line No."; "Attached to Line No.")
                {
                }
                field("Exit Point"; "Exit Point")
                {
                }
                field(Area;Area)
        {
        }
                field("Transaction Specification";"Transaction Specification")
                {
                }
                field("Tax Area Code";"Tax Area Code")
                {
                }
                field("Tax Liable";"Tax Liable")
                {
                }
                field("Tax Group Code";"Tax Group Code")
                {
                }
                field("VAT Bus. Posting Group";"VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group";"VAT Prod. Posting Group")
                {
                }
                field("Currency Code";"Currency Code")
                {
                }
                field("Outstanding Amount (LCY)";"Outstanding Amount (LCY)")
                {
                }
                field("Shipped Not Invoiced (LCY)";"Shipped Not Invoiced (LCY)")
                {
                }
                field("Reserved Quantity";"Reserved Quantity")
                {
                }
                field(Reserve;Reserve)
                {
                }
                field("Blanket Order No.";"Blanket Order No.")
                {
                }
                field("Blanket Order Line No.";"Blanket Order Line No.")
                {
                }
                field("VAT Base Amount";"VAT Base Amount")
                {
                }
                field("Unit Cost";"Unit Cost")
                {
                }
                field("System-Created Entry";"System-Created Entry")
                {
                }
                field("Line Amount";"Line Amount")
                {
                }
                field("VAT Difference";"VAT Difference")
                {
                }
                field("Inv. Disc. Amount to Invoice";"Inv. Disc. Amount to Invoice")
                {
                }
                field("VAT Identifier";"VAT Identifier")
                {
                }
                field("IC Partner Ref. Type";"IC Partner Ref. Type")
                {
                }
                field("IC Partner Reference";"IC Partner Reference")
                {
                }
                field("Variant Code";"Variant Code")
                {
                }
                field("Bin Code";"Bin Code")
                {
                }
                field("Qty. per Unit of Measure";"Qty. per Unit of Measure")
                {
                }
                field(Planned;Planned)
                {
                }
                field("Unit of Measure Code";"Unit of Measure Code")
                {
                }
                field("Quantity (Base)";"Quantity (Base)")
                {
                }
                field("Outstanding Qty. (Base)";"Outstanding Qty. (Base)")
                {
                }
                field("Qty. to Invoice (Base)";"Qty. to Invoice (Base)")
                {
                }
                field("Qty. to Ship (Base)";"Qty. to Ship (Base)")
                {
                }
                field("Qty. Shipped Not Invd. (Base)";"Qty. Shipped Not Invd. (Base)")
                {
                }
                field("Qty. Shipped (Base)";"Qty. Shipped (Base)")
                {
                }
                field("Qty. Invoiced (Base)";"Qty. Invoiced (Base)")
                {
                }
                field("Reserved Qty. (Base)";"Reserved Qty. (Base)")
                {
                }
                field("FA Posting Date";"FA Posting Date")
                {
                }
                field("Depreciation Book Code";"Depreciation Book Code")
                {
                }
                field("Depr. until FA Posting Date";"Depr. until FA Posting Date")
                {
                }
                field("Duplicate in Depreciation Book";"Duplicate in Depreciation Book")
                {
                }
                field("Use Duplication List";"Use Duplication List")
                {
                }
                field("Responsibility Center";"Responsibility Center")
                {
                }
                field("Out-of-Stock Substitution";"Out-of-Stock Substitution")
                {
                }
                field("Substitution Available";"Substitution Available")
                {
                }
                field("Originally Ordered No.";"Originally Ordered No.")
                {
                }
                field("Originally Ordered Var. Code";"Originally Ordered Var. Code")
                {
                }
                field("Cross-Reference No.";"Cross-Reference No.")
                {
                }
                field("Unit of Measure (Cross Ref.)";"Unit of Measure (Cross Ref.)")
                {
                }
                field("Cross-Reference Type";"Cross-Reference Type")
                {
                }
                field("Cross-Reference Type No.";"Cross-Reference Type No.")
                {
                }
                field("Item Category Code";"Item Category Code")
                {
                }
                field(Nonstock;Nonstock)
                {
                }
                field("Purchasing Code";"Purchasing Code")
                {
                }
                field("Product Group Code";"Product Group Code")
                {
                }
                field("Special Order";"Special Order")
                {
                }
                field("Special Order Purchase No.";"Special Order Purchase No.")
                {
                }
                field("Special Order Purch. Line No.";"Special Order Purch. Line No.")
                {
                }
                field("Whse. Outstanding Qty. (Base)";"Whse. Outstanding Qty. (Base)")
                {
                }
                field("Completely Shipped";"Completely Shipped")
                {
                }
                field("Requested Delivery Date";"Requested Delivery Date")
                {
                }
                field("Promised Delivery Date";"Promised Delivery Date")
                {
                }
                field("Shipping Time";"Shipping Time")
                {
                }
                field("Outbound Whse. Handling Time";"Outbound Whse. Handling Time")
                {
                }
                field("Planned Delivery Date";"Planned Delivery Date")
                {
                }
                field("Planned Shipment Date";"Planned Shipment Date")
                {
                }
                field("Shipping Agent Code";"Shipping Agent Code")
                {
                }
                field("Shipping Agent Service Code";"Shipping Agent Service Code")
                {
                }
                field("Allow Item Charge Assignment";"Allow Item Charge Assignment")
                {
                }
                field("Qty. to Assign";"Qty. to Assign")
                {
                }
                field("Qty. Assigned";"Qty. Assigned")
                {
                }
                field("Return Qty. to Receive";"Return Qty. to Receive")
                {
                }
                field("Return Qty. to Receive (Base)";"Return Qty. to Receive (Base)")
                {
                }
                field("Return Qty. Rcd. Not Invd.";"Return Qty. Rcd. Not Invd.")
                {
                }
                field("Ret. Qty. Rcd. Not Invd.(Base)";"Ret. Qty. Rcd. Not Invd.(Base)")
                {
                }
                field("Return Rcd. Not Invd.";"Return Rcd. Not Invd.")
                {
                }
                field("Return Rcd. Not Invd. (LCY)";"Return Rcd. Not Invd. (LCY)")
                {
                }
                field("Return Qty. Received";"Return Qty. Received")
                {
                }
                field("Return Qty. Received (Base)";"Return Qty. Received (Base)")
                {
                }
                field("Appl.-from Item Entry";"Appl.-from Item Entry")
                {
                }
                field("BOM Item No.";"BOM Item No.")
                {
                }
                field("Return Receipt No.";"Return Receipt No.")
                {
                }
                field("Return Receipt Line No.";"Return Receipt Line No.")
                {
                }
                field("Return Reason Code";"Return Reason Code")
                {
                }
                field("Allow Line Disc.";"Allow Line Disc.")
                {
                }
                field("Customer Disc. Group";"Customer Disc. Group")
                {
                }
                field("Customer line reference2";"Customer line reference2")
                {
                }
                field(Level;Level)
                {
                }
                field(Position;Position)
                {
                }
                field("Quote Variant";"Quote Variant")
                {
                }
                field("Subtotal Net";"Subtotal Net")
                {
                }
                field("Subtotal Gross";"Subtotal Gross")
                {
                }
                field("Title No.";"Title No.")
                {
                }
                field(Classification;Classification)
                {
                }
            }
        }
    }

    actions
    {
    }
}

