report 50039 "Maj order No. sur les ligne"
{
    DefaultLayout = RDLC;
    Permissions = TableData "Sales Invoice Line" = rimd;
    RDLCLayout = './src/report/RDL/MajorderNosurlesligne.rdlc';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("Order No." = FILTER(<> ''));
            RequestFilterFields = "Posting Date";
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(Item), Quantity = FILTER(<> 0), "Order No." = FILTER(''));

                trigger OnAfterGetRecord()
                begin
                    "Sales Invoice Line"."Order No." := "Sales Invoice Header"."Order No.";
                    "Sales Invoice Line"."Order Line No." := "Sales Invoice Line"."Line No.";
                    "Sales Invoice Line".MODIFY();
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

