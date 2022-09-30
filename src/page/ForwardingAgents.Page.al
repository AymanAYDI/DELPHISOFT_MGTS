page 50011 "DEL Forwarding Agents"
{
    // T-00799     THM       22.06.16        add "Departure port"

    Caption = 'Forwarding Agents';
    PageType = List;
    SourceTable = "DEL Forwarding Agent";

    layout
    {
        area(content)
        {
            repeater(Controle1)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Forwarding Agent"; Rec."Forwarding Agent")
                {
                }
                field("Departure port"; Rec."Departure port")
                {
                }
            }
        }
    }

    actions
    {
    }
}

