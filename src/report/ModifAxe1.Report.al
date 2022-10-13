report 50052 "Modif Axe 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ModifAxe1.rdlc';
    Permissions = TableData 122 = rimd;

    dataset
    {
        dataitem(DataItem1000000000; Table122)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                "Shortcut Dimension 1 Code" := 'ACO-24803';
                //MODIFY;
                //MESSAGE('no %1 ',"No.");
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

