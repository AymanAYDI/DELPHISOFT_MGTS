page 50149 "Container Invoiced"
{
    // MGTS10.042  | 02.01.2022 | Container/DESADV Management

    Caption = 'Container Invoiced';
    Editable = false;
    PageType = Worksheet;
    SourceTable = Table50085;
    SourceTableView = SORTING (Container No., Order No., Level)
                      WHERE (Invoice Status=FILTER(Invoiced));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "Order No.";
                IndentationColumn = Level;
                IndentationControls = "Container No.","Order No.";
                ShowAsTree = true;
                field("Container No.";"Container No.")
                {
                    Editable = false;
                    StyleExpr = ContainerNoStyle;
                }
                field("Order No.";"Order No.")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Receipt No.";"Receipt No.")
                {
                    Editable = false;
                }
                field("Purchase Invoice No.";"Purchase Invoice No.")
                {
                    Editable = false;
                }
                field("Buy-from Vendor No.";"Buy-from Vendor No.")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Buy-from Vendor Name";"Buy-from Vendor Name")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Item No.";"Item No.")
                {
                    Editable = false;
                    StyleExpr = ItemNoStyle;
                }
                field(Description;Description)
                {
                    Editable = false;
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Pieces;Pieces)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Meeting Date";"Meeting Date")
                {
                }
                field("Entry No.";"Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Special Order Sales No.";"Special Order Sales No.")
                {
                    Editable = false;
                }
                field("Special Order Sales Line No.";"Special Order Sales Line No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Shipment No.";"Shipment No.")
                {
                    Editable = false;
                }
                field("Sales Invoice No.";"Sales Invoice No.")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
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
                    PurchaseHeader: Record "38";
                    PageManagement: Codeunit "700";
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
                    PurchRcptHeader: Record "120";
                    PageManagement: Codeunit "700";
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
                    PurchInvHeader: Record "122";
                    PageManagement: Codeunit "700";
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
                    SalesHeader: Record "36";
                    PageManagement: Codeunit "700";
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
                    SalesShipmentHeader: Record "110";
                    PageManagement: Codeunit "700";
                begin
                    SalesShipmentHeader.GET(Rec."Shipment No.");
                    PageManagement.PageRunModal(SalesShipmentHeader);
                end;
            }
            action("Sales Invoice")
            {
                Caption = 'Sales Invoice';
                Image = SalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    SalesInvoiceHeader: Record "112";
                    PageManagement: Codeunit "700";
                begin
                    SalesInvoiceHeader.GET(Rec."Sales Invoice No.");
                    PageManagement.PageRunModal(SalesInvoiceHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Level = 1 THEN
          ContainerNoStyle := 'Strong'
        ELSE
          ContainerNoStyle := 'Subordinate';

        IF Warnning = '' THEN
          ItemNoStyle := 'Strong'
        ELSE
          ItemNoStyle := 'Ambiguous';
    end;

    var
        ContainerNoStyle: Text;
        ItemNoStyle: Text;
}

