page 50089 "DEL Usage"
{
    Caption = 'Usage';
    PageType = List;
    SourceTable = "DEL Desc Plan of control";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    Caption = 'Code';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
            }
        }
    }
}
