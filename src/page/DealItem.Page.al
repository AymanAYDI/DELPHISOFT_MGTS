page 50023 "DEL Deal Item"
{
    PageType = List;
    SourceTable = "DEL Deal Item";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                field("Item No."; Rec."Item No.")
                {
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                }
                field("Unit Price"; Rec."Unit Price")
                {
                }
                field("Currency Price"; Rec."Currency Price")
                {
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                }
                field("Currency Cost"; Rec."Currency Cost")
                {
                }
                field("Net Weight"; Rec."Net Weight")
                {
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                }
                field("Volume CMB"; Rec."Volume CMB")
                {
                }
                field("Volume CMB carton transport"; Rec."Volume CMB carton transport")
                {
                }
                field(PCB; Rec.PCB)
                {
                }
                field("Container No."; Rec."Container No.")
                {
                }
                field("Droit de douane reduit"; Rec."Droit de douane reduit")
                {
                }
            }
        }
    }

    actions
    {
    }
}

