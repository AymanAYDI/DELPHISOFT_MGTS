enum 50037 "DEL DoC Facture Type" //n'existe pas 
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "Service Invoice")
    {
        Caption = 'Facture service';
    }
    value(2; "Service Credit Memo")
    {
        Caption = 'Avoir service';
    }
    value(3; "Issued Reminder")
    {
        Caption = 'Relance émise';
    }
    value(4; "Service Header")
    {
        Caption = 'Service Header';
    }

}
