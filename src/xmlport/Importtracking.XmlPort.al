xmlport 50001 "DEL Import tracking"
{

    Direction = Both;
    Encoding = UTF8;

    schema
    {
        textelement(transitaire)
        {
            tableelement("trackingnontraité"; "DEL Tracking non traité")
            {
                LinkTableForceInsert = true;
                MinOccurs = Zero;
                XmlName = 'root';
                fieldelement(ForwardingAgentNo; "TrackingNonTraité".Forwading_agent_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(OrderNo; "TrackingNonTraité".Order_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ItemNo; "TrackingNonTraité".Item_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Description; "TrackingNonTraité".Description)
                {
                    MinOccurs = Zero;
                }
                fieldelement(EventNo; "TrackingNonTraité".Event_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(BookingNo; "TrackingNonTraité".Booking_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(BookingDate; "TrackingNonTraité".Booking_date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(OrderedQty; "TrackingNonTraité".Ordered_qty)
                {
                    MinOccurs = Zero;
                }
                fieldelement(BookedQty; "TrackingNonTraité".Booked_qty)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ReceivedQty; "TrackingNonTraité".Received_qty)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShippedQty; "TrackingNonTraité".Shipped_qty)
                {
                    MinOccurs = Zero;
                }
                fieldelement(VendorNo; "TrackingNonTraité".Vendor_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(OriginePort; "TrackingNonTraité".Origine_port)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ETD; "TrackingNonTraité".Etd)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ActualReceptionDate; "TrackingNonTraité".Actual_Reception_date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(LoadingDate; "TrackingNonTraité".Loading_date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ShippingDate; "TrackingNonTraité".Shipping_date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(UnloadingPort; "TrackingNonTraité".Unloading_port)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Carrier; "TrackingNonTraité".Carrier)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Vessel; "TrackingNonTraité".Vessel)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ContainerNo; "TrackingNonTraité".Container_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(StuffingNo; "TrackingNonTraité".Stuffing_no)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Size; "TrackingNonTraité".Size)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Type; "TrackingNonTraité".Type)
                {
                    MinOccurs = Zero;
                }
                fieldelement(EstimatedDischarge; "TrackingNonTraité".EstimatedDischarge)
                {
                    MinOccurs = Zero;
                }
                fieldelement(EstimatedDeliveryDate; "TrackingNonTraité".Estimated_delivery_date)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ActualDischarge; "TrackingNonTraité".ActualDischarge)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ActualDeliveryDate; "TrackingNonTraité".ActualDeliveryDate)
                {
                    MinOccurs = Zero;
                }
                fieldelement(DeliveryGateOut; "TrackingNonTraité".Delivery_gate_out)
                {
                    MinOccurs = Zero;
                }
                fieldelement(ContainerReturnedDate; "TrackingNonTraité".Container_returned_date)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin
                    DernierNum := DernierNum + 1;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    TrackingNonTraité.key := DernierNum;
                    TrackingNonTraité.Date_chargement_fichier := TODAY;
                    TrackingNonTraité.Heure_chargement_fichier := TIME;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        IF TrackingNonTraitéRec.FIND('+') THEN
            DernierNum1 := TrackingNonTraitéRec.key + 1
        ELSE
            DernierNum1 := 1;


        IF TrackinggénéraRec.FIND('+') THEN
            DernierNum2 := TrackinggénéraRec.key + 1
        ELSE
            DernierNum2 := 1;

        IF DernierNum1 >= DernierNum2 THEN
            DernierNum := DernierNum1
        ELSE
            DernierNum := DernierNum2;
    end;

    var
        "TrackingNonTraitéRec": Record "DEL Tracking non traité";
        "TrackinggénéraRec": Record "DEL Tracking général";

        DernierNum: Integer;
        DernierNum1: Integer;
        DernierNum2: Integer;
}

