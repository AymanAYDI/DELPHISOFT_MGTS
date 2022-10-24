enum 50066 "DEL Statut CG" //n'existe pas dans l'STD 
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "CGA envoyées")
    {
        Caption = 'PT sent';
    }
    value(2; "CGA signées")
    {
        Caption = 'PT signed';
    }
}
