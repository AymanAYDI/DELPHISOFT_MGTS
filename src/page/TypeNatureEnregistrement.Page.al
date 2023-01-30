page 50079 "Type / Nature Enregistrement"
{
    Caption = 'Type of forms';
    PageType = List;
    SourceTable = "DEL Type/Nature Enregistrement";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
