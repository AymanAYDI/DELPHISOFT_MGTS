report 50039 "Maj order No. sur les ligne"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MajorderNosurlesligne.rdlc';
    Permissions = TableData 113 = rimd;

    dataset
    {
        dataitem(DataItem1000000000; Table112)
        {
            DataItemTableView = SORTING (No.)
                                ORDER(Ascending)
                                WHERE (Order No.=FILTER(<>''));
            RequestFilterFields = "Posting Date";
            dataitem(DataItem1000000001;Table113)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Document No.,Line No.)
                                    ORDER(Ascending)
                                    WHERE(Type=FILTER(Item),
                                          Quantity=FILTER(<>0),
                                          Order No.=FILTER(''));

                trigger OnAfterGetRecord()
                begin
                    "Sales Invoice Line"."Order No.":="Sales Invoice Header"."Order No.";
                    "Sales Invoice Line"."Order Line No.":="Sales Invoice Line"."Line No.";
                    "Sales Invoice Line".MODIFY;
                end;
            }
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

