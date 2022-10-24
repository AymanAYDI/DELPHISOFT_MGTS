enum 50007 "DEL Subject Type" //n'existe pas dans l'STD 
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Vendor)
    {
        Caption = 'Vendor';
    }
    value(2; Customer)
    {
        Caption = 'Customer';
    }
    value(3; "G/L Account")
    {
        Caption = 'G/L Account';
    }
}
