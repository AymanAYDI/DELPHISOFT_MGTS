page 50046 "DEL Quality forms"
{
    Caption = 'Quality forms';
    PageType = ListPart;
    SourceTable = "DEL Item Quality forms";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Type / Nature Enregistrement"; Rec."Type / Nature Enregistrement")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Description Supplementaire"; Rec."Description Supplementaire")
                {
                }
                field("Date of creation"; Rec."Date of creation")
                {
                }
            }
        }
    }

    actions
    {
    }
}

