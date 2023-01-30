page 50016 "DEL Reporting Dimension 1 Code"
{
    Caption = 'Reporting Dimension 1 Code';
    PageType = List;
    SourceTable = "DEL Reporting Dimension 1 Code";
    UsageCategory = None;

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

