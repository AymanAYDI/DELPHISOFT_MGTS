page 50056 "DEL Détails booking"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "DEL Tracking détail";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field(Statut; Rec.Statut)
                {
                }
                field(Item_no; Rec.Item_no)
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Event_no; Rec.Event_no)
                {
                }
                field(Booking_no; Rec.Booking_no)
                {
                }
                field(Etd; Rec.Etd)
                {
                }
                field(Shipped_qty; Rec.Shipped_qty)
                {
                }
                field(Received_qty; Rec.Received_qty)
                {
                }
                field(Booked_qty; Rec.Booked_qty)
                {
                }
                field(Ordered_qty; Rec.Ordered_qty)
                {
                }
                field(Container_no; Rec.Container_no)
                {
                }
                field(Stuffing_no; Rec.Stuffing_no)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(Size; Rec.Size)
                {
                }
                field(Shipping_date; Rec.Shipping_date)
                {
                }
                field(Loading_date; Rec.Loading_date)
                {
                }
                field(Booking_date; Rec.Booking_date)
                {
                }
                field(Container_returned_date; Rec.Container_returned_date)
                {
                }
                field(Delivery_gate_out; Rec.Delivery_gate_out)
                {
                }
                field(ActualDeliveryDate; Rec.ActualDeliveryDate)
                {
                }
                field(Estimated_delivery_date; Rec.Estimated_delivery_date)
                {
                }
                field(ActualDischarge; Rec.ActualDischarge)
                {
                }
                field(EstimatedDischarge; Rec.EstimatedDischarge)
                {
                }
            }
        }
    }

    actions
    {
    }
}

