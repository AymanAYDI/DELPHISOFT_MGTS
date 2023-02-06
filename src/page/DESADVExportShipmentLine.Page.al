page 50151 "DESADV Export Shipment Line"
{
    // MGTS10.042  | 02.01.2022 | Container/DESADV Management

    Caption = 'Lines';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Table50087;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field("Document No."; "Document No.")
                {
                    Visible = false;
                }
                field("Document Line No."; "Document Line No.")
                {
                    Visible = false;
                }
                field("Item No."; "Item No.")
                {
                }
                field(Description; Description)
                {
                }
                field(EAN; EAN)
                {
                }
                field("Unit of Measure"; "Unit of Measure")
                {
                }
                field("Ordered Quantity"; "Ordered Quantity")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field("Delivery Quantity"; "Delivery Quantity")
                {
                }
                field("Delivery Date"; "Delivery Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

