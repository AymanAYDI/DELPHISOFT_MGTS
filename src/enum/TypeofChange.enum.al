enum 50042 "DEL Type of Change" //existe dans STD table 405 (field 9)
{
    Extensible = false;

    value(0; Insertion)
    {
        Caption = 'Insertion';
    }
    value(1; Modification)
    {
        Caption = 'Modification';
    }
    value(2; Deletion)
    {
        Caption = 'Deletion';
    }
}
