page 50003 "DEL Error Import"
{
    PageType = ListPart;
    SourceTable = "DEL Error Import vente";
    UsageCategory = None;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Error"; Rec.Error)
                {
                    Caption = 'Error';
                }
            }
        }
    }


}

