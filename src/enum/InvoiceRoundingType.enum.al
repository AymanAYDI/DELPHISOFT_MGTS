enum 50075 "DEL Invoice Rounding Type" //still an option in the STD (tab4 currency)
{
    Extensible = false;

    value(0; Nearest)
    {
        Caption = 'Nearest';
    }
    value(1; Up)
    {
        Caption = 'Up';
    }
    value(2; Down)
    {
        Caption = 'Down';
    }
}
