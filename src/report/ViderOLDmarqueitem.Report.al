report 50036 "Vider OLD marque item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ViderOLDmarqueitem.rdlc';

    dataset
    {
        dataitem(DataItem1100113000; Table27)
        {

            trigger OnAfterGetRecord()
            begin
                "OLD marque" := '';
                MODIFY;
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

    labels
    {
    }
}

