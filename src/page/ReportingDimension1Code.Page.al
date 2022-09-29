page 50016 "DEL Reporting Dimension 1 Code"
{
    Caption = 'Reporting Dimension 1 Code';
    PageType = List;
    SourceTable = "DEL Reporting Dimension 1 Code";

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

