enum 50061 "DEL Statut PA"
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Draft)
    {
        Caption = 'Draft';
    }
    value(2; "Signé")
    {
        Caption = ' Signed';
    }
    value(3; "Échu")
    {
        Caption = 'Expired';
    }
    value(4; "Prolongé")
    {
        Caption = 'Extented';
    }
}
