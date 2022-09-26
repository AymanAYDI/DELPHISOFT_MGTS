page 50036 "ACO Selection"
{
    PageType = List;
    SourceTable = Table38;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("No."; "No.")
                {
                }
                field("Buy-from Vendor Name"; "Buy-from Vendor Name")
                {
                }
            }
        }
    }

    actions
    {
    }

    [Scope('Internal')]
    procedure FNC_Get_ACO_No(): Code[20]
    begin
        EXIT("No.")
    end;
}

