xmlport 50016 "DEL Update Supplier Base ID"
{
    // Mgts10.00 | 01.11.2019 | Vendor Tools

    FieldDelimiter = 'None';
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(supplier; Table23)
            {
                AutoReplace = true;
                XmlName = 'Supplier';
                UseTemporary = true;
                fieldelement(SupplierBaseID; Supplier."Supplier Base ID")
                {
                }
                fieldelement(SupplierErpCode; Supplier."No.")
                {

                    trigger OnAfterAssignField()
                    var
                        Vendor: Record "23";
                    begin
                        IF Vendor.GET(Supplier."No.") THEN BEGIN
                            Vendor."Supplier Base ID" := Supplier."Supplier Base ID";
                            Vendor.MODIFY;
                        END;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    IF (UPPERCASE(Supplier."No.") = 'NULL') OR (Supplier."No." = '') THEN
                        currXMLport.SKIP;
                end;

                trigger OnBeforeInsertRecord()
                begin
                    IF (UPPERCASE(Supplier."No.") = 'NULL') OR (Supplier."No." = '') THEN
                        currXMLport.SKIP;
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
        Win.CLOSE;
        MESSAGE('Finished !')
    end;

    trigger OnPreXmlPort()
    begin
        Win.OPEN('Updating Supplier Base ID...');
    end;

    var
        Win: Dialog;
}

