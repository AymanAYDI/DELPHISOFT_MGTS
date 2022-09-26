page 50016 "Reporting Dimension 1 Code"
{
    Caption = 'Reporting Dimension 1 Code';
    PageType = List;
    SourceTable = Table50015;

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

