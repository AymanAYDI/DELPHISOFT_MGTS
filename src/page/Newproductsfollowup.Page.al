page 50004 "DEL New products follow up"
{
    Caption = 'New products follow up';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    Permissions = TableData "Purch. Inv. Line" = rimd;
    SourceTable = "Purchase Line";
    //TODO SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
    //                   WHERE("First Purch. Order" = CONST(Yes),
    //                         Type = CONST(Item),
    //                         "Photo And DDoc" = CONST(No));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
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
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    Editable = false;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    Caption = 'PI delivery date';
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = false;
                }
                //TODO: à ajouter aprés les tableextensions
                // field("Sample Collected"; "Sample Collected")
                // {
                //     Caption = 'DDOCS provided';

                //     trigger OnValidate()
                //     begin
                //         IF "Photo Taked" = TRUE THEN BEGIN
                //             IF "Sample Collected" = TRUE THEN "Photo And DDoc" := TRUE;
                //             CurrPage.UPDATE;
                //         END;
                //     end;
                // }
                // field("Collected Date"; "Collected Date")
                // {
                //     Caption = 'DDOCS date';
                //     Editable = true;
                // }
                // field("Sample Collected by"; "Sample Collected by")
                // {
                //     Caption = 'DDOCS by';
                // }
                // field("Photo Taked"; "Photo Taked")
                // {

                //     trigger OnValidate()
                //     begin
                //         IF "Photo Taked" = TRUE THEN BEGIN
                //             IF "Sample Collected" = TRUE THEN "Photo And DDoc" := TRUE;
                //             CurrPage.UPDATE;
                //         END;
                //     end;
                // }
                // field("Photo Date"; "Photo Date")
                // {
                //     Caption = 'Picture Date';
                //     Editable = true;
                // }
                // field("Photo Taked By"; "Photo Taked By")
                // {
                //     Caption = 'Picture Taked By';
                // }
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
                    PurchHeader.GET("Document Type", Rec."Document No.");
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

    trigger OnInit()
    var
        ExitRepeat: Boolean;
    begin
        /*ExitRepeat:=FALSE;
        IF Item_Rec.FINDSET THEN BEGIN
        REPEAT
          IF ExistOldPurch(Item_Rec."No.") THEN BEGIN
          MESSAGE('item No %1',Item_Rec."No.");
          ExitRepeat:=TRUE;
          END;
          UNTIL (Item_Rec.NEXT =0) AND (ExitRepeat = FALSE);
        END;
        MESSAGE('End');*/
        //Purch. Inv. Line
        /*PurchInvLine.SETRANGE("No.",'10121');
        PurchInvLine.SETRANGE(Type,PurchInvLine.Type::Item);
        PurchInvLine.DELETEALL;*/

    end;

    trigger OnOpenPage()
    begin
        //Sample Collected
        //<Photo Taked
        //First Purch. Order=CONST(Yes),Type=CONST(Item)
    end;

    var
        Item_Rec: Record Item;
        PurchInvLine: Record "Purch. Inv. Line";
        BuyfromVendorName: Text;
        Vendor_Rec: Record Vendor;
        PurchaseHeader_Rec: Record "Purchase Header";
        PurchCode: Code[10];
        PurchaseLine: Record "Purchase Line";

    local procedure ExistOldPurch(ItemNo: Code[20]): Boolean
    var
        PurchaseLine: Record "Purchase Line";
        PurchInvLine: Record "Purch. Inv. Line";
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

