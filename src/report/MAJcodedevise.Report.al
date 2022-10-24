report 50041 "DEL MAJ code devise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAJcodedevise.rdlc';
    Permissions = TableData "Sales Invoice Header" = rimd,
                  TableData "Sales Cr.Memo Header" = rimd,
                  TableData "VAT Entry" = rimd,
                  TableData "Detailed Cust. Ledg. Entry" = rimd;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("No." = FILTER(0539601));
            dataitem("VAT Entry"; "VAT Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date", "G/L Acc. No.")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = FILTER(Invoice),
                                          Type = FILTER(Sale));

                trigger OnAfterGetRecord()
                begin
                    "VAT Entry"."Currency Code" := 'EUR';
                    "VAT Entry".MODIFY();
                end;
            }
            dataitem("Detailed Cust. Ledg. Entry"; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending)
                                    WHERE("Entry Type" = FILTER("Initial Entry"),
                                          "Document Type" = FILTER(Invoice));

                trigger OnAfterGetRecord()
                begin
                    "Detailed Cust. Ledg. Entry"."Currency Code" := 'EUR';
                    "Detailed Cust. Ledg. Entry".MODIFY();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Sales Invoice Header"."Currency Code" := 'EUR';
                "Sales Invoice Header".MODIFY();
            end;
        }
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending)
                                WHERE("No." = FILTER('VAV2642'));
            dataitem("<VAT Entry>1"; "VAT Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    WHERE("Document Type" = FILTER("Credit Memo"));

                trigger OnAfterGetRecord()
                begin
                    "Currency Code" := 'EUR';
                    MODIFY();
                end;
            }
            dataitem("<Detailed Cust. Ledg. Entry>1"; "Detailed Cust. Ledg. Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending)
                                    WHERE("Entry Type" = FILTER("Initial Entry"),
                                          "Document Type" = FILTER("Credit Memo"));

                trigger OnAfterGetRecord()
                begin
                    "Currency Code" := 'EUR';
                    MODIFY();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Currency Code" := 'EUR';
                MODIFY();
            end;
        }
    }

    requestpage
    {

        layout
        { }

        actions
        { }
    }
    labels
    { }
}

