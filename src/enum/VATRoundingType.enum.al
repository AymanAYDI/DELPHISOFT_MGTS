enum 50080 "DEL VAT Rounding Type" //existe comme type option dans le STD (table4/ field53)
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
