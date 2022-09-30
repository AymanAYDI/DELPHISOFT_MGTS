page 50088 "DEL Pays"
{


    Caption = 'Country';
    PageType = List;
    SourceTable = "DEL Pays";

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


}

