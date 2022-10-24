enum 50022 "DEL Requested By Type" //n'existe pas dans l'STD de cet ordre 
{
    Extensible = true;

    value(0; Invoice)
    {
        Caption = 'Invoice';
    }
    value(1; "Purchase Header")
    {
        Caption = 'Purchase Header';
    }
    value(2; "Sales Header")
    {
        Caption = 'Sales Header';
    }
    value(3; "Sales Cr. Memo")
    {
        Caption = 'Sales Cr. Memo';
    }
    value(4; "Purch. Cr. Memo")
    {
        Caption = 'Purch. Cr. Memo';
    }
    value(5; Payment)
    {
        Caption = 'Payment';
    }
    value(6; Provision)
    {
        Caption = 'Provision';
    }
    value(7; CUSTOM)
    {
        Caption = 'CUSTOM';
    }
    value(8; "Deal Item")
    {
        Caption = 'Deal Item';
    }
}
