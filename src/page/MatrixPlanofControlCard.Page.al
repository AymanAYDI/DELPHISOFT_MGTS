page 50093 "Matrix Plan of Control Card"
{
    // +---------------------------------------------------------------+
    // | Logico SA                                                     |
    // | Status:                                                       |
    // | Customer/Project:                                             |
    // +---------------------------------------------------------------+
    // Requirement UserID   Date       Where   Description
    // -----------------------------------------------------------------
    // T-00755      THM     05.01.16           Create Object
    // T-00757      THM     07.01.16           add and modify Field

    Caption = 'Plan of Control Card';
    Editable = false;
    PageType = Card;
    SourceTable = Table50051;
    SourceTableView = SORTING(Item Category Code, Product Group Code, Mark, Product Description, No., Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER(Plan of control));

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Record details';
                field("Item Category Code"; "Item Category Code")
                {
                }
                field("Product Group Code"; "Product Group Code")
                {
                }
                field("Item Category Label"; "Item Category Label")
                {
                }
                field("Product Group Label"; "Product Group Label")
                {
                }
                field(Type; Type)
                {
                }
                field("Test Type"; "Test Type")
                {
                }
                field(Descriptive; Descriptive)
                {
                }
                field("Support Text"; "Support Text")
                {
                }
                field("Control Type"; "Control Type")
                {
                }
                field(Frequency; Frequency)
                {
                }
                field("Referent Laboratory"; "Referent Laboratory")
                {
                }
                field("Livrables 1"; "Livrables 1")
                {
                }
            }
        }
    }

    actions
    {
    }
}

