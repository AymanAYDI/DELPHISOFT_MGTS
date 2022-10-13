report 50043 "Insert axe segument"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Insertaxesegument.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; Table27)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                ModifSegment("Product Group Code", "Item Category Code");
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

