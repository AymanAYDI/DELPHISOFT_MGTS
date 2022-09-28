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
                    Caption = 'Statut';
                }
                field(Item_no; Rec.Item_no)
                {
                    Caption = 'Article n.';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(Event_no; Rec.Event_no)
                {
                    Caption = 'Code de l''évenement';
                }
                field(Booking_no; Rec.Booking_no)
                {
                    Caption = 'Numéro de booking';
                }
                field(Etd; Rec.Etd)
                {
                    Caption = 'ETD';
                }
                field(Shipped_qty; Rec.Shipped_qty)
                {
                    Caption = 'Qauantité shippee';
                }
                field(Received_qty; Rec.Received_qty)
                {
                    Caption = 'Quantité recue';
                }
                field(Booked_qty; Rec.Booked_qty)
                {
                    Caption = 'Quantité bookée';
                }
                field(Ordered_qty; Rec.Ordered_qty)
                {
                    Caption = 'Quantité commandée';
                }
                field(Container_no; Rec.Container_no)
                {
                    Caption = 'N. Conteneur';
                }
                field(Stuffing_no; Rec.Stuffing_no)
                {
                    Caption = 'CS n.(n. stuffing)';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(Size; Rec.Size)
                {
                    Caption = 'Size';
                }
                field(Shipping_date; Rec.Shipping_date)
                {
                    Caption = 'Date de livraison confirmé(Shipping date)';
                }
                field(Loading_date; Rec.Loading_date)
                {
                    Caption = 'Date embarquement(loading date)';
                }
                field(Booking_date; Rec.Booking_date)
                {
                    Caption = 'Booking date';
                }
                field(Container_returned_date; Rec.Container_returned_date)
                {
                    Caption = 'Conteneur return to carrier';
                }
                field(Delivery_gate_out; Rec.Delivery_gate_out)
                {
                    Caption = 'Gate out delivery';
                }
                field(ActualDeliveryDate; Rec.ActualDeliveryDate)
                {
                    Caption = 'delivery date actual ( at the warehouse)';
                }
                field(Estimated_delivery_date; Rec.Estimated_delivery_date)
                {
                    Caption = 'Livraison estimé';
                }
                field(ActualDischarge; Rec.ActualDischarge)
                {
                    Caption = 'discharge date actual';
                }
                field(EstimatedDischarge; Rec.EstimatedDischarge)
                {
                    Caption = 'discharge date planned';
                }
            }
        }
    }

    actions
    {
    }
}

