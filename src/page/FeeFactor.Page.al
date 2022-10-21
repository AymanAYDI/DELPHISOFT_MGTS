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
                    Caption = 'Allow From';
                }
                field("Allow To"; Rec."Allow To")
                {
                    Caption = 'Allow To';
                }
                field(Factor; Rec.Factor)
                {
                    Caption = 'Factor';
                }
                field(Fee_ID; Rec.Fee_ID)
                {
                    Caption = 'Fee_ID';
                }
            }
        }
    }

    actions
    {
    }
}

