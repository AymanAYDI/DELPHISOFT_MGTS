page 50119 "Contract comment"
{
    PageType = List;
    SourceTable = Table50063;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                    Editable = false;
                }
                field(Comment; Comment)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ContratComment.SETRANGE("No.", "No.");
        IF ContratComment.FINDLAST THEN
            "Line No." := ContratComment."Line No." + 10000
        ELSE
            "Line No." := 10000;
    end;

    var
        ContratComment: Record "50063";
}

