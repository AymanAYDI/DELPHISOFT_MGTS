page 50101 "DEL Sourceurs"
{
    Caption = 'Sourceurs';
    PageType = List;
    SourceTable = "DEL Sourceur";
    UsageCategory = Administration;
    ApplicationArea = all;
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
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                }
            }
        }
    }

}

