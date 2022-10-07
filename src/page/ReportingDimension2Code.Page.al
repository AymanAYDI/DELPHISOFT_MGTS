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
                    Caption = 'Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
            }
        }
    }

    actions
    {
    }
}

