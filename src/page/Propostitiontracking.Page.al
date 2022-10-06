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
                    Caption = 'Commande n.';
                }
                field(Booking_no; Rec.Booking_no)
                {
                    Caption = 'Numéro de booking';
                }
                field(Item_no; Rec.Item_no)
                {
                    Caption = 'Article n.';
                }
                field(Container_no; Rec.Container_no)
                {
                    Caption = 'N. Conteneur';
                }
                field(Vendor_no; Rec.Vendor_no)
                {
                    Caption = 'Vendor';
                }
                field(Booking_date; Rec.Booking_date)
                {
                    Caption = 'Booking date';
                }
                field(Origine_port; Rec.Origine_port)
                {
                    Caption = 'Port origine';
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



