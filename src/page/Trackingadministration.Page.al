page 50054 "Tracking administration"
{
    // 
    // ------------------------------------------------------------------------------------------
    // Sign    : Maria Hr. Hristova = mhh
    // Version : MGTS10.016
    // 
    // ------------------------------------------------------------------------------------------
    // No.    Version          Date        Sign    Description
    // ------------------------------------------------------------------------------------------
    // 001     MGTS10.016       23.11.20    mhh     List of changes:
    //                                              Added new action: 1000000002 "File recovery/NAV update"
    // ------------------------------------------------------------------------------------------

    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Table50012;

    layout
    {
        area(content)
        {
            repeater()
            {
                Editable = false;
                field(key;key)
                {
                }
                field(Forwading_agent_no;Forwading_agent_no)
                {
                }
                field(Order_no;Order_no)
                {
                }
                field(Item_no;Item_no)
                {
                }
                field(Description;Description)
                {
                }
                field(Event_no;Event_no)
                {
                }
                field(Booking_no;Booking_no)
                {
                }
                field(Booking_date;Booking_date)
                {
                }
                field(Ordered_qty;Ordered_qty)
                {
                }
                field(Booked_qty;Booked_qty)
                {
                }
                field(Received_qty;Received_qty)
                {
                }
                field(Shipped_qty;Shipped_qty)
                {
                }
                field(Vendor_no;Vendor_no)
                {
                }
                field(Origine_port;Origine_port)
                {
                }
                field(Etd;Etd)
                {
                }
                field(Actual_Reception_date;Actual_Reception_date)
                {
                }
                field(Loading_date;Loading_date)
                {
                }
                field(Shipping_date;Shipping_date)
                {
                }
                field(Unloading_port;Unloading_port)
                {
                }
                field(Carrier;Carrier)
                {
                }
                field(Vessel;Vessel)
                {
                }
                field(Container_no;Container_no)
                {
                }
                field(Stuffing_no;Stuffing_no)
                {
                }
                field(Size;Size)
                {
                }
                field(Type;Type)
                {
                }
                field(EstimatedDischarge;EstimatedDischarge)
                {
                }
                field(Estimated_delivery_date;Estimated_delivery_date)
                {
                }
                field(ActualDischarge;ActualDischarge)
                {
                }
                field(ActualDeliveryDate;ActualDeliveryDate)
                {
                }
                field(Delivery_gate_out;Delivery_gate_out)
                {
                }
                field(Container_returned_date;Container_returned_date)
                {
                }
                field(Date_chargement_fichier;Date_chargement_fichier)
                {
                }
                field(Heure_chargement_fichier;Heure_chargement_fichier)
                {
                }
                field(Nom_Fichier;Nom_Fichier)
                {
                }
                field(Statut;Statut)
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
        CuTracking: Codeunit "50006";

    local procedure Control1000000071OnDeactivate()
    begin

        CuTracking.RUN();
    end;
}

