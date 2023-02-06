page 50154 "Posted Purch. Cr. Memo-Upd"
{
    // MGTS10.043  | 24.01.2023 | Create new object : Dispute Reason

    Caption = 'Posted Purchase Credit Memo - Update';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    Permissions = TableData 124 = rm;
    ShowFilter = false;
    SourceTable = Table124;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group("Général")
            {
                Editable = false;
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Sell-to Customer No."; "Sell-to Customer No.")
                {
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                }
            }
            group(Dispute)
            {
                Caption = 'Dispute';
                field("Dispute Reason"; "Dispute Reason")
                {
                }
                field("Dispute Date"; "Dispute Date")
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
            IF RecordChanged THEN
                PurchaseCrMemoUpdate;
    end;

    var
        xPurchCrMemoHdr: Record "124";

    local procedure RecordChanged(): Boolean
    begin
        EXIT(
          ("Dispute Reason" <> xPurchCrMemoHdr."Dispute Reason") OR
          ("Dispute Date" <> xPurchCrMemoHdr."Dispute Date"))
    end;

    [Scope('Internal')]
    procedure SetRec(PurchCrMemoHdr: Record "124")
    begin
        Rec := PurchCrMemoHdr;
        INSERT;
    end;

    local procedure PurchaseCrMemoUpdate()
    var
        PurchCrMemoHdr: Record "124";
    begin
        PurchCrMemoHdr := Rec;
        PurchCrMemoHdr.LOCKTABLE;
        PurchCrMemoHdr.FIND;
        PurchCrMemoHdr."Dispute Reason" := "Dispute Reason";
        PurchCrMemoHdr."Dispute Date" := "Dispute Date";
        PurchCrMemoHdr.TESTFIELD("No.", "No.");
        PurchCrMemoHdr.MODIFY;
        Rec := PurchCrMemoHdr;
    end;
}

