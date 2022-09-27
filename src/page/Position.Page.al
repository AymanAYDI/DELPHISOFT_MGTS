page 50022 "DEL Position"
{
    PageType = List;
    SourceTable = "DEL Position";

    Caption = 'DEL Position';


    layout
    {
        area(content)
        {

            repeater(Controle1)

            {
                field(ID; Rec.ID)
                {
                    Caption = 'ID';
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                    Caption = 'Deal_ID';
                }
                field(Element_ID; Rec.Element_ID)
                {
                    Caption = 'Element_ID';
                }
                field("Sub Element_ID"; Rec."Sub Element_ID")
                {
                    Caption = 'Sub Element_ID';
                }
                field(Instance; Rec.Instance)
                {
                    Caption = 'Instance';
                }
                field("Deal Item No."; Rec."Deal Item No.")
                {
                    Caption = 'Deal Item No.';
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field("Line Amount (EUR)"; Rec."Line Amount (EUR)")
                {
                    Caption = 'Line Amount (EUR)';
                }
            }
        }
    }

    actions
    {
    }
}

