page 50101 "DEL Sourceurs"
{
    Caption = 'Sourceurs';
    PageType = List;
    SourceTable = "DEL Sourceur";

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
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
            }
        }
    }

}

