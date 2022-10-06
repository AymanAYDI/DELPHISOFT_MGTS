page 50089 "DEL Usage"
{


    Caption = 'Usage';
    PageType = List;
    SourceTable = "DEL Desc Plan of control";

    layout
    {
        area(content)
        {
            repeater(Group)
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


