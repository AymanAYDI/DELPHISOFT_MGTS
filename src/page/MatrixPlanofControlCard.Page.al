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
    SourceTable = "DEL Regulation Matrix Line";
    SourceTableView = SORTING("Item Category Code", "Product Group Code", Mark, "Product Description", "No.", Type)
                      ORDER(Ascending)
                      WHERE(Type = FILTER("Plan of control"));

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Record details';
                field("Item Category Code"; Rec."Item Category Code")
                {
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                }
                field("Item Category Label"; Rec."Item Category Label")
                {
                }
                field("Product Group Label"; Rec."Product Group Label")
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Test Type"; Rec."Test Type")
                {
                }
                field(Descriptive; Rec.Descriptive)
                {
                }
                field("Support Text"; Rec."Support Text")
                {
                }
                field("Control Type"; Rec."Control Type")
                {
                }
                field(Frequency; Rec.Frequency)
                {
                }
                field("Referent Laboratory"; Rec."Referent Laboratory")
                {
                }
                field("Livrables 1"; Rec."Livrables 1")
                {
                }
            }
        }
    }

    actions
    {
    }
}


