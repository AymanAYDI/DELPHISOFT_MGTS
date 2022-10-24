enum 50045 "DEL Post DocMatrix"  //n'existe pas dans le STD 
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Ship)
    {
        Caption = 'Ship';
    }
    value(2; Invoice)
    {
        Caption = 'Invoice';
    }
    value(3; "Ship and Invoice")
    {
        Caption = 'Ship and Invoice';
    }
    value(4; Yes)
    {
        Caption = 'Yes';
    }
}
