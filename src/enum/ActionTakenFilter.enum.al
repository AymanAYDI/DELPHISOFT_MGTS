enum 50048 "DEL Action Taken Filter"  //still an option in the std
{
    Extensible = false;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Next)
    {
        Caption = 'Next';
    }
    value(2; Previous)
    {
        Caption = 'Previous';
    }
    value(3; Updated)
    {
        Caption = 'Updated';
    }
    value(4; Jumped)
    {
        Caption = 'Jumped';
    }
    value(5; Won)
    {
        Caption = 'Won';
    }
    value(6; Lost)
    {
        Caption = 'Lost';
    }
}
