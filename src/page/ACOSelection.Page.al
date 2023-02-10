page 50036 "DEL ACO Selection"
{
    PageType = List;
    SourceTable = "Purchase Header";
    UsageCategory = None;
    Caption = 'ACO Selection';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                }
            }
        }
    }
    actions
    {
    }

    procedure FNC_Get_ACO_No(): Code[20]
    begin
        EXIT(Rec."No.")
    end;
}

