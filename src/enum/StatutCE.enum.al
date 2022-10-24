enum 50064 "DEL Statut CE" //n'existe pas dans l'STD 
{
    Extensible = false;

    value(0; " ")
    {
        Caption = '';
    }
    value(1; "Charte envoyée")
    {
        Caption = 'Sent';
    }
    value(2; "Charte signée")
    {
        Caption = 'Signed';
    }
}
