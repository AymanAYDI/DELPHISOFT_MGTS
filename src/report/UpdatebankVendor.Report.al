report 50060 "DEL Update bank Vendor"
{
    DefaultLayout = RDLC;
    Permissions = TableData "Vendor Ledger Entry" = rimd;
    RDLCLayout = './src/report/RDL/UpdatebankVendor.rdlc';

    dataset
    {
        dataitem("DEL bank fournisseur"; "DEL bank fournisseur")
        {
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Entry No." = FIELD("Entry No.");
                DataItemTableView = SORTING("Entry No.")
                                    ORDER(Ascending);

                trigger OnAfterGetRecord()
                begin
                    "Vendor Ledger Entry"."Recipient Bank Account" := "DEL bank fournisseur"."Bank Code";
                    "Vendor Ledger Entry".MODIFY();
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

