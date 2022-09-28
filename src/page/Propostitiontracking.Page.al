page 50055 "DEL Propostition tracking"
{
    PageType = List;
    SourceTable = "DEL Tracking général";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field(Order_no; Rec.Order_no)
                {
                }
                field(Booking_no; Rec.Booking_no)
                {
                }
                field(Item_no; Rec.Item_no)
                {
                }
                field(Container_no; Rec.Container_no)
                {
                }
                field(Vendor_no; Rec.Vendor_no)
                {
                }
                field(Booking_date; Rec.Booking_date)
                {
                }
                field(Origine_port; Rec.Origine_port)
                {
                }
                field(Unloading_port; Rec.Unloading_port)
                {
                }
                field(Carrier; Rec.Carrier)
                {
                }
                field(Vessel; Rec.Vessel)
                {
                }
                field(Ordered_qty; Rec.Ordered_qty)
                {
                }
                field(Booked_qty; Rec.Booked_qty)
                {
                }
                field(Received_qty; Rec.Received_qty)
                {
                }
                field(Shipped_qty; Rec.Shipped_qty)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        Rec.SETRANGE(Statut, '');
    end;
}

