report 50050 "DEL Update feuille paiement"
{
    Caption = 'mise à  jour feuille de paiement';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {

            trigger OnAfterGetRecord()
            begin
                IF UpdateRef THEN
                    IF VendorLedgerEntry.GET("Gen. Journal Line"."Source Line No.") THEN
                        // "Gen. Journal Line"."Reference No." := VendorLedgerEntry."Reference No."; TODO: field "Reference No." is not exist in "Gen. Journal Line" and "Vendor Ledger Entry" record

                IF UpdateDesc THEN
                            IF VendorLedgerEntry.GET("Gen. Journal Line"."Source Line No.") THEN BEGIN
                                Vendor.GET(VendorLedgerEntry."Vendor No.");
                                "Gen. Journal Line".Description := COPYSTR(Vendor.Name, 1, 49 - STRLEN(VendorLedgerEntry."External Document No.")) + '/' + VendorLedgerEntry."External Document No.";
                            END;

                IF UpdateBank THEN
                    IF VendorLedgerEntry.GET("Gen. Journal Line"."Source Line No.") THEN
                        "Gen. Journal Line"."Recipient Bank Account" := VendorLedgerEntry."Recipient Bank Account";
                "Gen. Journal Line".MODIFY();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Option")
                {
                    Caption = 'Options';
                    field(UpdateRef; UpdateRef)
                    {
                        Caption = 'Update reference No';
                    }
                    field(UpdateDesc; UpdateDesc)
                    {
                        Caption = 'Update description';
                    }
                    field(UpdateBank; UpdateBank)
                    {
                        Caption = 'Update target bank';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Vendor: Record Vendor;
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        UpdateBank: Boolean;
        UpdateDesc: Boolean;
        UpdateRef: Boolean;
}

