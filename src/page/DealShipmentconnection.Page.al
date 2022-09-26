page 50042 "Deal Shipment connection"
{
    PageType = List;
    SourceTable = Table50032;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Deal_ID; Deal_ID)
                {
                }
                field(Shipment_ID; Shipment_ID)
                {
                }
                field(Element_ID; Element_ID)
                {
                }
            }
        }
    }

    actions
    {
    }
}

