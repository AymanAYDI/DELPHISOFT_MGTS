report 50043 "DEL Insert axe segument"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Insertaxesegument.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; "Sales Price")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                // ModifSegment("Product Group Code", "Item Category Code"); // TODO:
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

