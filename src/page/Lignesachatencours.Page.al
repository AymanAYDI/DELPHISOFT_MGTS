page 50010 "Lignes achat en cours"
{
    Editable = false;
    PageType = List;
    SourceTable = Table39;
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
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
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
                field("Expected Receipt Date"; "Expected Receipt Date")
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
                field("Qty. to Receive"; "Qty. to Receive")
                {
                }
                field("Direct Unit Cost"; "Direct Unit Cost")
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
                field("Unit Price (LCY)"; "Unit Price (LCY)")
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
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Job No."; "Job No.")
                {
                }
                field("Indirect Cost %"; "Indirect Cost %")
                {
                }
                field("Outstanding Amount"; "Outstanding Amount")
                {
                }
                field("Qty. Rcd. Not Invoiced"; "Qty. Rcd. Not Invoiced")
                {
                }
                field("Amt. Rcd. Not Invoiced"; "Amt. Rcd. Not Invoiced")
                {
                }
                field("Quantity Received"; "Quantity Received")
                {
                }
                field("Quantity Invoiced"; "Quantity Invoiced")
                {
                }
                field("Receipt No."; "Receipt No.")
                {
                }
                field("Receipt Line No."; "Receipt Line No.")
                {
                }
                field("Profit %"; "Profit %")
                {
                }
                field("Pay-to Vendor No."; "Pay-to Vendor No.")
                {
                }
                field("Inv. Discount Amount"; "Inv. Discount Amount")
                {
                }
                field("Vendor Item No."; "Vendor Item No.")
                {
                }
                field("Sales Order No."; "Sales Order No.")
                {
                }
                field("Sales Order Line No."; "Sales Order Line No.")
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
                field("Entry Point"; "Entry Point")
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
                field("Use Tax";"Use Tax")
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
                field("Amt. Rcd. Not Invoiced (LCY)";"Amt. Rcd. Not Invoiced (LCY)")
                {
                }
                field("Reserved Quantity";"Reserved Quantity")
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
                field("Prod. Order No.";"Prod. Order No.")
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
                field("Qty. to Receive (Base)";"Qty. to Receive (Base)")
                {
                }
                field("Qty. Rcd. Not Invoiced (Base)";"Qty. Rcd. Not Invoiced (Base)")
                {
                }
                field("Qty. Received (Base)";"Qty. Received (Base)")
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
                field("FA Posting Type";"FA Posting Type")
                {
                }
                field("Depreciation Book Code";"Depreciation Book Code")
                {
                }
                field("Salvage Value";"Salvage Value")
                {
                }
                field("Depr. until FA Posting Date";"Depr. until FA Posting Date")
                {
                }
                field("Depr. Acquisition Cost";"Depr. Acquisition Cost")
                {
                }
                field("Maintenance Code";"Maintenance Code")
                {
                }
                field("Insurance No.";"Insurance No.")
                {
                }
                field("Budgeted FA No.";"Budgeted FA No.")
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
                field("Special Order Sales No.";"Special Order Sales No.")
                {
                }
                field("Special Order Sales Line No.";"Special Order Sales Line No.")
                {
                }
                field("Whse. Outstanding Qty. (Base)";"Whse. Outstanding Qty. (Base)")
                {
                }
                field("Completely Received";"Completely Received")
                {
                }
                field("Requested Receipt Date";"Requested Receipt Date")
                {
                }
                field("Promised Receipt Date";"Promised Receipt Date")
                {
                }
                field("Lead Time Calculation";"Lead Time Calculation")
                {
                }
                field("Inbound Whse. Handling Time";"Inbound Whse. Handling Time")
                {
                }
                field("Planned Receipt Date";"Planned Receipt Date")
                {
                }
                field("Order Date";"Order Date")
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
                field("Return Qty. to Ship";"Return Qty. to Ship")
                {
                }
                field("Return Qty. to Ship (Base)";"Return Qty. to Ship (Base)")
                {
                }
                field("Return Qty. Shipped Not Invd.";"Return Qty. Shipped Not Invd.")
                {
                }
                field("Ret. Qty. Shpd Not Invd.(Base)";"Ret. Qty. Shpd Not Invd.(Base)")
                {
                }
                field("Return Shpd. Not Invd.";"Return Shpd. Not Invd.")
                {
                }
                field("Return Shpd. Not Invd. (LCY)";"Return Shpd. Not Invd. (LCY)")
                {
                }
                field("Return Qty. Shipped";"Return Qty. Shipped")
                {
                }
                field("Return Qty. Shipped (Base)";"Return Qty. Shipped (Base)")
                {
                }
                field("Return Shipment No.";"Return Shipment No.")
                {
                }
                field("Return Shipment Line No.";"Return Shipment Line No.")
                {
                }
                field("Return Reason Code";"Return Reason Code")
                {
                }
                field("Routing No.";"Routing No.")
                {
                }
                field("Operation No.";"Operation No.")
                {
                }
                field("Work Center No.";"Work Center No.")
                {
                }
                field(Finished;Finished)
                {
                }
                field("Prod. Order Line No.";"Prod. Order Line No.")
                {
                }
                field("Overhead Rate";"Overhead Rate")
                {
                }
                field("MPS Order";"MPS Order")
                {
                }
                field("Planning Flexibility";"Planning Flexibility")
                {
                }
                field("Safety Lead Time";"Safety Lead Time")
                {
                }
                field("Routing Reference No.";"Routing Reference No.")
                {
                }
            }
        }
    }

    actions
    {
    }
}

