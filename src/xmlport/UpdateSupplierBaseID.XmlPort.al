xmlport 50016 "DEL Update Supplier Base ID"
{
    FieldDelimiter = 'None';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(supplier; Vendor)
            {
                AutoReplace = true;
                UseTemporary = true;
                XmlName = 'Supplier';
                fieldelement(SupplierBaseID; Supplier."DEL Supplier Base ID")
                {
                }
                fieldelement(SupplierErpCode; Supplier."No.")
                {

                    trigger OnAfterAssignField()
                    var
                        Vendor: Record Vendor;
                    begin
                        IF Vendor.GET(Supplier."No.") THEN BEGIN
                            Vendor."DEL Supplier Base ID" := Supplier."DEL Supplier Base ID";
                            Vendor.MODIFY();
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF (UPPERCASE(Supplier."No.") = 'NULL') OR (Supplier."No." = '') THEN
                        currXMLport.SKIP();
                end;

                trigger OnBeforeInsertRecord()
                begin
                    IF (UPPERCASE(Supplier."No.") = 'NULL') OR (Supplier."No." = '') THEN
                        currXMLport.SKIP();
                end;
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

    trigger OnPostXmlPort()
    begin
        Win.CLOSE();
        MESSAGE('Finished !')
    end;

    trigger OnPreXmlPort()
    begin
        Win.OPEN('Updating Supplier Base ID...');
    end;

    var
        Win: Dialog;
}

