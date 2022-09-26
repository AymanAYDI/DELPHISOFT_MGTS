page 50142 "Type Order EDI"
{
    Caption = 'Type Order EDI';
    PageType = List;
    SourceTable = Table50079;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Automatic ACO"; "Automatic ACO")
                {
                }
            }
        }
    }

    actions
    {
    }
}

