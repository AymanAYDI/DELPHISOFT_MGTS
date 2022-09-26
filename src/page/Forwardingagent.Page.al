page 50013 "Forwarding agent"
{
    // EDI       22.05.13/LOCO/ChC- Page Created

    Caption = 'Forwarding agent';
    PageType = List;
    SourceTable = Table50009;

    layout
    {
        area(content)
        {
            repeater()
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

