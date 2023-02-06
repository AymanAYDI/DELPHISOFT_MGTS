page 50152 "DEL Disputes Reasons"
{

    Caption = 'Disputes Reasons';
    PageType = List;
    SourceTable = "DEL Dispute Reason";

    layout
    {
        area(content)
        {
            repeater(SP)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a reason code to attach to the entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a description of what the code stands for.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

