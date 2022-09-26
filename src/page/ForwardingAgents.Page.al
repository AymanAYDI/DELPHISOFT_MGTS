page 50011 "Forwarding Agents"
{
    // T-00799     THM       22.06.16        add "Departure port"

    Caption = 'Forwarding Agents';
    PageType = List;
    SourceTable = Table50011;

    layout
    {
        area(content)
        {
            repeater()
            {
                field("Vendor No."; "Vendor No.")
                {
                }
                field("Location Code"; "Location Code")
                {
                }
                field("Forwarding Agent"; "Forwarding Agent")
                {
                }
                field("Departure port"; "Departure port")
                {
                }
            }
        }
    }

    actions
    {
    }
}

