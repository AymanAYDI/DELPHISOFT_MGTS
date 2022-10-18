xmlport 50015 "Deals API Xml"
{
    // Mgts10.00.01.00 | 11.01.2020 | Order API Management
    // 
    // Mgts10.00.01.02 | 06.02.2020 | Order API Management : Add fields
    // 
    // Mgts10.00.03.03 | 09.10.2020 | Order API Management : Add field :  status

    Direction = Export;
    Encoding = UTF8;
    Namespaces = Json = 'http://james.newtonking.com/projects/json';
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(Table50074; Table50074)
            {
                NamespacePrefix = 'Json';
                XmlName = 'orders';
                textelement(general)
                {
                    fieldelement(id; "Order API Record Tracking"."Deal ID")
                    {
                    }
                    textelement(status)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            IF "Order API Record Tracking".Completed THEN
                                status := '2'
                            ELSE
                                status := '0';
                        end;
                    }
                }
                textelement(aco)
                {
                    fieldelement(num; "Order API Record Tracking"."ACO No.")
                    {
                    }
                    textelement(creationDate)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            creationDate := FORMAT("Order API Record Tracking"."ACO Date", 0, '<Day,2>.<Month,2>.<Year4>');
                        end;
                    }
                    textelement(paymentDeadline)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            paymentDeadline := FORMAT("Order API Record Tracking"."ACO Payment Deadline", 0, '<Day,2>.<Month,2>.<Year4>');
                            IF (paymentDeadline = '') THEN
                                paymentDeadline := '31.12.9999';
                        end;
                    }
                    fieldelement(product; "Order API Record Tracking"."ACO Product")
                    {
                    }
                    fieldelement(supplierName; "Order API Record Tracking"."ACO Supplier ERP Name")
                    {
                    }
                    fieldelement(supplierErpCode; "Order API Record Tracking"."ACO Supplier ERP Code")
                    {
                    }
                    fieldelement(supplierBaseCode; "Order API Record Tracking"."ACO Supplier base code")
                    {
                    }
                    fieldelement(transportMode; "Order API Record Tracking"."ACO Transport Mode")
                    {
                    }
                    fieldelement(departurePort; "Order API Record Tracking"."ACO Departure Port")
                    {
                    }
                    fieldelement(arrivalPort; "Order API Record Tracking"."ACO Arrival Port")
                    {
                    }
                    fieldelement(warehouse; "Order API Record Tracking"."ACO Warehouse")
                    {
                    }
                    fieldelement("event"; "Order API Record Tracking"."ACO Event")
                    {
                    }
                    textelement(etd)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            etd := FORMAT("Order API Record Tracking"."ACO ETD", 0, '<Day,2>.<Month,2>.<Year4>');
                        end;
                    }
                    fieldelement(incoterm; "Order API Record Tracking"."ACO Incoterm")
                    {
                    }
                    textelement(amount)
                    {
                        XmlName = 'amount';

                        trigger OnBeforePassVariable()
                        begin
                            amount := FORMAT("Order API Record Tracking"."ACO Amount", 0, 1);
                        end;
                    }
                    fieldelement(currency; "Order API Record Tracking"."ACO Currency Code")
                    {
                    }
                    tableelement(Table50075; Table50075)
                    {
                        LinkFields = Field1 = FIELD (Field1);
                        LinkTable = "Order API Record Tracking";
                        NamespacePrefix = 'Json';
                        XmlName = 'lineDetails';
                        fieldelement(lineType; "ACO Lines API Record Tracking"."ACO Line Type")
                        {
                        }
                        fieldelement(articleCodeMgts; "ACO Lines API Record Tracking"."ACO Mgts Item No.")
                        {
                        }
                        fieldelement(articleCodeSupplier; "ACO Lines API Record Tracking"."ACO Supplier Item No.")
                        {
                        }
                        fieldelement(articleCodeCustomer; "ACO Lines API Record Tracking"."ACO External reference NGTS")
                        {
                        }
                        textelement(quantity)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                quantity := FORMAT("ACO Lines API Record Tracking".Quantity, 0, 1);
                            end;
                        }
                        textelement(lineamount)
                        {
                            XmlName = 'amount';

                            trigger OnBeforePassVariable()
                            begin
                                Lineamount := FORMAT("ACO Lines API Record Tracking"."ACO Line Amount", 0, 1);
                            end;
                        }
                        fieldelement(currency; "Order API Record Tracking"."ACO Currency Code")
                        {
                        }
                        textelement(newProduct)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                newProduct := '0';
                                IF "ACO Lines API Record Tracking"."ACO New Product" THEN
                                    newProduct := '1';
                            end;
                        }
                        fieldelement(designation; "ACO Lines API Record Tracking"."ACO Product Description")
                        {
                        }
                    }
                }
                textelement(vco)
                {
                    fieldelement(num; "Order API Record Tracking"."VCO No.")
                    {
                    }
                    fieldelement(customerRef; "Order API Record Tracking"."VCO Customer Ref")
                    {
                    }
                    textelement(deliveryDate)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            deliveryDate := FORMAT("Order API Record Tracking"."VCO Delivery date", 0, '<Day,2>.<Month,2>.<Year4>');
                        end;
                    }
                    fieldelement(customerName; "Order API Record Tracking"."VCO Customer Name")
                    {
                    }
                }
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
}

