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
                }
                field(Deal_ID; Rec.Deal_ID)
                {
                }
                field(Element_ID; Rec.Element_ID)
                {
                }
                field("Sub Element_ID"; Rec."Sub Element_ID")
                {
                }
                field(Instance; Rec.Instance)
                {
                }
                field("Deal Item No."; Rec."Deal Item No.")
                {
                }
                field(Quantity; Rec.Quantity)
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Line Amount"; Rec."Line Amount")
                {
                }
                field("Line Amount (EUR)"; Rec."Line Amount (EUR)")
                {
                }
            }
        }
    }

    actions
    {
    }
}

