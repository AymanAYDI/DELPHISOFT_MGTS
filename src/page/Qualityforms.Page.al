page 50046 "DEL Quality forms"
{
    Caption = 'Quality forms';
    PageType = ListPart;
    SourceTable = "DEL Item Quality forms";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                    Editable = false;
                    Visible = false;
                }
                field("Type / Nature Enregistrement"; Rec."Type / Nature Enregistrement")
                {
                    Caption = 'Type of forms';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Description Supplementaire"; Rec."Description Supplementaire")
                {
                    Caption = 'Additionnal description';
                }
                field("Date of creation"; Rec."Date of creation")
                {
                    Caption = 'Date of creation';
                }
            }
        }
    }

    actions
    {
    }
}

