page 50076 "DEL Comment Sheet Contrats"
{


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
            repeater(Control1)
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
                field("Type contrat"; Rec."DEL Type contrat")
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


