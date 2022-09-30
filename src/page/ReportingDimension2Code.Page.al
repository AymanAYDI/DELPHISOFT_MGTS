page 50017 "DEL Reporting Dimension 2 Code"
{
    Caption = 'Reporting Dimension 2 Code';
    PageType = List;
    SourceTable = "DEL Reporting Dimension 2 Code";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

