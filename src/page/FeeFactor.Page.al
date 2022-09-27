page 50049 "DEL Fee Factor"
{

    Caption = 'Fee Factor';
    PageType = List;
    SourceTable = "DEL Fee Factor";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Allow From"; Rec."Allow From")
                {
                }
                field("Allow To"; Rec."Allow To")
                {
                }
                field(Factor; Rec.Factor)
                {
                }
                field(Fee_ID; Fee_ID)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        fee: Record "DEL Fee";
}

