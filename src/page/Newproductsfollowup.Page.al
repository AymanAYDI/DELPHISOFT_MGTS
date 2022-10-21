page 50004 "DEL New products follow up"
{
    Caption = 'New products follow up';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    Permissions = TableData "Purch. Inv. Line" = rimd;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      WHERE("DEL First Purch. Order" = CONST(true),
                            Type = CONST(Item),
                            "DEL Photo And DDoc" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Buy-from Vendor No.';
                }
                field(BuyfromVendorName; BuyfromVendorName)
                {
                    Caption = 'Vendor name';
                    Editable = false;
                    ToolTip = 'Vendor name';
                }
                field("Document No."; Rec."Document No.")
                {
                    Editable = false;
                    Caption = 'Document No.';
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    Caption = 'No.';
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                    Caption = 'Description';
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                    Caption = 'Order Date';
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'PI delivery date';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                    Caption = 'Quantity';
                }

                field("Sample Collected"; Rec."DEL Sample Collected")
                {
                    Caption = 'DDOCS provided';

                    trigger OnValidate()
                    begin
                        IF Rec."DEL Photo Taked" = TRUE THEN BEGIN
                            IF Rec."DEL Sample Collected" = TRUE THEN Rec."DEL Photo And DDoc" := TRUE;
                            CurrPage.UPDATE();
                        END;
                    end;
                }
                field("Collected Date"; Rec."DEL Collected Date")
                {
                    Caption = 'DDOCS date';
                    Editable = true;
                }
                field("Sample Collected by"; Rec."DEL Sample Collected by")
                {
                    Caption = 'DDOCS by';
                }
                field("Photo Taked"; Rec."DEL Photo Taked")
                {
                    Caption = 'Picture Taken';

                    trigger OnValidate()
                    begin
                        IF Rec."DEL Photo Taked" = TRUE THEN BEGIN
                            IF Rec."DEL Sample Collected" = TRUE THEN Rec."DEL Photo And DDoc" := TRUE;
                            CurrPage.UPDATE();
                        END;
                    end;
                }
                field("Photo Date"; Rec."DEL Photo Date")
                {
                    Caption = 'Picture Date';
                    Editable = true;
                }
                field("Photo Taked By"; Rec."DEL Photo Taked By")
                {
                    Caption = 'Picture Taked By';
                }
                field(PurchCode; PurchCode)
                {
                    Caption = 'Purchaser Code';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Show Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Show Document';
                Image = View;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Shift+F7';
                ToolTip = 'Open the document that the selected line exists on.';

                trigger OnAction()
                var
                    PurchHeader: Record "Purchase Header";
                    PageManagement: Codeunit "Page Management";

                begin
                    PurchHeader.GET(Rec."Document Type", Rec."Document No.");
                    PageManagement.PageRun(PurchHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BuyfromVendorName := '';
        IF Vendor_Rec.GET(Rec."Buy-from Vendor No.") THEN
            BuyfromVendorName := Vendor_Rec.Name;
        PurchaseHeader_Rec.SETRANGE("No.", Rec."Document No.");

        IF PurchaseHeader_Rec.FINDFIRST() THEN
            PurchCode := PurchaseHeader_Rec."Purchaser Code"
        ELSE
            PurchCode := '';


    end;

    var

        PurchaseHeader_Rec: Record "Purchase Header";
        Vendor_Rec: Record Vendor;


        PurchCode: Code[10];
        BuyfromVendorName: Text;


    local procedure ExistOldPurch(ItemNo: Code[20]): Boolean
    var
        PurchInvLine: Record "Purch. Inv. Line";
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SETRANGE("Document Type", PurchaseLine."Document Type"::Order);
        PurchaseLine.SETRANGE(Type, PurchaseLine.Type::Item);
        PurchaseLine.SETRANGE("No.", ItemNo);

        PurchInvLine.SETRANGE("No.", ItemNo);
        PurchInvLine.SETRANGE(Type, PurchInvLine.Type::Item);
        IF (PurchaseLine.FINDFIRST() OR PurchInvLine.FINDFIRST()) THEN
            EXIT(FALSE)
        ELSE
            EXIT(TRUE);
    end;
}

