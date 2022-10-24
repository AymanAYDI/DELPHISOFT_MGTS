enum 50011 "DEL Type Vend/Cont" //existe mais l'ordre 'Customer,Vendor,Contact'(table249)  
{
    Extensible = true;

    value(0; Vendor)
    {
        Caption = 'Vendor';
    }
    value(1; Contact)
    {
        Caption = 'Contact';
    }
}
