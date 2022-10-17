report 50036 "DEL Vider OLD marque item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ViderOLDmarqueitem.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {

            trigger OnAfterGetRecord()
            begin
                "DEL OLD marque" := '';
                MODIFY();
            end;
        }
    }


}

