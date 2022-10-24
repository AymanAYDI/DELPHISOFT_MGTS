enum 50100 "DEL Status Purchase Order" //n'existe pas dans l'STD 

{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "Create Req. Worksheet")
    {
        Caption = 'Création demande d''achat';
    }
    value(2; "Create Deal")
    {
        Caption = 'Création affaire';
    }
    value(3; Created)
    {
        Caption = 'Commande créée';
    }
}
