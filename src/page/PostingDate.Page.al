page 50129 "DEL Posting Date"
{

    Caption = 'Enter Posting Date';
    InsertAllowed = false;
    PageType = StandardDialog;
    SourceTable = Integer;
    SourceTableView = WHERE(Number = CONST(1));

    layout
    {
        area(content)
        {
            group("Général")
            {
                Caption = 'Général';
                field(PostingDate; PostingDate)
                {
                    Caption = 'Posting Date';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::Cancel THEN
            CurrPage.CLOSE;
    end;

    var
        PostingDate: Date;
        GenJnlCheckLine: Codeunit "Gen. Jnl.-Check Line";
        Text001: Label 'The entered date is not within your range of allowed posting dates';

    procedure GetPostingDate(): Date
    begin
        IF NOT GenJnlCheckLine.DateNotAllowed(PostingDate) THEN
            EXIT(PostingDate)
        ELSE
            EXIT(0D);
    end;
}

