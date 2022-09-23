table 50012 "DEL Tracking non traité"
{
    Caption = 'Tracking non traité';

    fields
    {
        field(1; "key"; Integer)
        {
            Caption = 'key';
        }
        field(2; Forwading_agent_no; Text[20])
        {
            Caption = 'Code du transitaire';
        }
        field(3; Order_no; Text[20])
        {
            Caption = 'Commande n.';
        }
        field(4; Item_no; Text[20])
        {
            Caption = 'Article n.';
        }
        field(5; Description; Text[80])
        {
            Caption = 'Description';
        }
        field(6; Event_no; Text[30])
        {
            Caption = 'Code de l''évenement';
        }
        field(7; Booking_no; Text[50])
        {
            Caption = 'Numéro de booking';
        }
        field(8; Booking_date; Date)
        {
            Caption = 'Booking date';
        }
        field(9; Ordered_qty; Decimal)
        {
            Caption = 'Quantité commandée';
        }
        field(10; Booked_qty; Decimal)
        {
            Caption = 'Quantité bookée';
        }
        field(11; Received_qty; Decimal)
        {
            Caption = 'Quantité recue';
        }
        field(12; Shipped_qty; Decimal)
        {
            Caption = 'Qauantité shippee';
        }
        field(13; Vendor_no; Text[50])
        {
            Caption = 'Vendor';
        }
        field(14; Origine_port; Text[30])
        {
            Caption = 'Port origine';
        }
        field(15; Etd; Date)
        {
            Caption = 'ETD';
        }
        field(16; Actual_Reception_date; Date)
        {
            Caption = 'Date réception marchandise origine';
        }
        field(17; Loading_date; Date)
        {
            Caption = 'Date embarquement(loading date)';
        }
        field(18; Shipping_date; Date)
        {
            Caption = 'Date de livraison confirmé(Shipping date)';
        }
        field(19; Unloading_port; Text[30])
        {
            Caption = 'Port de déchargement';
        }
        field(20; Carrier; Text[50])
        {
            Caption = 'Carrier';
        }
        field(21; Vessel; Text[30])
        {
            Caption = 'Bateau';
        }
        field(22; Container_no; Text[30])
        {
            Caption = 'N. Conteneur';
        }
        field(23; Stuffing_no; Text[30])
        {
            Caption = 'CS n.(n. stuffing)';
        }
        field(24; Size; Text[10])
        {
            Caption = 'Size';
        }
        field(25; Type; Text[10])
        {
            Caption = 'Type';
        }
        field(26; EstimatedDischarge; Date)
        {
            Caption = 'discharge date planned';
        }
        field(27; Estimated_delivery_date; Date)
        {
            Caption = 'Livraison estimé';
        }
        field(28; ActualDischarge; Date)
        {
            Caption = 'discharge date actual';
        }
        field(29; ActualDeliveryDate; Date)
        {
            Caption = 'delivery date actual ( at the warehouse)';
        }
        field(30; Delivery_gate_out; Date)
        {
            Caption = 'Gate out delivery';
        }
        field(31; Container_returned_date; Date)
        {
            Caption = 'Conteneur return to carrier';
        }
        field(32; Date_chargement_fichier; Date)
        {
            Caption = 'Date_chargement_fichier';
        }
        field(33; Heure_chargement_fichier; Time)
        {
            Caption = 'Heure_chargement_fichier';
        }
        field(34; Nom_Fichier; Text[250])
        {
            Caption = 'Nom_Fichier';
        }
        field(35; Statut; Code[20])
        {
            Description = 'n.shipment si affecté';
            Caption = 'Statut';
        }
    }

    keys
    {
        key(Key1; "key")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

