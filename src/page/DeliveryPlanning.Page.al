page 50148 "DEL Delivery Planning"
{

    Caption = 'Delivery Planning';
    PageType = Worksheet;
    SourceTable = "DEL Posted Container List";
    SourceTableView = SORTING("Container No.", "Order No.", Level)
                      WHERE("Invoice Status" = FILTER("Awaiting Invoicing"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "Order No.";
                IndentationColumn = Rec.Level;
                IndentationControls = "Container No.", "Order No.";
                ShowAsTree = true;
                field("Container No."; Rec."Container No.")
                {
                    Editable = false;
                    StyleExpr = ContainerNoStyle;
                }
                field("Order No."; Rec."Order No.")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    Editable = false;
                }
                field("Purchase Invoice No."; Rec."Purchase Invoice No.")
                {
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    StyleExpr = ItemNoStyle;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Pieces; Rec.Pieces)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Meeting Date"; Rec."Meeting Date")
                {
                    Editable = DeliveryDateEditable;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Special Order Sales No."; Rec."Special Order Sales No.")
                {
                    Editable = false;
                }
                field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shipment No."; Rec."Shipment No.")
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Meeting Date")
            {
                Caption = 'Import Meeting Date';
                Ellipsis = true;
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Report "Import Meeting Date From Excel";

            }
            action(Invoice)
            {
                Caption = 'Invoice';
                Ellipsis = true;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    ContainerMgt: Codeunit "DEL Container Mgt";
                begin
                    ContainerMgt.Invoice(Rec);
                end;
            }
            action("Purchase Order")
            {
                Caption = 'Purchase Order';
                Image = "Order";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PurchaseHeader: Record "Purchase Header";
                    PageManagement: Codeunit "Page Management";
                begin
                    PurchaseHeader.GET(PurchaseHeader."Document Type"::Order, Rec."Order No.");
                    PageManagement.PageRunModal(PurchaseHeader);
                end;
            }
            action(Receipt)
            {
                Caption = 'Receipt';
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PurchRcptHeader: Record "Purch. Rcpt. Header";
                    PageManagement: Codeunit "Page Management";
                begin
                    PurchRcptHeader.GET(Rec."Receipt No.");
                    PageManagement.PageRunModal(PurchRcptHeader);
                end;
            }
            action("Purchase Invoice")
            {
                Caption = 'Purchase Invoice';
                Image = PurchaseInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                    PageManagement: Codeunit "Page Management";
                begin
                    PurchInvHeader.GET(Rec."Purchase Invoice No.");
                    PageManagement.PageRunModal(PurchInvHeader);
                end;
            }
            action("Sales Order")
            {
                Caption = 'Sales Order';
                Image = Sales;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    PageManagement: Codeunit "Page Management";
                begin
                    SalesHeader.GET(SalesHeader."Document Type"::Order, Rec."Special Order Sales No.");
                    PageManagement.PageRunModal(SalesHeader);
                end;
            }
            action(Shipment)
            {
                Caption = 'Shipment';
                Image = SalesShipment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SalesShipmentHeader: Record "Sales Shipment Header";
                    PageManagement: Codeunit "Page Management";
                begin
                    SalesShipmentHeader.GET(Rec."Shipment No.");
                    PageManagement.PageRunModal(SalesShipmentHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Level = 1 THEN BEGIN
            ContainerNoStyle := 'Strong';
            DeliveryDateEditable := TRUE;
        END
        ELSE BEGIN
            ContainerNoStyle := 'Subordinate';
            DeliveryDateEditable := FALSE;
        END;

        IF Rec.Warnning = '' THEN
            ItemNoStyle := 'Strong'
        ELSE
            ItemNoStyle := 'Ambiguous';
    end;

    var
        DeliveryDateEditable: Boolean;
        ContainerNoStyle: Text;
        ItemNoStyle: Text;
}

