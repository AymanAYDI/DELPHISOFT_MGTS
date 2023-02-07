page 50154 "DEL Posted Purch. Cr. Memo-Upd"
{

    Caption = 'Posted Purchase Credit Memo - Update';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    Permissions = TableData "Purch. Cr. Memo Hdr." = rm;
    ShowFilter = false;
    SourceTable = "Purch. Cr. Memo Hdr.";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Editable = false;
                }
            }
            group(Dispute)
            {
                Caption = 'Dispute';
                field("Dispute Reason"; Rec."DEL Dispute Reason")
                {
                }
                field("Dispute Date"; Rec."DEL Dispute Date")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        xPurchCrMemoHdr := Rec;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            IF RecordChanged() THEN
                PurchaseCrMemoUpdate();
    end;

    var
        xPurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";

    local procedure RecordChanged(): Boolean
    begin
        EXIT(
          (Rec."DEL Dispute Reason" <> xPurchCrMemoHdr."DEL Dispute Reason") OR
          (Rec."DEL Dispute Date" <> xPurchCrMemoHdr."DEL Dispute Date"))
    end;

    procedure SetRec(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        Rec := PurchCrMemoHdr;
        Rec.INSERT();
    end;

    local procedure PurchaseCrMemoUpdate()
    var
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    begin
        PurchCrMemoHdr := Rec;
        PurchCrMemoHdr.LOCKTABLE();
        PurchCrMemoHdr.FIND();
        PurchCrMemoHdr."DEL Dispute Reason" := Rec."DEL Dispute Reason";
        PurchCrMemoHdr."DEL Dispute Date" := Rec."DEL Dispute Date";
        PurchCrMemoHdr.TESTFIELD("No.", Rec."No.");
        PurchCrMemoHdr.MODIFY();
        Rec := PurchCrMemoHdr;
    end;
}

