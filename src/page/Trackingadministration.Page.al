#pragma implicitwith disable
page 50054 "DEL Tracking administration"
{
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "DEL Tracking non traité";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("key"; Rec."key")
                {
                }
                field(Forwading_agent_no; Rec.Forwading_agent_no)
                {
                }
                field(Order_no; Rec.Order_no)
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
                field(Booking_date; Rec.Booking_date)
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
                field(Vendor_no; Rec.Vendor_no)
                {
                }
                field(Origine_port; Rec.Origine_port)
                {
                }
                field(Etd; Rec.Etd)
                {
                }
                field(Actual_Reception_date; Rec.Actual_Reception_date)
                {
                }
                field(Loading_date; Rec.Loading_date)
                {
                }
                field(Shipping_date; Rec.Shipping_date)
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
                field(Container_no; Rec.Container_no)
                {
                }
                field(Stuffing_no; Rec.Stuffing_no)
                {
                }
                field(Size; Rec.Size)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field(EstimatedDischarge; Rec.EstimatedDischarge)
                {
                }
                field(Estimated_delivery_date; Rec.Estimated_delivery_date)
                {
                }
                field(ActualDischarge; Rec.ActualDischarge)
                {
                }
                field(ActualDeliveryDate; Rec.ActualDeliveryDate)
                {
                }
                field(Delivery_gate_out; Rec.Delivery_gate_out)
                {
                }
                field(Container_returned_date; Rec.Container_returned_date)
                {
                }
                field(Date_chargement_fichier; Rec.Date_chargement_fichier)
                {
                }
                field(Heure_chargement_fichier; Rec.Heure_chargement_fichier)
                {
                }
                field(Nom_Fichier; Rec.Nom_Fichier)
                {
                }
                field(Statut; Rec.Statut)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Fonctions)
            {
                Caption = 'Fonctions';
                action("Récupération fichier")
                {
                    Caption = 'Récupération fichier';

                    trigger OnAction()
                    begin
                        CODEUNIT.RUN(50003);
                    end;
                }
                action("Maj NAV")
                {
                    Caption = 'Maj NAV';

                    trigger OnAction()
                    begin


                        CODEUNIT.RUN(50006)
                    end;
                }
                action("File recovery/NAV update")
                {
                    Caption = 'File recovery/NAV update';
                    Image = Reuse;

                    trigger OnAction()
                    begin

                        //MGTS10.016; 001; mhh; entire trigger
                        CODEUNIT.RUN(50003);
                        CODEUNIT.RUN(50006);
                    end;
                }
            }
        }
    }

    var
    //TODO  // CuTracking: Codeunit "50006";

    // local procedure Control1000000071OnDeactivate()
    // begin

    //     CuTracking.RUN();
    // end;
}

#pragma implicitwith restore

