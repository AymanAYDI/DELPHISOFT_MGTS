page 50049 "DEL Fee Factor"
{

    Caption = 'Fee Factor';
    PageType = List;
    SourceTable = "DEL Fee Factor";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Allow From"; Rec."Allow From")
                {
                    ApplicationArea = All;
                }
                field("Allow To"; Rec."Allow To")
                {
                    ApplicationArea = All;
                }
                field(Factor; Rec.Factor)
                {
                    ApplicationArea = All;
                }
                field(Fee_ID; Rec.Fee_ID)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

