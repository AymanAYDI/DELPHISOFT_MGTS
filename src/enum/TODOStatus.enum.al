enum 50049 "DEL TODOStatus" // table de STD 5102 (field 21 )
{
    Extensible = false;

    value(0; "Not Started")
    {
        Caption = 'Not Started';
    }
    value(1; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(2; Completed)
    {
        Caption = 'Completed';
    }
    value(3; Waiting)
    {
        Caption = 'Waiting';
    }
    value(4; Postponed)
    {
        Caption = 'Postponed';
    }
}
