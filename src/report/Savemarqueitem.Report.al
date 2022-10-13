report 50034 "Save marque item"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Savemarqueitem.rdlc';

    dataset
    {
        dataitem(DataItem1100113000; Table27)
        {

            trigger OnAfterGetRecord()
            begin
                "OLD marque" := Marque;
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

