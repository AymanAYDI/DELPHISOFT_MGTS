
page 50131 "DEL DocMatrix Setup"
{


    PageType = Card;
    SourceTable = "DEL DocMatrix Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Sales File Folder"; Rec."Sales File Folder")
                {
                }
                field("Purchase File Folder"; Rec."Purchase File Folder")
                {
                }
                field("Default E-Mail From"; Rec."Default E-Mail From")
                {
                }
                field("Show Notifications"; Rec."Show Notifications")
                {
                }
                field("Statement Test Date"; Rec."Statement Test Date")
                {
                }
                field("Test Active"; Rec."Test Active")
                {
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
