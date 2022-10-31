page 50026 "DEL ACO Connection"
{
    PageType = List;
    SourceTable = "DEL ACO Connection";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal_ID';
                }
                field("ACO No."; Rec."ACO No.")
                {
                    Caption = 'ACO No.';
                }
            }
        }
    }


}

