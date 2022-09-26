page 50058 "Tracking non traité"
{
    Caption = 'Tracking recu par XML mais non traité dans Nav';
    Editable = false;
    PageType = List;
    SourceTable = Table50013;

    layout
    {
        area(content)
        {
            repeater()
            {
                field(Statut; Statut)
                {
                }
                field(Forwading_agent_no; Forwading_agent_no)
                {
                }
                field(Order_no; Order_no)
                {
                }
                field(Item_no; Item_no)
                {
                }
                field(Description; Description)
                {
                }
                field(Event_no; Event_no)
                {
                }
                field(Booking_no; Booking_no)
                {
                }
                field(Booking_date; Booking_date)
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
                field(Vendor_no; Vendor_no)
                {
                }
                field(Origine_port; Origine_port)
                {
                }
                field(Etd; Etd)
                {
                }
                field(Actual_Reception_date; Actual_Reception_date)
                {
                }
                field(Loading_date; Loading_date)
                {
                }
                field(Shipping_date; Shipping_date)
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
                field(Container_no; Container_no)
                {
                }
                field(Stuffing_no; Stuffing_no)
                {
                }
                field(Size; Size)
                {
                }
                field(Type; Type)
                {
                }
                field(EstimatedDischarge; EstimatedDischarge)
                {
                }
                field(Estimated_delivery_date; Estimated_delivery_date)
                {
                }
                field(ActualDischarge; ActualDischarge)
                {
                }
                field(ActualDeliveryDate; ActualDeliveryDate)
                {
                }
                field(Delivery_gate_out; Delivery_gate_out)
                {
                }
                field(Container_returned_date; Container_returned_date)
                {
                }
                field(Date_chargement_fichier; Date_chargement_fichier)
                {
                }
                field(Heure_chargement_fichier; Heure_chargement_fichier)
                {
                }
                field(Nom_Fichier; Nom_Fichier)
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

