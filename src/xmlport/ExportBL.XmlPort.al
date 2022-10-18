xmlport 50005 "Export BL"
{
    // Mgts10.00.05.00      04.01.2022 : Replace "Vol cbm" GetVolCBM

    Direction = Export;

    schema
    {
        textelement(DesAdv)
        {
            tableelement(Table18; Table18)
            {
                RequestFilterFields = Field1;
                XmlName = 'ENV';
                fieldelement(EANAdressedName; Customer.Name)
                {
                }
            }
            tableelement(Table110; Table110)
            {
                LinkFields = Field2 = FIELD (Field1);
                LinkTable = Customer;
                RequestFilterFields = Field3;
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
                tableelement(Table111; Table111)
                {
                    LinkFields = Field3 = FIELD (Field3);
                    LinkTable = "Sales Shipment Header";
                    XmlName = 'Line';
                    fieldelement(ItemID; "Sales Shipment Line"."No.")
                    {
                    }
                    fieldelement(Name; "Sales Shipment Line".Description)
                    {
                    }
                    fieldelement(ExternalItemId; "Sales Shipment Line"."Cross-Reference No.")
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
                            //>>Mgts10.00.05.00
                            //VolumeMST := FORMAT("Sales Shipment Line".Quantity*Item_Rec."Vol cbm");
                            VolumeMST := FORMAT("Sales Shipment Line".Quantity * Item_Rec.GetVolCBM(TRUE));
                        //<<Mgts10.00.05.00
                    end;
                }
            }

            trigger OnBeforePassVariable()
            begin
                Tag := 'HDR';
            end;
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

    var
        Item_Rec: Record "27";
}

