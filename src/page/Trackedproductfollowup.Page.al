page 50012 "DEL Tracked product follow up"
{
    Caption = 'Tracked product follow up';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      WHERE("DEL Risk Item" = CONST(true),
                            "DEL Photo Risk Item Taked" = CONST(false));

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
                field("Photo Risk Item Taked"; Rec."DEL Photo Risk Item Taked")
                {
                    Caption = 'Tracking Completed';
                }
                field("Photo Risk Item Date"; Rec."DEL Photo Risk Item Date")
                {
                    Caption = 'tracking completed on';
                    Editable = true;
                }
                field("Photo Risk Item Taked By"; Rec."DEL Photo Risk Item Taked By")
                {
                    Caption = 'tracking completed by';
                }
                field(PurchCode; PurchCode)
                {
                    Caption = 'Purchaser Code';
                }
                field(motif; motif)
                {
                    Caption = 'tracking reason';
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

        motif := '';
        IF Item.GET(Rec."No.") THEN
            IF Listedesmotifs.GET(Item."DEL Code motif de suivi") THEN
                motif := Listedesmotifs.Motif;
    end;

    trigger OnOpenPage()
    begin

        DateRecCalc := CALCDATE('<-5D>', WORKDATE());
        Rec.SETFILTER("Expected Receipt Date", '>%1', DateRecCalc);

    end;

    var
        Listedesmotifs: Record "DEL Liste des motifs";
        Item: Record Item;
        PurchaseHeader_Rec: Record "Purchase Header";
        Vendor_Rec: Record Vendor;
        PurchCode: Code[20];
        DateRecCalc: Date;
        BuyfromVendorName: Text;
        motif: Text[100];
}

