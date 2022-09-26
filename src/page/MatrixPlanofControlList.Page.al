page 50113 "Matrix Plan of Control List"
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

    Caption = 'Plan of Control';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = Table50051;
    SourceTableView = SORTING (Item Category Code, Product Group Code, Mark, Product Description, No., Type)
                      ORDER(Ascending)
                      WHERE (Type = FILTER (Plan of control));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Category Code"; "Item Category Code")
                {
                    Visible = false;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    Visible = false;
                }
                field("Item Category Label"; "Item Category Label")
                {
                    Visible = false;
                }
                field("Product Group Label"; "Product Group Label")
                {
                    Visible = false;
                }
                field(Type; Type)
                {
                    Visible = false;
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
        area(processing)
        {
            action(Card)
            {
                Image = Line;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page 50093;
                RunPageLink = Item Category Code=FIELD(Item Category Code),
                              Product Group Code=FIELD(Product Group Code),
                              No.=FIELD(No.),
                              Type=FIELD(Type),
                              Mark=FIELD(Mark),
                              Product Description=FIELD(Product Description);
            }
        }
    }
}

