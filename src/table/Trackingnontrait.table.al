table 50012 "DEL Tracking non traité"
{
    Caption = 'Tracking non traité';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "key"; Integer)
        {
            Caption = 'key';
            DataClassification = CustomerContent;
        }
        field(2; Forwading_agent_no; Text[20])
        {
            Caption = 'Code du transitaire';
            DataClassification = CustomerContent;
        }
        field(3; Order_no; Text[20])
        {
            Caption = 'Commande n.';
            DataClassification = CustomerContent;
        }
        field(4; Item_no; Text[20])
        {
            Caption = 'Article n.';
            DataClassification = CustomerContent;
        }
        field(5; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(6; Event_no; Text[30])
        {
            Caption = 'Code de l''évenement';
            DataClassification = CustomerContent;
        }
        field(7; Booking_no; Text[50])
        {
            Caption = 'Numéro de booking';
            DataClassification = CustomerContent;
        }
        field(8; Booking_date; Date)
        {
            Caption = 'Booking date';
            DataClassification = CustomerContent;
        }
        field(9; Ordered_qty; Decimal)
        {
            Caption = 'Quantité commandée';
            DataClassification = CustomerContent;
        }
        field(10; Booked_qty; Decimal)
        {
            Caption = 'Quantité bookée';
            DataClassification = CustomerContent;
        }
        field(11; Received_qty; Decimal)
        {
            Caption = 'Quantité recue';
            DataClassification = CustomerContent;
        }
        field(12; Shipped_qty; Decimal)
        {
            Caption = 'Qauantité shippee';
            DataClassification = CustomerContent;
        }
        field(13; Vendor_no; Text[50])
        {
            Caption = 'Vendor';
            DataClassification = CustomerContent;
        }
        field(14; Origine_port; Text[30])
        {
            Caption = 'Port origine';
            DataClassification = CustomerContent;
        }
        field(15; Etd; Date)
        {
            Caption = 'ETD';
            DataClassification = CustomerContent;
        }
        field(16; Actual_Reception_date; Date)
        {
            Caption = 'Date réception marchandise origine';
            DataClassification = CustomerContent;
        }
        field(17; Loading_date; Date)
        {
            Caption = 'Date embarquement(loading date)';
            DataClassification = CustomerContent;
        }
        field(18; Shipping_date; Date)
        {
            Caption = 'Date de livraison confirmé(Shipping date)';
            DataClassification = CustomerContent;
        }
        field(19; Unloading_port; Text[30])
        {
            Caption = 'Port de déchargement';
            DataClassification = CustomerContent;
        }
        field(20; Carrier; Text[50])
        {
            Caption = 'Carrier';
            DataClassification = CustomerContent;
        }
        field(21; Vessel; Text[30])
        {
            Caption = 'Bateau';
            DataClassification = CustomerContent;
        }
        field(22; Container_no; Text[30])
        {
            Caption = 'N. Conteneur';
            DataClassification = CustomerContent;
        }
        field(23; Stuffing_no; Text[30])
        {
            Caption = 'CS n.(n. stuffing)';
            DataClassification = CustomerContent;
        }
        field(24; Size; Text[10])
        {
            Caption = 'Size';
            DataClassification = CustomerContent;
        }
        field(25; Type; Text[10])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(26; EstimatedDischarge; Date)
        {
            Caption = 'discharge date planned';
            DataClassification = CustomerContent;
        }
        field(27; Estimated_delivery_date; Date)
        {
            Caption = 'Livraison estimé';
            DataClassification = CustomerContent;
        }
        field(28; ActualDischarge; Date)
        {
            Caption = 'discharge date actual';
            DataClassification = CustomerContent;
        }
        field(29; ActualDeliveryDate; Date)
        {
            Caption = 'delivery date actual ( at the warehouse)';
            DataClassification = CustomerContent;
        }
        field(30; Delivery_gate_out; Date)
        {
            Caption = 'Gate out delivery';
            DataClassification = CustomerContent;
        }
        field(31; Container_returned_date; Date)
        {
            Caption = 'Conteneur return to carrier';
            DataClassification = CustomerContent;
        }
        field(32; Date_chargement_fichier; Date)
        {
            Caption = 'Date_chargement_fichier';
            DataClassification = CustomerContent;
        }
        field(33; Heure_chargement_fichier; Time)
        {
            Caption = 'Heure_chargement_fichier';
            DataClassification = CustomerContent;
        }
        field(34; Nom_Fichier; Text[250])
        {
            Caption = 'Nom_Fichier';
            DataClassification = CustomerContent;
        }
        field(35; Statut; Code[20])
        {
            Caption = 'Statut';
            DataClassification = CustomerContent;
            Description = 'n.shipment si affecté';
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

