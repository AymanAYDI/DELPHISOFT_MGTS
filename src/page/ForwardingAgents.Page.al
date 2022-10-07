page 50011 "DEL Forwarding Agents"
{


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
                    Caption = 'Vendor No.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field("Forwarding Agent"; Rec."Forwarding Agent")
                {
                    Caption = 'Forwarding Agent';
                }
                field("Departure port"; Rec."Departure port")
                {
                    Caption = 'Departure port';
                }
            }
        }
    }

    actions
    {
    }
}

