page 50056 "DEL Détails booking"
{
    InsertAllowed = false;
    PageType = List;
    SourceTable = "DEL Tracking détail";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field(Statut; Rec.Statut)
                {
                    ApplicationArea = All;
                }
                field(Item_no; Rec.Item_no)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Event_no; Rec.Event_no)
                {
                    ApplicationArea = All;
                }
                field(Booking_no; Rec.Booking_no)
                {
                    ApplicationArea = All;
                }
                field(Etd; Rec.Etd)
                {
                    ApplicationArea = All;
                }
                field(Shipped_qty; Rec.Shipped_qty)
                {
                    ApplicationArea = All;
                }
                field(Received_qty; Rec.Received_qty)
                {
                    ApplicationArea = All;
                }
                field(Booked_qty; Rec.Booked_qty)
                {
                    ApplicationArea = All;
                }
                field(Ordered_qty; Rec.Ordered_qty)
                {
                    ApplicationArea = All;
                }
                field(Container_no; Rec.Container_no)
                {
                    ApplicationArea = All;
                }
                field(Stuffing_no; Rec.Stuffing_no)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Size; Rec.Size)
                {
                    ApplicationArea = All;
                }
                field(Shipping_date; Rec.Shipping_date)
                {
                    ApplicationArea = All;
                }
                field(Loading_date; Rec.Loading_date)
                {
                    ApplicationArea = All;
                }
                field(Booking_date; Rec.Booking_date)
                {
                    ApplicationArea = All;
                }
                field(Container_returned_date; Rec.Container_returned_date)
                {
                    ApplicationArea = All;
                }
                field(Delivery_gate_out; Rec.Delivery_gate_out)
                {
                    ApplicationArea = All;
                }
                field(ActualDeliveryDate; Rec.ActualDeliveryDate)
                {
                    ApplicationArea = All;
                }
                field(Estimated_delivery_date; Rec.Estimated_delivery_date)
                {
                    ApplicationArea = All;
                }
                field(ActualDischarge; Rec.ActualDischarge)
                {
                    ApplicationArea = All;
                }
                field(EstimatedDischarge; Rec.EstimatedDischarge)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
