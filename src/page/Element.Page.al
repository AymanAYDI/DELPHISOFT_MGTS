page 50021 "DEL Element"
{

    PageType = List;
    SourceTable = "DEL Element";
    UsageCategory = None;

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
                field(Instance; Rec.Instance)
                {
                }
                field(Type; Rec.Type)
                {
                }
                field("Type No."; Rec."Type No.")
                {
                }
                field(Fee_ID; Rec.Fee_ID)
                {
                }
                //TODO
                // field(Fee_Cu.FNC_Get_Description(Fee_ID);
                //     Fee_Cu.FNC_Get_Description(Fee_ID))
                // {
                // }
                field(Fee_Connection_ID; Rec.Fee_Connection_ID)
                {
                }
                field("Subject Type"; Rec."Subject Type")
                {
                }
                field("Subject No."; Rec."Subject No.")
                {
                }
                field("Date"; Rec.Date)
                {
                }
            }
        }
    }

    actions
    {
    }
}

