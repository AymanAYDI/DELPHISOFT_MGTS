page 50069 "Note audit"
{
    Caption = 'Rating Audit';
    PageType = List;
    SourceTable = Table50019;

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
                field("Revision Calculation"; "Revision Calculation")
                {
                }
                field("Impact statut"; "Impact statut")
                {
                }
            }
        }
    }

    actions
    {
    }
}

