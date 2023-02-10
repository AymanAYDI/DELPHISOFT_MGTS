page 50101 "DEL Sourceurs"
{
    ApplicationArea = all;
    Caption = 'Sourceurs';
    PageType = List;
    SourceTable = "DEL Sourceur";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Name';
                }
            }
        }
    }

}

