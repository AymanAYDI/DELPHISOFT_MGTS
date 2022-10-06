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
                field("Forwarding Agent Code"; Rec."Forwarding Agent Code")
                {
                    Caption = 'Forwarding Agent Code';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field("Folder for file"; Rec."Folder for file")
                {
                    Caption = 'Folder for file';
                }
                field("HSCODE Enable"; Rec."HSCODE Enable")
                {
                    Caption = 'HSCODE Enable';
                }
                field("URL Address"; Rec."URL Address")
                {
                    Caption = 'URL Address';

                }
            }
        }
    }

    actions
    {
    }
}

