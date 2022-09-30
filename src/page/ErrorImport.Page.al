page 50003 "DEL Error Import"
{
    PageType = List;
    SourceTable = "DEL Error Import vente";

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

