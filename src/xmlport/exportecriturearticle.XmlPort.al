xmlport 50012 "export ecriture article"
{
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(root)
        {
            tableelement(Table17; Table17)
            {
                XmlName = 'EcriCompta';
                fieldelement(compte; "G/L Entry"."G/L Account No.")
                {
                }
                fieldelement(date; "G/L Entry"."Posting Date")
                {
                }
                fieldelement(daocument; "G/L Entry"."Document No.")
                {
                }
                fieldelement(montant; "G/L Entry".Amount)
                {
                }
                fieldelement(type; "G/L Entry"."Source Type")
                {
                }
                fieldelement(source; "G/L Entry"."Source No.")
                {
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

