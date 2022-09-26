page 50046 "Quality forms"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00716      THM     27.08.15           Create Object
    // T-00757      THM     07.01.16           add and modify Field

    Caption = 'Quality forms';
    PageType = ListPart;
    SourceTable = Table50056;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; "Item No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Type / Nature Enregistrement"; "Type / Nature Enregistrement")
                {
                }
                field(Description; Description)
                {
                }
                field("Description Supplementaire"; "Description Supplementaire")
                {
                }
                field("Date of creation"; "Date of creation")
                {
                }
            }
        }
    }

    actions
    {
    }
}

