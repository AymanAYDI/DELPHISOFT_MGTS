page 50027 "DEL Element Connection"
{
    PageType = List;
    SourceTable = "DEL Element Connection";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Deal_ID; Rec.Deal_ID)
                {
                }
                field(Element_ID; Rec.Element_ID)
                {
                }
                field("Apply To"; Rec."Apply To")
                {
                }
                field(Instance; Rec.Instance)
                {
                }
            }
        }
    }

}

