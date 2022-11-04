page 50028 "DEL Audit Social"
{
    PageType = ListPlus;
    SourceTable = "DEL Audit social";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field(Axe; Rec.Axe)
                {
                }
            }
        }
    }

}

