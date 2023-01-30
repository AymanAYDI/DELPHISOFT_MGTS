page 50026 "DEL ACO Connection"
{
    PageType = List;
    SourceTable = "DEL ACO Connection";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Deal_ID; Rec.Deal_ID)
                {
                }
                field("ACO No."; Rec."ACO No.")
                {
                }
            }
        }
    }


}

