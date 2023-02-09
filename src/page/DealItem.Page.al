page 50023 "DEL Deal Item"
{
    ApplicationArea = all;
    PageType = List;
    SourceTable = "DEL Deal Item";
    UsageCategory = Tasks;
    layout
    {
        area(content)
        {

            repeater(Control1)


            {
                field("Item No."; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal_ID';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field("Currency Price"; Rec."Currency Price")
                {
                    Caption = 'Currency Price';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';
                }
                field("Currency Cost"; Rec."Currency Cost")
                {
                    Caption = 'Currency Cost';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    Caption = 'Net Weight';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    Caption = 'Gross Weight';
                }
                field("Volume CMB"; Rec."Volume CMB")
                {
                    Caption = 'Volume CMB';
                }
                field("Volume CMB carton transport"; Rec."Volume CMB carton transport")
                {
                    Caption = 'Volume CMB carton transport';
                }
                field(PCB; Rec.PCB)
                {
                    Caption = 'PCB';
                }
                field("Container No."; Rec."Container No.")
                {
                    Caption = 'Container No.';
                }
                field("Droit de douane reduit"; Rec."Droit de douane reduit")
                {
                    Caption = 'Droit de douane reduit';
                }
            }
        }
    }

    actions
    {
    }
}

