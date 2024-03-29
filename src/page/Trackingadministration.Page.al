page 50054 "DEL Tracking administration"
{
    ApplicationArea = all;
    Editable = true;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "DEL Tracking non traité";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                Editable = false;
                field("key"; Rec."key")
                {
                    Caption = 'key';
                }
                field(Forwading_agent_no; Rec.Forwading_agent_no)
                {
                    Caption = 'Code du transitaire';
                }
                field(Order_no; Rec.Order_no)
                {
                    Caption = 'Commande n.';
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
                field(Booking_date; Rec.Booking_date)
                {
                    Caption = 'Booking date';
                }
                field(Ordered_qty; Rec.Ordered_qty)
                {
                    Caption = 'Quantité commandée';
                }
                field(Booked_qty; Rec.Booked_qty)
                {
                    Caption = 'Quantité bookée';
                }
                field(Received_qty; Rec.Received_qty)
                {
                    Caption = 'Quantité recue';
                }
                field(Shipped_qty; Rec.Shipped_qty)
                {
                    Caption = 'Qauantité shippee';
                }
                field(Vendor_no; Rec.Vendor_no)
                {
                    Caption = 'Vendor';
                }
                field(Origine_port; Rec.Origine_port)
                {
                    Caption = 'Port origine';
                }
                field(Etd; Rec.Etd)
                {
                    Caption = 'ETD';
                }
                field(Actual_Reception_date; Rec.Actual_Reception_date)
                {
                    Caption = 'Date réception marchandise origine';
                }
                field(Loading_date; Rec.Loading_date)
                {
                    Caption = 'Date embarquement(loading date)';
                }
                field(Shipping_date; Rec.Shipping_date)
                {
                    Caption = 'Date de livraison confirmé(Shipping date)';
                }
                field(Unloading_port; Rec.Unloading_port)
                {
                    Caption = 'Port de déchargement';
                }
                field(Carrier; Rec.Carrier)
                {
                    Caption = 'Carrier';
                }
                field(Vessel; Rec.Vessel)
                {
                    Caption = 'Bateau';
                }
                field(Container_no; Rec.Container_no)
                {
                    Caption = 'N. Conteneur';
                }
                field(Stuffing_no; Rec.Stuffing_no)
                {
                    Caption = 'CS n.(n. stuffing)';
                }
                field(Size; Rec.Size)
                {
                    Caption = 'Size';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field(EstimatedDischarge; Rec.EstimatedDischarge)
                {
                    Caption = 'discharge date planned';
                }
                field(Estimated_delivery_date; Rec.Estimated_delivery_date)
                {
                    Caption = 'Livraison estimé';
                }
                field(ActualDischarge; Rec.ActualDischarge)
                {
                    Caption = 'discharge date actual';
                }
                field(ActualDeliveryDate; Rec.ActualDeliveryDate)
                {
                    Caption = 'delivery date actual ( at the warehouse)';
                }
                field(Delivery_gate_out; Rec.Delivery_gate_out)
                {
                    Caption = 'Gate out delivery';
                }
                field(Container_returned_date; Rec.Container_returned_date)
                {
                    Caption = 'Conteneur return to carrier';
                }
                field(Date_chargement_fichier; Rec.Date_chargement_fichier)
                {
                    Caption = 'Date_chargement_fichier';
                }
                field(Heure_chargement_fichier; Rec.Heure_chargement_fichier)
                {
                    Caption = 'Heure_chargement_fichier';
                }
                field(Nom_Fichier; Rec.Nom_Fichier)
                {
                    Caption = 'Nom_Fichier';
                }
                field(Statut; Rec.Statut)
                {
                    Caption = 'Statut';
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
                        CODEUNIT.RUN(Codeunit::"DEL MGT Tracking");
                    end;
                }
                action("Maj NAV")
                {
                    Caption = 'Maj NAV';

                    trigger OnAction()
                    begin

                        CODEUNIT.RUN(Codeunit::"DEL Tracking traitement")
                    end;
                }
                action("File recovery/NAV update")
                {
                    Caption = 'File recovery/NAV update';
                    Image = Reuse;

                    trigger OnAction()
                    begin

                        CODEUNIT.RUN(Codeunit::"DEL MGT Tracking");
                        CODEUNIT.RUN(Codeunit::"DEL Tracking traitement");
                    end;
                }
            }
        }
    }

    var
        CuTracking: Codeunit "DEL Tracking traitement";

    local procedure Control1000000071OnDeactivate()
    begin

        CuTracking.RUN();
    end;
}
