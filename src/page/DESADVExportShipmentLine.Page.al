page 50151 "DEL DESADV ExportShipment Line"
{

    Caption = 'Lines';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "DEL DESADV Export Buffer Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    Visible = false;
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(EAN; Rec.EAN)
                {
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                field("Ordered Quantity"; Rec."Ordered Quantity")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field("Delivery Quantity"; Rec."Delivery Quantity")
                {
                }
                field("Delivery Date"; Rec."Delivery Date")
                {
                }
            }
        }
    }

    actions
    {
    }
}

