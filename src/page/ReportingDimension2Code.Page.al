page 50017 "Reporting Dimension 2 Code"
{
    Caption = 'Reporting Dimension 2 Code';
    PageType = List;
    SourceTable = Table50016;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

