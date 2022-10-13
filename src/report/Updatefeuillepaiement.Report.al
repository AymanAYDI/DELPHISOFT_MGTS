report 50050 "Update feuille paiement"
{
    Caption = 'mise à  jour feuille de paiement';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1000000000; Table81)
        {

            trigger OnAfterGetRecord()
            begin
                IF UpdateRef THEN BEGIN
                    IF VendorLedgerEntry.GET("Gen. Journal Line"."Source Line No.") THEN BEGIN
                        "Gen. Journal Line"."Reference No." := VendorLedgerEntry."Reference No.";
                    END;
                END;

                IF UpdateDesc THEN BEGIN
                    IF VendorLedgerEntry.GET("Gen. Journal Line"."Source Line No.") THEN BEGIN
                        Vendor.GET(VendorLedgerEntry."Vendor No.");
                        "Gen. Journal Line".Description := COPYSTR(Vendor.Name, 1, 49 - STRLEN(VendorLedgerEntry."External Document No.")) + '/' + VendorLedgerEntry."External Document No.";
                    END;
                END;

                IF UpdateBank THEN BEGIN
                    IF VendorLedgerEntry.GET("Gen. Journal Line"."Source Line No.") THEN BEGIN
                        "Gen. Journal Line"."Recipient Bank Account" := VendorLedgerEntry."Recipient Bank Account";
                    END;

                END;
                "Gen. Journal Line".MODIFY;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
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
        UpdateRef: Boolean;
        UpdateDesc: Boolean;
        UpdateBank: Boolean;
        Vendor: Record "23";
        VendorLedgerEntry: Record "25";
}

