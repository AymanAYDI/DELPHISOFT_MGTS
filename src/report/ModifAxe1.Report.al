report 50052 "DEL Modif Axe 1"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report/RDL/ModifAxe1.rdlc';
    Permissions = TableData "Purch. Inv. Header" = rimd;

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

