report 50041 "MAJ code devise"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MAJcodedevise.rdlc';
    Permissions = TableData 112 = rimd,
                  TableData 114 = rimd,
                  TableData 254 = rimd,
                  TableData 379 = rimd;

    dataset
    {
        dataitem(DataItem1000000000; Table112)
        {
            DataItemTableView = SORTING (No.)
                                ORDER(Ascending)
                                WHERE (No.=FILTER(0539601));
            dataitem(DataItem1000000001;Table254)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Type,Closed,VAT Bus. Posting Group,VAT Prod. Posting Group,Posting Date,G/L Account No.)
                                    ORDER(Ascending)
                                    WHERE(Document Type=FILTER(Invoice),
                                          Type=FILTER(Sale));

                trigger OnAfterGetRecord()
                begin
                    "VAT Entry"."Currency Code":='EUR';
                    "VAT Entry".MODIFY;
                end;
            }
            dataitem(DataItem1000000002;Table379)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Entry No.)
                                    ORDER(Ascending)
                                    WHERE(Entry Type=FILTER(Initial Entry),
                                          Document Type=FILTER(Invoice));

                trigger OnAfterGetRecord()
                begin
                    "Detailed Cust. Ledg. Entry"."Currency Code":='EUR';
                    "Detailed Cust. Ledg. Entry".MODIFY;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Sales Invoice Header"."Currency Code":='EUR';
                "Sales Invoice Header".MODIFY;
            end;
        }
        dataitem(DataItem1000000003;Table114)
        {
            DataItemTableView = SORTING(No.)
                                ORDER(Ascending)
                                WHERE(No.=FILTER(VAV2642));
            dataitem("<VAT Entry>1";Table254)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Entry No.)
                                    WHERE(Document Type=FILTER(Credit Memo));

                trigger OnAfterGetRecord()
                begin
                    "Currency Code":='EUR';
                    MODIFY;
                end;
            }
            dataitem("<Detailed Cust. Ledg. Entry>1";Table379)
            {
                DataItemLink = Document No.=FIELD(No.);
                DataItemTableView = SORTING(Entry No.)
                                    ORDER(Ascending)
                                    WHERE(Entry Type=FILTER(Initial Entry),
                                          Document Type=FILTER(Credit Memo));

                trigger OnAfterGetRecord()
                begin
                    "Currency Code":='EUR';
                    MODIFY;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "Currency Code":='EUR';
                MODIFY;
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

