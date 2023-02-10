report 50052 "DEL Modif Axe 1"
{
    DefaultLayout = RDLC;
    Permissions = TableData "Purch. Inv. Header" = rimd;
    RDLCLayout = './src/report/RDL/ModifAxe1.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                "Shortcut Dimension 1 Code" := 'ACO-24803';
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

