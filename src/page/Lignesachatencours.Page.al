page 50010 "DEL Lignes achat en cours"
{
    Editable = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      ORDER(Ascending)
                      WHERE(Type = CONST(Item));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("Document Type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
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
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'Expected Receipt Date';
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
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Caption = 'Outstanding Quantity';
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    Caption = 'Qty. to Invoice';
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    Caption = 'Qty. to Receive';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    Caption = 'Direct Unit Cost';
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
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    Caption = 'Unit Price (LCY)';
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
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Caption = 'Shortcut Dimension 1 Code';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Caption = 'Shortcut Dimension 2 Code';
                }
                field("Job No."; Rec."Job No.")
                {
                    Caption = 'Job No.';
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    Caption = 'Indirect Cost %';
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    Caption = 'Outstanding Amount';
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    Caption = 'Qty. Rcd. Not Invoiced';
                }
                field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                {
                    Caption = 'Amt. Rcd. Not Invoiced';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    Caption = 'Quantity Received';
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    Caption = 'Quantity Invoiced';
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    Caption = 'Receipt No.';
                }
                field("Receipt Line No."; Rec."Receipt Line No.")
                {
                    Caption = 'Receipt Line No.';
                }
                field("Profit %"; Rec."Profit %")
                {
                    Caption = 'Profit %';
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    Caption = 'Pay-to Vendor No.';
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    Caption = 'Inv. Discount Amount';
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    Caption = 'Vendor Item No.';
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    Caption = 'Sales Order No.';
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    Caption = 'Sales Order Line No.';
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
                field("Entry Point"; Rec."Entry Point")
                {
                    Caption = 'Entry Point';
                }
                field("Area"; Rec.Area)
                {
                }
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
                field("Use Tax"; Rec."Use Tax")
                {
                    Caption = 'Use Tax';
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    Caption = 'VAT Bus. Posting Group';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    Caption = 'VAT Prod. Posting Group';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    Caption = 'Currency Code';
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                    Caption = 'Outstanding Amount (LCY)';
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    Caption = 'Amt. Rcd. Not Invoiced (LCY)';
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    Caption = 'Reserved Quantity';
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
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                    Caption = 'Inv. Disc. Amount to Invoice';
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
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    Caption = 'Prod. Order No.';
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
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    Caption = 'Outstanding Qty. (Base)';
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    Caption = 'Qty. to Invoice (Base)';
                }
                field("Qty. to Receive (Base)"; Rec."Qty. to Receive (Base)")
                {
                    Caption = 'Qty. to Receive (Base)';
                }
                field("Qty. Rcd. Not Invoiced (Base)"; Rec."Qty. Rcd. Not Invoiced (Base)")
                {
                    Caption = 'Qty. Rcd. Not Invoiced (Base)';
                }
                field("Qty. Received (Base)"; Rec."Qty. Received (Base)")
                {
                    Caption = 'Qty. Received (Base)';
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    Caption = 'Qty. Invoiced (Base)';
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                    Caption = 'Reserved Qty. (Base)';
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    Caption = 'FA Posting Date';
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    Caption = 'FA Posting Type';
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    Caption = 'Depreciation Book Code';
                }
                field("Salvage Value"; Rec."Salvage Value")
                {
                    Caption = 'Salvage Value';
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    Caption = 'Depr. until FA Posting Date';
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    Caption = 'Depr. Acquisition Cost';
                }
                field("Maintenance Code"; Rec."Maintenance Code")
                {
                    Caption = 'Maintenance Code';
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    Caption = 'Insurance No.';
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    Caption = 'Budgeted FA No.';
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
                field("Item Reference No."; Rec."Item Reference No.")
                {
                    Caption = 'Cross-Reference No.';
                }
                field("Item Reference Unit of Measure"; Rec."Item Reference Unit of Measure")
                {
                    Caption = 'Unit of Measure (Cross Ref.)';
                }
                field("Item Reference Type"; Rec."Item Reference Type")
                {
                    Caption = 'Cross-Reference Type';
                }
                field("Item Reference Type No."; Rec."Item Reference Type No.")
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
                field("Special Order"; Rec."Special Order")
                {
                    Caption = 'Special Order';
                }
                field("Special Order Sales No."; Rec."Special Order Sales No.")
                {
                    Caption = 'Special Order Sales No.';
                }
                field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
                {
                    Caption = 'Special Order Sales Line No.';
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    Caption = 'Whse. Outstanding Qty. (Base)';
                }
                field("Completely Received"; Rec."Completely Received")
                {
                    Caption = 'Completely Received';
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    Caption = 'Requested Receipt Date';
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    Caption = 'Promised Receipt Date';
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    Caption = 'Lead Time Calculation';
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    Caption = 'Inbound Whse. Handling Time';
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    Caption = 'Planned Receipt Date';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    Caption = 'Allow Item Charge Assignment';
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    Caption = 'Qty. to Assign';
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    Caption = 'Qty. Assigned';
                }
                field("Return Qty. to Ship"; Rec."Return Qty. to Ship")
                {
                    Caption = 'Return Qty. to Ship';
                }
                field("Return Qty. to Ship (Base)"; Rec."Return Qty. to Ship (Base)")
                {
                    Caption = 'Return Qty. to Ship (Base)';
                }
                field("Return Qty. Shipped Not Invd."; Rec."Return Qty. Shipped Not Invd.")
                {
                    Caption = 'Return Qty. Shipped Not Invd.';
                }
                field("Ret. Qty. Shpd Not Invd.(Base)"; Rec."Ret. Qty. Shpd Not Invd.(Base)")
                {
                    Caption = 'Ret. Qty. Shpd Not Invd.(Base)';
                }
                field("Return Shpd. Not Invd."; Rec."Return Shpd. Not Invd.")
                {
                    Caption = 'Return Shpd. Not Invd.';
                }
                field("Return Shpd. Not Invd. (LCY)"; Rec."Return Shpd. Not Invd. (LCY)")
                {
                    Caption = 'Return Shpd. Not Invd. (LCY)';
                }
                field("Return Qty. Shipped"; Rec."Return Qty. Shipped")
                {
                    Caption = 'Return Qty. Shipped';
                }
                field("Return Qty. Shipped (Base)"; Rec."Return Qty. Shipped (Base)")
                {
                    Caption = 'Return Qty. Shipped (Base)';
                }
                field("Return Shipment No."; Rec."Return Shipment No.")
                {
                    Caption = 'Return Shipment No.';
                }
                field("Return Shipment Line No."; Rec."Return Shipment Line No.")
                {
                    Caption = 'Return Shipment Line No.';
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    Caption = 'Return Reason Code';
                }
                field("Routing No."; Rec."Routing No.")
                {
                    Caption = 'Routing No.';
                }
                field("Operation No."; Rec."Operation No.")
                {
                    Caption = 'Operation No.';
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    Caption = 'Work Center No.';
                }
                field(Finished; Rec.Finished)
                {
                    Caption = 'Finished';
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    Caption = 'Prod. Order Line No.';
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    Caption = 'Overhead Rate';
                }
                field("MPS Order"; Rec."MPS Order")
                {
                    Caption = 'MPS Order';
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    Caption = 'Planning Flexibility';
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    Caption = 'Safety Lead Time';
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                    Caption = 'Routing Reference No.';
                }
            }
        }
    }

    actions
    {
    }
}

