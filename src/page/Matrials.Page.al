page 50087 Matrials
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object

    Caption = 'Matrials';
    PageType = List;
    SourceTable = Table50053;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; "Item Category Code")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

