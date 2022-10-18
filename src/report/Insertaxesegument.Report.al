report 50043 "DEL Insert axe segument"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Insertaxesegument.rdlc';

    dataset
    {


        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            //TODO 
            // trigger OnAfterGetRecord()
            // begin
            //     ModifSegment("Product Group Code", "Item Category Code");
            // end;

        }
    }

}

