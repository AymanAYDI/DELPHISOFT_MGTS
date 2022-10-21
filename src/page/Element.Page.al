page 50021 "DEL Element"
{

    PageType = List;
    SourceTable = "DEL Element";

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
                field(Instance; Rec.Instance)
                {
                    Caption = 'Instance';
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                }
                field("Type No."; Rec."Type No.")
                {
                    Caption = 'Type No.';
                }
                field(Fee_ID; Rec.Fee_ID)
                {
                    Caption = 'Fee_ID';
                }
                //TODO
                // field(Fee_Cu.FNC_Get_Description(Fee_ID);
                //     Fee_Cu.FNC_Get_Description(Fee_ID))
                // {
                // }
                field(Fee_Connection_ID; Rec.Fee_Connection_ID)
                {
                    Caption = 'Fee_Connection_ID';
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    Caption = 'Subject Type';
                }
                field("Subject No."; Rec."Subject No.")
                {
                    Caption = 'Subject No.';
                }
                field("Date"; Rec.Date)
                {
                    Caption = 'Date';
                }
            }
        }
    }

    actions
    {
    }
}

