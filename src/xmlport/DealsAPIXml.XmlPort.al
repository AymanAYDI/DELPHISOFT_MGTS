xmlport 50015 "DEL Deals API Xml"
{
    Direction = Export;
    Encoding = UTF8;
    Namespaces = Json = 'http://james.newtonking.com/projects/json';
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement("DEL Order API Record Tracking"; "DEL Order API Record Tracking")
            {
                NamespacePrefix = 'Json';
                XmlName = 'orders';
                textelement(general)
                {
                    fieldelement(id; "DEL Order API Record Tracking"."Deal ID")
                    {
                    }
                    textelement(status)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            IF "DEL Order API Record Tracking".Completed THEN
                                status := '2'
                            ELSE
                                status := '0';
                        end;
                    }
                }
                textelement(aco)
                {
                    fieldelement(num; "DEL Order API Record Tracking"."ACO No.")
                    {
                    }
                    textelement(creationDate)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            creationDate := FORMAT("DEL Order API Record Tracking"."ACO Date", 0, '<Day,2>.<Month,2>.<Year4>');
                        end;
                    }
                    textelement(paymentDeadline)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            paymentDeadline := FORMAT("DEL Order API Record Tracking"."ACO Payment Deadline", 0, '<Day,2>.<Month,2>.<Year4>');
                            IF (paymentDeadline = '') THEN
                                paymentDeadline := '31.12.9999';
                        end;
                    }
                    fieldelement(product; "DEL Order API Record Tracking"."ACO Product")
                    {
                    }
                    fieldelement(supplierName; "DEL Order API Record Tracking"."ACO Supplier ERP Name")
                    {
                    }
                    fieldelement(supplierErpCode; "DEL Order API Record Tracking"."ACO Supplier ERP Code")
                    {
                    }
                    fieldelement(supplierBaseCode; "DEL Order API Record Tracking"."ACO Supplier base code")
                    {
                    }
                    fieldelement(transportMode; "DEL Order API Record Tracking"."ACO Transport Mode")
                    {
                    }
                    fieldelement(departurePort; "DEL Order API Record Tracking"."ACO Departure Port")
                    {
                    }
                    fieldelement(arrivalPort; "DEL Order API Record Tracking"."ACO Arrival Port")
                    {
                    }
                    fieldelement(warehouse; "DEL Order API Record Tracking"."ACO Warehouse")
                    {
                    }
                    fieldelement("event"; "DEL Order API Record Tracking"."ACO Event")
                    {
                    }
                    textelement(etd)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            etd := FORMAT("DEL Order API Record Tracking"."ACO ETD", 0, '<Day,2>.<Month,2>.<Year4>');
                        end;
                    }
                    fieldelement(incoterm; "DEL Order API Record Tracking"."ACO Incoterm")
                    {
                    }
                    textelement(amount)
                    {
                        XmlName = 'amount';

                        trigger OnBeforePassVariable()
                        begin
                            amount := FORMAT("DEL Order API Record Tracking"."ACO Amount", 0, 1);
                        end;
                    }
                    fieldelement(currency; "DEL Order API Record Tracking"."ACO Currency Code")
                    {
                    }
                    tableelement("DEL ACO Lines API Rec. Track."; "DEL ACO Lines API Rec. Track.")
                    {
                        LinkFields = "Deal ID" = FIELD("Deal ID");
                        LinkTable = "DEL Order API Record Tracking";
                        NamespacePrefix = 'Json';
                        XmlName = 'lineDetails';
                        fieldelement(lineType; "DEL ACO Lines API Rec. Track."."ACO Line Type")
                        {
                        }
                        fieldelement(articleCodeMgts; "DEL ACO Lines API Rec. Track."."ACO Mgts Item No.")
                        {
                        }
                        fieldelement(articleCodeSupplier; "DEL ACO Lines API Rec. Track."."ACO Supplier Item No.")
                        {
                        }
                        fieldelement(articleCodeCustomer; "DEL ACO Lines API Rec. Track."."ACO External reference NGTS")
                        {
                        }
                        textelement(quantity)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                quantity := FORMAT("DEL ACO Lines API Rec. Track.".Quantity, 0, 1);
                            end;
                        }
                        textelement(lineamount)
                        {
                            XmlName = 'amount';

                            trigger OnBeforePassVariable()
                            begin
                                Lineamount := FORMAT("DEL ACO Lines API Rec. Track."."ACO Line Amount", 0, 1);
                            end;
                        }
                        fieldelement(currency; "DEL Order API Record Tracking"."ACO Currency Code")
                        {
                        }
                        textelement(newProduct)
                        {

                            trigger OnBeforePassVariable()
                            begin
                                newProduct := '0';
                                IF "DEL ACO Lines API Rec. Track."."ACO New Product" THEN
                                    newProduct := '1';
                            end;
                        }
                        fieldelement(designation; "DEL ACO Lines API Rec. Track."."ACO Product Description")
                        {
                        }
                    }
                }
                textelement(vco)
                {
                    fieldelement(num; "DEL Order API Record Tracking"."VCO No.")
                    {
                    }
                    fieldelement(customerRef; "DEL Order API Record Tracking"."VCO Customer Ref")
                    {
                    }
                    textelement(deliveryDate)
                    {

                        trigger OnBeforePassVariable()
                        begin
                            deliveryDate := FORMAT("DEL Order API Record Tracking"."VCO Delivery date", 0, '<Day,2>.<Month,2>.<Year4>');
                        end;
                    }
                    fieldelement(customerName; "DEL Order API Record Tracking"."VCO Customer Name")
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

