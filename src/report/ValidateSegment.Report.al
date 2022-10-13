report 50037 "Validate Segment"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ValidateSegment.rdlc';

    dataset
    {
        dataitem(DataItem1100113000; Table27)
        {

            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Segment Code");
                IF "Segment Code" <> '' THEN
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

