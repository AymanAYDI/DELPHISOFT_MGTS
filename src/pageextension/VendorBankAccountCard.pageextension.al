pageextension 50064 "DEL VendorBankAccountCard" extends "Vendor Bank Account Card" //425
{
    layout
    {
        modify(IBAN)
        {
            Caption = 'IBAN/QR-IBAN';
            ToolTip = 'Specifies the IBAN or QR-IBAN account of the vendor.';
        }
    }
    actions
    {


    }
}

