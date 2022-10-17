report 50034 "DEL Save marque item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Savemarqueitem.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {

            trigger OnAfterGetRecord()
            begin
                "DEL OLD marque" := "DEL Marque";
                MODIFY;
            end;
        }
    }


}

