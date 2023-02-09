page 50147 "DEL Container List"
{

    Caption = 'Container List';
    Editable = false;
    PageType = Worksheet;
    SourceTable = "DEL Container List";
    SourceTableView = SORTING("Container No.", "Order No.", Level);

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
                    StyleExpr = ContainerNoStyle;
                }
                field("Order No."; Rec."Order No.")
                {
                    Style = Strong;
                    StyleExpr = TRUE;
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
                    StyleExpr = ItemNoStyle;
                }
                field(Description; Rec.Description)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Pieces; Rec.Pieces)
                {
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field(CTNS; Rec.CTNS)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Volume; Rec.Volume)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field(Weight; Rec.Weight)
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                }
                field("Special Order Sales No."; Rec."Special Order Sales No.")
                {
                }
                field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
                {
                }
                field(Warnning; Rec.Warnning)
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
                    PurchaseHeader: Record "Purchase Header";
                    PageManagement: Codeunit "Page Management";
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
                    SalesHeader: Record "Sales Header";
                    PageManagement: Codeunit "Page Management";
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
                    ContainerMgt: Codeunit "DEL Container Mgt";
                    Text50000: Label 'There are unposted prepayment amounts on the document of type %1 with the number %2.';
                    Text50001: Label 'There are unpaid prepayment invoices that are related to the document of type %1 with the number %2.';
                begin
                    ContainerMgt.RUN(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Rec.Level = 1 THEN
            ContainerNoStyle := 'Strong'
        ELSE
            ContainerNoStyle := 'Subordinate';

        IF Rec.Warnning = '' THEN
            ItemNoStyle := 'Strong'
        ELSE
            ItemNoStyle := 'Ambiguous';
    end;

    var
        ContainerNoStyle: Text;
        ItemNoStyle: Text;
}

