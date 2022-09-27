page 50012 "DEL Tracked product follow up"
{
    Caption = 'Tracked product follow up';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Purchase Line";
    SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
                      WHERE("Risk Item" = CONST(true),
                            "Photo Risk Item Taked" = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; "Buy-from Vendor No.")
                {
                }
                field(BuyfromVendorName; BuyfromVendorName)
                {
                    Caption = 'Vendor name';
                    Editable = false;
                    ToolTip = 'Vendor name';
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                }
                field("No."; "No.")
                {
                    Editable = false;
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Order Date"; "Order Date")
                {
                    Editable = false;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    Caption = 'PI delivery date';
                }
                field(Quantity; Quantity)
                {
                    Editable = false;
                }
                field("Photo Risk Item Taked"; "Photo Risk Item Taked")
                {
                    Caption = 'Tracking Completed';
                }
                field("Photo Risk Item Date"; "Photo Risk Item Date")
                {
                    Caption = 'tracking completed on';
                    Editable = true;
                }
                field("Photo Risk Item Taked By"; "Photo Risk Item Taked By")
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
                    PageManagement: Codeunit 700;
                    PurchHeader: Record 38;
                begin
                    PurchHeader.GET("Document Type", "Document No.");
                    PageManagement.PageRun(PurchHeader);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BuyfromVendorName := '';
        IF Vendor_Rec.GET("Buy-from Vendor No.") THEN
            BuyfromVendorName := Vendor_Rec.Name;
        PurchaseHeader_Rec.SETRANGE("No.", "Document No.");
        IF PurchaseHeader_Rec.FINDFIRST THEN
            PurchCode := PurchaseHeader_Rec."Purchaser Code"
        ELSE
            PurchCode := '';
        //DEL.SAZ 17.09.2018
        motif := '';
        IF Item.GET("No.") THEN
            IF Listedesmotifs.GET(Item."Code motif de suivi") THEN
                motif := Listedesmotifs.Motif;
    end;

    trigger OnOpenPage()
    begin
        //DEL.SAZ 17.09.2018
        //afficher dans la liste toutes les commandes pour lesquelles la date de reception prevue + 5 jours < date système
        DateRecCalc := CALCDATE('<-5D>', WORKDATE);
        SETFILTER("Expected Receipt Date", '>%1', DateRecCalc);
        //END DEL.SAZ 17.09.2018
    end;

    var
        PurchHeader: Record 38;
        BuyfromVendorName: Text;
        Vendor_Rec: Record 23;
        PurchaseHeader_Rec: Record 38;
        PurchCode: Code[10];
        motif: Text[100];
        Listedesmotifs: Record 50064;
        Item: Record 27;
        DateRecCalc: Date;
}

