page 50119 "DEL Contract comment"
{
    PageType = List;
    SourceTable = "DEL Contrat Comment";
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    Editable = false;
                }
                field(Comment; Rec.Comment)
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
        ContratComment.SETRANGE("No.", Rec."No.");
        IF ContratComment.FINDLAST() THEN
            Rec."Line No." := ContratComment."Line No." + 10000
        ELSE
            Rec."Line No." := 10000;
    end;

    var
        ContratComment: Record "DEL Contrat Comment";
}

