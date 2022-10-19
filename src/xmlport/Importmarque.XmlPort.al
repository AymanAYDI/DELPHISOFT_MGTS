xmlport 50004 "DEL Import marque" //TODO: 3032100 doesnt exist
{
    FieldSeparator = ';';
    Format = VariableText;
    //Permissions = TableData 3032100 = rimd;

    schema
    {
        textelement(root)
        {
            // tableelement(Table3032100; "3032100")
            // {
            //     XmlName = 'T3032100';
            //     fieldelement(Code; "Temp Correspondance marque".Code)
            //     {
            //     }
            //     fieldelement(DescMarque; "Temp Correspondance marque"."Desc Marque")
            //     {
            //     }
            //     fieldelement(OldMarque; "Temp Correspondance marque"."OLD marque")
            //     {
            //     }
            // }
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

