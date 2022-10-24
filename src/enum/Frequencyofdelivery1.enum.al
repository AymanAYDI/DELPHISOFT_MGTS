enum 50065 "DEL Frequency of delivery 1" // n'existe pas 
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Monthly)
    {
        Caption = 'Monthly';
    }
    value(2; Quarterly)
    {
        Caption = 'Quarterly';
    }
    value(3; "Semi-annual")
    {
        Caption = 'Semi-annual';
    }
    value(4; Annual)
    {
        Caption = 'Annual';
    }
    value(5; "No frequency")
    {
        Caption = 'No frequency';
    }
}
