page 50152 "Disputes Reasons"
{
    // MGTS10.043  | 24.01.2023 | Create new object : Dispute Reason

    Caption = 'Disputes Reasons';
    PageType = List;
    SourceTable = Table50088;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Code; Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a reason code to attach to the entry.';
                }
                field(Description; Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of what the code stands for.';
                }
            }
        }
        area(factboxes)
        {
            systempart(; Links)
            {
                Visible = false;
            }
            systempart(; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

