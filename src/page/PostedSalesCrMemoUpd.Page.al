page 50153 "DEL Posted Sales Cr. Memo-Upd"
{

    Caption = 'Posted Sales Credit Memo - Update';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = Card;
    Permissions = TableData "Sales Cr.Memo Header" = rm;
    ShowFilter = false;
    SourceTable = "Sales Cr.Memo Header";
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
                field("Dispute Reason"; "DEL Dispute Reason")
                {
                }
                field("Dispute Date"; "DEL Dispute Date")
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
            IF RecordChanged() THEN
                SalesCrMemoUpdate();
    end;

    var
        xSalesCrMemoHeader: Record "Sales Cr.Memo Header";

    local procedure RecordChanged(): Boolean
    begin
        EXIT(
          ("DEL Dispute Reason" <> xSalesCrMemoHeader."DEL Dispute Reason") OR
          ("DEL Dispute Date" <> xSalesCrMemoHeader."DEL Dispute Date"))
    end;

    procedure SetRec(SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        Rec := SalesCrMemoHeader;
        INSERT();
    end;

    local procedure SalesCrMemoUpdate()
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        SalesCrMemoHeader := Rec;
        SalesCrMemoHeader.LOCKTABLE();
        SalesCrMemoHeader.FIND();
        SalesCrMemoHeader."DEL Dispute Reason" := "DEL Dispute Reason";
        SalesCrMemoHeader."DEL Dispute Date" := "DEL Dispute Date";
        SalesCrMemoHeader.TESTFIELD("No.", Rec."No.");
        SalesCrMemoHeader.MODIFY();
        Rec := SalesCrMemoHeader;
    end;
}

