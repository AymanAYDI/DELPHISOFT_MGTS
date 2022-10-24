enum 50051 "DEL Separator" //n'existe pas dans l'STD 
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Space)
    {
        Caption = 'Space';
    }
    value(2; "Carriage Return")
    {
        Caption = 'Carriage Return';
    }
}
