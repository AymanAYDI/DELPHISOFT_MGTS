page 50076 "DEL Comment Sheet Contrats"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00652      THM     24.03.14           Change SourceTableView

    AutoSplitKey = true;
    Caption = 'Comment Sheet';
    DataCaptionFields = "No.";
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = List;
    SourceTable = "Comment Line";
    SourceTableView = SORTING(Date)
                      ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Date"; Rec.Date)
                {
                }
                field(Comment; Rec.Comment)
                {
                }
                field("Code"; Rec.Code)
                {
                    Visible = false;
                }
                field("Type contrat"; "Type contrat")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetUpNewLine();
    end;
}


