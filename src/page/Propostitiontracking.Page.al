page 50055 "Propostition tracking"
{
    PageType = List;
    SourceTable = Table50013;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Order_no; Order_no)
                {
                }
                field(Booking_no; Booking_no)
                {
                }
                field(Item_no; Item_no)
                {
                }
                field(Container_no; Container_no)
                {
                }
                field(Vendor_no; Vendor_no)
                {
                }
                field(Booking_date; Booking_date)
                {
                }
                field(Origine_port; Origine_port)
                {
                }
                field(Unloading_port; Unloading_port)
                {
                }
                field(Carrier; Carrier)
                {
                }
                field(Vessel; Vessel)
                {
                }
                field(Ordered_qty; Ordered_qty)
                {
                }
                field(Booked_qty; Booked_qty)
                {
                }
                field(Received_qty; Received_qty)
                {
                }
                field(Shipped_qty; Shipped_qty)
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

