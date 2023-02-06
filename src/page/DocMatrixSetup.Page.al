page 50131 "DEL DocMatrix Setup"
{
    PageType = Card;
    SourceTable = "DEL DocMatrix Setup";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Sales File Folder"; Rec."Sales File Folder")
                {
                    ApplicationArea = All;
                }
                field("Purchase File Folder"; Rec."Purchase File Folder")
                {
                    ApplicationArea = All;
                }
                field("Default E-Mail From"; Rec."Default E-Mail From")
                {
                    ApplicationArea = All;
                }
                field("Show Notifications"; Rec."Show Notifications")
                {
                    ApplicationArea = All;
                }
                field("Statement Test Date"; Rec."Statement Test Date")
                {
                    ApplicationArea = All;
                }
                field("Test Active"; Rec."Test Active")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;
    end;
}
