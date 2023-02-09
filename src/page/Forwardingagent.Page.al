page 50013 "DEL Forwarding agent"
{
    ApplicationArea = all;
    Caption = 'Forwarding agent';
    PageType = List;
    SourceTable = "DEL Forwarding agent 2";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Forwarding Agent Code"; Rec."Forwarding Agent Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Folder for file"; Rec."Folder for file")
                {
                }
                field("HSCODE Enable"; Rec."HSCODE Enable")
                {
                }
                field("URL Address"; Rec."URL Address")
                {

                }
            }
        }
    }

    actions
    {
    }
}

