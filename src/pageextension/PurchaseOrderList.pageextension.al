pageextension 50065 "DEL PurchaseOrderList" extends "Purchase Order List" //9307
{

    layout
    {
        modify("Requested Receipt Date")
        {
            Caption = 'PO delivery date';
        }
        addafter("Requested Receipt Date")
        {
            field("DEL Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                Caption = 'Real delivery date';
            }
        }
        addafter("Amount Including VAT")
        {
            field("DEL FirstPurchItem"; FirstPurchItem)
            {
                Caption = 'New Product';
                Editable = false;
                Enabled = False;
                ShowCaption = true;
                Style = Standard;
                StyleExpr = FirstPurchStyle;
            }
            field("DEL Expected Receipt Date"; Rec."Expected Receipt Date")
            {
                Caption = 'PI delivery date';
            }
            field("Port de départ"; Rec."DEL Port de départ")
            {
                Caption = 'Real delivery date';
            }

        }
    }
    actions
    {
        addafter(RemoveFromJobQueue)
        {
            action("DEL Print MGTS")
            {
                ApplicationArea = Suite;
                Caption = '&Print MGTS';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    PurchaseHeader: Record 38;
                    CduLMinimizingClicksNGTS: Codeunit 50012;
                begin
                    PurchaseHeader := Rec;
                    CurrPage.SETSELECTIONFILTER(PurchaseHeader);
                    PurchaseHeader.PrintRecords(TRUE);
                    CduLMinimizingClicksNGTS.FctSendMailPurchOrder(Rec);
                end;
            }

            action("DEL ActionName")
            {
                ApplicationArea = Suite;
                Caption = '&Print Dossier';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                RunPageOnRec = false;
                trigger OnAction()
                var
                    PurchaseHeader: Record 38;
                    ReportSelection: Record 77;
                    StandardPurchaseOrder: Report 1322;
                    CduLMinimizingClicksNGTS: Codeunit 50012;
                begin
                    PurchaseHeader := Rec;
                    PurchaseHeader.SETRECFILTER();
                    StandardPurchaseOrder.SETTABLEVIEW(PurchaseHeader);
                    StandardPurchaseOrder.RUNMODAL();
                end;
            }
        }
    }
    VAR
        FirstPurchItem: Boolean;
        RiskItem: Boolean;
        FirstPurchStyle: Text;
        RiskStyle: Text;

    LOCAL PROCEDURE FirstAndRiskItem();
    VAR
        PurchaseLine_Rec: Record 39;
    BEGIN
        FirstPurchItem := FALSE;
        RiskItem := FALSE;
        FirstPurchStyle := '';
        RiskStyle := '';
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document Type", PurchaseLine_Rec."Document Type"::Order);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document No.", Rec."No.");
        IF PurchaseLine_Rec.FINDSET() THEN
            REPEAT
                IF PurchaseLine_Rec."DEL First Purch. Order" = TRUE THEN BEGIN
                    FirstPurchItem := TRUE;
                    //Unfavorable
                    FirstPurchStyle := 'Favorable';
                END;
                IF PurchaseLine_Rec."DEL Risk Item" = TRUE THEN BEGIN
                    RiskItem := TRUE;
                    RiskStyle := 'Favorable';
                    //Favorable
                END;
            UNTIL PurchaseLine_Rec.NEXT() = 0;
        PurchaseLine_Rec.RESET();
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document Type", PurchaseLine_Rec."Document Type"::Order);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document No.", Rec."No.");
        PurchaseLine_Rec.SETRANGE("DEL First Purch. Order", TRUE);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."DEL Sample Collected", TRUE);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."DEL Photo Taked", FALSE);
        IF PurchaseLine_Rec.FINDFIRST() THEN
            FirstPurchStyle := 'Unfavorable';
        PurchaseLine_Rec.RESET();
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document Type", PurchaseLine_Rec."Document Type"::Order);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document No.", Rec."No.");
        PurchaseLine_Rec.SETRANGE("DEL First Purch. Order", TRUE);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."DEL Sample Collected", FALSE);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."DEL Photo Taked", TRUE);
        IF PurchaseLine_Rec.FINDFIRST() THEN
            FirstPurchStyle := 'Unfavorable';

        PurchaseLine_Rec.RESET();
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document Type", PurchaseLine_Rec."Document Type"::Order);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."Document No.", Rec."No.");
        PurchaseLine_Rec.SETRANGE("DEL First Purch. Order", TRUE);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."DEL Sample Collected", FALSE);
        PurchaseLine_Rec.SETRANGE(PurchaseLine_Rec."DEL Photo Taked", FALSE);
        IF PurchaseLine_Rec.FINDFIRST() THEN
            FirstPurchStyle := 'Unfavorable';
    END;

}




















