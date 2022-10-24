enum 50038 "DEL ActivationStatus"   //TODO : still an option in the std exp status in 13 there is an enum "Impact Status" that has the same options but not in the same order 
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
