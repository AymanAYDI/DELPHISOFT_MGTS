page 50153 "Posted Sales Cr. Memo-Upd"
{
    // MGTS10.043  | 24.01.2023 | Create new object : Dispute Reason

    Caption = 'Posted Sales Credit Memo - Update';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    Permissions = TableData 114 = rm;
    ShowFilter = false;
    SourceTable = Table114;
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
        xSalesCrMemoHeader := Rec;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::LookupOK THEN
            IF RecordChanged THEN
                SalesCrMemoUpdate;
    end;

    var
        xSalesCrMemoHeader: Record "114";

    local procedure RecordChanged(): Boolean
    begin
        EXIT(
          ("Dispute Reason" <> xSalesCrMemoHeader."Dispute Reason") OR
          ("Dispute Date" <> xSalesCrMemoHeader."Dispute Date"))
    end;

    [Scope('Internal')]
    procedure SetRec(SalesCrMemoHeader: Record "114")
    begin
        Rec := SalesCrMemoHeader;
        INSERT;
    end;

    local procedure SalesCrMemoUpdate()
    var
        SalesCrMemoHeader: Record "114";
    begin
        SalesCrMemoHeader := Rec;
        SalesCrMemoHeader.LOCKTABLE;
        SalesCrMemoHeader.FIND;
        SalesCrMemoHeader."Dispute Reason" := "Dispute Reason";
        SalesCrMemoHeader."Dispute Date" := "Dispute Date";
        SalesCrMemoHeader.TESTFIELD("No.", "No.");
        SalesCrMemoHeader.MODIFY;
        Rec := SalesCrMemoHeader;
    end;
}

