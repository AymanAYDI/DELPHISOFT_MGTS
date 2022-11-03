xmlport 50005 "DEL Export BL"
{

    Direction = Export;

    schema
    {
        textelement(DesAdv)
        {
            tableelement(Customer; Customer)
            {
                RequestFilterFields = "No.";
                XmlName = 'ENV';
                fieldelement(EANAdressedName; Customer.Name)
                {
                }
            }
            tableelement("Sales Shipment Header"; "Sales Shipment Header")
            {
                LinkFields = "Sell-to Customer No." = FIELD("No.");
                LinkTable = Customer;
                RequestFilterFields = "No.";
                XmlName = 'HEAD';
                textelement(Tag)
                {
                }
                fieldelement(PurchaseOrder; "Sales Shipment Header"."External Document No.")
                {
                }
                fieldelement(PackingSlipId; "Sales Shipment Header"."No.")
                {
                }
                fieldelement(DeliveryDate; "Sales Shipment Header"."Shipment Date")
                {
                }
                fieldelement(DeliveryName; "Sales Shipment Header"."Ship-to Name")
                {
                }
                fieldelement(DeliveryStreet; "Sales Shipment Header"."Ship-to Address")
                {
                }
                fieldelement(DeliveryCity; "Sales Shipment Header"."Ship-to City")
                {
                }
                fieldelement(DeliveryCountryRegionID; "Sales Shipment Header"."Ship-to Country/Region Code")
                {
                }
                fieldelement(SalesPers; "Sales Shipment Header"."Salesperson Code")
                {
                }
                tableelement("Sales Shipment Line"; "Sales Shipment Line")
                {
                    LinkFields = "Document No." = FIELD("No.");
                    LinkTable = "Sales Shipment Header";
                    XmlName = 'Line';
                    fieldelement(ItemID; "Sales Shipment Line"."No.")
                    {
                    }
                    fieldelement(Name; "Sales Shipment Line".Description)
                    {
                    }
                    fieldelement(ExternalItemId; "Sales Shipment Line"."Item Reference No.")
                    {
                    }
                    fieldelement(Ordered; "Sales Shipment Line".Quantity)
                    {
                    }
                    fieldelement(Quantity; "Sales Shipment Line".Quantity)
                    {
                    }
                    fieldelement(PriceUnit; "Sales Shipment Line"."Unit Price")
                    {
                    }
                    textelement(VolumeMST)
                    {
                    }
                    fieldelement(SalesUnit; "Sales Shipment Line"."Unit of Measure Code")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VolumeMST := '';
                        IF Item_Rec.GET("Sales Shipment Line"."No.") THEN
                            VolumeMST := FORMAT("Sales Shipment Line".Quantity * Item_Rec.GetVolCBM(TRUE));
                    end;
                }
            }

            trigger OnBeforePassVariable()
            begin
                Tag := 'HDR';
            end;
        }
    }



    var
        Item_Rec: Record Item;
}

