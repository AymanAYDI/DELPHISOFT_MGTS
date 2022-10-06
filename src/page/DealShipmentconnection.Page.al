page 50042 "DEL Deal Shipment connection"
{
    PageType = List;
    SourceTable = "DEL Deal Shipment Connection";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal_ID';
                }
                field(Shipment_ID; Rec.Shipment_ID)
                {
                    Caption = 'Shipment_ID';
                }
                field(Element_ID; Rec.Element_ID)
                {
                    Caption = 'Element_ID';
                }
            }
        }
    }

    actions
    {
    }
}

