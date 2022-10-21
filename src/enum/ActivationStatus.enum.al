enum 50038 "DEL ActivationStatus"   // still an option in the std exp status in 13
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Actif)
    {
        Caption = 'Active';
    }
    value(2; Inactif)
    {
        Caption = 'Inactive';
    }
}
