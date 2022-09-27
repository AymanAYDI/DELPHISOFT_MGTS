page 50013 "DEL Forwarding agent"
{
    Caption = 'Forwarding agent';
    PageType = List;
    SourceTable = "DEL Forwarding agent 2";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Forwarding Agent Code"; "Forwarding Agent Code")
                {
                }
                field(Description; Description)
                {
                }
                field("Folder for file"; "Folder for file")
                {
                }
                field("HSCODE Enable"; "HSCODE Enable")
                {
                }
                field("URL Address"; "URL Address")
                {
                }
            }
        }
    }

    actions
    {
    }
}

