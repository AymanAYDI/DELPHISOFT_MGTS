page 50147 "Container List"
{
    // MGTS10.042  | 02.01.2022 | Container/DESADV Management

    Caption = 'Container List';
    Editable = false;
    PageType = Worksheet;
    SourceTable = Table50084;
    SourceTableView = SORTING (Container No., Order No., Level);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                FreezeColumn = "Order No.";
                IndentationColumn = Level;
                IndentationControls = "Container No.", "Order No.";
                ShowAsTree = true;
                field("Container No."; "Container No.")
                {
                    StyleExpr = ContainerNoStyle;
                }
                field("Order No."; "Order No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Item No."; "Item No.")
                {
                    StyleExpr = ItemNoStyle;
                }
                field(Description; Description)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Order Quantity"; "Order Quantity")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Quantity Received"; "Quantity Received")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Outstanding Quantity"; "Outstanding Quantity")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Pieces; Pieces)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(CTNS; CTNS)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Volume; Volume)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Weight; Weight)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Entry No."; "Entry No.")
                {
                    Visible = false;
                }
                field("Special Order Sales No."; "Special Order Sales No.")
                {
                }
                field("Special Order Sales Line No."; "Special Order Sales Line No.")
                {
                }
                field(Warnning; Warnning)
                {
                    Style = Ambiguous;
                    StyleExpr = TRUE;
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
            action(PostContainerList)
            {
                Caption = 'Post Container List';
                Ellipsis = true;
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                var
                    Text50000: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
                    Text50001: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
                    ContainerMgt: Codeunit "50060";
                begin
                    ContainerMgt.RUN(Rec);
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

