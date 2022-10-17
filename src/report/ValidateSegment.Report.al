report 50037 "DEL Validate Segment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ValidateSegment.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("DEL Segment Code");
                //TODO
                // IF "DEL Segment Code" <> '' THEN
                //     ModifSegment("Product Group Code", "Item Category Code");
            end;
        }
    }


}

