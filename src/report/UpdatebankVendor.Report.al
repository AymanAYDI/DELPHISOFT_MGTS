report 50060 "Update bank Vendor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './UpdatebankVendor.rdlc';
    Permissions = TableData 25 = rimd;

    dataset
    {
        dataitem(DataItem1000000000; Table50060)
        {
            dataitem(DataItem1000000001; Table25)
            {
                DataItemLink = Entry No.=FIELD(Entry No.);
                DataItemTableView = SORTING (Entry No.)
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    "Vendor Ledger Entry"."Recipient Bank Account" := "bank fournisseur"."Bank Code";
                    "Vendor Ledger Entry".MODIFY;
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

