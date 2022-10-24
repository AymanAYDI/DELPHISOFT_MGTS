enum 50047 "DEL Last Synchronized State" //still an option in the STD ( 5967 )
{
    Extensible = false;

    value(0; Insert)
    {
        Caption = 'Insert';
    }
    value(1; Modify)
    {
        Caption = 'Modify';
    }
    value(2; Delete)
    {
        Caption = 'Delete';
    }
    value(3; Rename)
    {
        Caption = 'Rename';
    }
}
